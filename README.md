# Installers

## Linux

### x86_64

- OSes: `Ubuntu`, `Archlinux`
- Requirements: `bash` `conda` or `miniconda`, `curl` and `git`

The following command will create a conda environment that has everything setup to run threedb. The env will be called `threedb` but you can change the name by editing the command.

`curl https://raw.githubusercontent.com/3db/installers/main/linux_x86_64.sh | bash /dev/stdin threedb`

You will have to activate it to use it: `conda activate threedb`.
