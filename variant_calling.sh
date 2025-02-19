#Variant Calling Workflow

#align the reads to the reference genome and output a .sam file:
bwa mem $genome $fq1 $fq2 > $sam

#convert the SAM file to BAM format
samtools view -S -b $sam > $bam

#sort the BAM file:
samtools sort -o $sorted_bam $bam

#index the BAM file for display purposes
samtools index $sorted_bam

#calculate the read coverage of positions in the genome
bcftools mpileup -O b -o $raw_bcf -f $genome $sorted_bam

#call SNVs with bcftools
bcftools call --ploidy 1 -m -v -o $variants $raw_bcf

#filter and report the SNVs in variant calling format (VCF):
vcfutils.pl varFilter $variants  > $final_variants

