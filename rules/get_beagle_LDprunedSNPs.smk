rule index_LDpruned_sites:
  input:
    'ngsLD/{sets}/LDpruned_snps_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.list'
  output:
    touch('ngsLD/{sets}/index_SNPs_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.done')
  log:
    'log/{sets}/index_SNPs_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.log'
  threads: 12
  message:
    """ Index LDpruned SNP list using angsd """
  shell:
    """
    module load angsd/0.938
    /apps/uibk/bin/sysconfcpus -n {threads} angsd sites index {input} 2> {log}
    """



rule getChrom_from_sites:
  input:
    'ngsLD/{sets}/LDpruned_snps_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.list',
    'ngsLD/{sets}/index_SNPs_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.done'
  output:
    'ngsLD/{sets}/LDpruned_snps_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.chr'
  log:
    'log/{sets}/getChrom_from_LDpruned_snps_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.log'
  message:
    """ Get a list of chromosomes/scaffolds """
  shell:
    """
     cut -f1 {input} | uniq > {output}
    """


#rule index_bam:
#  input:
#    'realigned/{sample}.bam'
#  output:
#    'realigned/{sample}.bam.bai'
#  log: 'log/{sample}.index_bam.log'
#  message: """ --- Indexing bam files --- """
#  shell:
#    """
#    samtools index -b {input} 2> {log}
#    """


rule getbeagle_LDpruned:
  input:
    ref = config["ref_HiC"],
    bamlist = 'depth/stats/{sets}_realignedBAM_df1.list',
    touched = 'ngsLD/{sets}/index_SNPs_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.done',
    sites = 'ngsLD/{sets}/LDpruned_snps_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.list',
    chroms = 'ngsLD/{sets}/LDpruned_snps_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.chr'
  output:
    touch('angsd/{sets}/LDpruned_angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.done')
  log:
    'log/{sets}/LDpruned_angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.log'
  threads: 24
  message:
    """ Calculate genotype likelihoods on predefined LD pruned sites only using angsd (-doMajorMinor 3 -sites)  """
  shell:
    """
    module load angsd/0.938
    /apps/uibk/bin/sysconfcpus -n 24 angsd -b {input.bamlist} -out angsd/{wildcards.sets}/LDpruned_angsd_GL{wildcards.GL}_minInd{wildcards.IND}_maf{wildcards.minMaf}_minDepth{wildcards.MinDepth}_maxDepth{wildcards.MaxDepth}_{wildcards.Minweight}Minweight -anc {input.ref} -GL {wildcards.GL} -doGlf 2 -doMajorMinor 3 -doMaf 1 -sites {input.sites} -rf {input.chroms} 2> {log}
    """
