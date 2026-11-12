# Derived from records/packets/subscribe.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_subscribe
  title: MQTT-SN v2.0 SUBSCRIBE packet
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
- id: topic_alias
  type: u2
  if: subscribe_flags.topic_type == 0 or subscribe_flags.topic_type == 1
- id: topic_filter
  size-eos: true
  if: subscribe_flags.topic_type == 3
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
