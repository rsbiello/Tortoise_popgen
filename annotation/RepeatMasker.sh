#!/bin/bash
#SBATCH --job-name=RM_THer
#SBATCH --cpus-per-task=32
#SBATCH --mem=100
#SBATCH --time=240:00:00
#SBATCH -o %x.%N.%j.out
#SBATCH -e %x.%N.%j.err

#Donwload the wrapper script if not available
if [ ! -f dfam-tetools.sh ]; then
    curl -sSLO https://github.com/Dfam-consortium/TETools/raw/master/dfam-tetools.sh
    chmod +x dfam-tetools.sh
fi

#Run RepeatMasker 
docker run --rm -v $(pwd):/data -w /data dfam/tetools:latest bash -c "
    RepeatMasker -a -gff -s -pa 32 -lib TesHerHer.hap2-families.fa TesHerHer.hap2_nuclear.genomic.fna
