#!/usr/bin/perl -w
use strict;

print "\n".'What is your read group ID (date of run, MMDDYY)?'."\n\n";

my $rgid = <STDIN>;
chomp $rgid;
$rgid =~ s/\;//g;

print "\n".'What is your read library (project name, library name, etc.)?'."\n\n";

my $rglb = <STDIN>;
chomp $rglb;
$rglb =~ s/\;//g;

print "\n".'What is your platform unit? (flowcell ID)'."\n\n";

my $rgpu = <STDIN>;
chomp $rgpu;
$rgpu =~ s/\;//g;

print "\n".'Writing jobs ..... '."\n\n";

print "\n".'Submitting jobs ..... '."\n\n";

my $rawreads = "";
my @rawreadsarray = ();

open(IN, $ARGV[0]);

for(my $rawreads = <IN>){

	chomp $rawreads;
	my @rawreadsarray = split(/\,/,$rawreads);
	
	my $backslash = '\\';
	my $dash = '-';

	for(my $i = 0; $i < scalar(@rawreadsarray)-1; $i++){
		my $array = "";
		$array = $rawreadsarray[$i];

		for(my $j = 1; $j < 25; $j++){

		open(OUT, '>/work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/Map_'.$j.'_'.$array.'.slurm');

		print OUT '#!/bin/sh'."\n";
		print OUT '#SBATCH --ntasks=16'."\n";
		print OUT '#SBATCH --mem=55gb'."\n";
		print OUT '#SBATCH --time=7:30:00'."\n";
		print OUT '#SBATCH --job-name=map'."\n";
		print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/Map_'.$array.'_'.$j.'.error'."\n";
		print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/Map_'.$array.'_'.$j.'.out'."\n\n";
		
		print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/'."\n\n";
			
		print OUT 'module load trimmomatic/0.36'."\n\n";
		
		print OUT 'trimmomatic SE -threads 16 -phred33 Raw/Fastq/'.$array.'.'.$j.'.fastq TrimmedReads/'.$array.'_'.$j.'.fastq ILLUMINACLIP:/work/soybean/mhapp95/SNPGenotyping/Data/Intermediaries/Reference/Soybean_Contaminants.fasta:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36'."\n\n";
 
		print OUT 'module load bowtie/2.2'."\n\n";		

		print OUT 'bowtie2 -p 16 -N 1 --mm --sensitive -t -x /work/soybean/mhapp95/SNPGenotyping/Data/Intermediaries/Reference/GlyMax -U TrimmedReads/'.$array.'_'.$j.'.fastq -S Sam/'.$array.'.'.$j.'_mapped_soybean.sam'."\n\n";
		
		print OUT 'module load picard/2.9'."\n";
		print OUT 'module load samtools/1.5'."\n\n";
		
		print OUT 'samtools view -q 30 -bT /work/soybean/mhapp95/SNPGenotyping/Data/Intermediaries/Reference/GlyMax.fasta Sam/'.$array.'.'.$j.'_mapped_soybean.sam > Bam/'.$array.'.'.$j.'_soybean.bam'."\n\n";

		print OUT 'picard -Xms5g -Xmx35g AddOrReplaceReadGroups '.$backslash.''."\n";
		print OUT 'I=Bam/'.$array.'.'.$j.'_soybean.bam '.$backslash.''."\n";
		print OUT 'O=Bam/'.$array.'.'.$j.'_soybeanwrg.bam '.$backslash.''."\n";
		print OUT 'RGID='.$rgid.' '.$backslash.''."\n";
		print OUT 'RGLB='.$rglb.' '.$backslash.''."\n";
		print OUT 'RGPL=illumina '.$backslash.''."\n";
		print OUT 'RGPU='.$rgpu.' '.$backslash.''."\n";
		print OUT 'RGSM='.$array.''."\n\n";

		print OUT 'samtools sort -o Bam/'.$array.'.'.$j.'_soybeansorted.bam -O bam Bam/'.$array.'.'.$j.'_soybeanwrg.bam'."\n";
		print OUT 'samtools index -b Bam/'.$array.'.'.$j.'_soybeansorted.bam Bam/'.$array.'.'.$j.'_soybeansorted.bai'."\n";
		print OUT 'samtools idxstats Bam/'.$array.'.'.$j.'_soybeansorted.bam  > Stats/'.$array.'.'.$j.'_soybean.stats'."\n\n";

		close OUT;

		system('sbatch /work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/Map_'.$j.'_'.$array.'.slurm');
 
		}
	}

}
close IN;

