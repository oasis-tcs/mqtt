# MQTT-SN v2.0 — Delivery Artifacts

This folder contains the publication-ready artifacts built from the sources in `../edit/`.

## Artifacts

| File                               | Description                                                |
|:-----------------------------------|:-----------------------------------------------------------|
| `mqtt-sn-v2.0-draft.md`            | GFM+ single-file Markdown                                  |
| `mqtt-sn-v2.0-draft.html`          | Self-contained HTML with OASIS styling and embedded images |
| `mqtt-sn-v2.0-draft.ir.json`       | Intermediate representation (nide IR)                      |
| `mqtt-sn-v2.0-draft.manifest.json` | Content manifest with per-channel hashes                   |
| `mqtt-sn-v2.0-draft.pdf`           | PDF                                                        |
| `mqtt-sn-v2.0-draft.pdf.sha256`    | SHA-256 checksum of the PDF                                |
| `mqtt-sn-v2.0-draft.pdf.blake3`    | BLAKE3 checksum of the PDF                                 |
| `mqtt-sn-v2.0-draft.typ`           | Generated typst source (input used to produce the PDF)     |

## Verifying checksums

```sh
# SHA-256
shasum -a 256 --check mqtt-sn-v2.0-draft.pdf.sha256

# BLAKE3 (requires b3sum)
b3sum --check mqtt-sn-v2.0-draft.pdf.blake3
```

## Building

Run from the `../edit/` directory:

```sh
make          # GFM+ and HTML
make pdf      # PDF
make release  # all channels + manifest + validate
```

## Comparing versions

```sh
# Prose diff of the HTML against the last committed version
nide diff --mode prose mqtt-sn-v2.0-draft.html

# Reproducibility diff of the PDF
nide diff --mode repro mqtt-sn-v2.0-draft.pdf
```
