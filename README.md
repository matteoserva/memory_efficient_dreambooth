# Deprecation warning
    This repository is obsolete. ShivamShrirao made a better implementation of this.
    Here is [his repository](https://github.com/ShivamShrirao/diffusers).


# notes
    the original source is from https://github.com/ShivamShrirao/diffusers
    I used this revision of the xformers library pip install git+https://github.com/facebookresearch/xformers@1d31a3a#egg=xformers
    Tested on a nvidia 3060 12G.
    My machine: 
        debian linux, 
        64GB of ram, 
        a nvidia 3060 as the main gpu for the desktop, 
        a secondary nvidia 1060 6G.


# DreamBooth training example

    open comand.sh and edit the folder names and the relevant parameters
    
    DREAMBOOTH_SECONDARY is the device where you want to put the vae.
    If unsure, leave "cpu". If you have a secondary GPU, then use "cuda:1". If you want to use the main gpu, then "cuda"
    
    The EFFICIENT_TRAINER is set to 1 to use the most efficient setup I found.
    For a bit more precise training use 0.

    PARALLEL_TRAINING. If 0, the execution is alternating between cpu and gpu
    If set to 1, the gpu and secondary device will run in parallel.
    Parallel training doesn't increase VRAM.
