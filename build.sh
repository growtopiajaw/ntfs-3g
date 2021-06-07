#! /bin/bash

##############################################################################
#                                                                            #
# ARMv7 (hard-float) ntfs-3g build script for Ubuntu 14.04.6 LTS Trusty Tahr #
#                                                                            #
##############################################################################

if [ ! -d "$HOME"/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf ]; then
  sudo apt update >/dev/null 2>&1
  sudo apt install autoconf automake libtool m4 libgcrypt20-dev pkg-config make wget xz-utils -y >/dev/null 2>&1
  wget https://github.com/growtopiajaw/ntfs-3g/releases/download/v2017.3.23/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf.tar.xz -O "$HOME"/
  tar -C "$HOME" xvf "$HOME"/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf.tar.xz
  echo -e 'Please enter "export PATH=$PATH:$HOME/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf/bin" without quotes into your command prompt'
fi
./autogen.sh
./configure --enable-really-static --host=arm-none-linux-gnueabihf
make -j 4
tar -C src -cvf ntfs-3g.tar ntfs-3g lowntfs-3g ntfs-3g.probe
xz -z9ev ntfs-3g.tar
echo -e "Your files are ready at $(pwd)/ntfs-3g.tar.xz"
