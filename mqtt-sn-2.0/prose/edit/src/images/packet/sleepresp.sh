packet=sleepresp
bytefield-svg -s "${packet}"-packet-diagram.edn -o "${packet}"-packet-diagram.svg
svgexport "${packet}"-packet-diagram.svg "${packet}"-packet-diagram.png '100%'
