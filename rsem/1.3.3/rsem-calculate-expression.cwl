#!/usr/bin/env cwl-runner

baseCommand:
- rsem-calculate-expression
class: CommandLineTool
cwlVersion: v1.0
id: rsem-calculate-expression
inputs:
- doc: SAM/BAM/CRAM formatted input file. If "-" is specified for the filename, the
    input is instead assumed to come from standard input. RSEM requires all alignments
    of the same read group together. For paired-end reads, RSEM also requires the
    two mates of any alignment be adjacent. In addition, RSEM does not allow the SEQ
    and QUAL fields to be empty. See Description section for how to make input file
    obey RSEM's requirements.
  id: input
  inputBinding:
    position: 0
  type: string
- doc: The name of the reference used. The user must have run 'rsem-prepare-reference'
    with this reference_name before running this program.
  id: reference_name
  inputBinding:
    position: 1
  type: string
- doc: The name of the sample analyzed. All output files are prefixed by this name
    (e.g., sample_name.genes.results)
  id: sample_name
  inputBinding:
    position: 2
  type: string
- doc: "/--num-threads <int> Number of threads to use. Both Bowtie/Bowtie2, expression\
    \ estimation and 'samtools sort' will use this many threads. (Default: 1)"
  id: p
  inputBinding:
    prefix: -p
  type: boolean
- doc: 'Input file contains alignments in SAM/BAM/CRAM format. The exact file format
    will be determined automatically. (Default: off)'
  id: alignments
  inputBinding:
    prefix: --alignments
  type: boolean
- doc: "If the header section of input alignment file does not contain reference sequence\
    \ information, this option should be turned on. <file> is a FAI format file containing\
    \ each reference sequence's name and length. Please refer to the SAM official\
    \ website for the details of FAI format. (Default: off)"
  id: fai
  inputBinding:
    prefix: --fai
  type: File
- doc: "Use Bowtie 2 instead of Bowtie to align reads. Since currently RSEM does not\
    \ handle indel, local and discordant alignments, the Bowtie2 parameters are set\
    \ in a way to avoid those alignments. In particular, we use options '--sensitive\
    \ --dpad 0 --gbar 99999999 --mp 1,1 --np 1 --score-min L,0,-0.1' by default. The\
    \ last parameter of '--score-min', '-0.1', is the negative of maximum mismatch\
    \ rate. This rate can be set by option '--bowtie2-mismatch-rate'. If reads are\
    \ paired-end, we additionally use options '--no-mixed' and '--no-discordant'.\
    \ (Default: off)"
  id: bowtie2
  inputBinding:
    prefix: --bowtie2
  type: boolean
- doc: "Use STAR to align reads. Alignment parameters are from ENCODE3's STAR-RSEM\
    \ pipeline. To save computational time and memory resources, STAR's Output BAM\
    \ file is unsorted. It is stored in RSEM's temporary directory with name as 'sample_name.bam'.\
    \ Each STAR job will have its own private copy of the genome in memory. (Default:\
    \ off)"
  id: star
  inputBinding:
    prefix: --star
  type: boolean
- doc: 'Use HISAT2 to align reads to the transcriptome according to Human Cell Atlast
    SMART-Seq2 pipeline. In particular, we use HISAT parameters "-k 10 --secondary
    --rg-id=$sampleToken --rg SM:$sampleToken --rg LB:$sampleToken --rg PL:ILLUMINA
    --rg PU:$sampleToken --new-summary --summary-file $sampleName.log --met-file $sampleName.hisat2.met.txt
    --met 5 --mp 1,1 --np 1 --score-min L,0,-0.1 --rdg 99999999,99999999 --rfg 99999999,99999999
    --no-spliced-alignment --no-softclip --seed 12345". If inputs are paired-end reads,
    we additionally use parameters "--no-mixed --no-discordant". (Default: off)'
  id: hisat2_hca
  inputBinding:
    prefix: --hisat2-hca
  type: boolean
- doc: "If gene_name/transcript_name is available, append it to the end of gene_id/transcript_id\
    \ (separated by '_') in files 'sample_name.isoforms.results' and 'sample_name.genes.results'.\
    \ (Default: off)"
  id: append_names
  inputBinding:
    prefix: --append-names
  type: boolean
