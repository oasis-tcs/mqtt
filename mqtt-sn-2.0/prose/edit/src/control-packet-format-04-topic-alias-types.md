<!-- transformation-note: left upstream numbering of headings for verification -->
## 2.4 Topic Alias Types

Several packets will refer to a topic alias type in their flags.
This is a 2-bit field which determines the format of the topic Id value.

The allowable values are as follows:

<!-- transformation-note: Added header to left most column and changed "Topic Alias Type Value" to the more generic "Code". -->
| Code\[Dec.] | Code\[Hex.] | Name                   | Description                                                                                                                                                                                                 |
|:------------|:------------|:-----------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 0           | 0b00        | Normal Topic Alias     | A normal topic alias is negotiated between the gateway and client within the scope of a gateway session.                                                                                                    |
| 1           | 0b01        | Predefined Topic Alias | A predefined alias is known statically by both the gateway and the client outside the scope of a gateway session. No negotiation is required since both entities have knowledge of the topic alias mapping. |
| 2           | 0b10        | Short Topic Name       | A 2-byte topic name which requires no negotiation.                                                                                                                                                          |
| 3           | 0b11        | Long Topic Name        | A full topic, which requires no session negotiation.                                                                                                                                                        |

Table 10: Topic alias types and their description

Please refer to operational behavior for detailed descriptions of topic types and aliases.
