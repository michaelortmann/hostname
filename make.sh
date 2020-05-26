# SPDX-License-Identifier: MIT
# Copyright (c) 2006 Michael Ortmann

# use as and ld from gnu binutils
# tested with binutils-2.17
# dont use sun as and ld

as -R hostname.s -o hostname.o
ld -s hostname.o -o hostname
