# Derived from records/packets/subscribe-with-topic-data.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_subscribe_with_topic_data
  title: MQTT-SN v2.0 SUBSCRIBE WITH TOPIC DATA packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 8
- id: subscribe_flags
  type: subscribe_flags
- id: packet_identifier
  type: u2
- id: topic_data
  type: u2
types:
  packet_length:
    doc: 'The Length field: 1 byte, or 0x01 followed by a 2 byte length (section 2.1.2).'
    seq:
    - id: first
      type: u1
    - id: extended
      type: u2
      if: first == 1
    instances:
      value:
        value: 'first == 1 ? extended : first'
  subscribe_flags:
    seq:
    - id: no_local
      type: b1
    - id: qos
      type: b2
    - id: rap
      type: b1
    - id: retain_handling
      type: b2
    - id: topic_type
      type: b2
