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

AS = mrisc32-elf-as
ASFLAGS = -I src
AR = mrisc32-elf-ar
ARFLAGS = crs

OUT = out

LIBSELFTEST = $(OUT)/libselftest.a

OBJS = \
  $(OUT)/selftest.o \
  $(OUT)/test_cpuid.o \
  $(OUT)/test_or.o \
  $(OUT)/test_nor.o \
  $(OUT)/test_and.o \
  $(OUT)/test_bic.o \
  $(OUT)/test_xor.o \
  $(OUT)/test_add.o \
  $(OUT)/test_sub.o \
  $(OUT)/test_seq.o \
  $(OUT)/test_sne.o \
  $(OUT)/test_slt.o \
  $(OUT)/test_sltu.o \
  $(OUT)/test_sle.o \
  $(OUT)/test_sleu.o \
  $(OUT)/test_min.o \
  $(OUT)/test_max.o \
  $(OUT)/test_minu.o \
  $(OUT)/test_maxu.o \
  $(OUT)/test_asr.o \
  $(OUT)/test_lsl.o \
  $(OUT)/test_lsr.o \
  $(OUT)/test_shuf.o \
  $(OUT)/test_clz.o \
  $(OUT)/test_rev.o \
  $(OUT)/test_packb.o \
  $(OUT)/test_packh.o \
  $(OUT)/test_ldb.o \
  $(OUT)/test_ldub.o \
  $(OUT)/test_ldh.o \
  $(OUT)/test_lduh.o


.PHONY: all clean

all: $(LIBSELFTEST)

clean:
	rm -rf $(OUT)/*

$(LIBSELFTEST): $(OBJS)
	$(AR) $(ARFLAGS) $(LIBSELFTEST) $(OBJS)

$(OUT)/selftest.o: src/selftest.s
	$(AS) $(ASFLAGS) -o $@ $<

$(OUT)/test_%.o: src/test_%.s
	$(AS) $(ASFLAGS) -o $@ $<

