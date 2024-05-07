// Define the Nextflow script for trimming and assembling reads

// Define process for trimming the reads
process trimReads {
 maxForks 1

    // Specifying input reads
    input: 
    file inputRead1
    file inputRead2

    // Setting output files from fastp
    output: 
    file "trimmed_read1.fastq.gz" 
    file "trimmed_read2.fastq.gz" 

    // The main trimming command
    script: 
    """ 
    fastp -i $inputRead1 -I $inputRead2 -o trimmed_read1.fastq.gz -O trimmed_read2.fastq.gz
    """ 
}

// Define process for assembling the trimmed reads
process assemble {
maxForks 1

    // Specifying the input files
    input:
    file "trimmed_read1.fastq.gz" 
    file "trimmed_read2.fastq.gz" 

    // Specifying the output files
    output:
    path 'assembly.fna'
    path 'skesa.stdout.txt'
    path 'skesa.stderr.txt'

    // The main script for assembling using skesa
    script:
    """
    skesa --fastq trimmed_read1.fastq.gz  trimmed_read1.fastq.gz  --contigs_out assembly.fna 1> skesa.stdout.txt 2> skesa.stderr.txt
    """
}

// Define process for Quality assessment of assemblies
process QA {
 

    // Specifying the input files
    input:
    path "assembly.fna" 
    path "skesa.stdout.txt"
    path "skesa.stderr.txt"
    

    // Specifying the output files
    output:
    path 'quast_results'

    // The main script for assessing quality of assembly
    """
    quast assembly.fna -o quast_results
    """
}

// Define process for characterization of bacterial strain
process mlstt {


    // Specifying the input files
    input:
    path "assembly.fna" 
    path "skesa.stdout.txt"
    path "skesa.stderr.txt"

    // Specifying the output files
    output:
    path 'mlst.tsv'

    // The main script characterizing strain
    script:
    """
   mlst assembly.fna > mlst.tsv
    """
}

// // Specifying workflow
// workflow {

//     // Defining channels for input read files
//     inputR1Channel = Channel.fromPath(params.inputR1)
//     inputR2Channel = Channel.fromPath(params.inputR2)

//     // Using output of trimming as input for assembling
//     trim_reads_output = trimReads(inputR1Channel, inputR2Channel)
//     assemble(trim_reads_output)
//     QA(assemble.out)
//     mlstt(assemble.out)

   
// }
// Specifying workflow
workflow {

    // Defining channels for input read files
    inputR1Channel = Channel.fromPath(params.inputR1)
    inputR2Channel = Channel.fromPath(params.inputR2)

    // Using output of trimming as input for assembling
    trimReads(inputR1Channel, inputR2Channel) | assemble | QA & mlstt | mix| view

   
}

