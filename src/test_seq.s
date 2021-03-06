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

    BEGIN_TEST  test_seq

    ; Immediate operand.
    ldi     s9, #123456
    seq     s10, s9, #42
    CHECKEQ s10, 0x00000000

    ldi     s9, #42
    seq     s10, s9, #42
    CHECKEQ s10, 0xffffffff


    ; Register operands.
    ldi     s9, #123456
    ldi     s10, #-9456
    seq     s11, s9, s10
    CHECKEQ s11, 0x00000000

    ldi     s9, #123456
    ldi     s10, #123456
    seq     s11, s9, s10
    CHECKEQ s11, 0xffffffff

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ldi     s9,  #0x1234a698
    ldi     s10, #0x1212a698

    ; Packed half-word.
    seq.h   s11, s9, s10
    CHECKEQ s11, 0x0000ffff

    ; Packed byte.
    seq.b   s11, s9, s10
    CHECKEQ s11, 0xff00ffff

no_packed_ops:

    END_TEST

