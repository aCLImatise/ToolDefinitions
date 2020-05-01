#!/usr/bin/env cwl-runner

baseCommand:
- anvi-get-split-coverages
class: CommandLineTool
cwlVersion: v1.0
id: anvi-get-split-coverages
inputs:
- doc: Anvi'o profile database
  id: profile_db
  inputBinding:
    prefix: --profile-db
  type: string
- doc: Split name.
  id: split_name
  inputBinding:
    prefix: --split-name
  type: string
- doc: Anvi'o contigs database generated by 'anvi-gen- contigs'
  id: contigs_db
  inputBinding:
    prefix: --contigs-db
  type: string
- doc: Collection name.
  id: collection_name
  inputBinding:
    prefix: --collection-name
  type: string
- doc: Bin name you are interested in.
  id: bin_id
  inputBinding:
    prefix: --bin-id
  type: string
- doc: File path to store results.
  id: output_file
  inputBinding:
    prefix: --output-file
  type: File
- doc: When declared, the program will list split names in the profile database and
    quite
  id: list_splits
  inputBinding:
    prefix: --list-splits
  type: boolean
- doc: Show available collections and exit.
  id: list_collections
  inputBinding:
    prefix: --list-collections
  type: boolean
- doc: List available bins in a collection and exit.
  id: list_bins
  inputBinding:
    prefix: --list-bins
  type: boolean