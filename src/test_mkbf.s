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

    BEGIN_TEST  test_mkbf

    ; Immediate operands.
    ldi     s9, #123456
    mkbf    s10, s9, #3         ; Pure shift.
    CHECKEQ s10, 987648

    ldi     s9, #-41
    mkbf    s10, s9, #(7<<5)|3  ; Width and shift.
    CHECKEQ s10, 696

    ; Register operands.
    ldi     s9, #0x23456
    ldi     s10, #5
    mkbf    s11, s9, s10
    CHECKEQ s11, 0x468ac0

    ldi     s9, #0xa9875000
    ldi     s10, #17
    mkbf    s11, s9, s10
    CHECKEQ s11, 0xa0000000

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ldi     s9,  #0x1289ab78
    ldi     s10, #0x0062000a
    ldi     s11, #0x11028304

    ; Packed half-word.
    mkbf.h  s12, s9, s10
    CHECKEQ s12, 0x0024e000

    ; Packed byte.
    mkbf.b  s12, s9, s11
    CHECKEQ s12, 0x04245880

no_packed_ops:

    END_TEST

