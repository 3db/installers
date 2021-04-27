#/bin/sh

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

echo $DISTRO

case $DISTRO in
    Arch)
        sudo pacman -Sy  alembic boost-libs desktop-file-utils embree ffmpeg fftw freetype2 glew hicolor-icon-theme jack jemalloc libpng libsndfile libspnav libtiff log4cplus openal opencollada opencolorio1 openexr openimagedenoise openimageio openjpeg2 openshadinglanguage opensubdiv openvdb openxr potrace ptex python python-numpy python-requests sdl2 shared-mime-info xdg-utils;
        ;;
    Ubuntu)
        sudo apt-get update
        sudo apt-get install -y build-essential git subversion cmake libx11-dev libxxf86vm-dev libxcursor-dev libxi-dev libxrandr-dev libxinerama-dev libglew-dev;
        ;;
esac

conda create -n threedb python=3.7.7
source ~/.bashrc 
conda activate threedb
echo $CONDA_PREFIX

git clone https://github.com/3db/3db.git /tmp/3db
mv /tmp/3db/threedb $CONDA_PREFIX/lib/python3.7/site-packages

curl "https://mirror.clarkson.edu/blender/release/Blender2.92/blender-2.92.0-linux64.tar.xz" --output /tmp/blender.tar.xz
cd $CONDA_PREFIX
tar -xf /tmp/blender.tar.xz -C ./
rm /tmp/blender.tar.xz
mv blender-2.92.0-linux64/ blender
rm -rf ./blender/2.92/python
ln -s $CONDA_PREFIX ./blender/2.92/python
rm $CONDA_PREFIX/bin/blender
ln -s $CONDA_PREFIX/blender/blender $CONDA_PREFIX/bin
