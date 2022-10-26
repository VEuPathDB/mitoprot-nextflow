#!/usr/bin/env nextflow
nextflow.enable.dsl=2


process runMitoprot {
  input:
    path 'subset.fa'

  output:
    path 'summary', emit: summary
    path 'subset.mitoprot', emit: subset

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