<!-- transformation-note: left upstream numbering of headings for verification -->
## 4.5 Quality of Service levels and protocol flows

MQTT delivers Application Messages according to the Quality of Service (QoS) levels defined in the following sections.
The delivery protocol is symmetric, in the description below the Client and Server and Gateway can each take the role of either sender or receiver.
The delivery protocol is concerned solely with the delivery of an application message from a single sender to a single receiver.
When the Gateway is delivering an Application Message to more than one Client, each Client is treated independently.
The QoS level used to deliver an Application Message outbound to the Client could differ from that of the inbound Application Message.

<!-- transformation-note: left upstream numbering of headings for verification -->
### 4.5.1 QoS 0: At most once delivery

The message is delivered according to the capabilities of the underlying network.
No response is sent by the receiver and no retry is performed by the sender.
The message arrives at the receiver either once or not at all.

In the QoS 0 delivery protocol, the sender

- MUST send a PUBLISH packet with QoS 0 and DUP flag set to 0.

In the QoS 0 delivery protocol, the receiver

- Accepts ownership of the message when it receives the PUBLISH packet.

<!-- transformation-note: left upstream numbering of headings for verification -->
### 4.5.2 QoS 1: At least once delivery

This Quality of Service level ensures that the message arrives at the receiver at least once.
A QoS 1 PUBLISH packet has a Packet Identifier in its Variable Header and is acknowledged by a PUBACK packet.

In the QoS 1 delivery protocol, the sender

- MUST assign an unused Packet Identifier each time it has a new Application Message to publish
- MUST send a PUBLISH packet containing this Packet Identifier with QoS 1 and DUP flag set to 0
- MUST treat the PUBLISH packet as "unacknowledged" until it has received the corresponding PUBACK packet from the receiver.

The Packet Identifier becomes available for reuse once the sender has received the PUBACK packet.

In a difference to MQTT 5, the sender is NOT permitted to send further PUBLISH packets with different Packet Identifiers while
it is waiting to receive acknowledgements.
At any given time a sender must ONLY have 1 outstanding application message inflight.

In the QoS 1 delivery protocol, the receiver

- MUST respond with a PUBACK packet containing the Packet Identifier from the incoming PUBLISH packet, having accepted ownership of the Application Message
- After it has sent a PUBACK packet the receiver MUST treat any incoming PUBLISH packet that contains the same Packet Identifier as being a new Application Message,
  irrespective of the setting of its DUP flag

<!-- transformation-note: below should become a sequence diagram with the note maybe a real paragraph. -->
  ------------------------------------------------ --------------------- --------------------------------------------------------------
  Sender Action                                    MQTT Control Packet   Receiver action
  Store message                                                          
  Send PUBLISH QoS 1, DUP=0, <Packet Identifier>   ---------->           
                                                                         Initiate onward delivery of the Application Message (Note 1)
                                                   <----------           Send PUBACK <Packet Identifier>
  Discard message                                                        
  ------------------------------------------------ --------------------- --------------------------------------------------------------

Figure 4.2 – QoS 1 protocol flow diagram, Informative example

Figure Note(s):

1. The receiver does not need to complete delivery of the Application Message before sending the PUBACK.
   When its original sender receives the PUBACK packet, ownership of the Application Message is transferred to the receiver.

<!-- transformation-note: left upstream numbering of headings for verification -->
### 4.5.3 QoS 2: Exactly once delivery

This is the highest Quality of Service level, for use when neither loss nor duplication of messages are acceptable.
There is an increased overhead associated with QoS 2.

In the QoS 2 delivery protocol, the sender:

- MUST assign an unused Packet Identifier when it has a new Application Message to publish
- MUST send a PUBLISH packet containing this Packet Identifier with QoS 2 and DUP flag set to 0
- MUST treat the PUBLISH packet as "unacknowledged" until it has received the corresponding PUBREC packet from the receiver
- MUST send a PUBREL packet when it receives a PUBREC packet from the receiver with a Reason Code value less than 0x80.
  This PUBREL packet MUST contain the same Packet Identifier as the original PUBLISH packet
- MUST treat the PUBREL packet as "unacknowledged" until it has received the corresponding PUBCOMP packet from the receiver
- MUST NOT resend the PUBLISH once it has sent the corresponding PUBREL packet
- MUST NOT apply Message expiry if a PUBLISH packet has been sent

The Packet Identifier becomes available for reuse once the sender has received the PUBCOMP packet or a PUBREC with a Reason Code of 0x80 or greater.

In this version of MQTT-SN and in contrast to MQTT 5.0, the sender MUST only send further PUBLISH packets with
different Packet Identifiers when it is not waiting to receive acknowledgements.
At any given time a sender has only 1 outstanding application message inflight.

In the QoS 2 delivery protocol, the receiver:

- MUST respond with a PUBREC containing the Packet Identifier from the incoming PUBLISH packet, having accepted ownership of the Application Message
- If it has sent a PUBREC with a Reason Code of 0x80 or greater,
  the receiver MUST treat any subsequent PUBLISH packet that contains that Packet Identifier as being a new Application Message
- Until it has received the corresponding PUBREL packet, the receiver MUST acknowledge any subsequent PUBLISH packet with the same Packet Identifier by sending a PUBREC.
  It MUST NOT cause duplicate messages to be delivered to any onward recipients in this case
- MUST respond to a PUBREL packet by sending a PUBCOMP packet containing the same Packet Identifier as the PUBREL
- After it has sent a PUBCOMP, the receiver MUST treat any subsequent PUBLISH packet that contains that Packet Identifier as being a new Application Message
