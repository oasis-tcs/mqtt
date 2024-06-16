<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.25 Protection Encapsulation

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway -->
<!-- transformation-note: bitfield display candidate could be clearer that X means variable bit values for PROTECTION flags (bits). -->
<!-- transformation-note: different style to other packet descriptions: dash instead of ellipsis for ranges and suspicious
     letter continuations across ranges eg. instead of 17 ... P and P+1 ... Q it states 17 ... P and Q ... R. --->
| Bit          | 7                            | 6               | 5               | 4               | 3                      | 2                      | 1                        | 0                        |
|:-------------|:-----------------------------|:----------------|:----------------|:----------------|:-----------------------|:-----------------------|:-------------------------|:-------------------------|
| Byte 1       | Length                       |                 |                 |                 |                        |                        |                          |                          |
| Byte 2       | Packet Type                  |                 |                 |                 |                        |                        |                          |                          |
|              | PROTECTION FLAGS             |                 |                 |                 |                        |                        |                          |                          |
|              | Auth Tag Length              | Auth Tag Length | Auth Tag Length | Auth Tag Length | Crypto Material Length | Crypto Material Length | Monotonic Counter Length | Monotonic Counter Length |
| Byte 3       | x                            | x               | x               | x               | X                      | X                      | X                        | X                        |
| Byte 4       | Protection Scheme            |                 |                 |                 |                        |                        |                          |                          |
| Byte 5 - 12  | Sender Id                    |                 |                 |                 |                        |                        |                          |                          |
| Byte 13 - 16 | Random                       |                 |                 |                 |                        |                        |                          |                          |
| Byte 17 - P  | Crypto Material (Optional)   |                 |                 |                 |                        |                        |                          |                          |
| Byte Q - R   | Monotonic Counter (Optional) |                 |                 |                 |                        |                        |                          |                          |
| Byte S - T   | Protected MQTT-SN Packet     |                 |                 |                 |                        |                        |                          |                          |
| Byte U - N   | Authentication Tag           |                 |                 |                 |                        |                        |                          |                          |

Table 53: Format of the protection encapsulated MQTT-SN packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

Protection encapsulation provides a secure envelope for any MQTT-SN packet (with the exception of the Forward Encapsulation packet).
The fields provided by the protection encapsulation provide a means by which the sender can be identified and the packet can be protected,
using a number of prescribed protection schemes.

The sender is the originator of the "Protected MQTT-SN Packet" and responsible for its protection.
This responsibility MUST NOT be delegated to a third entity like a Forwarder.

The sender identification is required as the sender and the receiver of the protected packet must have access to the same shared key to be used directly or after derivation.
The authentication of the sender and the receiver, their authorizations and the provisioning of the shared keys used to protect integrity and
optionally confidentiality of the protected packet content are out of scope.

A protected packet, like any other one, can be the payload of a Forwarder Encapsulated packet.

<!-- transformation-note: bad markup used as TODO indicaator scope is until next subsection start. -->
//TODO - Break out the conformance aspects of this paragraph from recommendations.

When the PROTECTION packet is handled by a gateway, it is mandatory to use it to protect all MQTT-SN packets exchanged with a Client for which a shared key
(indexed by its Sender Id) is available.

If the client is not enrolled to the gateway (so the gateway has no access to a key shared with it on the basis of its Sender Id) and the Client and gateway are not in a private network,
it is recommended for the gateway to process only MQTT-SN packets received over a DTLS session initiated with mutual authentication by the client.

When the PROTECTION packet is handled by a Client, it is mandatory to use it to protect all MQTT-SN packets exchanged with a GW for which a shared key (indexed by its GwId) is available.

