#!/bin/bash

#SBATCH -N 1 --ntasks-per-node=4 -c 4
#SBATCH -t 00:10:00
#SBATCH -p normal_q

#SBATCH -A tcfriendly

#Change to the directory from which the job was submitted
cd $SLURM_SUBMIT_DIR


#Load module
module load SciPy-bundle/2020.03-gomkl-2020a-Python-3.8.2
module load PyTorch/1.6.0-gomkl-2020a-Python-3.8.2

mpirun -np 4 --map-by ppr:1:L3cache --bind-to l3cache -x OMP_NUM_THREADS=1 python distributed_experiment.py
