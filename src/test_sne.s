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

    BEGIN_TEST  test_sne

    ; Immediate operand.
    ldi     s9, #123456
    sne     s10, s9, #42
    CHECKEQ s10, 0xffffffff

    ldi     s9, #42
    sne     s10, s9, #42
    CHECKEQ s10, 0x00000000


    ; Register operands.
    ldi     s9, #123456
    ldi     s10, #-9456
    sne     s11, s9, s10
    CHECKEQ s11, 0xffffffff

    ldi     s9, #123456
    ldi     s10, #123456
    sne     s11, s9, s10
    CHECKEQ s11, 0x00000000

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ldhi    s9,       #0x1234a698@hi
    or      s9, s9,   #0x1234a698@lo
    ldhi    s10,      #0x1212a698@hi
    or      s10, s10, #0x1212a698@lo

    ; Packed half-word.
    sne.h   s11, s9, s10
    CHECKEQ s11, 0xffff0000

    ; Packed byte.
    sne.b   s11, s9, s10
    CHECKEQ s11, 0x00ff0000

no_packed_ops:

    END_TEST

