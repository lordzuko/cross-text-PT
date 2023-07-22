#!/bin/bash
# Author(s): Himanshu Maurya
# How to use: 
# 1. cd the repo
# 2. sbatch ​train_job.slurm

# ====================
# Options for sbatch
# ====================
#SBATCH --account=tc046-hmaurya
#SBATCH --job-name=daft-exprt
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:4
#SBATCh --nodes=1
#SBATCH --time=24:00:00
#SBATCH --output=/work/tc046/tc046/%u/work/daft-exprt/slurm_logs/slurm-%A_output.out


# =====================
# Logging information
# =====================

# slurm info - more at https://slurm.schedmd.com/sbatch.html#lbAJ
echo "Job running on ${SLURM_JOB_NODELIST}"

dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job started: $dt"​
# Load the required modules
source /work/tc046/tc046/lordzuko/.bashrc
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/work/tc046/tc046/lordzuko/miniconda3/lib
echo "sourced .bashrc and env var set"

cd /work/tc046/tc046/lordzuko/work/daft-exprt/hifi_gan
conda activate daft_exprt
echo "conda environment activated"​
COMMAND="python train.py \
        --fine_tuning True \
        --config /work/tc046/tc046/lordzuko/work/daft-exprt/hifi_gan/config_v1.json \
        --input_wavs_dir /work/tc046/tc046/lordzuko/work/daft-exprt/trainings/daft_bc2013_v1/fine_tuning_dataset/CB \
        --input_mels_dir /work/tc046/tc046/lordzuko/work/daft-exprt/trainings/daft_bc2013_v1/fine_tuning_dataset/CB \
        --input_training_file /work/tc046/tc046/lordzuko/work/daft-exprt/trainings/hifigan/train_english.txt \
        --input_validation_file /work/tc046/tc046/lordzuko/work/daft-exprt/trainings/hifigan/validation_english.txt \
        --checkpoint_path /work/tc046/tc046/lordzuko/work/daft-exprt/trainings/hifigan/checkpoints \
        --batch_size 8"
echo "Running provided command: ${COMMAND}"
eval "${COMMAND}"
echo "Command ran successfully!"

# =========================
# Post experiment logging
# =========================
echo ""
echo "============"
echo "job finished successfully"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job finished: $dt"