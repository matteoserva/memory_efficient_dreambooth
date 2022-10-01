# notes
    the original source is from https://github.com/ShivamShrirao/diffusers
    I used this revision of the xformers library pip install git+https://github.com/facebookresearch/xformers@1d31a3a#egg=xformers
    Tested on a nvidia 3060 12G


# DreamBooth training example

    open comand.sh and edit the folder names and the relevant parameters
    
    DREAMBOOTH_SECONDARY is the device where you want to put the vae.
    If unsure, leave "cpu". If you have a secondary GPU, then use "cuda:1". If you want to use the main gpu, then "cuda"
    
    The EFFICIENT_TRAINER is set to 1 to use the most efficient setup I found.
    For a bit more precise training use 0.
