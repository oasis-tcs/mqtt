# Derived from records/packets/disconnect.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_disconnect
  title: MQTT-SN v2.0 DISCONNECT packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 14
- id: disconnect_flags
  type: disconnect_flags
- id: packet_identifier
  type: u2
  if: disconnect_flags.packetid
- id: session_expiry_interval
  type: u4
  if: disconnect_flags.sess_exp
- id: reason_code
  type: u1
  if: disconnect_flags.reason_c
- id: reason_string_optional
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
  disconnect_flags:
    seq:
    - id: reserved
      type: b5
      valid: 0
    - id: reason_c
      type: b1
    - id: sess_exp
      type: b1
    - id: packetid
      type: b1
