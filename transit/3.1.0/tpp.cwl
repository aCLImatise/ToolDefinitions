#!/usr/bin/env cwl-runner

baseCommand:
- tpp
class: CommandLineTool
cwlVersion: v1.0
id: tpp
inputs:
- doc: "# if multiple replicons/genomes/contigs/sequences were provided in -ref, give\
    \ them names. # Enter 'auto' for autogenerated ids."
  id: replicon_ids
  inputBinding:
    prefix: -replicon-ids
  type: string