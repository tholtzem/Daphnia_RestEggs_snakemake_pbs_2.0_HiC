rule genoFile:
  input:
    'angsd/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.done'
  output:
    'LD_decay/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_geno.beagle.gz'
  log: 'log/{sets}/prepare_genoFile_angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.log'
  threads: 12
  message:
    """ Prepare beagle formatted genotype likelihood file generated from ANGSD (-doGlf 2) by removing the header row and the first three columns (i.e. positions, major allele, minor allele) """
  shell:
    """
    zcat angsd/{wildcards.sets}/angsd_GL{wildcards.GL}_minInd{wildcards.IND}_maf{wildcards.minMaf}_minDepth{wildcards.MinDepth}_maxDepth{wildcards.MaxDepth}.beagle.gz | cut -f 4- | awk 'NR != 1' | gzip  > {output} 2> {log}
    """


rule posFile:
  input:
    'angsd/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.done'
  output:
    'LD_decay/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_pos.gz'
  log: 'log/{sets}/prepare_posFile_angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.log'
  threads: 12
  message:
    """ Prepare position file generated from ANGSD (-doGlf 2) by removing the header row and the first three columns (i.e. positions, major allele, minor allele) """
  shell:
    """
    zcat angsd/{wildcards.sets}/angsd_GL{wildcards.GL}_minInd{wildcards.IND}_maf{wildcards.minMaf}_minDepth{wildcards.MinDepth}_maxDepth{wildcards.MaxDepth}.mafs.gz | cut -f 1,2 |  awk 'NR != 1' | sed 's/:/_/g'| gzip > {output}
    """


rule estimate_ngsLD_10000kbwindows:
  input:
   position = 'LD_decay/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_pos.gz',
   geno = 'LD_decay/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_geno.beagle.gz'
  output:
    'LD_decay/{sets}/ngsLD_windows_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.ld.gz'
  log: 'log/{sets}/ngsLD_windows_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.ld.log'
  threads: 36
  message:
    """ Estimate LD using ngsLD, which employs a maximum likelihood approach to account for genotype uncertainty in low-coverage whole genome sequencing data. """
  shell:
    """
    module load ngsld/1.1.1
    N_SITES=`zcat {input.position} | wc -l` &&
    ngsld --geno {input.geno} --pos {input.position} --probs --n_ind {wildcards.IND} --n_sites $N_SITES --max_kb_dist 10000 --max_snp_dist 0 --min_maf 0.01 --rnd_sample 0.01 --n_threads {threads} | gzip --best > {output} 2> {log}
    """
