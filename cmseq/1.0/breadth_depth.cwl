#!/usr/bin/env cwl-runner

baseCommand:
- breadth_depth.py
class: CommandLineTool
cwlVersion: v1.0
id: breadth_depth.py
inputs:
- doc: The file on which to operate
  id: bam_file
  inputBinding:
    position: 0
  type: string
- doc: ID, --contig REFERENCE ID Focus on a subset of references in the BAM file.
    Can be a list of references separated by commas or a FASTA file (the IDs are used
    to subset)
  id: c
  inputBinding:
    prefix: -c
  type: string
- doc: 'If set unmapped (FUNMAP), secondary (FSECONDARY), qc- fail (FQCFAIL) and duplicate
    (FDUP) are excluded. If unset ALL reads are considered (bedtools genomecov style).
    Default: unset'
  id: f
  inputBinding:
    prefix: -f
  type: boolean
- doc: Sort and index the file
  id: sort_index
  inputBinding:
    prefix: --sortindex
  type: boolean
- doc: Minimum Reference Length for a reference to be considered
  id: min_len
  inputBinding:
    prefix: --minlen
  type: long
- doc: 'Minimum base quality. Bases with quality score lower than this will be discarded.
    This is performed BEFORE --mincov. Default: 30'
  id: min_qual
  inputBinding:
    prefix: --minqual
  type: long
- doc: 'Minimum position coverage to perform the polymorphism calculation. Position
    with a lower depth of coverage will be discarded (i.e. considered as zero-coverage
    positions). This is calculated AFTER --minqual. Default: 1'
  id: min_cov
  inputBinding:
    prefix: --mincov
  type: long
- doc: Number of nucleotides that are truncated at either contigs end before calculating
    coverage values.
  id: truncate
  inputBinding:
    prefix: --truncate
  type: string