# Derived from records/packets/register.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_register
  title: MQTT-SN v2.0 REGISTER packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 16
- id: register_flags
  type: register_flags
- id: packet_identifier
  type: u2
- id: topic_alias
  type: u2
  if: register_flags.topic_alias
- id: topic_name
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
  register_flags:
    seq:
    - id: reserved
      type: b7
      valid: 0
    - id: topic_alias
      type: b1
