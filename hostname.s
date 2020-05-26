! SPDX-License-Identifier: MIT
! Copyright (c) 2006 Michael Ortmann

  .global _start

  .text

_start:
  mov  2,%o0        ! int command : SI_HOSTNAME = 2
  set  str0,%o1     ! char *buf
  mov  256,%o2      ! long count
  mov  139,%g1      ! long sysinfo(int command, char *buf, long count)
  ta   0

  set  str0,%o1     ! *str
  mov  0,%o2        ! len = 0
  mov  %o1,%o3
next:
  ldub [%o3],%o0    ! c = str[len]
  cmp  %o0,0        ! c == \0 ?
  be   done
  inc  %o2          ! len++
  inc  %o3          ! &c++
  ba   next
done:
  mov  '\n',%o0
  stb  %o0,[%o3]

  mov  1,%o0        ! stdout
  mov  4,%g1        ! write(0, str, len);
  ta   0

  mov  0,%o0        ! n = 0
  mov  1,%g1        ! exit(n)
  ta   0

  .lcomm str0 256
