#!/usr/bin/env cwl-runner

baseCommand:
- anvi-export-gene-calls
class: CommandLineTool
cwlVersion: v1.0
id: anvi-export-gene-calls
inputs:
- doc: Anvi'o contigs database generated by 'anvi-gen- contigs'
  id: contigs_db
  inputBinding:
    prefix: --contigs-db
  type: string
- doc: File path to store results.
  id: output_file
  inputBinding:
    prefix: --output-file
  type: File
- doc: Which gene caller(s) would you like to export gene calls for? If providing
    multiple they should be comma- separated (no spaces). If you don't know, use --list-
    gene-callers
  id: gene_caller
  inputBinding:
    prefix: --gene-caller
  type: string
- doc: List available gene callers in the contigs database and quit.
  id: list_gene_callers
  inputBinding:
    prefix: --list-gene-callers
  type: boolean
- doc: By default, exported gene calls have an amino acid sequences column in the
    output. Turn this behavior off with this flag
  id: skip_sequence_reporting
  inputBinding:
    prefix: --skip-sequence-reporting
  type: boolean