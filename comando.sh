#!/bin/bash


####################################
### start configuration parameters
####################################

CLASS_NAME="person"
INSTANCE_NAME="matteo"

MODEL_NAME=/home/matteo/programmi/stable-diffusion-v1-4/stable-diffusion-v1-4/
OUTPUT_DIR=/home/matteo/programmi/stable-diffusion-v1-4/trained_${INSTANCE_NAME}
CLASS_DIR=/home/matteo/Progetti/ImageAI/textual_inversion/${CLASS_NAME}
INSTANCE_DIR=/home/matteo/Progetti/ImageAI/textual_inversion/me/

INSTANCE_PROMPT="photo of $INSTANCE_NAME $CLASS_NAME"
CLASS_PROMPT="photo of a $CLASS_NAME"
export USE_MEMORY_EFFICIENT_ATTENTION=1


export DREAMBOOTH_SECONDARY=cpu
EFFICIENT_TRAINER=1
PARALLEL_TRAINING=0

####################################
### end of configuration parameters
####################################




PYTHON_TRAIN_FILENAME=train_dreambooth.py 
if [[ $PARALLEL_TRAINING -gt 0 ]]
then
PYTHON_TRAIN_FILENAME=train_dreambooth_parallel.py 
fi


if [[ $EFFICIENT_TRAINER -gt 0 ]]
then
    echo using the most efficient training
    accelerate launch $PYTHON_TRAIN_FILENAME \
    --pretrained_model_name_or_path=$MODEL_NAME --use_auth_token \
    --instance_data_dir=$INSTANCE_DIR \
    --class_data_dir=$CLASS_DIR \
    --output_dir=$OUTPUT_DIR \
    --instance_prompt="$INSTANCE_PROMPT" \
    --class_prompt="$CLASS_PROMPT" \
    --resolution=512 \
    --use_8bit_adam \
    --train_batch_size=1 \
    --learning_rate=5e-6 \
    --lr_scheduler="constant" \
    --lr_warmup_steps=0 \
    --sample_batch_size=4 \
    --num_class_images=200 \
    --max_train_steps=400
  
else

echo "you can also try this if you have enough memory and the correct repository, it uses the prior preservation and gradient accumulation" 
accelerate launch $PYTHON_TRAIN_FILENAME \
  --pretrained_model_name_or_path=$MODEL_NAME --use_auth_token \
  --instance_data_dir=$INSTANCE_DIR \
  --class_data_dir=$CLASS_DIR \
  --output_dir=$OUTPUT_DIR \
  --with_prior_preservation --prior_loss_weight=1.0 \
  --instance_prompt="$INSTANCE_PROMPT" \
  --class_prompt="$CLASS_PROMPT" \
  --resolution=512 \
  --use_8bit_adam \
  --train_batch_size=1 \
  --gradient_accumulation_steps=2 --gradient_checkpointing \
  --learning_rate=5e-6 \
  --lr_scheduler="constant" \
  --lr_warmup_steps=0 \
  --sample_batch_size=4 \
  --num_class_images=200 \
  --max_train_steps=800
  
fi

