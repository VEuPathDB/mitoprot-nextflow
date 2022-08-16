#!/usr/bin/env nextflow
nextflow.enable.dsl=2


//---------------------------------------------------------------
// Param Checking 
//---------------------------------------------------------------


if(params.inputFilePath) {
  seqs = Channel.fromPath( params.inputFilePath ).splitFasta( by:params.fastaSubsetSize, file:true )
}
else {
  throw new Exception("Missing params.inputFilePath")
}

if(!params.outputDir) {
  throw new Exception("Missing params.outputDir")
}

if(params.formatType != "a" && params.formatType != "p" && params.formatType != "s") {
  throw new Exception("Non-valid value for params.formatType. <a|p|s>")
}

if(!params.fastaSubsetSize) {
  throw new Exception("Missing params.fastaSubsetSize")
}

//--------------------------------------------------------------------------
// Includes
//--------------------------------------------------------------------------

include { mitoprot } from './modules/mitoprot.nf'

//--------------------------------------------------------------------------
// Main Workflow
//--------------------------------------------------------------------------


workflow {

  mitoprot(seqs)

}