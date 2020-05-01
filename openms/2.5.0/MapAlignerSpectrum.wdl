version 1.0

task MapAlignerSpectrum {
  input {
    File inIn
    File outOut
    File trafTrafOOut
    File iniIni
    String threadsThreads
    File writeWriteIni
    Boolean helphelpHelphelp
    Boolean algorithmAlgorithm
    Boolean modelModel
    Boolean httpHttp
  }
  command <<<
    MapAlignerSpectrum \
      ~{if defined(inIn) then ("-in " +  '"' + inIn + '"') else ""} \
      ~{if defined(outOut) then ("-out " +  '"' + outOut + '"') else ""} \
      ~{if defined(trafTrafOOut) then ("-trafo_out " +  '"' + trafTrafOOut + '"') else ""} \
      ~{if defined(iniIni) then ("-ini " +  '"' + iniIni + '"') else ""} \
      ~{if defined(threadsThreads) then ("-threads " +  '"' + threadsThreads + '"') else ""} \
      ~{if defined(writeWriteIni) then ("-write_ini " +  '"' + writeWriteIni + '"') else ""} \
      ~{true="--helphelp" false="" helphelpHelphelp} \
      ~{true="- algorithm" false="" algorithmAlgorithm} \
      ~{true="- model" false="" modelModel} \
      ~{true="- http" false="" httpHttp}
  >>>
}