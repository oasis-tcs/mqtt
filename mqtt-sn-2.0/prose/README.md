# MQTT for Sensor Networks Version 2.0 — Prose

The `prose` folder holds the editable source and the publication-ready delivery items
for the MQTT for Sensor Networks (MQTT-SN) v2.0 specification.

## Delivery channels

The `share/` folder contains four rendered artifacts:

| Channel | File                         | Description                                                                     |
|:--------|:-----------------------------|:--------------------------------------------------------------------------------|
| GFM+    | `mqtt-sn-v2.0-draft.md`      | Single-file GitHub-flavored Markdown; renders on Codeberg, GitHub, and GitLab   |
| HTML    | `mqtt-sn-v2.0-draft.html`    | Self-contained HTML with OASIS styling and embedded images; open in any browser |
| PDF     | `mqtt-sn-v2.0-draft.pdf`     | Print-ready PDF via nide + pandoc + typst                                       |
| IR      | `mqtt-sn-v2.0-draft.ir.json` | Intermediate representation; input for downstream tooling                       |


Four additional supportive artifacts will be generated in the `share/`folder after a successful rendering run (assuming `pip install blake3` has been executed for the python environment):

| File                               | Description                                                |
|:-----------------------------------|:-----------------------------------------------------------|
| `mqtt-sn-v2.0-draft.manifest.json` | Content manifest with per-channel hashes                   |
| `mqtt-sn-v2.0-draft.pdf.sha256`    | SHA-256 checksum of the PDF                                |
| `mqtt-sn-v2.0-draft.pdf.blake3`    | BLAKE3 checksum of the PDF                                 |
| `mqtt-sn-v2.0-draft.typ`           | Generated typst source (input used to produce the PDF)     |

`make packet-dictionary` adds the machine-readable packet dictionary:

| File                                         | Description                                                    |
|:---------------------------------------------|:---------------------------------------------------------------|
| `mqtt-sn-v2.0-draft-packet-dictionary.json`  | Every packet's layout: fields, bit fields, presence conditions, length symbols |
| `schema/packet-dictionary.schema.json`       | JSON schema of the packet dictionary                           |

`make derive` also writes `kaitai/`: one [Kaitai Struct](https://kaitai.io) description (`.ksy`) per packet and
`mqtt_sn_packet.ksy`, which selects the packet by its type; the Kaitai compiler turns them into parsers for many
programming languages. `make kaitai-test` (in `edit/`) checks them against the packet vectors.

## Building

All targets are defined in `edit/makefile`.
Run commands from the `edit/` directory.

```
make          # all channels, quick: no cleaning, no gates (default)
make pdf      # PDF via typst
make quality  # run spec and OASIS baseline quality checks
make release  # before a PR or release: everything from scratch, every gate, manifest, validation
```

## Source layout

The source lives in `edit/src/` assembled per `edit/etc/bind.txt`.
Images are in `edit/src/images/` and are embedded as data-URLs in the HTML output.
Normative statements, packet layouts, code tables, client states and roles are authored as records in
`edit/records/`; the corresponding parts of `edit/src/` (marked statements, Appendix B, those tables, the packet
figure sources) are generated from them by `make derive`.
See `edit/README.md` for the full authoring reference, including which files are generated, and
`edit/records/README.md` for the record fields.
