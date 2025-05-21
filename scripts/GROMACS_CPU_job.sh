#!/bin/bash

#SBATCH -p rome
#SBATCH --ntasks 128
#SBATCH -t 00:59:00
#SBATCH --exclusive 

#SBATCH --output=GROMACS.CPU.%j.out
#SBATCH --error=GROMACS.CPU.%j.err
#SBATCH --job-name=GROMACS.CPU

module load 2024
module load GROMACS/2024.3-foss-2024a-CUDA-12.6.0-PLUMED-2.9.2

# ENV variable needed to report "loops" to the EARDB
# export EARL_REPORT_LOOPS=1

# location of the binaries for the course
PROJECT_DIR=/projects/0/energy-course

# The different simulation domains available

# 20K atom system  --> Crambin_benchmark.tpr
# 1.4M atom system --> hEGFRDimer_benchmark.tpr
# 3M atom system   --> hEGFRDimerSmallerPL_benchmark.tpr

#CPU run
srun --ntasks=128 --cpus-per-task=1 gmx_mpi mdrun -s $PROJECT_DIR/GROMACS/hEGFRDimerSmallerPL_benchmark.tpr
