<!-- transformation-note: left upstream numbering of headings for verification -->
## 1.5 Data representation

<!-- transformation-note: left upstream numbering of headings for verification -->
### 1.5.1 Bits (Byte)

Bits in a byte are labeled 7 to 0. Bit number 7 is the most significant bit, the least significant bit is assigned bit number 0.

<!-- transformation-note: left upstream numbering of headings for verification -->
### 1.5.2 Two Byte Integer

Two Byte Integer data values are 16-bit unsigned integers in big-endian order: the high order byte precedes the lower order byte.
This means that a 16-bit word is presented on the network as Most Significant Byte (MSB), followed by Least Significant Byte (LSB).

<!-- transformation-note: left upstream numbering of headings for verification -->
### 1.5.3 Four Byte Integer

Four Byte Integer data values are 32-bit unsigned integers in big-endian order:
the high order byte precedes the successively lower order bytes.
This means that a 32-bit word is presented on the network as Most Significant Byte (MSB),
followed by the next most Significant Byte (MSB), followed by the next most Significant Byte (MSB),
followed by Least Significant Byte (LSB).

<!-- transformation-note: left upstream numbering of headings for verification -->
### 1.5.4 UTF-8 Encoded String

Text fields within the MQTT-SN Control Packets are encoded as fixed length UTF-8 strings. UTF-8 \[RFC3629] is an efficient encoding of
Unicode \[Unicode] characters that optimizes the encoding of ASCII characters in support of text-based communications.


Unless stated otherwise all variable length UTF-8 encoded strings can have any length in the range 0 to 65,535 bytes.

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit        | 7   | 6   | 5   | 4   | 3   | 2   | 1   | 0   |
|:-----------|:----|:----|:----|:----|:----|:----|:----|:----|
| byte 1 ... | UTF-8 encoded character data, if length \> 0. |

Table 1: Structure of UTF-8 Encoded Strings

The character data in a UTF-8 Encoded String MUST be well-formed UTF-8 as defined by the Unicode specification \[Unicode]
and restated in RFC 3629 \[RFC3629].
In particular, the character data MUST NOT include encodings of code points between U+D800 and U+DFFF.
If the Client or Server receives an MQTT Control Packet containing ill-formed UTF-8 it is a Malformed Packet

A UTF-8 Encoded String MUST NOT include an encoding of the null character U+0000.
If a receiver (Server or Client) receives an MQTT-SN Control Packet containing U+0000 it is a Malformed Packet.

The data SHOULD NOT include encodings of the Unicode \[Unicode] code points listed below.
If a receiver (Server or Client) receives an MQTT-SN Control Packet containing any of them it MAY treat it as a Malformed Packet.
These are the Disallowed Unicode code points.

- U+0001..U+001F control characters
- U+007F..U+009F control characters
- Code points defined in the Unicode specification \[Unicode] to be non-characters (for example U+0FFFF)

A UTF-8 encoded sequence 0xEF 0xBB 0xBF is always interpreted as U+FEFF ("ZERO WIDTH NO-BREAK SPACE") wherever it appears in a string and
MUST NOT be skipped over or stripped off by a packet receiver.

> *Informative example*
> For example, the string A&#173780; which is LATIN CAPITAL Letter A followed by the code point U+2A6D4
> (which represents a CJK IDEOGRAPH EXTENSION B character) is encoded as follows:

<!-- transformation-note: no table col span in markdown (so amended with payload render as in hexdumps typical),
     but we should specify bitfields better (than with layout tables) anyway --> 
| Bit    | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 | Hex. Value or Glyph |
|:-------|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|--------------------:|
| byte 1 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 1 |          ‘A’ (0x41) |
| byte 2 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 |              (0xF0) |
| byte 3 | 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 |              (0xAA) |
| byte 4 | 1 | 0 | 0 | 1 | 1 | 0 | 1 | 1 |              (0x9B) |
| byte 5 | 1 | 0 | 0 | 1 | 0 | 1 | 0 | 0 |              (0x94) |

Table 2: Fixed Length UTF-8 Encoded String informative example
