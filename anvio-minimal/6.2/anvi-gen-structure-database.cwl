#!/usr/bin/env cwl-runner

baseCommand:
- anvi-gen-structure-database
class: CommandLineTool
cwlVersion: v1.0
id: anvi-gen-structure-database
inputs:
- doc: Anvi'o contigs database generated by 'anvi-gen- contigs'
  id: contigs_db
  inputBinding:
    prefix: --contigs-db
  type: string
- doc: By default, this program accesses the structure files it needs from an internal
    anvi'o database that can be set up with anvi-setup-pdb-database. If a required
    structure is not in this database, it will instead be downloaded from the RCSB
    PDB server. This parameter exists only if a) you created a database and b) it
    exists in a custom location. In this case, please provide that path here. Otherwise
    we vibing.
  id: pdb_db
  inputBinding:
    prefix: --pdb-db
  type: string
- doc: A file with anvi'o gene caller IDs. There should be only one column in the
    file, and each line should correspond to a unique gene caller id (without a column
    header).
  id: genes_of_interest
  inputBinding:
    prefix: --genes-of-interest
  type: File
- doc: Gene caller ids. Multiple of them can be declared separated by a delimiter
    (the default is a comma). In anvi-gen-variability-profile, if you declare nothing
    you will get all genes matching your other filtering criteria. In other programs,
    you may get everything, nothing, or an error. It really depends on the situation.
    Fortunately, mistakes are cheap, so it's worth a try.
  id: gene_caller_ids
  inputBinding:
    prefix: --gene-caller-ids
  type: string
- doc: Output file path for the new database.
  id: output_db_path
  inputBinding:
    prefix: --output-db-path
  type: string
- doc: Modeling and annotating structures requires a lot of moving parts, each which
    have their own outputs. The output of this program is a structure database containing
    the pertinent results of this computation, however a lot of stuff doesn't make
    the cut. By providing a directory for this parameter you will get, in addition
    to the structure database, a directory containing the raw output for everything.
  id: dump_dir
  inputBinding:
    prefix: --dump-dir
  type: string
- doc: This parameter determines the number of predicted structures that are solved
    for a given protein. The original atomic positions for each model are perturbed
    by an amount defined by --deviation, which leads to differences between each model.
    Therefore, whichever of the N models is chosen to be the "best" model is more
    likely to be accurate when --num-models is high, since more of the solution space
    is searched. It should be kept in mind that the largest determinant of a model's
    accuracy is determined by the protein templates used, so no need to go overboard
    with an excessively large --num-models. The default is 1.
  id: num_models
  inputBinding:
    prefix: --num-models
  type: string
- doc: Deviation (angstroms)
  id: deviation
  inputBinding:
    prefix: --deviation
  type: string
- doc: Which database do you want to search the structures of? Default is "pdb_95".
    If you have your own database it must have either the extension .bin or .pir.
    If you don't have a database or don't know what this means, don't worry, we will
    both inform you and take care of you.
  id: modeller_database
  inputBinding:
    prefix: --modeller-database
  type: string
- doc: 'How should the best model be decided? The metric used could be any of GA341_score,
    DOPE_score, and molpdf. GA341 is an absolute measure, where a good model will
    have a score near 1.0, whereas anything below 0.6 can be considered bad. DOPE
    and molpdf scores are relative energy measures, where lower scores are better.
    DOPE has been generally shown to be a better distinguisher between good and bad
    models than molpdf. By default, DOPE is used. To learn more see the MODELLER tutorial:
    https://salilab.org/modeller/tutorial/basic.html.'
  id: scoring_method
  inputBinding:
    prefix: --scoring-method
  type: string
- doc: If provided, a very fast optimization is done for each model at the cost of
    accuracy. It is recommended to use a --num-models of 1, since the optimization
    is so crude that all models will likely converge to the same solution.
  id: very_fast
  inputBinding:
    prefix: --very-fast
  type: boolean
