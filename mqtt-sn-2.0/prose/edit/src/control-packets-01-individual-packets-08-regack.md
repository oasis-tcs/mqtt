<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.8 REGACK

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
<!-- transformation-note: bitfield display candidate could be clearer that x means variable bit values for REGACK flags (bits). -->
| Bit    | 7                  | 6        | 5        | 4        | 3        | 2        | 1                | 0                |
|:-------|:-------------------|:---------|:---------|:---------|:---------|:---------|:-----------------|:-----------------|
| Byte 1 | Length             |          |          |          |          |          |                  |                  |
| Byte 2 | Packet Type (0x0C) |          |          |          |          |          |                  |                  |
|        | REGACK FLAGS       |          |          |          |          |          |                  |                  |
|        | Reserved           | Reserved | Reserved | Reserved | Reserved | Reserved | Topic Alias Type | Topic Alias Type |
| Byte 3 | 0                  | 0        | 0        | 0        | 0        | 0        | x                | x                |
| Byte 4 | Topic Alias MSB    |          |          |          |          |          |                  |                  |
| Byte 5 | Topic Alias LSB    |          |          |          |          |          |                  |                  |
| Byte 6 | Packet Id MSB      |          |          |          |          |          |                  |                  |
| Byte 7 | Packet Id LSB      |          |          |          |          |          |                  |                  |
| Byte 8 | Reason Code        |          |          |          |          |          |                  |                  |

Table 25: REGACK packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

The REGACK packet is sent by a client or by a GW as an acknowledgment to the receipt and processing of a REGISTER packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.8.1 Length and Packet Type{#regack--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 1.4.2 for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 is obviously wrong and should point to 1.4.2 "Two Byte Integer" instead. -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.8.2 REGACK Flags

The REGACK Flags is 1 byte field in Byte position 3 of the REGACK packet.  

The REGACK Flags field includes the following flag:

<!-- transformation-note: the below table ref upstream 10 needs identification and verification before transforming into a semantic ref later. -->
- **Topic Alias Type**: This is a 2-bit field in Bit 0 and 1 which determines the format of the topic Id value.
  Refer to Table 10 for the definition of the various topic types.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.8.3 Topic Alias{#regack--topic-alias}

A Topic Alias is an integer value that is used to identify the Topic instead of the Topic Name.
This numeric value is used as the Topic Alias.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.8.4 Packet Id{#regack--packet-id}

The same value as the one contained in the corresponding REGISTER packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.8.5 Reason Code{#regack--reason-code}

<!-- transformation-note: the below table ref upstream 9 "Reason Code Values" needs verification before transforming into a semantic ref later. -->
Byte 8 in the REGACK packet holds the Register Reason Code.
The values for the Register Reason Code field are shown in Table 9: Reason Code Values.
The sender of the REGACK Packet MUST use one of the Register Reason Codes.
