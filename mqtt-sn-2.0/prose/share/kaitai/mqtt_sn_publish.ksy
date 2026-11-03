# Derived from records/packets/publish.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_publish
  title: MQTT-SN v2.0 PUBLISH packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 3
- id: publish_flags
  type: publish_flags
- id: packet_identifier
  type: u2
  if: publish_flags.qos == 1 or publish_flags.qos == 2
- id: topic_alias_or_topic_name_length
  type: u2
- id: topic_name
  size: topic_alias_or_topic_name_length
  if: publish_flags.topic_type == 3
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
  publish_flags:
    seq:
    - id: dup
      type: b1
    - id: qos
      type: b2
    - id: retain
      type: b1
    - id: reserved
      type: b2
      valid: 0
    - id: topic_type
      type: b2
