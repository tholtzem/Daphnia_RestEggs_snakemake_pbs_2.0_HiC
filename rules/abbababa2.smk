# Here, we use the global list of SNPs, we called/calculated from GLs of the entire D.lgc-complex (including reference panel, resting eggs and pelagial). This set should explain the variation in our data from the D.lgc-complex. Then, we add the outgroup to the data set, and call SNPs from GLs, but only for those sites present in the D. lgc-complex.


localrules: all, prepare_bamlist, prepare_sizefile, create_errorFile, get_popNames


rule prepare_bamlist:
  input:
    'list/pop_list/4pop_combinations.list'
  output:
    touch('list/abbababa/4pop_combinations.bam.list.done')
  log:
    'log/abbababa/4pop_combinations.bam.list.log'
  threads: 12
  message:
    """ Prepare list of bam files required for the ABBA-BABA test (D-statistic) """
  shell:
    """
    Lines=$(cat {input} | tail -n +2)
    path2in=list/saf
    path2out=list/abbababa
    
    for Line in $Lines; do
      p1=$(echo $Line | cut -f1 -d',')
      p2=$(echo $Line | cut -f2 -d',')
      p3=$(echo $Line | cut -f3 -d',')
      p4=$(echo $Line | cut -f4 -d',')
      echo $p1 $p2 $p3 $p4
      cat $path2in/${{p1}}.list $path2in/${{p2}}.list $path2in/${{p3}}.list $path2in/${{p4}}.list > $path2out/${{p1}}_${{p2}}_${{p3}}_${{p4}}.bam.list 2> {log}
    done
    """


rule prepare_sizefile:
  input:
    'list/pop_list/4pop_combinations.list'
  output:
    touch('list/abbababa/4pop_combinations.sizefile.done')
  log:
    'log/abbababa/4pop_combinations.sizefile.log'
  threads: 12
  message:
    """ Prepare a size file (number of bam/individuals in group) required for the ABBA-BABA test (D-statistic) """
  shell:
    """
    Lines=$(cat {input} | tail -n +2)
    path2in=list/saf
    path2out=list/abbababa
    
    for Line in $Lines; do
      p1=$(echo $Line | cut -f1 -d',')
      p2=$(echo $Line | cut -f2 -d',')
      p3=$(echo $Line | cut -f3 -d',')
      p4=$(echo $Line | cut -f4 -d',')
      echo $p1 $p2 $p3 $p4

      NBR_pop1=$(cat $path2in/${{p1}}.list | wc -l)
      NBR_pop2=$(cat $path2in/${{p2}}.list | wc -l)
      NBR_pop3=$(cat $path2in/${{p3}}.list | wc -l)
      NBR_pop4=$(cat $path2in/${{p4}}.list | wc -l)
      printf '%s\n' $NBR_pop1 $NBR_pop2 $NBR_pop3 $NBR_pop4 > $path2out/${{p1}}_${{p2}}_${{p3}}_${{p4}}.sizefile.list
    done 2> {log}
    """



rule ABBA_BABA:
  input:
    'list/abbababa/4pop_combinations.bam.list.done',
    'list/abbababa/4pop_combinations.sizefile.done',
    ref = config["ref_HiC"],
    sites = 'angsd/LC/{prefix}_globalSNP.list',
    chroms = 'angsd/LC/{prefix}_globalSNP.chr'
  output:
   touch('abbababa/{prefix}/{combi}.abbababa.{blocksize}blocksize.done')
  log:
    'log/abbababa/{prefix}/{combi}.abbababa.{blocksize}blocksize.log'
  threads: 24
  message:
    """ Compute ABBA-BABA test (D-statistic) in angsd, using a global SNP list and allowing for multiple individuals in each group """
  shell:
    """
    bamlist=(list/abbababa/{wildcards.combi}.bam.list)
    popsize=(list/abbababa/{wildcards.combi}.sizefile.list)

    module load angsd/0.938
    /apps/uibk/bin/sysconfcpus -n 24 angsd -doAbbababa2 1 -b $bamlist -sizeFile $popsize -useLast 1 -doCounts 1 -out abbababa/{wildcards.prefix}/abbababa_{wildcards.combi}.{wildcards.blocksize}blocksize -blockSize {wildcards.blocksize} -ref {input.ref} -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -minQ 20 -minMapQ 30 -rmTrans 0 -sites {input.sites} -rf {input.chroms} 2> {log}
    """


rule create_errorFile:
  output:
    'list/abbababa/errorFile.txt'
  log: 'log/abbababa/errorFile.log'
  message:
    """ Define the error file in text file (if available, if not write NA) """
  shell:
    """
    printf '%s\n' NA NA NA NA > {output} 2> {log}
    """


rule get_popNames:
  input:
    'list/pop_list/4pop_combinations.list'
  output:
    touch('list/abbababa/4pop_combinations.Popnames.list.done')
  log:
    'log/abbababa/4pop_combinations.Popnames.list.log'
  threads: 12
  message:
    """ Prepare list of population names required for the R script calculating D statistic """
  shell:
    """
    Lines=$(cat {input} | tail -n +2)
    path2out=list/abbababa
    
    for Line in $Lines; do
      p1=$(echo $Line | cut -f1 -d',')
      p2=$(echo $Line | cut -f2 -d',')
      p3=$(echo $Line | cut -f3 -d',')
      p4=$(echo $Line | cut -f4 -d',')
      printf '%s\n' ${{p1}} ${{p2}} ${{p3}} ${{p4}} > $path2out/${{p1}}_${{p2}}_${{p3}}_${{p4}}.POPnames.list 2> {log}
    done
    """


rule get_Dstats:
  input:
    touched = 'list/abbababa/4pop_combinations.Popnames.list.done',
    #errFile = 'list/abbababa/errorFile.txt',
    angsd = 'abbababa/{prefix}/{combi}.abbababa.{blocksize}blocksize.done'
  output:
    touch('abbababa/{prefix}/{combi}.Dstat_results.{blocksize}blocksize.done')
  log:
    'log/abbababa/{prefix}/{combi}.Dstat_results.{blocksize}blocksize.log'
  threads: 12
  message: """ Run R script downloaded from https://github.com/ANGSD/angsd/blob/master/R/estAvgError.R """
  shell:
    """
    pop_list=(list/abbababa/{wildcards.combi}.POPnames.list)
    
    Rscript scripts/estAvgError.R angsdFile=abbababa/{wildcards.prefix}/abbababa_{wildcards.combi}.{wildcards.blocksize}blocksize out=abbababa/{wildcards.prefix}/abbababa_{wildcards.combi}.Dstatresults.{wildcards.blocksize}blocksize sizeFile=list/abbababa/{wildcards.combi}.sizefile.list nameFile=$pop_list 2> {log}
    """



