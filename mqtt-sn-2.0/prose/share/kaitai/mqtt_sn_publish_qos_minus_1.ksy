# Derived from records/packets/publish-qos-minus-1.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_publish_qos_minus_1
  title: MQTT-SN v2.0 PUBLISH QOS MINUS 1 packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 3
- id: publish_qos_1_flags
  type: publish_qos_1_flags
- id: topic_alias
  type: u2
  if: publish_qos_1_flags.topic_type == 1
- id: topic_short_name_1
  type: u1
  if: 'false'
- id: topic_short_name_2
  type: u1
  if: 'false'
- id: topic_name_length
  type: u2
  if: publish_qos_1_flags.topic_type == 3
- id: f_0x00_fixed_field_value
  type: u1
- id: f_0x00_fixed_field_value_2
  type: u1
- id: topic_name
  size: topic_name_length
  if: publish_qos_1_flags.topic_type == 3
- id: payload
  size-eos: true
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
  publish_qos_1_flags:
    seq:
    - id: dup
      type: b1
      valid: false
    - id: qos
      type: b2
      valid: 3
    - id: retain
      type: b1
    - id: reserved
      type: b2
      valid: 0
    - id: topic_type
      type: b2
