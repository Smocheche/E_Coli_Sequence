#Trimming and filtering
#Uses Trimmimatic to filter out poor quality read and trim poor quality bases from samples

#Go to the working directory with the sequence
cd ~/dc_workshop/data/untrimmed_fastq

#Compress all the unzipped files before running the trimming command
gzip *.fastq

#Run trimmomatic for loop
for infile in *_1.fastq.gz
> do
>   base=$(basename ${infile} _1.fastq.gz)
>   trimmomatic PE ${infile} ${base}_2.fastq.gz \
>                ${base}_1.trim.fastq.gz ${base}_1un.trim.fastq.gz \
>                ${base}_2.trim.fastq.gz ${base}_2un.trim.fastq.gz \
>                SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15 
> done

#Create a directory and move the trimmed files
cd ~/dc_workshop/data/untrimmed_fastq
mkdir ../trimmed_fastq
mv *.trim* ../trimmed_fastq

