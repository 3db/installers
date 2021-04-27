# Installers

## Automated Installation

We do our best to make installation as seamless as possible but we apologize in advance if you run into issues on your machine.

The goal of the automated scripts is tocreate a conda environment that has everything setup to run threedb. The env will be called `threedb` but you can change the name by editing the command.

Once the installation is over you have to activate the environment: `conda activate threedb` (assuming you didn't change the name in the command).

### Linux

### x86_64

- OSes: `Ubuntu`, `Archlinux`
- Requirements: `bash` `conda` or `miniconda`, `curl` and `git`

`curl https://raw.githubusercontent.com/3db/installers/main/linux_x86_64.sh | bash /dev/stdin threedb`

## Manual installation

If the scripts don't work for you or if you have an unsupported operating system you can still follow the manual installation steps:

- Install `blender`. The current supported version is `2.92` but it's possible that others will work
- Clone `https://github.com/3db/3db.git`
- Make sure the requirements (`requirements.txt`) in that repo are installed: `pip install -r ./requirements.txt`
- Make sure the 3db folder is part of your `$PYTHON_PATH`.

Blender uses its own `python` internally. It can problematic because when you installed the packages earlier in the set of instructions, these were for the regular version of python (wheter it's `conda`, your system python or a `virtualenv`). As a result when you run the workers they won't have the necessary packages. To solve that issue there are multiople alternatives. You should pick the one that suits you better:

### Option 1: Install the packages twice

- Install pip in the blender distribution of `python`: `PATH/TO/BLENDER/$BLENDER_VERSION/python/python${PYTHON_VERSION}m -m ensurepip`
- Install the requirements in the blender distribution of `python`: ``PATH/TO/BLENDER/$BLENDER_VERSION/python/python${PYTHON_VERSION}m/pip3 install -r PATH/TO/3DB/requirements.txt`

### Option 2: Make blender use your existing version of python

This is the solution used by the automated install script.

**Warning:** Because blender is a binary and was compiled against a specific version of python it expects an **specific** version of python. 

- Check the `python` version expected by Blender: `PATH/TO/BLENDER/$BLENDER_VERSION/python/python${PYTHON_VERSION}m --version`.
- Make sure it matches your currend python version: `python --version`
- If it doesn't change your current python install until they match
- Remove the python folder `PATH/TO/BLENDER/$BLENDER_VERSION/python` from your blender install
- Symlink your existing python installation there so that blender can use it
  - For `conda` if your environment is already activated: `ln -s $CONDA_PREFIX PATH/TO/BLENDER/$BLENDER_VERSION/python`
  - On most operating systems your system python will be in `/usr`, in this case you should do: `ln -s /usr PATH/TO/BLENDER/$BLENDER_VERSION/python`
