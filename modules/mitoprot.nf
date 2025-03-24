#!/usr/bin/env nextflow
nextflow.enable.dsl=2


process runMitoprot {
  container= 'veupathdb/mitoprot'
  
  input:
    path subsetFasta

  output:
    path 'summary', emit: summary
    path '*.mitoprot', emit: subset

  script:
    template 'runMitoprot.bash'
}


workflow mitoprot {
  take:
    seqs

  main:
    results = runMitoprot(seqs)
    results.summary | collectFile( storeDir: params.outputDir )
    results.subset  | collectFile( storeDir: params.outputDir, name: params.outputFileName )
    
}