# Derived from records/packets/ and records/tables/packet-types.yaml by bin/spec_records.py.
meta:
  id: mqtt_sn_packet
  title: MQTT-SN v2.0 packet, by packet type
  endian: be
  imports:
  - mqtt_sn_advertise
  - mqtt_sn_auth
  - mqtt_sn_connack
  - mqtt_sn_connect
  - mqtt_sn_connection_encapsulation
  - mqtt_sn_disconnect
  - mqtt_sn_forwarder_encapsulation
  - mqtt_sn_gwinfo
  - mqtt_sn_pingreq
  - mqtt_sn_pingresp
  - mqtt_sn_protection_encapsulation
  - mqtt_sn_puback
  - mqtt_sn_pubcomp
  - mqtt_sn_publish
  - mqtt_sn_pubrec
  - mqtt_sn_pubrel
  - mqtt_sn_pubwos
  - mqtt_sn_regack
  - mqtt_sn_register
  - mqtt_sn_searchgw
  - mqtt_sn_sleepreq
  - mqtt_sn_sleepresp
  - mqtt_sn_suback
  - mqtt_sn_subscribe
  - mqtt_sn_unsuback
  - mqtt_sn_unsubscribe
  - mqtt_sn_wakeup
instances:
  length_first:
    pos: 0
    type: u1
  packet_type:
    pos: 'length_first == 1 ? 3 : 1'
    type: u1
  packet:
    pos: 0
    type:
      switch-on: packet_type
      cases:
        '0x01': mqtt_sn_connect
        '0x02': mqtt_sn_connack
        '0x03': mqtt_sn_publish
        '0x04': mqtt_sn_puback
        '0x05': mqtt_sn_pubrec
        '0x06': mqtt_sn_pubrel
        '0x07': mqtt_sn_pubcomp
        '0x08': mqtt_sn_subscribe
        '0x09': mqtt_sn_suback
        '0x0a': mqtt_sn_unsubscribe
        '0x0b': mqtt_sn_unsuback
        '0x0c': mqtt_sn_pingreq
        '0x0d': mqtt_sn_pingresp
        '0x0e': mqtt_sn_disconnect
        '0x0f': mqtt_sn_auth
        '0x10': mqtt_sn_register
        '0x11': mqtt_sn_regack
        '0x12': mqtt_sn_pubwos
        '0x13': mqtt_sn_sleepreq
        '0x14': mqtt_sn_sleepresp
        '0x15': mqtt_sn_wakeup
        '0x16': mqtt_sn_advertise
        '0x17': mqtt_sn_searchgw
        '0x18': mqtt_sn_gwinfo
        '0xfc': mqtt_sn_forwarder_encapsulation
        '0xfe': mqtt_sn_connection_encapsulation
        '0xff': mqtt_sn_protection_encapsulation