- doc: 'Set the seed for the random number generators used in calculating posterior
    mean estimates and credibility intervals. The seed must be a non-negative 32 bit
    integer. (Default: off)'
  id: seed
  inputBinding:
    prefix: --seed
  type: string
- doc: 'By default, RSEM uses Dirichlet(1) as the prior to calculate posterior mean
    estimates and credibility intervals. However, much less genes are expressed in
    single cell RNA-Seq data. Thus, if you want to compute posterior mean estimates
    and/or credibility intervals and you have single-cell RNA-Seq data, you are recommended
    to turn on this option. Then RSEM will use Dirichlet(0.1) as the prior which encourage
    the sparsity of the expression levels. (Default: off)'
  id: single_cell_prior
  inputBinding:
    prefix: --single-cell-prior
  type: boolean
- doc: "Run RSEM's collapsed Gibbs sampler to calculate posterior mean estimates.\
    \ (Default: off)"
  id: calc_pm_e
  inputBinding:
    prefix: --calc-pme
  type: boolean
- doc: "Calculate 95% credibility intervals and posterior mean estimates. The credibility\
    \ level can be changed by setting '--ci-credibility-level'. (Default: off)"
  id: calc_ci
  inputBinding:
    prefix: --calc-ci
  type: boolean
- doc: '/--quiet Suppress the output of logging information. (Default: off)'
  id: q
  inputBinding:
    prefix: -q
  type: boolean
- doc: 'Sort BAM file aligned under transcript coordidate by read name. Setting this
    option on will produce deterministic maximum likelihood estimations from independent
    runs. Note that sorting will take long time and lots of memory. (Default: off)'
  id: sort_bam_by_read_name
  inputBinding:
    prefix: --sort-bam-by-read-name
  type: boolean
- doc: 'Do not output any BAM file. (Default: off)'
  id: no_bam_output
  inputBinding:
    prefix: --no-bam-output
  type: boolean
- doc: 'When RSEM generates a BAM file, instead of outputting all alignments a read
    has with their posterior probabilities, one alignment is sampled according to
    the posterior probabilities. The sampling procedure includes the alignment to
    the "noise" transcript, which does not appear in the BAM file. Only the sampled
    alignment has a weight of 1. All other alignments have weight 0. If the "noise"
    transcript is sampled, all alignments appeared in the BAM file should have weight
    0. (Default: off)'
  id: sampling_for_bam
  inputBinding:
    prefix: --sampling-for-bam
  type: boolean
- doc: "Generate a BAM file, 'sample_name.genome.bam', with alignments mapped to genomic\
    \ coordinates and annotated with their posterior probabilities. In addition, RSEM\
    \ will call samtools (included in RSEM package) to sort and index the bam file.\
    \ 'sample_name.genome.sorted.bam' and 'sample_name.genome.sorted.bam.bai' will\
    \ be generated. (Default: off)"
  id: output_genome_bam
  inputBinding:
    prefix: --output-genome-bam
  type: boolean
- doc: 'Sort RSEM generated transcript and genome BAM files by coordinates and build
    associated indices. (Default: off)'
  id: sort_bam_by_coordinate
  inputBinding:
    prefix: --sort-bam-by-coordinate
  type: boolean
- doc: "Set the maximum memory per thread that can be used by 'samtools sort'. <string>\
    \ represents the memory and accepts suffices 'K/M/G'. RSEM will pass <string>\
    \ to the '-m' option of 'samtools sort'. Note that the default used here is different\
    \ from the default used by samtools. (Default: 1G)"
  id: sort_bam_memory_per_thread
  inputBinding:
    prefix: --sort-bam-memory-per-thread
  type: string
- doc: "Seed length used by the read aligner. Providing the correct value is important\
    \ for RSEM. If RSEM runs Bowtie, it uses this value for Bowtie's seed length parameter.\
    \ Any read with its or at least one of its mates' (for paired-end reads) length\
    \ less than this value will be ignored. If the references are not added poly(A)\
    \ tails, the minimum allowed value is 5, otherwise, the minimum allowed value\
    \ is 25. Note that this script will only check if the value >= 5 and give a warning\
    \ message if the value < 25 but >= 5. (Default: 25)"
  id: seed_length
  inputBinding:
    prefix: --seed-length
  type: long
