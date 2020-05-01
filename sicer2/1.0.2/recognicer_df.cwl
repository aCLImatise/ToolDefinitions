#!/usr/bin/env cwl-runner

baseCommand:
- recognicer_df
class: CommandLineTool
cwlVersion: v1.0
id: recognicer_df
inputs:
- doc: ''
  id: use
  inputBinding:
    position: 0
  type: string
- doc: ''
  id: more
  inputBinding:
    position: 1
  type: string
- doc: ''
  id: information
  inputBinding:
    position: 2
  type: string
- doc: Names of the sample file you wish to run RECOGNICER on. This can either be
    the relative or the absolute path of the file. Must be in BED or BAM format.
  id: treatment_file
  inputBinding:
    prefix: --treatment_file
  type:
    items: string
    type: array
- doc: '[CONTROL_FILE [CONTROL_FILE ...]], -c [CONTROL_FILE [CONTROL_FILE ...]] Name
    of the control library in BED or BAM format. This can either be the relative or
    the absolute path of the file. If you wish to run RECOGNICER without a control
    library, simply do not enter the file.'
  id: control_file
  inputBinding:
    prefix: --control_file
  type: boolean
- doc: 'The species/genome used (ex: hg38)'
  id: species
  inputBinding:
    prefix: --species
  type: string
- doc: The number of copies of indentical reads allowed in a library. Default value
    is 1
  id: redundancy_threshold
  inputBinding:
    prefix: --redundancy_threshold
  type: string
- doc: Resolution of RECOGNICER. Default value is 200 (bp)
  id: window_size
  inputBinding:
    prefix: --window_size
  type: string
- doc: The amount of shift from the beginning of a read to the center of the DNA fragment
    represented by the read. Default value is 150 (bp).
  id: fragment_size
  inputBinding:
    prefix: --fragment_size
  type: string
- doc: Effective genome as fraction of the genome size. Default value is 0.74
  id: effective_genome_fraction
  inputBinding:
    prefix: --effective_genome_fraction
  type: string
- doc: Remove all islands with an false_discovery_rate below cutoff. Default value
    is 0.01.
  id: false_discovery_rate
  inputBinding:
    prefix: --false_discovery_rate
  type: string
- doc: Cutoff for identification of significant changes been wild-type library and
    knockout library. Only provide a value when comparing two libraries.
  id: false_discovery_rate_df
  inputBinding:
    prefix: --false_discovery_rate_df
  type: string
- doc: Path of the directory in which results will be stored. Default path is the
    current path
  id: output_directory
  inputBinding:
    prefix: --output_directory
  type: string
- doc: 'Step Size: the number of windows in one graining unit. Used for RECOGNICER
    algorithm'
  id: step_size
  inputBinding:
    prefix: --step_size
  type: string
- doc: 'Step Score: The minimum number of positive elements in the graining unit to
    call the unit positive. Used for RECOGNICER algorithm'
  id: step_score
  inputBinding:
    prefix: --step_score
  type: string
- doc: "CPU Core Count: The number of CPU cores RECOGNICER program will use when executing\
    \ multi-processing tasks. Ideal core count is the species' number of chromosomes.\
    \ Default value is the maximum number of cores avaiable in the system."
  id: cpu
  inputBinding:
    prefix: --cpu
  type: string
- doc: 'Output Significant Reads: Enter "--significant_reads" to have SICER produce
    a BED file of treatment reads filtered by significant islands and WIG file of
    filtered reads binned into windows'
  id: significant_reads
  inputBinding:
    prefix: --significant_reads
  type: boolean
- doc: increase console output verbosity
  id: verbose
  inputBinding:
    prefix: --verbose
  type: boolean