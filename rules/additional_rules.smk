rule reheader_vcf:
  input:
    samples = 'list/ancestry/parents_hybrids_LC_realignedBAM_2_RENAMED.list',
    vcf = 'ancestry/LC/data/{prefix}.vcf.gz'
  output:
    vcf = 'ancestry/LC/data/{prefix}_RENAMED.vcf.gz'
  log: 'log/{prefix}_RENAMED.log'
  threads: 12
  message: """--- Rename samples in vcf using a file with a list of samples---"""
  shell:
    """
    bcftools reheader -s {input.samples} -o {output.vcf} {input.vcf} --threads {threads} 2> {log}
    """


#rule list_parents_hybrids:
#  output:
#    'list/parents_hybrids.list'
#  log: 'log/parents_hybrids_list.log'
#  threads: 12
#  message: """--- Create a list of parental species and hybrids, one sample per line ---"""
#  shell:
#    """
#    path=(list/pop_list)
#   hybrids=$(cat $path/hybrids_LC.txt)
#    LONG=$(cat $path/longispina.txt | cut -f1 -d'.' | cut -f2 -d'/')
#    GAL=$(cat $path/galeata.txt | cut -f1 -d'.' | cut -f2 -d'/')
#    CUC=$(cat $path/cucullata.txt | cut -f1 -d'.' | cut -f2 -d'/')
#    echo $hybrids $LONG $GAL $CUC | sed -z 's/ /\n/g;s/,$/\n/' > {output} 2> {log}
#    """

#rule subset_vcf:
#  input:
#    samples = 'list/parents_hybrids.list',
#    vcf = 'ancestry/LC/{prefix}.vcf.gz'
#  output:
#    vcf = 'ancestry/parents_hybrids.vcf.gz'
#  log: 'log/parents_hybrids.log'
#  threads: 12
#  message: """--- Subset vcf using a file with a list of samples---"""
#  shell:
#    """
#    bcftools view -S {input.samples} {input.vcf} -Oz -o {output.vcf} 2> {log}
#    """

