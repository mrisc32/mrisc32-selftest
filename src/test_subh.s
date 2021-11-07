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

    BEGIN_TEST  test_subh

    NOSM    no_saturating_ops

    ; No rounding.
    ldi     r9,  #0x7fffffff
    ldi     r10, #0x65432124
    subh    r11, r9, r10
    CHECKEQ r11, 0x0d5e6f6d

    ; Signed operands.
    ldi     r9,  #-123
    ldi     r10, #124
    subh    r11, r9, r10
    CHECKEQ r11, -124

    ; Can we do packed operations?
    NOPM    no_packed_ops

    ; Packed half-word.
    ldi     r9,  #0x71238471
    ldi     r10, #0x81727999
    subh.h  r11, r9, r10
    CHECKEQ r11, 0x77d8856c

    ; Packed byte.
    ldi     r9,  #0x13700185
    ldi     r10, #0x3468ff81
    subh.b  r11, r9, r10
    CHECKEQ r11, 0xef040102

no_packed_ops:
no_saturating_ops:

    END_TEST

