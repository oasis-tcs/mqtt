# Derived from records/packets/sleepresp.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_sleepresp
  title: MQTT-SN v2.0 SLEEPRESP packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 20
- id: sleepresp_flags
  type: sleepresp_flags
- id: packet_identifier
  type: u2
- id: sleep_duration
  type: u4
  if: sleepresp_flags.sleep_dur
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
  sleepresp_flags:
    seq:
    - id: reserved
      type: b7
      valid: 0
    - id: sleep_dur
      type: b1
