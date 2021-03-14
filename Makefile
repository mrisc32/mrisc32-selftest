# -*- mode: Makefile; tab-width: 8; indent-tabs-mode: t; -*-
#-----------------------------------------------------------------------------
# Copyright (c) 2019 Marcus Geelnard
#
# This software is provided 'as-is', without any express or implied warranty.
# In no event will the authors be held liable for any damages arising from
# the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
#  1. The origin of this software must not be misrepresented; you must not
#     claim that you wrote the original software. If you use this software in
#     a product, an acknowledgment in the product documentation would be
#     appreciated but is not required.
#
#  2. Altered source versions must be plainly marked as such, and must not be
#     misrepresented as being the original software.
#
#  3. This notice may not be removed or altered from any source distribution.
#-----------------------------------------------------------------------------

OUT = out

AS      = mrisc32-elf-gcc
ASFLAGS = -c -I src
AR      = mrisc32-elf-ar
ARFLAGS = crs

CC      = mrisc32-elf-gcc
CFLAGS  = -c -O2 -W -Wall -I src
LD      = mrisc32-elf-gcc
LDFLAGS = -L$(OUT) -msim
OBJCOPY = mrisc32-elf-objcopy

LIBSELFTEST = $(OUT)/libselftest.a

LIBOBJS = \
  $(OUT)/selftest.o \
  $(OUT)/test_add.o \
  $(OUT)/test_addh.o \
  $(OUT)/test_addhr.o \
  $(OUT)/test_addhu.o \
  $(OUT)/test_addhur.o \
  $(OUT)/test_addpchi.o \
  $(OUT)/test_adds.o \
  $(OUT)/test_addsu.o \
  $(OUT)/test_and.o \
  $(OUT)/test_bge.o \
  $(OUT)/test_bgt.o \
  $(OUT)/test_ble.o \
  $(OUT)/test_blt.o \
  $(OUT)/test_bns.o \
  $(OUT)/test_bnz.o \
  $(OUT)/test_bs.o \
  $(OUT)/test_bz.o \
  $(OUT)/test_clz.o \
  $(OUT)/test_cpuid.o \
  $(OUT)/test_ebf.o \
  $(OUT)/test_ebfu.o \
  $(OUT)/test_fadd.o \
  $(OUT)/test_jl.o \
  $(OUT)/test_j.o \
  $(OUT)/test_ldb.o \
  $(OUT)/test_ldea.o \
  $(OUT)/test_ldhi.o \
  $(OUT)/test_ldh.o \
  $(OUT)/test_ldli.o \
  $(OUT)/test_ldub.o \
  $(OUT)/test_lduh.o \
  $(OUT)/test_ldw.o \
  $(OUT)/test_ldwpc.o \
  $(OUT)/test_max.o \
  $(OUT)/test_maxu.o \
  $(OUT)/test_min.o \
  $(OUT)/test_minu.o \
  $(OUT)/test_mkbf.o \
  $(OUT)/test_mulq.o \
  $(OUT)/test_mulqr.o \
  $(OUT)/test_or.o \
  $(OUT)/test_pack.o \
  $(OUT)/test_packhi.o \
  $(OUT)/test_packhir.o \
  $(OUT)/test_packhiur.o \
  $(OUT)/test_packs.o \
  $(OUT)/test_packsu.o \
  $(OUT)/test_popcnt.o \
  $(OUT)/test_rev.o \
  $(OUT)/test_sel.o \
  $(OUT)/test_seq.o \
  $(OUT)/test_shuf.o \
  $(OUT)/test_sle.o \
  $(OUT)/test_sleu.o \
  $(OUT)/test_slt.o \
  $(OUT)/test_sltu.o \
  $(OUT)/test_sne.o \
  $(OUT)/test_stb.o \
  $(OUT)/test_sth.o \
  $(OUT)/test_stw.o \
  $(OUT)/test_stwpc.o \
  $(OUT)/test_sub.o \
  $(OUT)/test_subh.o \
  $(OUT)/test_subhr.o \
  $(OUT)/test_subhu.o \
  $(OUT)/test_subhur.o \
  $(OUT)/test_subs.o \
  $(OUT)/test_subsu.o \
  $(OUT)/test_xor.o

RUNTESTS = $(OUT)/runtests

RUNTESTSOBJS = \
  $(OUT)/runtests.o

.PHONY: all clean

all: $(LIBSELFTEST) $(RUNTESTS)

clean:
	rm -rf $(OUT)/*

$(LIBSELFTEST): $(LIBOBJS)
	$(AR) $(ARFLAGS) $(LIBSELFTEST) $(LIBOBJS)

$(OUT)/selftest.o: src/selftest.s
	$(AS) $(ASFLAGS) -o $@ $<

$(OUT)/test_%.o: src/test_%.s
	$(AS) $(ASFLAGS) -o $@ $<

$(RUNTESTS): $(OUT)/runtests.elf
	$(OBJCOPY) -O binary $< $@

$(OUT)/runtests.elf: $(RUNTESTSOBJS) $(LIBSELFTEST)
	$(LD) $(LDFLAGS) -o $@ $(RUNTESTSOBJS) -lselftest

$(OUT)/runtests.o: src/runtests.c
	$(CC) $(CFLAGS) -o $@ $<

