version 1.0

task MultiIntersectBed {
  input {
    Boolean clusterCluster
    Boolean headerHeader
    Boolean namesNames
    Boolean gG
    Boolean emptyEmpty
    String fillerFiller
    Boolean examplesExamples
  }
  command <<<
    multiIntersectBed \
      ~{true="-cluster" false="" clusterCluster} \
      ~{true="-header" false="" headerHeader} \
      ~{true="-names" false="" namesNames} \
      ~{true="-g" false="" gG} \
      ~{true="-empty" false="" emptyEmpty} \
      ~{if defined(fillerFiller) then ("-filler " +  '"' + fillerFiller + '"') else ""} \
      ~{true="-examples" false="" examplesExamples}
  >>>
}