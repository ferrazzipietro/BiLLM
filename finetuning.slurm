#!/bin/bash -l
### job name
#SBATCH --job-name=finetuning

### 
#SBATCH --mail-user=ferrazzi@math.unipd.it

### Standard output and standard error for our job
#SBATCH --error=finetuning.err
#SBATCH --output=finetuning.out

### queue/partition choosed
#SBATCH --partition=testing
### Number of tasks
#SBATCH --ntasks=1

### RAM requirement
#SBATCH --mem=32G

### Time limit for our job (ten minutes here: HH:MM:SS)
#SBATCH --time=96:00:00

### GPU request
#SBATCH --gres=gpu
####SBATCH --constraint=A6000
####SBATCH --constraint=vgpu1-1

### Some useful informative commands
echo -n 'Date: '
date
echo -n 'Directory: '
pwd
echo -n 'This job will be executed on th following nodes: '
echo ${SLURM_NODELIST}
echo

SHELL=/bin/bash

### Jobs execution commands
conda activate gpu_venv_lates
which python
export 'PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:256'

python --version
WANDB_MODE=disabled BiLLM_START_INDEX=0 python examples/billm_ner.py --model_name_or_path mistralai/Mistral-7B-v0.1 --dataset_name_or_path conll2003 --push_to_hub 0# train_ls_llama.py
echo -n 'Date: '
date