- doc: 'Input quality scores are encoded as Phred+33. This option is used by Bowtie,
    Bowtie 2 and HISAT2. (Default: on)'
  id: phred33_quals
  inputBinding:
    prefix: --phred33-quals
  type: boolean
- doc: 'Input quality scores are encoded as Phred+64 (default for GA Pipeline ver.
    >= 1.3). This option is used by Bowtie, Bowtie 2 and HISAT2. (Default: off)'
  id: phred64_quals
  inputBinding:
    prefix: --phred64-quals
  type: boolean
- doc: 'Input quality scores are solexa encoded (from GA Pipeline ver. < 1.3). This
    option is used by Bowtie, Bowtie 2 and HISAT2. (Default: off)'
  id: solexa_quals
  inputBinding:
    prefix: --solexa-quals
  type: boolean
- doc: "The path to the Bowtie executables. (Default: the path to the Bowtie executables\
    \ is assumed to be in the user's PATH environment variable)"
  id: bowtie_path
  inputBinding:
    prefix: --bowtie-path
  type: File
- doc: '(Bowtie parameter) max # of mismatches in the seed. (Range: 0-3, Default:
    2)'
  id: bowtie_n
  inputBinding:
    prefix: --bowtie-n
  type: long
- doc: '(Bowtie parameter) max sum of mismatch quality scores across the alignment.
    (Default: 99999999)'
  id: bowtie_e
  inputBinding:
    prefix: --bowtie-e
  type: long
- doc: '(Bowtie parameter) suppress all alignments for a read if > <int> valid alignments
    exist. (Default: 200)'
  id: bowtie_m
  inputBinding:
    prefix: --bowtie-m
  type: long
- doc: "(Bowtie parameter) memory allocated for best first alignment calculation (Default:\
    \ 0 - use Bowtie's default)"
  id: bowtie_chunk_mbs
  inputBinding:
    prefix: --bowtie-chunkmbs
  type: long
- doc: "(Bowtie 2 parameter) The path to the Bowtie 2 executables. (Default: the path\
    \ to the Bowtie 2 executables is assumed to be in the user's PATH environment\
    \ variable)"
  id: bowtie2_path
  inputBinding:
    prefix: --bowtie2-path
  type: File
- doc: '(Bowtie 2 parameter) The maximum mismatch rate allowed. (Default: 0.1)'
  id: bowtie2_mismatch_rate
  inputBinding:
    prefix: --bowtie2-mismatch-rate
  type: string
- doc: '(Bowtie 2 parameter) Find up to <int> alignments per read. (Default: 200)'
  id: bowtie2_k
  inputBinding:
    prefix: --bowtie2-k
  type: long
- doc: "(Bowtie 2 parameter) Set Bowtie 2's preset options in --end-to-end mode. This\
    \ option controls how hard Bowtie 2 tries to find alignments. <string> must be\
    \ one of \"very_fast\", \"fast\", \"sensitive\" and \"very_sensitive\". The four\
    \ candidates correspond to Bowtie 2's \"--very-fast\", \"--fast\", \"--sensitive\"\
    \ and \"--very-sensitive\" options. (Default: \"sensitive\" - use Bowtie 2's default)"
  id: bowtie2_sensitivity_level
  inputBinding:
    prefix: --bowtie2-sensitivity-level
  type: string
- doc: "The path to STAR's executable. (Default: the path to STAR executable is assumed\
    \ to be in user's PATH environment variable)"
  id: star_path
  inputBinding:
    prefix: --star-path
  type: File
- doc: '(STAR parameter) Input read file(s) is compressed by gzip. (Default: off)'
  id: star_gzipped_read_file
  inputBinding:
    prefix: --star-gzipped-read-file
  type: boolean
- doc: '(STAR parameter) Input read file(s) is compressed by bzip2. (Default: off)'
  id: star_b_zipped_read_file
  inputBinding:
    prefix: --star-bzipped-read-file
  type: boolean
- doc: "(STAR parameter) Save the BAM file from STAR alignment under genomic coordinate\
    \ to 'sample_name.STAR.genome.bam'. This file is NOT sorted by genomic coordinate.\
    \ In this file, according to STAR's manual, 'paired ends of an alignment are always\
    \ adjacent, and multiple alignments of a read are adjacent as well'. (Default:\
    \ off)"
  id: star_output_genome_bam
  inputBinding:
    prefix: --star-output-genome-bam
  type: boolean
