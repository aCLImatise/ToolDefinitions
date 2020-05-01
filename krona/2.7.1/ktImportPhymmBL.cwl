#!/usr/bin/env cwl-runner

baseCommand:
- ktImportPhymmBL
class: CommandLineTool
cwlVersion: v1.0
id: ktimportphymmbl
inputs:
- doc: PhymmBL results files (results.03.*). Results can also be from Phymm alone
    (results.01.*), but [-p] must be specified. By default, separate datasets will
    be created for each input (see [-c]).
  id: phy_mm_bl_results
  inputBinding:
    position: 0
  type: string
- doc: Optional file listing query IDs with magnitudes, separated by tabs. This can
    be used to account for read length or contig depth to obtain a more accurate representation
    of abundance. By default, query sequences without specified magnitudes will be
    assigned a magnitude of 1. Magnitude files for assemblies in ACE format can be
    created with ktGetContigMagnitudes.
  id: magnitudes
  inputBinding:
    position: 1
  type: string
- doc: A name to show in the list of datasets in the Krona chart (if multiple input
    files are present and [-c] is not specified). By default, the basename of the
    file will be used. _________
  id: name
  inputBinding:
    position: 2
  type: string