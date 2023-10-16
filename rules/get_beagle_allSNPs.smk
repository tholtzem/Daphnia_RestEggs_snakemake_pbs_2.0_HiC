rule get_beagle_allSNPs:
  input:
    ref = config["ref_HiC"],
    bamlist = 'depth/stats/{sets}_realignedBAM_df1.list',
    depthFilter = 'depth/stats/depthFilter.list'
  output:
    touch('angsd/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.done')
  log: 'log/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.log'
  threads: 24
  message:
    """ Calculate genotype likelihoods and call SNPs for all bam files using angsd setting various cutoffs """
  shell:
    """
    module load angsd/0.938
    /apps/uibk/bin/sysconfcpus -n 24 angsd -b {input.bamlist} -ref {input.ref} -out angsd/{wildcards.sets}/angsd_GL{wildcards.GL}_minInd{wildcards.IND}_maf{wildcards.minMaf}_minDepth{wildcards.MinDepth}_maxDepth{wildcards.MaxDepth} -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -minMapQ 30 -minQ 20 -skipTriallelic 1 -minInd {wildcards.IND} -setMinDepth {wildcards.MinDepth} -setMaxDepth {wildcards.MaxDepth} -GL {wildcards.GL} -doGlf 2 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -minMaf {wildcards.minMaf} -doCounts 1 2> {log}
    """


rule get_globalSNP_list:
  input:
    'angsd/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.done'
  output:
    'angsd/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_globalSNP.list'
  log: 'log/{sets}/get_globalSNP_angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.log'
  threads: 12
  message:
    """ Prepare a global SNP file from the mafs.gz file generated by ANGSD (-doGlf 2) by removing the header row and the first three columns (i.e. positions, major allele, minor allele) """
  shell:
    """
    zcat angsd/{wildcards.sets}/angsd_GL{wildcards.GL}_minInd{wildcards.IND}_maf{wildcards.minMaf}_minDepth{wildcards.MinDepth}_maxDepth{wildcards.MaxDepth}.mafs.gz | cut -f 1,2,3,4 | tail -n +2 > {output}
    """



rule index_globalSNP_file:
  input:
    'angsd/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_globalSNP.list'
  output:
    touch('angsd/{sets}/index_globalSNP_angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.done')
  log: 'log/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_index_globalSNP.log'
  threads: 12
  message:
    """ Prepare a global sites file from the mafs.gz file generated by ANGSD (-doGlf 2) by removing the header row and the first three columns (i.e. positions, major allele, minor allele) """
  shell:
    """
    module load angsd/0.938
    /apps/uibk/bin/sysconfcpus -n {threads} angsd sites index {input} 2> {log}
    """


rule getChrom_from_SNPs:
  input:
    'angsd/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_globalSNP.list'
  output:
    'angsd/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_globalSNP.chr'
  log:
    'log/{sets}/getChrom_from_globalSNP_angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.log'
  message:
    """ Get a list of chromosomes/scaffolds """
  shell:
    """
     cut -f1 {input} | uniq > {output}
    """
