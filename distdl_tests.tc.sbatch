#!/bin/bash

#SBATCH -N 2 --ntasks-per-node=10
#SBATCH -t 00:10:00
#SBATCH -p normal_q

#SBATCH -A distdl

#Change to the directory from which the job was submitted
cd $SLURM_SUBMIT_DIR


#Load module
module load SciPy-bundle/2020.03-gomkl-2020a-Python-3.8.2
module load PyTorch/1.6.0-gomkl-2020a-Python-3.8.2
module load mpi4py/3.0.2-gompi-2020a-timed-pingpong

srun --ntasks 20 python -m mpi4py -m pytest --with-mpi -rsa tests
