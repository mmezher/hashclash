# Project HashClash - MD5 Collision Creation for AWS Server Use

## This copy of HashClash has been altered to allow for emails to be sent while process is running to say when MD5 collision is complete. Original HashClash program, written by Marc Stevens, is entirely his own work. This version is meant to be run on an EC2 Amazon Linux Server with >=2 CPUs and >= 2 GB RAM. 

## Requirements
- An email account for results to be sent to (e.g. fakeaccount@gmail.com)
- C++11 compiler (e.g. g++). In Amazon Linux, installation command is

  `sudo yum install gcc-c++`
  
- make

- autoconf & automake & libtool

  `sudo apt-get install autoconf automake libtool` or `sudo yum install autoconf automake libtool`
  
- zlib & bzip2 libraries

  `sudo apt-get install zlib1g-dev libbz2-dev` or `sudo yum install zlib bzip2-devel`
  
- git 

  `sudo yum install git`
  
- this GitHub repository

  `git clone https://github.com/mmezher/hashclash/`
  
- if using Amazon Free Tier or low memory, consider creating a swapfile

  `sudo dd if=/dev/zero of=/swapfile bs=1024 count=65536`
  `sudo mkswap /swapfile` or `sudo swapon /swapfile`

- local boost C++ libraries (preferable version 1.57.0)

  `cd hashclash`
  `./install_boost.sh` 

  If boost already installed, override default boost version to 1.57.0 and/or installation directory as follows:
  
  `BOOST_VERSION=1.65.1 BOOST_INSTALL_PREFIX=$HOME/boost/boost-1.65.1 ./install_boost.sh`
  
- heirloom-mailx and mailutils for emailing collisions to oneself

  `sudo apt-get install heirloom-mailx`
  `sudo apt-get install mailutils`
 
- openssl (for email purposes)
 
  `sudo apt-get install openssl`
  
- Optional: CUDA

## Setting up Email Functionality

- Create a certificate for gmail email to be used (Note: you may have to switch off some securitty settings on this gmail account.

  `mkdir /.certs`
  `certutil -N -d "/.certs"`
  `openssl s_client c-connect smtp.gmail.com:465 | sed -ne '/BEGIN CERTIFICATE-/,/END CERTIFICATE-/p' > "~/.certs/gmail.crt" certutil -A -n "Google Internet Authority" -t "C," -d`
  
## Building

- Build configure script

  `autoreconf --install`
  
- Run configure (with boost installed in `$(pwd)/boost-VERSION` by `install_boost.sh`)

  `./configure --with-boost=$(pwd)/boost-1.57.0 [--without-cuda|--with-cuda=/usr/local/cuda-X.X]`

- Build programs

  `make`
## Connecting to AWS Server via SSH in Terminal

- Create key to use for your EC2 instance in AWS
- Using key, ssh into the instance. ec2-user-name is default ec2-user. 

  `ssh -i key-name.pem ${ec2-user-name}@${ec2-server-name-here.compute.amazon.com}`
 
## Create your own chosen-prefix collisions

- Create temporary working directory (in top directory)

  `mkdir cpc_workdir`
  
  `cd cpc_workdir`
  
- Run script

  `../scripts/cpc.sh <prefix.filename1> <prefix.filename2>`

- Monitor progress of script

  `ls -altr`
  
  If last change to any directory is several hours old then
  * kill script & any running md5_diffpathhelper programs
  * let K be the number of the last `workdir$(K)` directory
  * restart script:
    `../scripts/cpc.sh <prefix.filename1> <prefix.filename2> $((K-1))`

