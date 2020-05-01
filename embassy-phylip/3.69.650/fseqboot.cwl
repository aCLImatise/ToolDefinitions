#!/usr/bin/env cwl-runner

baseCommand:
- fseqboot
class: CommandLineTool
cwlVersion: v1.0
id: fseqboot
inputs:
- doc: properties File of input categories
  id: categories
  inputBinding:
    prefix: -categories
  type: boolean
- doc: properties Weights file
  id: weights
  inputBinding:
    prefix: -weights
  type: boolean
- doc: 'menu       [b] Choose test (Values: b (Bootstrap); j (Jackknife); c (Permute
    species for each character); o (Permute character order); s (Permute within species);
    r (Rewrite data))'
  id: test
  inputBinding:
    prefix: -test
  type: boolean
- doc: boolean    [N] Print out the data at start of run
  id: print_data
  inputBinding:
    prefix: -printdata
  type: boolean