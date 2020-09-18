#!/bin/bash

#SBATCH -N 1 --ntasks-per-node=4 -c 4
#SBATCH -t 00:10:00
#SBATCH -p normal_q

#SBATCH -A tcfriendly

#Change to the directory from which the job was submitted
cd $SLURM_SUBMIT_DIR


#Load module
module load foss/2020a
module load SciPy-bundle/2020.03-foss-2020a-Python-3.8.2
module load PyTorch/1.4.0-foss-2020a-Python-3.8.2
module load mpi4py/3.0.2-gompi-2020a-timed-pingpong

mpirun -np 4 --map-by ppr:1:L3cache --bind-to l3cache -x OMP_NUM_THREADS=1 python distributed_experiment.py
