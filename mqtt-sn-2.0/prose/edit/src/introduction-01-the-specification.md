<!-- transformation-note: left upstream numbering of headings for verification -->
## 1.1 MQTT For Sensor Networks (MQTT-SN){#mqtt-for-sensor-networks-mqtt-sn}

Sensor Networks are simple, low cost and easy to deploy, they are typically used to provide, event detection,
monitoring, automation, process control and more. Sensor Networks often comprise of many battery-powered sensors and
actuators, each containing a limited amount of storage and processing capability. They usually communicate wirelessly.

Sensor Networks are self-forming, continually change, and do not have any central control. The wireless network
connections and processing nodes will fail, and the batteries will run out. The nodes will be replaced, added or removed
in an unplanned way. The identities of the devices are usually created when they are manufactured, this avoids the need
for specialist configuration when they are deployed. Applications running outside the Sensor Network do not need to know
the details of the devices in it. The applications consume information from the sensors and send instructions to
actuators based only on labels created by the application designers. The labels are called Topic Names in the MQTT and
MQTT-SN protocols. The MQTT-SN implementation carries the information between a set of applications and the correct set
of devices based on its knowledge of the network and the applications designer’s choice of Topic Names.

Consider an example of a medicine tracking application. The application needs to know the location and temperature of
the medicine, but it does not want to concern itself with the network details of the devices providing the data. It may
be that the number and types of the devices changes over time. There may also be other applications using the same
sensor data for other purposes. The model is that the devices and applications produce and consume data to and from the
Topics rather than the other devices and applications.

This MQTT-SN specification is a variant of the MQTT version 5 specification. It is adapted to exploit low power and low
bandwidth wireless networks. Low power wireless radio links have higher numbers of transmission errors compared to more
powerful networks because they are more susceptible to interference and fading of the radio signals. They also have
lower transmission rates.

For example, wireless networks based on the IEEE 802.15.4 standard used by Zigbee have a maximum bandwidth of 250 kbit/s
in the 2.4 GHz band. To reduce transmission errors the packets are kept short. The maximum packet length at the physical
layer is 128 bytes and half of these may be used for Media Access Control and security.

The MQTT-SN protocol is optimized for implementation on low-cost, battery-operated devices with limited processing and
storage resources. The capabilities are kept simple and the specification allows partial implementations.

<!-- transformation-note: left upstream numbering of headings for verification -->
### 1.1.1 MQTT-SN and MQTT Differences{#mqtt-sn-and-mqtt-differences}

MQTT and MQTT-SN specifications are similar in many ways and meant to interoperate with each other, but the two
specifications are independent of each other.

MQTT-SN can work isolated from other networks or in conjunction with MQTT. The main differences between MQTT-SN and MQTT
are:

1. MQTT-SN uses separate packets to transfer the Will Topic and Will Payload if they are used.
   The Will Topic and Will Payload can be modified during the lifetime of a Session.
1. In addition to Topic Alias and long Topic Names MQTT-SN allows predefined and short two-byte Topic Names.
1. If the network supports broadcast, Gateway discovery can be implemented, otherwise the Gateway addresses must be
   configured in the nodes.
1. The Will message is part of the Session State and is discarded as part of Clean Start processing.
1. Support for sleeping clients allows battery operated devices to enter a low power mode.
   In this state, messages for the client are buffered by the Gateway and delivered when the client wakes.
1. A new Quality of Service level (OUT OF BAND) is introduced in MQTT-SN, allowing devices to publish without a GW
   session having been established.
1. MQTT-SN doesn’t have any requirement on the underlying transport and it can use connectionless network transports
   such as User Datagram Protocol (UDP).
1. MQTT-SN introduced the Protection packet for message-based security based on symmetric cryptography.
