#!/usr/bin/env cwl-runner

baseCommand:
- pr
class: CommandLineTool
cwlVersion: v1.0
id: pr
inputs:
- doc: use hat notation (^G) and octal backslash notation
  id: show_control_chars
  inputBinding:
    prefix: --show-control-chars
  type: boolean
- doc: double space the output
  id: double_space
  inputBinding:
    prefix: --double-space
  type: boolean
- doc: use FORMAT for the header date
  id: date_format
  inputBinding:
    prefix: --date-format
  type: string
- doc: '[CHAR[WIDTH]], --expand-tabs[=CHAR[WIDTH]] expand input CHARs (TABs) to tab
    WIDTH (8)'
  id: e
  inputBinding:
    prefix: -e
  type: boolean
- doc: use form feeds instead of newlines to separate pages (by a 3-line page header
    with -F or a 5-line header and trailer without -F)
  id: form_feed
  inputBinding:
    prefix: --form-feed
  type: boolean
- doc: use a centred HEADER instead of filename in page header, -h "" prints a blank
    line, don't use -h""
  id: header
  inputBinding:
    prefix: --header
  type: string
- doc: '[CHAR[WIDTH]], --output-tabs[=CHAR[WIDTH]] replace spaces with CHARs (TABs)
    to tab WIDTH (8)'
  id: i
  inputBinding:
    prefix: -i
  type: boolean
- doc: merge full lines, turns off -W line truncation, no column alignment, --sep-string[=STRING]
    sets separators
  id: join_lines
  inputBinding:
    prefix: --join-lines
  type: boolean
- doc: set the page length to PAGE_LENGTH (66) lines (default number of lines of text
    56, and with -F 63). implies -t if PAGE_LENGTH <= 10
  id: length
  inputBinding:
    prefix: --length
  type: string
- doc: print all files in parallel, one in each column, truncate lines, but join lines
    of full length with -J
  id: merge
  inputBinding:
    prefix: --merge
  type: boolean
- doc: '[SEP[DIGITS]], --number-lines[=SEP[DIGITS]] number lines, use DIGITS (5) digits,
    then SEP (TAB), default counting starts with 1st line of input file'
  id: n
  inputBinding:
    prefix: -n
  type: boolean
- doc: start counting with NUMBER at 1st line of first page printed (see +FIRST_PAGE)
  id: first_line_number
  inputBinding:
    prefix: --first-line-number
  type: string
- doc: offset each line with MARGIN (zero) spaces, do not affect -w or -W, MARGIN
    will be added to PAGE_WIDTH
  id: indent
  inputBinding:
    prefix: --indent
  type: string
- doc: omit warning when a file cannot be opened
  id: no_file_warnings
  inputBinding:
    prefix: --no-file-warnings
  type: boolean
- doc: "[CHAR], --separator[=CHAR] separate columns by a single character, default\
    \ for CHAR is the <TAB> character without -w and 'no char' with -w. -s[CHAR] turns\
    \ off line truncation of all 3 column options (-COLUMN|-a -COLUMN|-m) except -w\
    \ is set"
  id: s
  inputBinding:
    prefix: -s
  type: boolean
- doc: '[STRING], --sep-string[=STRING] separate columns by STRING, without -S: Default
    separator <TAB> with -J and <space> otherwise (same as -S" "), no effect on column
    options'
  id: s
  inputBinding:
    prefix: -S
  type: boolean
- doc: omit page headers and trailers; implied if PAGE_LENGTH <= 10
  id: omit_header
  inputBinding:
    prefix: --omit-header
  type: boolean
- doc: omit page headers and trailers, eliminate any pagination by form feeds set
    in input files
  id: omit_pagination
  inputBinding:
    prefix: --omit-pagination
  type: boolean
- doc: use octal backslash notation
  id: show_non_printing
  inputBinding:
    prefix: --show-nonprinting
  type: boolean
- doc: set page width to PAGE_WIDTH (72) characters for multiple text-column output
    only, -s[char] turns off (72)
  id: width
  inputBinding:
    prefix: --width
  type: string
- doc: set page width to PAGE_WIDTH (72) characters always, truncate lines, except
    -J option is set, no interference with -S or -s
  id: page_width
  inputBinding:
    prefix: --page-width
  type: string