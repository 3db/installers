#/bin/sh

env_name=${1:-threedb}

# Determine OS platform
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
    # If available, use LSB to identify distribution
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
        export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
fi
# For everything else (or if above failed), just use generic identifier
[ "$DISTRO" == "" ] && export DISTRO=$UNAME
unset UNAME

case $DISTRO in
    Arch)
        sudo pacman -Sy  alembic boost-libs desktop-file-utils embree ffmpeg fftw freetype2 glew hicolor-icon-theme jack jemalloc libpng libsndfile libspnav libtiff log4cplus openal opencollada opencolorio1 openexr openimagedenoise openimageio openjpeg2 openshadinglanguage opensubdiv openvdb openxr potrace ptex python python-numpy python-requests sdl2 shared-mime-info xdg-utils;
        ;;
    Ubuntu)
        sudo apt-get update
        sudo apt-get install -y build-essential git subversion cmake libx11-dev libxxf86vm-dev libxcursor-dev libxi-dev libxrandr-dev libxinerama-dev libglew-dev;
        ;;
esac

conda create -y -n $env_name python=3.7.7
# source $CONDA_PREFIX/etc/profile.d/conda.sh
# source ~/anaconda3/etc/profile.d/conda.sh
CONDA_PREFIX=$(conda run -n $env_name bash -c 'echo \$CONDA_PREFIX')
echo $CONDA_PREFIX

rm -rf /tmp/3db
git clone https://github.com/3db/3db.git /tmp/3db
cd /tmp/3db
conda run -n $env_name pip install -r ./requirements.txt
cp -r /tmp/3db/threedb $CONDA_PREFIX/lib/python3.7/site-packages
mv /tmp/3db/threedb_* $CONDA_PREFIX/bin/

cd $CONDA_PREFIX
rm -rf /tmp/3db
rm $CONDA_PREFIX/bin/blender /tmp/blender.tar.xz blender-2.92.0-linux64/ 2> /dev/null
curl "https://mirror.clarkson.edu/blender/release/Blender2.92/blender-2.92.0-linux64.tar.xz" --output /tmp/blender.tar.xz
tar -xf /tmp/blender.tar.xz -C ./
rm /tmp/blender.tar.xz
mv blender-2.92.0-linux64/ blender
rm -rf ./blender/2.92/python
ln -s $CONDA_PREFIX ./blender/2.92/python
rm $CONDA_PREFIX/bin/blender 2> /dev/null
ln -s $CONDA_PREFIX/blender/blender $CONDA_PREFIX/bin/blender
