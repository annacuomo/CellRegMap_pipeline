version development

task AggregateInteractionResults {
    input {
        Array[File] listOfFiles # to figure out (how to get these files)
        Float FDR_threshold
    }

    command <<<
        # michael: to work out how to more cleanly pass these files in
    cat << EOF >> path-results.txt
    ~{sep("\n", listOfFiles)}
    EOF

    conda activate cellregmap_notebook

    python /share/ScratchGeneral/anncuo/github_repos/CellRegMap_pipeline/images/cellregmap/summarise.py \
        --fdr-threshold ~{FDR_threshold} \
        --fileWithFilenames path-results.txt
    >>>
    
    output {
        File all_results = "summary.csv"
        File significant_results = "significant_results.csv"
    }
}

task AggregateBetaResults {
    input {
        Array[File] listOfFiles1
        Array[File] listOfFiles2
    }

    command <<<

    cat << EOF >> path-results-betaG.txt
    ~{sep("\n", listOfFiles1)}
    EOF
    cat << EOF >> path-results-betaGxC.txt
    ~{sep("\n", listOfFiles2)}
    EOF

    conda activate cellregmap_notebook

    python /share/ScratchGeneral/anncuo/github_repos/CellRegMap_pipeline/images/cellregmap/summarise_betas.py \
        --fileWithFilenames1 path-results-betaG.txt \
        --fileWithFilenames2 path-results-betaGxC.txt
    >>>

    output {
        File all_betaG = "summary_betaG.csv"
        File all_betaGxC = "summary_betaGxC.csv"
    }
}
