# Derived from records/packets/protection-encapsulation.yaml by bin/spec_records.py -- edit the record, not this file.
meta:
  id: mqtt_sn_protection_encapsulation
  title: MQTT-SN v2.0 PROTECTION ENCAPSULATION packet
  endian: be
  bit-endian: be
seq:
- id: length
  type: packet_length
- id: packet_type
  type: u1
  valid: 255
- id: protection_flags
  type: protection_flags
- id: protection_scheme
  type: u1
- id: sender_identifier
  size: 8
- id: random
  size: 4
- id: rest
  size-eos: true
  doc: 'Not parsed further: the size of "Crypto Material" is not derivable from the records.'
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
  protection_flags:
    seq:
    - id: authentication_tag_length
      type: b4
    - id: crypto_length_c
      type: b2
    - id: counter_length_m
      type: b2
