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

    BEGIN_TEST  test_ebfu

    ; Immediate operand.
    ldi     r9, #123456
    ebfu    r10, r9, #3         ; Pure shift.
    CHECKEQ r10, 15432

    ldi     r9, #-41
    ebfu    r10, r9, #<3:7>     ; Width and shift.
    CHECKEQ r10, 0x0000007a


    ; Register operands.
    ldi     r9, #0x23456
    ldi     r10, #5
    ebfu    r11, r9, r10
    CHECKEQ r11, 0x11a2

    ldi     r9, #0xa9875000
    ldi     r10, #17
    ebfu    r11, r9, r10
    CHECKEQ r11, 0x000054c3

    ; Can we do packed operations?
    NOPM    no_packed_ops

    ldi     r9,  #0x1289ab78
    ldi     r10, #0x0062000a
    ldi     r11, #0x11020304

    ; Packed half-word.
    ebfu.h  r12, r9, r10
    CHECKEQ r12, 0x04a2002a

    ; Packed byte.
    ebfu.b   r12, r9, r11
    CHECKEQ r12, 0x01221507

no_packed_ops:

    END_TEST

