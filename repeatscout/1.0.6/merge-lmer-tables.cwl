#!/usr/bin/env cwl-runner

baseCommand:
- merge-lmer-tables.prl
class: CommandLineTool
cwlVersion: v1.0
id: merge-lmer-tables.prl
inputs:
- doc: ''
  id: no
  inputBinding:
    position: 0
  type: string
- doc: ''
  id: such
  inputBinding:
    position: 1
  type: string
- doc: ''
  id: file
  inputBinding:
    position: 2
  type: File
- doc: ''
  id: or
  inputBinding:
    position: 3
  type: string
- doc: ''
  id: directory
  inputBinding:
    position: 4
  type: Directory