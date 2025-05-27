#!/bin/bash

####################### Configuration starts here ####################### 

## Add here the external features you want to enable in all the cases. 

git clone https://gitlab.bsc.es/ear_team/ear.git
cd ear
# Specify source path
SRCPATH=$PWD

# EAR library versions: enabled or disabled
openmpi="enabled"
nompi="enabled"
intelmpi="disabled"

# If gpus are disabled, remove --with-cuda flag from configure
export extra_disable="--disable-avx512"
# End disable section

# Installation paths
export EAR_VERSION=5.1
# tag is a text to be included as prefix for the installation path
export tag="8"
# Installation prefix path
export INSTALL_ROOT=$HOME/EAR
export INS_PATH=$INSTALL_ROOT/ear$EAR_VERSION.$tag

export ETC=$INS_PATH/etc
export ETMP=/var/ear
export DOCPATH=$INSTALL_ROOT/doc

## If some specific paths must be defined becauset there is no module, add here

# Uncoment to install with specific users
#export US=ear
#export GR=ear

####################### Configuration
	echo "  Features enabled: " $EAR_FEATURES
  echo "  libraries compiled IntelMPI=$intelmpi OpenMPI=$openmpi NO-MPI=$nompi"
  echo "  Install path $INS_PATH"
  echo "  Sources      $SRCPATH"
  echo "  This script executes the configure, make, make install for the enabled versions. ETC is also installed with template files"
	echo "  No services are started"


# Ear deploy script

# Modify with specific modules to be loaded

core_modules="2023"
intel_modules="iimpi/2023a"
nvidia_modules="CUDA/12.1.1"
openmpi_modules="gompi/2023a"


####################### Configuration ends here ####################### 

# Start preparing environment

echo "******************************** EAR installation starts here ********************************"
module purge
module load $core_modules

# PATH configuration
cd $SRCPATH

echo "***** Autoreconfig ****"
autoreconf -i


if [ "$nompi" == "enabled" ]; then
module load  $openmpi_modules
module load  $nvidia_modules

echo "------------------------"
echo "Configuring NO MPI"
echo "------------------------"

my_cflags='-march=native -Wall -g'

echo "Using CFLAGS="$my_cflags
./configure --prefix=$INS_PATH EAR_TMP=$ETMP EAR_ETC=$ETC CC=gcc CC_FLAGS="$my_cflags" MPICC_FLAGS="$my_cflags" MPICC=mpicc MAKE_NAME=nompi.$tag  USER=$US GROUP=$GR --docdir=$DOCPATH --disable-mpi --with-cuda=$CUDA_ROOT $extra_disable 


echo "------------------------"
echo " Compiling NO MPI"
echo "------------------------"

eval $EAR_FEATURES make -f Makefile.nompi.$tag full
eval $EAR_FEATURES make -f Makefile.nompi.$tag install
eval $EAR_FEATURES make -f Makefile.intelmpi.$tag etc.install
eval $EAR_FEATURES make -f Makefile.intelmpi.$tag doc.install

fi
module unload $nvidia_modules
module unload $openmpi_modules

if [ "$openmpi" == "enabled" ]; then
module load  $openmpi_modules
module load  $nvidia_modules

echo "------------------------"
echo "Configuring OpenMPI"
echo "------------------------"

my_cflags='-march=native -Wall'
echo "Using CFLAGS="$my_cflags
./configure --prefix=$INS_PATH EAR_TMP=$ETMP EAR_ETC=$ETC CC=gcc CC_FLAGS="$my_cflags" MPICC_FLAGS="$my_cflags" MPICC=mpicc MPI_VERSION=ompi MAKE_NAME=openmpi.$tag  USER=$US GROUP=$GR --docdir=$DOCPATH --with-cuda=$CUDA_ROOT $extra_disable 


echo "------------------------"
echo " Compiling OpenMPI"
echo "------------------------"

eval $EAR_FEATURES make -f Makefile.openmpi.$tag full
eval $EAR_FEATURES make -f Makefile.openmpi.$tag install

module unload $nvidia_modules
module unload $openmpi_modules
fi


if [ "$intelmpi" == "enabled" ]; then
module load  $intel_modules
module load  $nvidia_modules

echo "------------------------"
echo "Configuring IntelMPI"
echo "------------------------"

my_cflags='-Wno-unused-command-line-argument -static-intel -Wall -g -Rno-debug-disables-optimization -Wno-empty-body'
echo "Using CFLAGS="$my_cflags

./configure --prefix=$INS_PATH EAR_TMP=$ETMP EAR_ETC=$ETC CC=icx CC_FLAGS="$my_cflags" MPICC_FLAGS="$my_cflags" MPICC=mpiicc MAKE_NAME=intelmpi.$tag   USER=$US GROUP=$GR --docdir=$DOCPATH --with-cuda=$CUDA_ROOT $extra_disable 

echo "------------------------"
echo " Compiling IntelMPI"
echo "------------------------"

eval $EAR_FEATURES make -f Makefile.intelmpi.$tag full
eval $EAR_FEATURES make -f Makefile.intelmpi.$tag earl.install

module unload $nvidia_modules
module unload $intel_modules
fi


echo "******************************** EAR installation ends here ********************************"
