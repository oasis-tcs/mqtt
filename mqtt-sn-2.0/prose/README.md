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

## Building

All targets are defined in `edit/makefile`.
Run commands from the `edit/` directory.

```
make          # GFM+ and HTML (default)
make pdf      # PDF via typst
make release  # all channels + manifest + validation
make quality  # run spec and OASIS baseline quality checks
```

## Source layout

The source lives in `edit/src/` assembled per `edit/etc/bind.txt`.
Images are in `edit/src/images/` and are embedded as data-URLs in the HTML output.
See `edit/README.md` for the full authoring reference.
