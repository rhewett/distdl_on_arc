
DistDL on TinkerCliffs

Review the SLURM documentation on ARC's website if you need help with SLURM commands.

1. Connect to VPN, if off-campus.
2. SSH into TinkerCliffs.  If you do not have an SSH key setup on ARC for the machine you are using, you will need to set one up.  (Instructions from 3634 attached.)

```
ssh  tinkercliffs1.arc.vt.edu

```


3. Setup your module environment.  This is important, as TinkerCliffs uses a different module system than the other ARC machines you may have used.
    a. required modules (in order, for discovery purposes)

    ```
    module load foss/2020a
    module load SciPy-bundle/2020.03-foss-2020a-Python-3.8.2
    module load PyTorch/1.4.0-foss-2020a-Python-3.8.2
    module load mpi4py/3.0.2-gompi-2020a-timed-pingpong

    ```

    b. optional modules (e.g., if you want IPython)

    ```
    module load Anaconda3/2020.07

    ```

4. Clone and install distdl.  These notes are for using the main repository.  You may use your own fork if you like.  Use whatever directory structure you like.
    a. Clone the repo.  You may also need to setup an SSH key on GitHub.

    ```
    git clone git@github.com:distdl/distdl.git

    ```

    b. From your clone's directory, install DistDL *locally*.  This will allow you to make local edits and not need to reinstall.  It also forces the dev requirements to install so that you can run any tests.

    ```
    pip install --user -e . -r requirements-dev.txt

    ```

5. Run the tests from an interactive session.  This gets 20 workers across two nodes using the `tcfriendly` allocation.  Load is low right now so this should be quick.  Exit when done to release the resources.

For numerical reasons, a test might occasionally fail.  If you get a failure, run it again to be sure it is a systemic issue.

```
interact -N 2 --ntasks-per-node=10 -p dev_q -A tcfriendly
srun --ntasks 20 python -m mpi4py -m pytest --with-mpi -rsa tests -x
exit

```

6. Run the tests from a batch session.  I've included a sample batch script.  The output will be in `slurm-JOBIDNUMBER.out`.

```
sbatch distdl_tests.tc.sbatch

```

7. Clone the sample network and install dependencies.  Be sure to do this from *outside* of the main DistDL repo. The version of torchvision we require is tied to version of PyTorch that is currently installed.

```
git clone git@github.com:distdl/distdl-examples.git
pip install 'torchvision==0.5.0'

```

8. From the `lenet5` directory, you can queue and run the sequential and distributed examples.  Sbatch files are included.  **Be sure to run the sequential first, it downloads data.**  You will probably want to queue sequential and only queue the distributed form when the sequential has run.

```
sbatch lenet5_seq.tc.sbatch
sbatch lenet5_dist.tc.sbatch

```

If all of these run, you are setup to work on TinkerCliffs.



