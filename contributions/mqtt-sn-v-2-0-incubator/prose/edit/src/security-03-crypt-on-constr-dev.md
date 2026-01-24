## Lightweight cryptography and constrained devices{#lightweight-cryptography-and-constrained-devices}

MQTT-SN is targeted at the most power saving and constrained devices. In contrast to MQTT where there is principally one underlying network technology - TCP/IP - MQTT-SN is intended to be agnostic to the underlying network as long as it conforms to the requirements outlined in [[4.2 Networks and Virtual Connections]](#networks-and-virtual-connections).

Previous versions of MQTT-SN did not include specific security and integrity features, preferring to leave that to the underlying network. That approach is still supported, but to aid interoperability the Protection Encapsulation is introduced, in [[3.17 Protection Encapsulation]](#protection-encapsulation). In order to disassociate the security model from the rest of the MQTT-SN specification, the Protection Encapsulation allows all the packet types, including CONNECT, to be wrapped in a security envelope. Furthermore the security material is self-contained in each Protection Encapsulation envelope, so it is completely decoupled from the Virtual Connection.

The schemes defined by the Protection Encapsulation are especially suited for implementation by constrained devices:

- HMAC and AES CMAC are widely adopted authentication only standard schemes.

- The Advanced Encryption Standard [[\[AES\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#AES) is the most widely adopted encryption algorithm. There is hardware support for AES in many processors, but not commonly for embedded processors.

- The encryption algorithm ChaCha20 \[[[CHACHA20]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#CHACHA20)\] encrypts and decrypts much faster in software, but is not as widely available as AES.

The Protection Encapsulation approach is informed by the OSCORE \[RFC 8613\] standard and CBOR Initial Algorithms \[RFC 9053\] informational document. The ISO 29192 [[\[ISO29192\]]](https://docs.oasis-open.org/mqtt/mqtt/v5.0/cos02/mqtt-v5.0-cos02.html#ISO29192) standard makes recommendations for cryptographic primitives specifically tuned to perform on constrained, low end, devices.

The MQTT-SN Protection Encapsulation also allows for user defined protection schemes, although these will of necessity have lower interoperability compared to the built-in schemes, as implementations of both Client and Server will have to be aware of them.
