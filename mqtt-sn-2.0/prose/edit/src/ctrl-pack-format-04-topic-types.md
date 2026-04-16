## Topic Types{#topic-types}

Several packets refer to a Topic Type in their flags. This is a 2-bit field which determines the format of the topic value. The allowable values are as follows:

*Figure 2-8 -- Topic Types*

|   | Topic Type Value | Name                   | Description                                                                                                                                                                                              |
|:--|:-----------------|:-----------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 0 | 0b00             | Session Topic Alias    | A session Topic Alias is negotiated between the Server and Client within the scope of a session.                                                                                                         |
| 1 | 0b01             | Predefined Topic Alias | A predefined Topic Alias is known statically by both the Server and the Client outside the scope of a session. No negotiation is required since both entities have knowledge of the topic alias mapping. |
| 2 | 0b10             |                        | Reserved                                                                                                                                                                                                 |
| 3 | 0b11             | Topic Name or Filter   | A Topic Name or Topic Filter, which requires no session negotiation.                                                                                                                                     |

Table: Topic Types

Predefined and Session Topic Aliases are assigned from different pools so there is no danger of collision.

Refer to [sec](#topics) for detailed descriptions of Topic Names and Topic Aliases.
