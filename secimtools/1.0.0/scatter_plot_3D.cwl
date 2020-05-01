#!/usr/bin/env cwl-runner

baseCommand:
- scatter_plot_3D.py
class: CommandLineTool
cwlVersion: v1.0
id: scatter_plot_3d.py
inputs:
- doc: Input dataset in wide format.
  id: input
  inputBinding:
    prefix: --input
  type: string
- doc: Design file.
  id: design
  inputBinding:
    prefix: --design
  type: string
- doc: Name of the column with unique identifiers.
  id: id
  inputBinding:
    prefix: --ID
  type: string
- doc: Name of the column with groups.
  id: group
  inputBinding:
    prefix: --group
  type: string
- doc: Name of column for X values
  id: x
  inputBinding:
    prefix: --X
  type: string
- doc: Name of column for Y values
  id: y
  inputBinding:
    prefix: --Y
  type: string
- doc: Name of column for Z values
  id: z
  inputBinding:
    prefix: --Z
  type: string
- doc: Path of figure.
  id: figure
  inputBinding:
    prefix: --figure
  type: string
- doc: Name of the palette to use.
  id: palette
  inputBinding:
    prefix: --palette
  type: string
- doc: Name of a valid color scheme on the selected palette
  id: color
  inputBinding:
    prefix: --color
  type: string
- doc: camera viewing rotation
  id: rotation
  inputBinding:
    prefix: --rotation
  type: string
- doc: Camera vieweing elevation
  id: elevation
  inputBinding:
    prefix: --elevation
  type: string