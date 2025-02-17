#Data Wrangling and Processing for Genomics
#Data is from three sample events from the Ara-3 strain of E-coli to assess its adaptability
1- 5,000 generations,
2-15,000 generations,
3-50,000 generations
#I created the ecessary folders and downloaded the files
mkdir -p ~/dc_workshop/data/untrimmed_fastq/
cd ~/dc_workshop/data/untrimmed_fastq

#File Download
curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/004/SRR2589044/SRR2589044_1.fastq.gz
curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/004/SRR2589044/SRR2589044_2.fastq.gz
curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/003/SRR2584863/SRR2584863_1.fastq.gz
curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/003/SRR2584863/SRR2584863_2.fastq.gz
curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/006/SRR2584866/SRR2584866_1.fastq.gz
curl -O ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR258/006/SRR2584866/SRR2584866_2.fastq.gz

#Unzipped the data, collectively
gunzip *fastq.gz

#STEP 1
#Get a fastq file
#Run FastQC on the file(this will create 2 new files: Fastqc and zip)
fastqc *.fastq*

#Lists the quality scores in different file formats. Interest is the .html files and the .zip files.

#I created a folder for all the different  fastqc files of interest.
mkdir -p ~/dc_workshop/results/fastqc_untrimmed_reads
mv *.zip ~/dc_workshop/results/fastqc_untrimmed_reads/
mv *.html ~/dc_workshop/results/fastqc_untrimmed_reads/

#Working with the fastqc files.
cd ~/dc_workshop/results/fastqc_untrimmed_reads/

#Unzipping the .zip files using loop
for filename in *.zip
> do
> unzip $filename
> done

#Creates a list of different files and then the folders of interest are the summary.txt
#We concatenate the .txt files into one folder
cat */summary.txt > ~/dc_workshop/docs/fastqc_summaries.txt

# We have successfuly run our fastqc and the outcomes shows us the quality score for each of the run sequences.
