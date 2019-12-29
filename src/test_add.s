; -*- mode: mr32asm; tab-width: 4; indent-tabs-mode: nil; -*-
;-----------------------------------------------------------------------------
; Copyright (c) 2019 Marcus Geelnard
;
; This software is provided 'as-is', without any express or implied warranty.
; In no event will the authors be held liable for any damages arising from
; the use of this software.
;
; Permission is granted to anyone to use this software for any purpose,
; including commercial applications, and to alter it and redistribute it
; freely, subject to the following restrictions:
;
;  1. The origin of this software must not be misrepresented; you must not
;     claim that you wrote the original software. If you use this software in
;     a product, an acknowledgment in the product documentation would be
;     appreciated but is not required.
;
;  2. Altered source versions must be plainly marked as such, and must not be
;     misrepresented as being the original software.
;
;  3. This notice may not be removed or altered from any source distribution.
;-----------------------------------------------------------------------------

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

