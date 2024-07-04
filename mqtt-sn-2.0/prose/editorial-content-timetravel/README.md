# Editorial Content Timetravel

The purpose of this place is to allow timetravel along the content changes in a linear way back and forth.

As we for now edit the draft MQTT-SN v2.0 workproduct behind the curtain of a cost free but proprietary service,
the other file in this folder named `content-autobahn.md` may help to track back changes and esp. the consistency of changes.

The filename shall emphasize that this is not the workproduct but a temporary derived form for working on the text.
In this way, the text changes can be inspected via merged pull request / diffs.
Also, we can select specific tags / commits and search in the single text file to better verify the consistency of our work.

We generate the file automatically per pandoc wit a column width of 150 characters / columns as to minimize the noise of diffs. Source is the download as docx file and target format is markdown.

Example:

```console
❯ pandoc downloaded.docx -t markdown --columns=150 -o content-autobahn.md
```

## On the Selected Column Size

We tried the default, 142, 150, and 345 columns.

The default and 142 columns were too noisy (well 142 seemed too arbitrary).
The chosen variant with 150 columns is not too wide on modern screens and still reduces the noise.
The 345 column wide text enforces a lot of horizontal scrolling or does wrap (which both hinder the diff).
