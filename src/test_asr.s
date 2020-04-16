; -*- mode: mr32asm; tab-width: 4; indent-tabs-mode: nil; -*-
;-----------------------------------------------------------------------------
; Copyright (c) 2020 Marcus Geelnard
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

    BEGIN_TEST  test_asr

    ; Immediate operand.
    ldi     s9, #123456
    asr     s10, s9, #3
    CHECKEQ s10, 15432

    ldi     s9, #-41
    asr     s10, s9, #33    ; Only the lowest 5 bits are used (i.e. >> 1)!
    CHECKEQ s10, -21


    ; Register operands.
    ldi     s9, #0x23456
    ldi     s10, #5
    asr     s11, s9, s10
    CHECKEQ s11, 0x11a2

    ldi     s9, #0xa9875000
    ldi     s10, #17
    asr     s11, s9, s10
    CHECKEQ s11, 0xffffd4c3

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ldi     s9,  #0x1289ab78
    ldi     s10, #0x0002000a
    ldi     s11, #0x01020304

    ; Packed half-word.
    asr.h   s12, s9, s10
    CHECKEQ s12, 0x04a2ffea

    ; Packed byte.
    asr.b   s12, s9, s11
    CHECKEQ s12, 0x09e2f507

no_packed_ops:

    END_TEST

