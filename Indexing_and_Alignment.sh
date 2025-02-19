#Variant Calling Workflow
#We perform alignment to the reference Genome using Burrows Wheeler Aligner (BWA)
#Alignment consists of two steps:
#Indexing the reference genome
#Aligning the reads to the reference genome

#Indexing the reference genome
 #Download the reference genome
 cd ~/dc_workshop
 mkdir -p data/ref_genome
 curl -L -o data/ref_genome/ecoli_rel606.fasta.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/017/985/GCA_000017985.1_ASM1798v1/GCA_000017985.1_ASM1798v1_genomic.fna.gz
 gunzip data/ref_genome/ecoli_rel606.fasta.gz

#We will also download a set of trimmed FASTQ files to run our variant calling workflow
curl -L -o sub.tar.gz https://ndownloader.figshare.com/files/14418248
 tar xvf sub.tar.gz
 mv sub/ ~/dc_workshop/data/trimmed_fastq_small

#Create directories for the results that will be generated 
mkdir -p results/sam results/bam results/bcf results/vcf

#Index the reference genome using BWA
bwa index data/ref_genome/ecoli_rel606.fasta

#After Indexing the reference genome,we align the reads to reference genome
#Use BWA-MEM algorithm to align reads
bwa mem data/ref_genome/ecoli_rel606.fasta data/trimmed_fastq_small/SRR2584866_1.trim.sub.fastq data/trimmed_fastq_small/SR>

#We will convert the SAM file to BAM format using the samtools program
#Input is in SAM format (-S) and output BAM format (-b)
samtools view -S -b results/sam/SRR2584866.aligned.sam > results/bam/SRR2584866.aligned.bam

#Next we sort the BAM file using the sort command from samtools
samtools sort -o results/bam/SRR2584866.aligned.sorted.bam results/bam/SRR2584866.aligned.bam

#To view the statistics of the BAM file
samtools flagstat results/bam/SRR2584866.aligned.sorted.bam

