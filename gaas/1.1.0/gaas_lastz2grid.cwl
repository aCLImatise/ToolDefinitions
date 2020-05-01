#!/usr/bin/env cwl-runner

baseCommand:
- gaas_lastz2grid.pl
class: CommandLineTool
cwlVersion: v1.0
id: gaas_lastz2grid.pl
inputs:
- doc: ''
  id: gaas_blat2gridpl
  inputBinding:
    position: 0
  type: string
- doc: name of the query genome file.
  id: query
  inputBinding:
    prefix: --query
  type: string
- doc: The name of the target genome file.
  id: target
  inputBinding:
    prefix: --target
  type: boolean
- doc: you want to define a particular queue to run the jobs
  id: queue
  inputBinding:
    prefix: --queue
  type: string
- doc: Define which grid to use, Slurm, Lsf or None. Default = Slurm.
  id: grid
  inputBinding:
    prefix: --grid
  type: boolean
- doc: Quiet mode
  id: quiet
  inputBinding:
    prefix: --quiet
  type: string
- doc: The name of the output directory.
  id: outdir
  inputBinding:
    prefix: --outdir
  type: string
- doc: description,
  id: a
  inputBinding:
    prefix: '- a'
  type: string
- doc: relevant information as possible,
  id: as
  inputBinding:
    prefix: '- as'
  type: string
- doc: used,
  id: the
  inputBinding:
    prefix: '- the'
  type: string
- doc: sample,
  id: a
  inputBinding:
    prefix: '- a'
  type: string
- doc: of the expected behaviour that is not occurring.
  id: an
  inputBinding:
    prefix: '- an'
  type: string