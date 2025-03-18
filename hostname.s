! SPDX-License-Identifier: MIT
! Copyright (c) 2006-2025 Michael Ortmann

  .equ COUNT,          257  ! https://docs.oracle.com/cd/E88353_01/html/E37841/sysinfo-2.html
  .equ EXIT_SUCCESS,   0    ! /usr/include/iso/stdlib_iso.h
  .equ SI_HOSTNAME,    2    ! /usr/include/sys/systeminfo.h
  .equ STDOUT_FILENO,  1    ! /usr/include/unistd.h
  .equ SYSCALL,        0x00 ! https://github.com/illumos/illumos-gate/blob/master/usr/src/uts/sun4u/ml/trap_table.S
  .equ SYS_exit,       1    ! /usr/include/sys/syscall.h
  .equ SYS_write,      4
  .equ SYS_systeminfo, 139

  .globl _start             ! entry symbol _start

_start:
  mov  SI_HOSTNAME,%o0      ! int command = SI_HOSTNAME = 2
  sub  %sp, (COUNT + 7) & ~7, %o1 ! char *buf, stack instead of bss, align 8
  mov  COUNT,%o2            ! long count
  mov  SYS_systeminfo,%g1   ! int sysinfo(int command, char *buf, long count)
  ta   SYSCALL              ! https://docs.oracle.com/cd/E88353_01/html/E37841/sysinfo-2.html

  mov  %o0,%o2              ! size_t nbyte
  dec  %o0                  ! buf + nbyte - 1 = '\n'
  mov  '\n',%o3
  stb  %o3,[%o1 + %o0]

  mov  STDOUT_FILENO,%o0    ! int fildes = STDOUT_FILENO = 1
  mov  SYS_write,%g1        ! ssize_t write(int fildes, const void *buf, size_t nbyte)
  ta   SYSCALL              ! https://docs.oracle.com/cd/E88353_01/html/E37841/write-2.html

  mov  EXIT_SUCCESS,%o0     ! int status = EXIT_SUCCESS = 0
  mov  SYS_exit,%g1         ! void exit(int status)
  ta   SYSCALL              ! https://docs.oracle.com/cd/E88353_01/html/E37841/exit-2.html
