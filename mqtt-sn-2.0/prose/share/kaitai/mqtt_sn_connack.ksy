# Derived from records/packets/connack.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_connack
  title: MQTT-SN v2.0 CONNACK packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 2
- id: connack_flags
  type: connack_flags
- id: packet_identifier
  type: u2
- id: reason_code
  type: u1
- id: session_expiry_interval
  type: u4
  if: connack_flags.sess_exp
- id: server_keep_alive
  type: u2
  if: connack_flags.server_ka
- id: authentication_method_length
  type: u1
  if: connack_flags.auth
- id: authentication_method
  size: authentication_method_length
  if: connack_flags.auth
- id: authentication_data_length
  type: u2
  if: connack_flags.auth
- id: authentication_data
  size: authentication_data_length
  if: connack_flags.auth
- id: assigned_client_identifier
  size-eos: true
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
  connack_flags:
    seq:
    - id: reserved
      type: b4
      valid: 0
    - id: auth
      type: b1
    - id: server_ka
      type: b1
    - id: sess_exp
      type: b1
    - id: sess_pres
      type: b1
