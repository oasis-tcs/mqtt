# Records: what editors author

The normative content that is structured by nature lives here as YAML records. `make derive` writes everything
derived from them; `make check` fails when a derived file no longer matches its records (`make sections`, and so
every build, runs it first). Edit a record, run `make derive`, review the diff of record and views together.

| Record                      | Holds                                                         | Derived from it                                        |
|:----------------------------|:--------------------------------------------------------------|:-------------------------------------------------------|
| `statements/<file>.yaml`    | the numbered normative statements of one prose file           | each `«...»` mark in that file; Appendix B (all rows)  |
| `packets/<packet>.yaml`     | the layout of one packet: fields, bit fields, groups, presence | `src/images/packet/<...>.edn` (the figure source); the rows of the packet dictionary; `views/packet-vectors.json` |
| `tables/<table>.yaml`       | a table of the prose: packet types, packet identifiers, reason codes, topic types, client states, session timers | that table in its prose file |
| `states/server-view.yaml`   | the transitions of the Server's view of Client states and the state-dependent sending rules | `views/states/server-view.md` |
| `roles.yaml`                | the roles statements bind (Client, Server, Forwarder)         | `views/roles/<role>.md`                                |

## For reviewers

Start with `../views/findings.md`, then read a record next to the prose or figure it generates. Every check that
produces a finding is in `../bin/spec_records.py` (functions ending in `_findings` and `findings`).

## Statements

To add a statement, add a record (`id`, `text`, optionally `standalone` and `binds`) and write `«MQTT-SN-x.y-n»` at
its place in the prose; derive expands it into the full mark and adds the Appendix B row. Never edit a mark or
Appendix B by hand. `binds` names the roles; `binds-by` says why it was assigned when it was seeded (review it).

## Packet layouts

A layout is a list of items:

- `field` (with `bytes` when more than one; drawn as MSB ... LSB rows)
- `bits` with `flags` (name, width) and `values` (one character per bit, or [value, width] pairs)
- `variable` (a variable-length field; `symbol` names its length, or `bytes` gives a fixed size)
- `group` with `items`: fields that are present together

`present-if` makes an item or group conditional: `{flag: Sess Exp}`, `{field: Topic Type, is: [Topic Name]}`,
`{field: Crypto Length, greater: 0}` or `optional`. A conditional group or field with a `symbol` contributes that
symbol to the offsets after it. From this, derive generates the cursive notes, the symbol equations such as
`(S=4+AM or AM)` and every address label such as `11+AM`.

What a record stores beyond that is an override and is reported in `views/findings.md`: `at` (an address label the
figure shows differently, or one that cannot be computed after alternatives of different size), and `boxes`
(single boxes drawn differently from the common style: index -> label, notes or attrs). Deleting an override makes
the figure follow the convention.

## Views (generated, never edit)

- `views/findings.md`: what derive noticed without refusing to derive (contradictions between figure, tables and
  statements; notation drift; statements without a role)
- `views/packet-vectors.json`: per packet one byte sequence for each combination of presence conditions, with the
  field offsets; derive checks every address label of the figure against these real offsets
- `views/roles/<role>.md`, `views/states/server-view.md`
- `../share/mqtt-sn-v2.0-draft-packet-dictionary.json` (`make packet-dictionary`): the rows now come from the
  layout records, with `present_if` and `length_symbol`
- `../share/kaitai/`: one Kaitai Struct `.ksy` per packet layout (presence as `if:` on the flags, sizes from the
  preceding length field or the end of the packet) and `mqtt_sn_packet.ksy`, which dispatches on the packet type.
  Where the records cannot give a size or a condition, the parse ends in an explicit `rest` field and
  `views/findings.md` says why. `make kaitai-test` compiles them and parses every vector of `views/packet-vectors.json`
  (each variable-length field there carries 2 bytes, with its length field set accordingly).

## Migration

`bin/spec_records.py migrate <statements|packets|codes|roles>` seeded the records once from the prose and the
`.edn` sources of this branch's base; it refuses to overwrite records. Two figures stay hand-written:
`structure-packet-diagram.edn` and `mqtt-basic-bit-diagram.edn` (they are not packets).