- doc: "The path to HISAT2's executable. (Default: the path to HISAT2 executable is\
    \ assumed to be in user's PATH environment variable)"
  id: hisat2_path
  inputBinding:
    prefix: --hisat2-path
  type: File
- doc: 'The name of the optional field used in the SAM input for identifying a read
    with too many valid alignments. The field should have the format <tagName>:i:<value>,
    where a <value> bigger than 0 indicates a read with too many alignments. (Default:
    "")'
  id: tag
  inputBinding:
    prefix: --tag
  type: string
- doc: 'Minimum read/insert length allowed. This is also the value for the Bowtie/Bowtie2
    -I option. (Default: 1)'
  id: fragment_length_min
  inputBinding:
    prefix: --fragment-length-min
  type: long
- doc: 'Maximum read/insert length allowed. This is also the value for the Bowtie/Bowtie
    2 -X option. (Default: 1000)'
  id: fragment_length_max
  inputBinding:
    prefix: --fragment-length-max
  type: long
- doc: '(single-end data only) The mean of the fragment length distribution, which
    is assumed to be a Gaussian. (Default: -1, which disables use of the fragment
    length distribution)'
  id: fragment_length_mean
  inputBinding:
    prefix: --fragment-length-mean
  type: string
- doc: '(single-end data only) The standard deviation of the fragment length distribution,
    which is assumed to be a Gaussian. (Default: 0, which assumes that all fragments
    are of the same length, given by the rounded value of --fragment-length-mean)'
  id: fragment_length_sd
  inputBinding:
    prefix: --fragment-length-sd
  type: string
- doc: 'Set this option if you want to estimate the read start position distribution
    (RSPD) from data. Otherwise, RSEM will use a uniform RSPD. (Default: off)'
  id: estimate_r_spd
  inputBinding:
    prefix: --estimate-rspd
  type: boolean
- doc: "Number of bins in the RSPD. Only relevant when '--estimate-rspd' is specified.\
    \ Use of the default setting is recommended. (Default: 20)"
  id: num_r_spd_bins
  inputBinding:
    prefix: --num-rspd-bins
  type: long
- doc: "The number of burn-in rounds for RSEM's Gibbs sampler. Each round passes over\
    \ the entire data set once. If RSEM can use multiple threads, multiple Gibbs samplers\
    \ will start at the same time and all samplers share the same burn-in number.\
    \ (Default: 200)"
  id: gibbs_burnin
  inputBinding:
    prefix: --gibbs-burnin
  type: long
- doc: 'The total number of count vectors RSEM will collect from its Gibbs samplers.
    (Default: 1000)'
  id: gibbs_number_of_samples
  inputBinding:
    prefix: --gibbs-number-of-samples
  type: long
- doc: 'The number of rounds between two succinct count vectors RSEM collects. If
    the count vector after round N is collected, the count vector after round N +
    <int> will also be collected. (Default: 1)'
  id: gibbs_sampling_gap
  inputBinding:
    prefix: --gibbs-sampling-gap
  type: long
- doc: 'The credibility level for credibility intervals. (Default: 0.95)'
  id: ci_credibility_level
  inputBinding:
    prefix: --ci-credibility-level
  type: string
- doc: 'Maximum size (in memory, MB) of the auxiliary buffer used for computing credibility
    intervals (CI). (Default: 1024)'
  id: ci_memory
  inputBinding:
    prefix: --ci-memory
  type: long
- doc: 'The number of read generating probability vectors sampled per sampled count
    vector. The crebility intervals are calculated by first sampling P(C | D) and
    then sampling P(Theta | C) for each sampled count vector. This option controls
    how many Theta vectors are sampled per sampled count vector. (Default: 50)'
  id: ci_number_of_samples_per_count_vector
  inputBinding:
    prefix: --ci-number-of-samples-per-count-vector
  type: long