If the GW is not enrolled to the Client (so the Client has no access to a key shared with it on the basis of its GwId)
and the Client and GW are not in a private network, it is recommended for the Client to open a DTLS session and process
only MQTT-SN packets received over it.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.25.1 Length{#protection-encapsulation--length}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 was obviously wrong and should point to section 2.1 "Structure of an MQTT-SN Control Packet". -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.25.2 Packet Type

Coded "0x1E", see Table 63

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.25.3 Protection Flags

The PROTECTION Flags is 1 byte field in Byte position 3 of the packet, specifying the properties of the PROTECTION.

The PROTECTION Flags field includes the following flags:

<!-- transformation-note: suspiciously deep list nesting: who will be able to follow that, suggested is a different approach. -->
- **(Auth)entication tag length** - (4 bits) should represent the number of 16 bits groups forming the authentication tag
  in big-endian order.
  - Only 14 of the 16 possible values are allowed:
    - If 0x00, the authentication tag length is provider defined
    - the values from 0x1 to 0x2 are Reserved;
    - any other value 0xZ, so between 0x3 and 0xF, is allowed and the authentication tag length will be (0xZ+1)*16 bits; for example
      - if the value is 0xF, the Authentication tag length will be (0xF+1)*16=256 bits;
      - if the value is 0x3, the Authentication tag length will be (0x3+1)*16=64 bits;
    - If a truncation of the output of the authentication algorithm is required, it has to be taken in most significant bits first order (leftmost bits).
    - If an extension of the output of the authentication algorithm is required, 0s are appended until the Authentication tag length is reached.
    - Some values are not allowed for some protection schemes.
      For instance the values 0x03, 0x04, 0x05, 0x06 are not allowed for AES-CCM-128-128, AES-CCM-128-192, AES-CCM-128-256, AES-GCM-128-128, AES-GCM-128-192, AES-GCM-128-256 and
      ChaCha20/Poly1305 as for those protection schemes the 128-bit authentication tag can’t be truncated.
- **Crypto material length** - (2 bits) should represent the number of 16 bits groups forming the crypto material in big-endian order. Below the meaning of each possible value:
  - if 0x3, a crypto material field of 96 bits (12 bytes) is present
  - if 0x2, a crypto material field of 32 bits (4 bytes) is present
  - if 0x1, a crypto material field of 16 bits (2 bytes) is present
  - if 0x0, the crypto material field is not present.
- **Monotonic counter length** - (2 bits) should represent the number of bytes forming the monotonic counter in big-endian order.
  Only 3 of the 4 possible values are allowed:
  - the value 0x3 is Reserved;
  - if 0x2, a monotonic counter field of 32 bits (4 bytes) is present;
  - if 0x1, a monotonic counter field of 16 bits (2 bytes) is present;
  - if 0x0, the monotonic counter field is not present.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.25.4 Protection Scheme

A (1 byte) field located at byte 4 should contain one of the not Reserved indexes in the following table.
In general two types of protection scheme are considered: Authentication only (like HMAC or CMAC) and AEAD (Authenticated Encryption with Associated Data, like GCM, CCM or ChaCha20/Poly1305).

| Index     | Name                          | Auth Only | Key size          | Tag size         |
|:----------|:------------------------------|:----------|:------------------|:-----------------|
| 0x00      | HMAC-SHA256 (Note 1)          | Yes       | Any size (Note 2) | 256 bits         |
| 0x01      | HMAC-SHA3_256 (Note 1)        | Yes       | Any size (Note 2) | 256 bits         |
| 0x02      | CMAC-128 (Note 3)             | Yes       | 128 bits          | 128 bits         |
| 0x03      | CMAC-192 (Note 3)             | Yes       | 192 bits          | 128 bits         |
| 0x04      | CMAC-256 (Note 3)             | Yes       | 256 bits          | 128 bits         |
| 0x05-0x3B | RESERVED                      |           |                   |                  |
| 0x3C-0x3F | Provider defined              | Yes       | Provider defined  | Provider defined |
| 0x40      | AES-CCM-64-128 (Notes 4,5)    | No        | 128 bits          | 64 bits          |
| 0x41      | AES-CCM-64-192 (Notes 4,5)    | No        | 192 bits          | 64 bits          |
| 0x42      | AES-CCM-64-256 (Notes 4,5)    | No        | 256 bits          | 64 bits          |
| 0x43      | AES-CCM-128-128 (Notes 4,5)   | No        | 128 bits          | 128 bits         |
| 0x44      | AES-CCM-128-192 (Notes 4,5)   | No        | 192 bits          | 128 bits         |
| 0x45      | AES-CCM-128-256 (Notes 4,5)   | No        | 256 bits          | 128 bits         |
| 0x46      | AES-GCM-128-128 (Notes 6,7)   | No        | 128 bits          | 128 bits         |
| 0x47      | AES-GCM-128-192 (Notes 6,7)   | No        | 192 bits          | 128 bits         |
| 0x48      | AES-GCM-128-256 (Notes 6,7)   | No        | 256 bits          | 128 bits         |
| 0x49      | ChaCha20/Poly1305 (Notes 8,9) | No        | 256 bits          | 128 bits         |
| 0x4A-0xEF | RESERVED                      |           |                   |                  |
| 0xF0-0xFF | Provider defined              | No        | Provider defined  | Provider defined |

Table: Relating protection schemes (see also table notes).
<!-- transformation-note: made up table caption with hint on table notes. -->

<!-- transformation-note: amended notes as "Table Notes" and set to strong markup. -->
**Table Note(s)**:

1. Reference <https://www.rfc-editor.org/rfc/rfc2104>
1. Reference <https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.198-1.pdf>
1. Reference <https://www.rfc-editor.org/rfc/rfc4493> and <https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-38b.pdf> and
   <https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Standards-and-Guidelines/documents/examples/AES_CMAC.pdf>
1. Reference <https://www.rfc-editor.org/rfc/rfc3610> and security considerations on <https://www.rfc-editor.org/rfc/rfc8152#section-10.2.1>
1. AES CCM requires a 13 bytes nonce as indicated in <https://www.rfc-editor.org/rfc/rfc8152#section-10.2> and the nonce
   is obtained by performing SHA256, truncated to the leftmost 104 bits, of the sequence Byte 1 to Byte R (all packet fields until Protected MQTT-SN Packet)
1. Reference <https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf> and security considerations on <https://www.rfc-editor.org/rfc/rfc8152#section-10.1.1>
1. AES GCM requires a 12 bytes IV as indicated in <https://www.rfc-editor.org/rfc/rfc8152#section-10.1> and the IV is obtained by performing SHA256,
   truncated to the leftmost 96 bits, of the sequence Byte 1 to Byte R (all packet fields until Protected MQTT-SN Packet)
1. Reference: <https://www.rfc-editor.org/rfc/rfc7539> and security considerations on <https://www.rfc-editor.org/rfc/rfc8152#section-10.3.1>
1. ChaCha20/Poly1305 requires a 12 bytes nonce as indicated in https://www.rfc-editor.org/rfc/rfc8152#section-10.3 obtained by performing SHA256 truncated
   to 96 bit of the sequence Byte 1 to Byte R (all packet fields until Protected MQTT-SN Packet)
<!-- transformation-note: above references should all correspond to informal reference entries. -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.25.5 Sender Id

Located at Bytes 5 - 12 the Sender Id field (8 bytes) should contain:

If the message is originated by the Gateway:

- The SHA256 of the GwId truncated to the leftmost 64 bits (8 bytes);

If the message is originated by the Client:

- If a session is available: the SHA256 of the Client Identifier truncated to the leftmost 64 bits (8 bytes);
- If a session is not available: a unique value per sender over 8 bytes (like a MAC address, or other identifying characteristics).
  The methods to guarantee the uniqueness of the Sender Id in this case are out of scope for this technical proposal.

> Informative Comment
> 8 bytes for the "Sender Id" field seems enough as it is calculated with a cryptographic hash, so the probability of collision is 1/2^64=5.42x10-20.
>
>  **Client Behavior**:
>
> In order to create a whitelist of authorized senders, the Client should store a map of GwId and SHA256(GwId) truncated to the leftmost 64 bits.
> GwId can be obtained from pre-configuration, from an ADVERTISE packet or from a GWINFO packet.
>
> **Gateway Behavior**:
>
> In order to create a whitelist of authorized senders, the MQTT-SN Gateway should store a map of ClientID and SHA256(ClientID) truncated to the leftmost 64 bits
> (8 bytes for each registered ClientID) for the clients having an active session and store a list of authorized Sender Ids for the clients not capable to establish sessions.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.25.6 Random

Located at Byte 13 - 16, the "Random" field (4 bytes) should contain a random number (not guessable) generated at the PROTECTION packet creation.

> Informative Comment
> In case of CCM, in the worst case scenario where the "Crypto Material" and the "Monotonic Counter" optional fields are not present,
> the recommended nonce on 13 bytes will be calculated as SHA256 truncated to 104 bits of the sequence Byte 1 to Byte 16 (all packet fields until Protected MQTT-SN Packet).
> So considering the same Sender Id, the same nonce can be generated with a probability of 1/2^32=2.33x10-10.
> With a shorter Random field of 2 bytes, the same nonce would be calculated with a probability of only 1/2^16=1.53x10-5.
> As CCM is a derivation of CTR (see https://en.wikipedia.org/wiki/CCM_mode), the nonce should never be reused for the same key so the probability to generate two
> identical nonces should be kept as low as possible. Same for GCM and ChaCha20/Poly1305, the security depends on choosing a unique IV of 12 bytes for
> every encryption performed with the same key (https://en.wikipedia.org/wiki/Galois/Counter_Mode).

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.25.7 Crypto Material

Located at Byte (17 - P), the optional field "Crypto Material" contains 0, 2, 4 or 12 bytes of crypto material that when defined it can be used to derive,
from a shared master secret, the same keys on the two endpoints and/or, when filled partially or totally with a random value,
to further reduce the probability of IV/nonce reuse for CCM or GCM or ChaCha20/Poly1305.
For instance when the Crypto material length is set to 0x03, the Crypto Material field can be partially filled with a random value of 9 bytes
(the remaining 3 bytes can be set to 0 if not used) in order to reach the 13 bytes used only once recommended for the nonce used by CCM or
it can be partially filled with a random value of 8 bytes in order to reach the 12 bytes used only once recommended for the IV/nonce used by GCM or ChaCha20/Poly1305.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.25.8 Monotonic Counter

Located at Byte Byte (Q - R), the optional field "Monotonic Counter" contains 0, 2 or 4 byte number that when defined,
is increased by the Client or GW for every packet sent.
The counters should be considered independent of session or destination.
E.g. The UE will keep a counter independently from the GW.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.25.9 Protected MQTT-SN Packet

Located at Byte (S - T), the field "Protected MQTT-SN Packet" contains the MQTT-SN packet that is being secured, encoded as per its packet type.

The "Protected MQTT-SN Packet" should not be a "Forwarder-Encapsulation packet" as the shared key used directly or after derivation for
the protection must belong to the originator of the content and not to a Forwarder that, in general, is not able to securely identify the originator.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.25.10 Authentication Tag

Located at Byte (U - N), the field "Authentication tag" field has a length depending on the "Authentication tag length" flag and it is calculated,
on the basis of the "Protection scheme" selected in Byte 4, on ALL the preceding fields.
