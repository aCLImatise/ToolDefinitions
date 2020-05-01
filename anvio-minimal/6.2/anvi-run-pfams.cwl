#!/usr/bin/env cwl-runner

baseCommand:
- anvi-run-pfams
class: CommandLineTool
cwlVersion: v1.0
id: anvi-run-pfams
inputs:
- doc: Anvi'o contigs database generated by 'anvi-gen- contigs'
  id: contigs_db
  inputBinding:
    prefix: --contigs-db
  type: string
- doc: The directory path for your Pfam setup. Anvi'o will try to use the default
    path if you do not specify anything.
  id: pfam_data_dir
  inputBinding:
    prefix: --pfam-data-dir
  type: string
- doc: Maximum number of threads to use for multithreading whenever possible. Very
    conservatively, the default is 1. It is a good idea to not exceed the number of
    CPUs / cores on your system. Plus, please be careful with this option if you are
    running your commands on a SGE --if you are clusterizing your runs, and asking
    for multiple threads to use, you may deplete your resources very fast.
  id: num_threads
  inputBinding:
    prefix: --num-threads
  type: string