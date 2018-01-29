# Project HashClash - MD5 & SHA-1 cryptanalytic toolbox

## Feedback & pingback appreciated

## Requirements
- An email account for results to be sent to (e.g. fakeaccount@gmail.com)
- C++11 compiler (e.g. g++)
- make
- autoconf & automake & libtool

  `sudo apt-get install autoconf automake libtool`
  
- zlib & bzip2 libraries

  `sudo apt-get install zlib1g-dev libbz2-dev`
  
- local boost C++ libraries (preferable version 1.57.0)

  `./install_boost.sh` 

  Override default boost version 1.57.0 and/or installation directory as follows:
  
  `BOOST_VERSION=1.65.1 BOOST_INSTALL_PREFIX=$HOME/boost/boost-1.65.1 ./install_boost.sh`
  
- heirloom-mailx and mailutils for emailing collisions to oneself

 `sudo apt-get install heirloom-mailx`
 `sudo apt-get install mailutils`
 
 - openssl (for email purposes)
 
 `sudo apt-get install openssl`
  
 - Optional: CUDA
 
  
## Building

- Build configure script

  `autoreconf --install`
  
- Run configure (with boost installed in `$(pwd)/boost-VERSION` by `install_boost.sh`)

  `./configure --with-boost=$(pwd)/boost-1.57.0 [--without-cuda|--with-cuda=/usr/local/cuda-X.X]`

- Build programs

  `make`

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

## Create you own identical-prefix collision

- Create temporary working directory

  `mkdir ipc_workdir`

  `cd ipc_workdir`

- Run script

  `echo -n "TEST" > prefix.txt`

  `../scripts/poc_no.sh prefix.txt`

  Note: the prefix file is expected to be a multiple of 64 bytes 
  and optionally plus a small multiple of 4 bytes.
  These last bytes will be used as forced message words in steps of 4 bytes
  inside the first near-collision block.
  Any remaining 1, 2 or 3 bytes of the prefix file are ignored.

  Note: the first time the script is run it will be slower
  as it needs to create the 'upper' differential path set for the first time.

- Example output:

```
$ xxd collision1.bin
0000000: 5445 5354 1789 6de2 c568 339d 8bbf 6269  TEST..m..h3...bi
0000010: 563a c4ab 2fba 7aba 6ec7 e182 8566 8883  V:../.z.n....f..
0000020: b0f2 d716 17d5 8f97 b244 b9ca dcaa af93  .........D......
0000030: 3a33 4552 a9fd 023b 7012 7e5c d644 9646  :3ER...;p.~\.D.F
0000040: 723e 737a 6c3a 66e5 5d51 8e7c 7bc2 ec4f  r>szl:f.]Q.|{..O
0000050: 95a2 349f 0f4b 2540 cbe6 5644 d113 104b  ..4..K%@..VD...K
0000060: 5c39 898d f19a f9e9 e2aa bbad e191 d2d3  \9..............
0000070: a25d 4df0 9058 a873 4ee8 9dc9 47a5 281c  .]M..X.sN...G.(.
```

- Make your own attack

  Inside poc_no.sh there are three example identical-prefix collision attacks,
  selected by N=1, 2 or 3.
  You can add your own choice of message word differences here
  and see if you can make own collision attack!
