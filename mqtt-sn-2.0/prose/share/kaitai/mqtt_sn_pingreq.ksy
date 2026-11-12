# Derived from records/packets/pingreq.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_pingreq
  title: MQTT-SN v2.0 PINGREQ packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 12
- id: packet_identifier
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
