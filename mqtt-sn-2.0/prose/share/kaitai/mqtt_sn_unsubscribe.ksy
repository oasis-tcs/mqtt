# Derived from records/packets/unsubscribe.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_unsubscribe
  title: MQTT-SN v2.0 UNSUBSCRIBE packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 10
- id: unsubscribe_flags
  type: unsubscribe_flags
- id: packet_identifier
  type: u2
- id: topic_alias
  type: u2
  if: unsubscribe_flags.topic_type == 0 or unsubscribe_flags.topic_type == 1
- id: topic_filter
  size-eos: true
  if: unsubscribe_flags.topic_type == 3
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
  unsubscribe_flags:
    seq:
    - id: reserved
      type: b6
      valid: 0
    - id: topic_type
      type: b2