- doc: If a protein in the database has a proper percent identity to the gene of interest
    that is greater than or equal to --percent-identical-cutoff, then it is used as
    a template. Otherwise it is not. Here we define proper percent identity as the
    percentage of amino acids in the gene of interest that are identical to an entry
    in the database given the sequence length of the gene of interest. For example,
    if there is 100% identity between the gene of interest and the template over the
    length of the alignment, but the alignment length is only half of the gene of
    interest sequence length, then the proper percent identical is 50%. (This helps
    us avoid the inflation of identity scores due to only partially good matches).
    The default is 30.
  id: percent_identical_cut_off
  inputBinding:
    prefix: --percent-identical-cutoff
  type: string
- doc: "Generally speaking it is best to use as many templates as possible given that\
    \ they have high proper percent identity to the gene of interest. Taken from https://s\
    \ alilab.org/modeller/methenz/andras/node4.html: 'The use of several templates\
    \ generally increases the model accuracy. One strength of MODELLER is that it\
    \ can combine information from multiple template structures, in two ways. First,\
    \ multiple template structures may be aligned with different domains of the target,\
    \ with little overlap between them, in which case the modeling procedure can construct\
    \ a homology-based model of the whole target sequence. Second, the template structures\
    \ may be aligned with the same part of the target, in which case the modeling\
    \ procedure is likely to automatically build the model on the locally best template\
    \ [43,44]. In general, it is frequently beneficial to include in the modeling\
    \ process all the templates that differ substantially from each other, if they\
    \ share approximately the same overall similarity to the target sequence.' The\
    \ default is 5."
  id: max_number_templates
  inputBinding:
    prefix: --max-number-templates
  type: long
- doc: Dictionary of Secondary Structure of Proteins (DSSP) is a program that takes
    as its input a protein structure file and outputs predicted secondary structure
    (alpha helix, beta strand, etc.), measures of solvent accessibility, and hydrogen
    bonds for each residue in the protein. If for some reason you don't want this,
    provide this flag.
  id: skip_dssp
  inputBinding:
    prefix: --skip-DSSP
  type: boolean
- doc: The MODELLER program to use. For example, `mod9.19`. Anvi'o will try and find
    it if not provided
  id: modeller_executable
  inputBinding:
    prefix: --modeller-executable
  type: string
- doc: Anvi'o first tries to obtain template structures from a database (see --pdb-db
    for details). If the requested template does not exist in the database, its structure
    will be downloaded from the RCSB PDB server. However, if you don't have access
    to internet, or hate the RCSB PDB, provide this flag so that all operations of
    this program remain offline. If the template structure is not in the database,
    then no template structure for you.
  id: offline_mode
  inputBinding:
    prefix: --offline-mode
  type: boolean
- doc: Maximum number of threads to use for multithreading whenever possible. Very
    conservatively, the default is 1. It is a good idea to not exceed the number of
    CPUs / cores on your system. Plus, please be careful with this option if you are
    running your commands on a SGE --if you are clusterizing your runs, and asking
    for multiple threads to use, you may deplete your resources very fast.
  id: num_threads
  inputBinding:
    prefix: --num-threads
  type: string
- doc: How many items should be kept in memory before they are written do the disk.
    The default is 25 per thread. So a single-threaded job would have a write buffer
    size of 25, whereas a job with 4 threads would have a write buffer size of 4*25.
    The larger the buffer size, the less frequent the program will access to the disk,
    yet the more memory will be consumed since the processed items will be cleared
    off the memory only after they are written to the disk. The default buffer size
    will likely work for most cases. Please keep an eye on the memory usage output
    to make sure the memory use never exceeds the size of the physical memory. If
    --num-threads is 1, this parameter is ignored because the DB is written to after
    each gene
  id: write_buffer_size_per_thread
  inputBinding:
    prefix: --write-buffer-size-per-thread
  type: long