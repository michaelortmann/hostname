# SPDX-License-Identifier: MIT
# Copyright (c) 2006-2025 Michael Ortmann

# use as and ld from gnu binutils
# tested with binutils-2.17 under SunOS
# dont use sun as and ld

# as -R hostname.s -o hostname.o
# ld -s hostname.o -o hostname

# binutils can also be compiled with sparc elf target to cross assemble
# and link to sparc elf
# tested with binutils 2.42 under GNU/Linux x86-64

# wget http://ftp.gnu.org/gnu/binutils/binutils-2.42.tar.xz
# tar -Jxf binutils-2.42.tar.xz
# cd binutils-2.42
# ./configure --prefix=/home/michael/opt/binutils-2.42-sparc-elf --target=sparc-elf
# make
# make install

/home/michael/opt/binutils-2.42-sparc-elf/bin/sparc-elf-as -R hostname.s -o hostname.o
/home/michael/opt/binutils-2.42-sparc-elf/bin/sparc-elf-ld -s hostname.o -o hostname

# https://www.muppetlabs.com/~breadbox/software/elfkickers.html

sstrip hostname
