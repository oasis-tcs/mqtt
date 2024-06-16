# Note

> The implementations in this folder are presumably not relevant for MQTT-SN v2.0
> to keep similarity with MQTT v5.0 Packe Diagram implementations.
> Please see the diagrams in the sibling folder `[../packet/](../packet/)`.

# Package Diagrams (Non-Table)

The diagrams representing the bytefields of MQTT-SN packages
in a manner deviating slightly from the incoming draft as well as from
the existing MQTT v5.0 specification.

Byte and bit offsets (row and column lables) as hex numbers and more
as typical in bit-/byte-field diagrams elsewhere.

> We probably want to instead keep the similarity with the table
> like display (../packet/README.md) to better align with MQTT v2.0.

## Tools

Open source tool `bytefield-svg` (and in case rasterization is needed `svgexport`).

Source of `bytefield-svg` is at <https://github.com/Deep-Symmetry/bytefield-svg/tree/main>.
Additional documentation of the domain specific language (DSL) essentially clojure based is
at <https://bytefield-svg.deepsymmetry.org/bytefield-svg/>.

Both tools can be installed e.g. per `npm` (the node package manager) or the other 42 such managers:

```console
❯ npm install -g bytefield-svg
❯ npm install -g svgexport
```

### Usage

The source files are in Clojure using the functions of the `bytefield-svg` package as a Domain Specific Language (DSN):

Example `GWINFO`):

```clojure
;; This is the source for 3.1.3 GWINFO package diagram of MQTT-SN v2.0.
(def boxes-per-row 8)
(def box-width 70)
(def left-margin 20)
(defattrs :cursive {:font-family "Arial" :font-size 18 :font-style "italic"})
(defattrs :byte {:span 8})

(draw-column-headers {:labels (str/split "7,6,5,4,3,2,1,0" #",")})
(draw-box "Length" :byte)
(draw-box "Packet Type" :byte)
(draw-box "GwId" :byte)
(draw-gap (text "GwAdd" :plain [:cursive "?"]) :byte)
(draw-bottom)
```

Example of rendering of SVG from these text files (and subsequent rasterization to PNG files):

```console
❯ bytefield-svg -s gwinfo.edn -o gwinfo.svg
❯ svgexport gwinfo.svg gwinfo.png '100%'
```

Notice the indication of a trailing variable number of bytes for the optional 
GwAdd field in the following rendition:

!["Rasterized GWINFO package diagram"](gwinfo.png "Rasterized GWINFO package diagram")

Processing all (blunt bash hack):

```bash
❯ cd /some/where && for f in ./*.edn; \
  do stem="${f%.*}"; bytefield-svg -s "${stem}.edn" -o "${stem}.svg" \
    && svgexport "${stem}.svg" "${stem}.png" '100%' \
    && printf "processed %s\n" "${stem}.edn"; \
  done
/some/where/advertise.svg /some/where/advertise.png png 100% 1x 0:0:581:166 581:166
processed ./advertise.edn
/some/where/gwinfo.svg /some/where/gwinfo.png png 100% 1x 0:0:581:206 581:206
processed ./gwinfo.edn
/some/where/searchgv.svg /some/where/searchgv.png png 100% 1x 0:0:581:106 581:106
processed ./searchgv.edn
```

## What does "Non-Table" mean?

Here non-table indicates that these representations are freed from using a
table like implementation with textual row and column headers.
