# Derived from records/packets/connect.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_connect
  title: MQTT-SN v2.0 CONNECT packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 1
- id: connect_flags
  type: connect_flags
- id: will_flags
  type: will_flags
  if: connect_flags.will
- id: packet_identifier
  type: u2
- id: protocol_version
  type: u1
- id: keep_alive
  type: u2
- id: maximum_packet_size
  type: u2
- id: maximum_number_of_awake_messages
  type: u1
  if: connect_flags.mam
- id: session_expiry_interval
  type: u4
  if: connect_flags.sess_exp
- id: will_topic_alias_or_will_topic_name_length
  type: u2
  if: connect_flags.will
- id: will_topic_name
  size: will_topic_alias_or_will_topic_name_length
  if: (connect_flags.will) and (will_flags.will_topic_type == 3)
- id: will_payload_length
  type: u2
  if: connect_flags.will
- id: will_payload
  size: will_payload_length
  if: connect_flags.will
- id: authentication_method_length
  type: u1
  if: connect_flags.auth
- id: authentication_method
  size: authentication_method_length
  if: connect_flags.auth
- id: authentication_data_length
  type: u2
  if: connect_flags.auth
- id: authentication_data
  size: authentication_data_length
  if: connect_flags.auth
- id: client_identifier
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
  connect_flags:
    seq:
    - id: reserved
      type: b1
      valid: false
    - id: srv_sugg
      type: b1
    - id: net_addr
      type: b1
    - id: mam
      type: b1
    - id: sess_exp
      type: b1
    - id: auth
      type: b1
    - id: will
      type: b1
    - id: clean_start
      type: b1
  will_flags:
    seq:
    - id: reserved
      type: b3
      valid: 0
    - id: wil_retain
      type: b1
    - id: will_qos
      type: b2
    - id: will_topic_type
      type: b2
