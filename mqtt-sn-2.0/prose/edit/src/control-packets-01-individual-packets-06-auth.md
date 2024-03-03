<!-- transformation-note: left upstream numbering of headings for verification -->
### 3.1.6 AUTH

<!-- transformation-note: no table col span in markdown, but we should specify bitfields better (than with layout tables) anyway --> 
| Bit        | 7                      | 6  | 5  | 4  | 3  | 2  | 1  | 0  |
|:-----------|:-----------------------|:---|:---|:---|:---|:---|:---|:---|
| Byte 1     | Length                 |    |    |    |    |    |    |    |
| Byte 2     | Packet Type            |    |    |    |    |    |    |    |
| Byte 3     | Auth Reason Code       |    |    |    |    |    |    |    |
| Byte 4     | Auth Method Length (K) |    |    |    |    |    |    |    |
| Byte 5:5+K | Auth Method            |    |    |    |    |    |    |    |
| Byte 6+K:N | Auth Data (N)          |    |    |    |    |    |    |    |

Table 22: AUTH packet
<!-- transformation-note: above upstream table number will be replaced by auto-numbering later. -->

The authentication method and data is first sent by the Client as part of a CONNECT exchange.
If the Server requires additional information to complete the authentication, it responds with an AUTH packet to obtain that the Client generates and
sends another AUTH packet with the required information and so on until the authentication is complete.
The server then responds with a CONNACK message.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.6.1 Length and Packet Type{#auth--length-and-packet-type}

The first 2 or 4 bytes of the packet are encoded according to the variable length packet header format.
Please refer to section 2.1 "Structure of an MQTT-SN Control Packet" for a detailed description.
<!-- transformation-note: the above section ref upstream 1.8.2 was obviously wrong and should point to section 2.1 "Structure of an MQTT-SN Control Packet". -->

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.6.2 Reason Code{#auth--reason-code}

<!-- transformation-note: the below table ref upstream 9 "Reason Code Values" needs verification before transforming into a semantic ref later. -->
Byte 3 in the Auth packet holds the Authentication Reason Code.
The values for the Authentication Reason Code field are shown in Table 9: Reason Code Values.
The sender of the AUTH Packet MUST use one of the Authenticate Reason Codes.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.6.3 Auth Method Length

The length of the auth method string.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.6.4 Auth Method

A UTF-8 Encoded String containing the name of the authentication method.

<!-- transformation-note: left upstream numbering of headings for verification -->
#### 3.1.6.5 Auth Data

Binary Data containing authentication data.
The contents of this data are defined by the authentication method.

> Informative comment
> For a simple cleartext password analogous to MQTT username and password, the SASL PLAIN method can be used.
