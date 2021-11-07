; -*- mode: mr32asm; tab-width: 4; indent-tabs-mode: nil; -*-
;-----------------------------------------------------------------------------
; Copyright (c) 2021 Marcus Geelnard
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

    BEGIN_TEST  test_madd

    ; Immediate operand.
    ldi     r9, #123456
    ldi     r10, #777
    madd    r10, r9, #42
    CHECKEQ r10, 5185929

    ; Register operands.
    ldi     r9, #1234
    ldi     r10, #-9456
    ldi     r11, #777
    madd    r11, r9, r10
    CHECKEQ r11, -11667927

    ; Can we do packed operations?
    NOPM    no_packed_ops

    ldi     r9, #0x01020304
    ldi     r10, #0x1234a698
    ldi     r11, #0xa7ef83a3

    ; Packed half-word.
    mov     r12, r9
    madd.h  r12, r10, r11
    CHECKEQ r12, 0xeb8eddcc

    ; Packed byte.
    mov     r12, r9
    madd.b  r12, r10, r11
    CHECKEQ r12, 0xbf8ef5cc

no_packed_ops:

    END_TEST

