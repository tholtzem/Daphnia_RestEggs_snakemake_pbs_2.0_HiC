include: "rules/common.smk"



# -----------------------------------------------

rule all:
	input:
		#expand('raw/qc/fastqc/{sample}_{pair}_001_fastqc.{ext}', sample=sample_names, pair=['R1', 'R2'], ext=['html', 'zip']),
		#expand('raw/qc/multiqc/'),
		## !!! works, but some intermediate files from trimming were deleted due to space limitation on mach2 !!! ##
		#expand('trm/{sample}_{pair}.{ext}', sample=sample_names, pair=['R1','R2'], ext=['trmd.fq.gz']),
		#expand('trm/{sample}_{pair}.{ext}', sample=sample_names, pair=['R1','R2'], ext=['trmdfilt.fq.gz']),
		#expand('trm/qc/fastqc/{sample}_{pair}.trmdfilt_fastqc.{ext}', sample=sample_names, pair=['R1', 'R2'], ext=['html', 'zip']),
		#expand('trm/qc/multiqc/')#,
		## !!! works, but some intermediate files from Kraken were deleted due to space limitation on mach2 !!! ##
		#expand('KRAKEN2_RESULTS/{sample}_kraken2_classified.done', sample=sample_names),
		#expand('KRAKEN2_RESULTS/{sample}_{pair}.{ext}', sample=sample_names, pair=['R1', 'R2'], ext=['trmdfilt.classified_retain.fq']),
		#expand('KRAKEN2_RESULTS/{sample}_{pair}.{ext}', sample=sample_names, pair=['R1','R2'], ext=['trmdfilt.keep.fq.gz']),
		#expand('KRAKEN2_RESULTS/qc/fastqc/{sample}_{pair}.trmdfilt.keep_fastqc.{ext}', sample=sample_names, pair=['R1', 'R2'], ext=['zip', 'html']),
		#expand('KRAKEN2_RESULTS/qc/multiqc/'),
		#expand('ref/bb_indexRef.done'),
		#expand('bbmap/{sample}.{ext}', sample=sample_names, ext=['bam']),
		#expand('bbmap/{sample}.{ext}', sample=sample_names, ext=['bam.bai']),
		#expand('deDup/{sample}.{ext}', sample=sample_names, ext=['dedup.bam', 'dedup.metrics.txt']),
		#expand('deDup/{sample}.{ext}', sample=sample_names, ext=['overlapclipped.bam']),
		#expand('deDup/{sample}.{ext}', sample=sample_names, ext=['overlapclipped.bam.bai']),
		#expand('ref/{ref_name}.{ext}', ref_name=['Dgaleata_M5_PBasm.FINAL'] ,ext=['fasta.fai', 'dict']),
		#expand('deDup/{sample}.symlink.done', sample=outgroup_names),
		#expand('deDup/{sample}.added2ClippedList.done', sample=outgroup_names),
		#expand('deDup/{sample}.REFsadded2ClippedList.done', sample=refclone_names),
		##Run until here
		#expand('list/indels_{ref_name}.list', ref_name=['Dgaleata_M5_PBasm.FINAL']),
		#expand('list/indels_{ref_name}_curvi.list', ref_name=['Dgaleata_M5_PBasm.FINAL']),
		#expand('realigned/{sample}.{ext}', sample=outgroup_names, ext=['realigned.bam']),
                #expand('depth/{sample}.{ext}', sample=outgroup_names, ext=['realigned.bam.coverage.hist']),
		#expand('depth/{sample}.{ext}', sample=outgroup_names, ext=['realigned.bam.depth.gz']),
		#expand('depth/{sample}.added2DepthList.list', sample=outgroup_names),
		#expand('depth/stats/depth_statistics_curvi.txt'),
		#expand('depth/plots/plot_summary_{sets}.done', sets=['LC', 'LZ', 'LCwithoutREF', 'LZwithoutREF', 'longREF7', 'longREF9', 'cucREF7', 'galREF9', 'ALL_gal_LC', 'hatched_gal_LC', 'EGGS_gal_LC', 'PEL_cuc_LC', 'PEL_long_LC', 'PRE_long_LC', 'curvirostris']),
                ## run until here
		#expand('depth/stats/rbind_depthFilter.done'),
		#expand('bedtools/{sample}.realigned.{ext}', sample=ALL_names, ext=['genomecov.bed']),
		#expand('bedtools/plots/{sample}.realigned.{ext}', sample=ALL_names, ext=['genomecov.pdf']),
		#expand('angsd/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.done', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure),
		#expand('angsd/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_globalSNP.list', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure),
		#expand('angsd/{sets}/index_globalSNP_angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.done', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure),
		#expand('angsd/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_globalSNP.chr', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure),
		#expand('pcangsd/{sets}/PCAngsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_cov_admix.done', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure),
		#expand('ngsLD/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_sub_geno.beagle.gz', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure),
		#expand('ngsLD/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_sub_pos.gz', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure),
		#expand('ngsLD/{sets}/run_ngsLD_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_sub.ld.gz', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure),
		#expand('ngsLD/{sets}/run_LDpruning_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.done', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure, Minweight=['0.1', '0.1', '0.1', '0.1']),
		#expand('ngsLD/{sets}/LDpruned_snps_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.list', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure, Minweight=['0.1', '0.1', '0.1', '0.1']),
		#expand('ngsLD/{sets}/index_SNPs_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.done', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure, Minweight=['0.5', '0.5', '0.5', '0.5']),
		#expand('ngsLD/{sets}/LDpruned_snps_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.chr', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure, Minweight=['0.5', '0.5', '0.5', '0.5']),
		#expand('angsd/{sets}/LDpruned_angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.done', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure, Minweight=['0.1', '0.1', '0.1', '0.1']),
		#expand('angsd/{sets}/LDpruned_angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.done', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure, Minweight=['0.5', '0.5', '0.5', '0.5']),
		#expand('pcangsd/{sets}/PCAngsd_LDpruned_angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_{Minweight}Minweight.done', zip, sets=sets_structure, GL=GL_structure, minMaf=minMaf, IND=N_structure, MinDepth=MinDepth_structure, MaxDepth=MaxDepth_structure, Minweight=['0.5', '0.5', '0.5', '0.5']),
		#expand('LD_decay/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_geno.beagle.gz', sets=['LC'], GL=['2'], minMaf=['0.05'], IND=['202'], MinDepth=['202'], MaxDepth=['9051']),
		#expand('LD_decay/{sets}/angsd_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}_pos.gz', sets=['LC'], GL=['2'], minMaf=['0.05'], IND=['202'], MinDepth=['202'], MaxDepth=['9051']),
		#expand('LD_decay/{sets}/ngsLD_windows_GL{GL}_minInd{IND}_maf{minMaf}_minDepth{MinDepth}_maxDepth{MaxDepth}.ld.gz', sets=['LC'], GL=['2'], minMaf=['0.05'], IND=['202'], MinDepth=['202'], MaxDepth=['9051']),
                #expand('saf/saf_samples/{sample}.GL2.saf.idx.done', sample=ALL_names),
                #expand('saf/saf_samples/{sample}.GL2.est.ml', sample=ALL_names),
		#expand('list/saf/{POPS}.list', POPS=sets_saf),
                #expand('saf/POPS/{POPS}_{IND}_{MinDepth}_{MaxDepth}.GL2.saf.idx.done', zip, POPS=sets_saf, IND=N_saf, MinDepth=MinDepth_saf, MaxDepth=MaxDepth_saf),
		#expand('saf/POPS/{POPS}_{IND}_{MinDepth}_{MaxDepth}.GL2.sfs', zip, POPS=sets_saf, IND=N_saf, MinDepth=MinDepth_saf, MaxDepth=MaxDepth_saf),
		#expand('saf/POPS/{POPS}_{IND}_{MinDepth}_{MaxDepth}.GL2.sfs2theta.done', zip, POPS=sets_saf, IND=N_saf, MinDepth=MinDepth_saf, MaxDepth=MaxDepth_saf),
                #expand('saf/POPS/{POPS}_{IND}_{MinDepth}_{MaxDepth}.GL2.theta_stats_chrom.done', zip, POPS=sets_saf, IND=N_saf, MinDepth=MinDepth_saf, MaxDepth=MaxDepth_saf),
                #expand('saf/POPS/{POPS}_{IND}_{MinDepth}_{MaxDepth}.GL2.theta_stats_Window10kb.done', zip, POPS=sets_saf, IND=N_saf, MinDepth=MinDepth_saf, MaxDepth=MaxDepth_saf),
                #expand('saf/POPS/{POP1}_vs_{POP2}_2D.sfs', zip, POP1=POP1, POP2=POP2),
                #expand('saf/POPS/{POP1}_vs_{POP2}.fstIndex.done', zip, POP1=POP1, POP2=POP2),
                #expand('saf/POPS/{POP1}_vs_{POP2}.fst_Global.done', zip, POP1=POP1, POP2=POP2),
		#expand('saf/POPS/{POP1}_vs_{POP2}.fst_Windows.done', zip, POP1=POP1, POP2=POP2),
                #expand('list/abbababa/4pop_combinations.bam.list.done'),
                #expand('list/abbababa/4pop_combinations.sizefile.done'),
                expand('abbababa/{prefix}/{combi}.abbababa.{blocksize}blocksize.done', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9051'], combi=Dstats_combi[4:12], blocksize=['2500000']),
		expand('list/abbababa/errorFile.txt'),
                expand('list/abbababa/4pop_combinations.Popnames.list.done'),
                expand('abbababa/{prefix}/{combi}.Dstat_results.{blocksize}blocksize.done', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9051'], combi=Dstats_combi[4:12], blocksize=['2500000']),
		#expand('realigned/{sample}.{ext}', sample=samples_ALL_names, ext=['realigned.bai']),
                #expand('ancestry/LC/data/get_bcf_{prefix}.done', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9051']),
		#expand('ancestry/LC/data/{prefix}.{ext}', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9051'], ext=['vcf.gz']),
                #expand('ancestry/LC/data/{prefix}_{ext}', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9051'], ext=['INFODP.txt', 'nbrSites.txt']),
                #expand('ancestry/LC/data/{prefix}_{ext}', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9051'], ext=['INFODP.pdf', 'INFODP.stats.txt']),
		#expand('ancestry/LC/data/{prefix}_hf.{ext}', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9051'], ext=['vcf.gz', 'nbrSites.txt']),
		#expand('ancestry/LC/data/{prefix}_hf.DP{genoDP}.{ext}', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9051'], genoDP=['10'], ext=['vcf.gz', 'nbrSites.txt']),
		#expand('ancestry/LC/data/{prefix}_hf.DP{genoDP}.{ext}', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9051'], genoDP=['10'], ext=['imiss']),
                #expand('ancestry/LC/data/{prefix}_hf.DP{genoDP}.imiss.{ext}', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9051'], genoDP=['10'], ext=['pdf', 'tsv']),
                #expand('ancestry/LC/data/{prefix}_hf.DP{genoDP}_{ext}', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9051'], genoDP=['10'], ext=['vmiss20.vcf', 'nbrSites.vmiss20.txt']),
                #expand('ancestry/LC/new/{prefix}_hf.DP{genoDP}_{ext}', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9088'], genoDP=['10'], ext=['fixed_sites.txt', 'get_fixedSites_sites.report']),
                #expand('ancestry/LC/new/{prefix}_hf_DP{genoDP}_{ext}', prefix=['angsd_GL2_minInd202_maf0.05_minDepth202_maxDepth9088'], genoDP=['10'], ext=['fixed_sites_100percent_thinned1000bp.svg', 'plot_fixed_sites_100percent_thinned1000bp.report']),
# -----------------------------------------------


#include: "rules/eggs2.0.smk"
#include: "rules/get_beagle_allSNPs.smk"
#include: "rules/PCAngsd_allSNPs.smk"
#include: "rules/ngsLD.smk"
#include: "rules/get_beagle_LDprunedSNPs.smk"
#include: "rules/PCAngsd_LDprunedSNPs.smk"
#include: "rules/estimate_ngsLD.smk"
#include: "rules/realSFS.smk"
include: "rules/abbababa2.smk"
#include: "rules/get_vcf.smk"
#include: "rules/ancestry.smk"
