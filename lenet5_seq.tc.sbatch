#!/bin/bash

# 1 node, 1 mpi task, 4 cores (or openMP threads) available for that task
#SBATCH -N 1 --ntasks-per-node=1 -c 4
#SBATCH -t 00:15:00
#SBATCH -p normal_q

#SBATCH -A tcfriendly

#Change to the directory from which the job was submitted
cd $SLURM_SUBMIT_DIR


#Load module
module load SciPy-bundle/2020.03-gomkl-2020a-Python-3.8.2
module load PyTorch/1.6.0-gomkl-2020a-Python-3.8.2

mpirun -np 1 --map-by ppr:1:L3cache --bind-to l3cache -x OMP_NUM_THREADS=4 python sequential_experiment.py