- doc: "Keep temporary files generated by RSEM. RSEM creates a temporary directory,\
    \ 'sample_name.temp', into which it puts all intermediate output files. If this\
    \ directory already exists, RSEM overwrites all files generated by previous RSEM\
    \ runs inside of it. By default, after RSEM finishes, the temporary directory\
    \ is deleted. Set this option to prevent the deletion of this directory and the\
    \ intermediate files inside of it. (Default: off)"
  id: keep_intermediate_files
  inputBinding:
    prefix: --keep-intermediate-files
  type: boolean
- doc: 'Set where to put the temporary files generated by RSEM. If the folder specified
    does not exist, RSEM will try to create it. (Default: sample_name.temp)'
  id: temporary_folder
  inputBinding:
    prefix: --temporary-folder
  type: string
- doc: "Output time consumed by each step of RSEM to 'sample_name.time'. (Default:\
    \ off)"
  id: time
  inputBinding:
    prefix: --time
  type: boolean
- doc: "Running prior-enhanced RSEM (pRSEM). Prior parameters, i.e. isoform's initial\
    \ pseudo-count for RSEM's Gibbs sampling, will be learned from input RNA-seq data\
    \ and an external data set. When pRSEM needs and only needs ChIP-seq peak information\
    \ to partition isoforms (e.g. in pRSEM's default partition model), either ChIP-seq\
    \ peak file (with the '--chipseq-peak-file' option) or ChIP-seq FASTQ files for\
    \ target and input and the path for Bowtie executables are required (with the\
    \ '--chipseq-target-read-files <string>', '--chipseq-control-read-files <string>',\
    \ and '--bowtie-path <path> options), otherwise, ChIP-seq FASTQ files for target\
    \ and control and the path to Bowtie executables are required. (Default: off)"
  id: run_pr_sem
  inputBinding:
    prefix: --run-pRSEM
  type: boolean
- doc: "Full path to a ChIP-seq peak file in ENCODE's narrowPeak, i.e. BED6+4, format.\
    \ This file is used when running prior-enhanced RSEM in the default two-partition\
    \ model. It partitions isoforms by whether they have ChIP-seq overlapping with\
    \ their transcription start site region or not. Each partition will have its own\
    \ prior parameter learned from a training set. This file can be either gzipped\
    \ or ungzipped. (Default: \"\")"
  id: chips_eq_peak_file
  inputBinding:
    prefix: --chipseq-peak-file
  type: string
- doc: "Comma-separated full path of FASTQ read file(s) for ChIP-seq target. This\
    \ option is used when running prior-enhanced RSEM. It provides information to\
    \ calculate ChIP-seq peaks and signals. The file(s) can be either ungzipped or\
    \ gzipped with a suffix '.gz' or '.gzip'. The options '--bowtie-path <path>' and\
    \ '--chipseq-control-read-files <string>' must be defined when this option is\
    \ specified. (Default: \"\")"
  id: chips_eq_target_read_files
  inputBinding:
    prefix: --chipseq-target-read-files
  type: string
- doc: "Comma-separated full path of FASTQ read file(s) for ChIP-seq conrol. This\
    \ option is used when running prior-enhanced RSEM. It provides information to\
    \ call ChIP-seq peaks. The file(s) can be either ungzipped or gzipped with a suffix\
    \ '.gz' or '.gzip'. The options '--bowtie-path <path>' and '--chipseq-target-read-files\
    \ <string>' must be defined when this option is specified. (Default: \"\")"
  id: chips_eq_control_read_files
  inputBinding:
    prefix: --chipseq-control-read-files
  type: string
- doc: "Comma-separated full path of FASTQ read files for multiple ChIP-seq targets.\
    \ This option is used when running prior-enhanced RSEM, where prior is learned\
    \ from multiple complementary data sets. It provides information to calculate\
    \ ChIP-seq signals. All files can be either ungzipped or gzipped with a suffix\
    \ '.gz' or '.gzip'. When this option is specified, the option '--bowtie-path <path>'\
    \ must be defined and the option '--partition-model <string>' will be set to 'cmb_lgt'\
    \ automatically. (Default: \"\")"
  id: chips_eq_read_files_multi_targets
  inputBinding:
    prefix: --chipseq-read-files-multi-targets
  type: string
