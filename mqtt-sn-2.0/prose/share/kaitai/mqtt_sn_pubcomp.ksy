# Derived from records/packets/pubcomp.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_pubcomp
  title: MQTT-SN v2.0 PUBCOMP packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 7
- id: packet_identifier
  type: u2
- id: reason_code
  type: u1
  if: not _io.eof
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
