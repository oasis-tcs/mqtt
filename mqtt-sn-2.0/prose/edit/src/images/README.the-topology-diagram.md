# Notes on the Construction of the Topology Diagram

I could have used my honest spacemacs or maybe chalk and a board,
but in this case (I was late):

- I used https://asciiflow.com/ to draw the boxes, connections,
  and regions as well as labelled the entities
- Copied and pasted into my text editor du jour (via clipboard)
  as basic ASCII
- Removed every second pipe symbol in the region border
- Fed the text file into asvg
- Used svgexport with '100%' to export into PNG format

Revision report (changes made compared to the source diagram):

1. Unified the arrow types
2. Added a third client for symmetrie to the aggregating gateway
   use case
3. moved the MQTT broker downwards to temove the need for diagona lines
   and emphasize the pass through logic of the transparent gateway
4. Used only rectangular boxes (not circle and rectangle)
   to further reduce the message of the visual
5. As agreed, removed the decoupled part of the MQTT-SN "Broker" 