- doc: "Comma-separated full path of BED files for multiple ChIP-seq targets. This\
    \ option is used when running prior-enhanced RSEM, where prior is learned from\
    \ multiple complementary data sets. It provides information of ChIP-seq signals\
    \ and must have at least the first six BED columns. All files can be either ungzipped\
    \ or gzipped with a suffix '.gz' or '.gzip'. When this option is specified, the\
    \ option '--partition-model <string>' will be set to 'cmb_lgt' automatically.\
    \ (Default: \"\")"
  id: chips_eq_bed_files_multi_targets
  inputBinding:
    prefix: --chipseq-bed-files-multi-targets
  type: string
- doc: "Keep a maximum number of ChIP-seq reads that aligned to the same genomic interval.\
    \ This option is used when running prior-enhanced RSEM, where prior is learned\
    \ from multiple complementary data sets. This option is only in use when either\
    \ '--chipseq-read-files-multi-targets <string>' or '--chipseq-bed-files-multi-targets\
    \ <string>' is specified. (Default: off)"
  id: cap_stacked_chips_eq_reads
  inputBinding:
    prefix: --cap-stacked-chipseq-reads
  type: boolean
- doc: "The maximum number of stacked ChIP-seq reads to keep. This option is used\
    \ when running prior-enhanced RSEM, where prior is learned from multiple complementary\
    \ data sets. This option is only in use when the option '--cap-stacked-chipseq-reads'\
    \ is set. (Default: 5)"
  id: n_max_stacked_chips_eq_reads
  inputBinding:
    prefix: --n-max-stacked-chipseq-reads
  type: long
- doc: "A keyword to specify the partition model used by prior-enhanced RSEM. It must\
    \ be one of the following keywords: - pk Partitioned by whether an isoform has\
    \ a ChIP-seq peak overlapping with its transcription start site (TSS) region.\
    \ The TSS region is defined as [TSS-500bp, TSS+500bp]. For simplicity, we refer\
    \ this type of peak as 'TSS peak' when explaining other keywords. - pk_lgtnopk\
    \ First partitioned by TSS peak. Then, for isoforms in the 'no TSS peak' set,\
    \ a logistic model is employed to further classify them into two partitions. -\
    \ lm3, lm4, lm5, or lm6 Based on their ChIP-seq signals, isoforms are classified\
    \ into 3, 4, 5, or 6 partitions by a linear regression model. - nopk_lm2pk, nopk_lm3pk,\
    \ nopk_lm4pk, or nopk_lm5pk First partitioned by TSS peak. Then, for isoforms\
    \ in the 'with TSS peak' set, a linear regression model is employed to further\
    \ classify them into 2, 3, 4, or 5 partitions. - pk_lm2nopk, pk_lm3nopk, pk_lm4nopk,\
    \ or pk_lm5nopk First partitioned by TSS peak. Then, for isoforms in the 'no TSS\
    \ peak' set, a linear regression model is employed to further classify them into\
    \ 2, 3, 4, or 5 partitions. - cmb_lgt Using a logistic regression to combine TSS\
    \ signals from multiple complementary data sets and partition training set isoform\
    \ into 'expressed' and 'not expressed'. This partition model is only in use when\
    \ either '--chipseq-read-files-multi-targets <string>' or '--chipseq-bed-files-multi-targets\
    \ <string> is specified. Parameters for all the above models are learned from\
    \ a training set. For detailed explanations, please see prior-enhanced RSEM's\
    \ paper. (Default: 'pk')"
  id: partition_model
  inputBinding:
    prefix: --partition-model
  type: string
- doc: 'Inputs are alignments in SAM format. (Default: off)'
  id: sam
  inputBinding:
    prefix: --sam
  type: boolean
- doc: 'Inputs are alignments in BAM format. (Default: off)'
  id: bam
  inputBinding:
    prefix: --bam
  type: boolean
- doc: "Equivalent to '--strandedness forward'. (Default: off)"
  id: strand_specific
  inputBinding:
    prefix: --strand-specific
  type: boolean
- doc: 'Probability of generating a read from the forward strand of a transcript.
    Set to 1 for a strand-specific protocol where all (upstream) reads are derived
    from the forward strand, 0 for a strand-specific protocol where all (upstream)
    read are derived from the reverse strand, or 0.5 for a non-strand-specific protocol.
    (Default: off)'
  id: forward_prob
  inputBinding:
    prefix: --forward-prob
  type: string