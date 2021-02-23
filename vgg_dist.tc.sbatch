#!/bin/bash

# 4 node, 1 mpi task, 4 cores (or openMP threads) available for that task
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH -t 01:00:00
#SBATCH --partition=dev_q
#SBATCH --account=distdl

# Remove this for less accurate timing, but also using less resources
# This is just testing, so in general exclusive should not be set
#SBATCH --exclusive

#Change to the directory from which the job was submitted
cd $SLURM_SUBMIT_DIR

#Load modules
module load SciPy-bundle/2020.03-gomkl-2020a-Python-3.8.2
module load PyTorch/1.6.0-gomkl-2020a-Python-3.8.2
module load mpi4py/3.0.2-gompi-2020a-timed-pingpong

# Run with 16 threads to compare to the OMP enabled MPI test
mpirun -np 4 --map-by ppr:1:node --bind-to L3cache -x OMP_NUM_THREADS=4 python distributed_experiment.py

