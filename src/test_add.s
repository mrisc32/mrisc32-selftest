; -*- mode: mr32asm; tab-width: 4; indent-tabs-mode: nil; -*-

    .include    "selftest.inc"

    BEGIN_TEST  test_add

    ; Register operands.
    ldi     s9, #123456
    add     s10, s9, #42
    CHECKEQ s10, 123498

    ; Immediate operand.
    ldi     s9, #123456
    ldi     s10, #-9456
    add     s11, s9, s10
    CHECKEQ s11, 114000

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ldhi    s9,       #0x1234a698@hi
    or      s9, s9,   #0x1234a698@lo
    ldhi    s10,      #0xa7ef83a3@hi
    or      s10, s10, #0xa7ef83a3@lo

    ; Packed half-word.
    add.h   s11, s9, s10
    CHECKEQ s11, 0xba232a3b

    ; Packed byte.
    add.b   s11, s9, s10
    CHECKEQ s11, 0xb923293b

no_packed_ops:

    END_TEST

