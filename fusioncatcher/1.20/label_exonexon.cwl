#!/usr/bin/env cwl-runner

baseCommand:
- label_exonexon.py
class: CommandLineTool
cwlVersion: v1.0
id: label_exonexon.py
inputs:
- doc: The input GTF file containing the genome annotation.
  id: gtf
  inputBinding:
    prefix: --gtf
  type: string
- doc: The input file containing the fusion (chromosomal) coordinates for each fusion
    genes.
  id: input
  inputBinding:
    prefix: --input
  type: string
- doc: The output file where the frame predictions are written.
  id: output
  inputBinding:
    prefix: --output
  type: string
- doc: Do not print status messages to stdout.
  id: quiet
  inputBinding:
    prefix: --quiet
  type: boolean
- doc: 'Daniel Nicorici, E-mail: Daniel.Nicorici@gmail.com'
  id: author
  inputBinding:
    prefix: --author
  type: string