#!/bin/bash
#SBATCH --job-name=RM_THer
#SBATCH --cpus-per-task=32
#SBATCH --mem=500gb
#SBATCH --time=240:00:00
#SBATCH -o %x.%N.%j.out
#SBATCH -e %x.%N.%j.err
#SBATCH --partition=bigmem

#Donwload the wrapper script if not available
if [ ! -f dfam-tetools.sh ]; then
    curl -sSLO https://github.com/Dfam-consortium/TETools/raw/master/dfam-tetools.sh
    chmod +x dfam-tetools.sh
fi

#Run RepeatModeler 
docker run --rm -v $(pwd):/data -w /data dfam/tetools:latest bash -c "
    echo '--- Starting building the database ---'
    BuildDatabase -name TesHerHer.hap2 TesHerHer.hap2_nuclear.genomic.fna
    
    echo '--- Running RepeatModeler ---'
    RepeatModeler -database TesHerHer.hap2 -threads 32 -LTRStruct
    
    echo '--- Pipeline completed ---'
"
