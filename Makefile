# -*- mode: Makefile; tab-width: 8; indent-tabs-mode: t; -*-

AS = mrisc32-elf-as
ASFLAGS = -I src
AR = mrisc32-elf-ar
ARFLAGS = crs

OUT = out

LIBSELFTEST = $(OUT)/libselftest.a

OBJS = \
  $(OUT)/test_add.o

.PHONY: all clean

all: $(LIBSELFTEST)

clean:
	rm -rf $(OUT)/*

$(LIBSELFTEST): $(OBJS)
	$(AR) $(ARFLAGS) $(LIBSELFTEST) $(OBJS)

$(OUT)/test_add.o: src/test_add.s
	$(AS) $(ASFLAGS) -o $@ $<

