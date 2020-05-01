#!/usr/bin/env cwl-runner

baseCommand:
- novoindex
class: CommandLineTool
cwlVersion: v1.0
id: novoindex
inputs:
- doc: -k 99 -s 9 -m indexfile sequencefiles....
  id: novo_index
  inputBinding:
    position: 0
  type: string
- doc: is the filename for the indexed reference sequence generated by novoindex.
  id: index_file
  inputBinding:
    position: 0
  type: string
- doc: a list of sequence files in fasta format to be included in the index.
  id: sequence_files
  inputBinding:
    position: 1
  type: string
- doc: 'name      sets the an internal name for the reference sequence index. This
    is used in report headers and as the AS: field in SAM SQ record. Defaults to the
    indexfile name.'
  id: n
  inputBinding:
    prefix: -n
  type: boolean