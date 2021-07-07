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

    BEGIN_TEST  test_ldb

    addpchi r9, #data@pchi
    add     r9, r9, #data+4@pclo

    ; Immediate offset.
    ldb     r11, [r9]
    CHECKEQ r11, 1

    ldb     r11, [r9, #2]
    CHECKEQ r11, 3

    ldb     r11, [r9, #3]
    CHECKEQ r11, -4

    ; Register offset.
    ldb     r11, [r9, z]
    CHECKEQ r11, 1

    ldi     r10, #7
    ldb     r11, [r9, r10]
    CHECKEQ r11, -8

    ; Register offset with scale.
    ldi     r10, #1

    ldb     r11, [r9, r10*2]
    CHECKEQ r11, 3

    ldb     r11, [r9, r10*4]
    CHECKEQ r11, 5

    ldb     r11, [r9, r10*8]
    CHECKEQ r11, 9

    END_TEST

data:
    .byte   1, -2, 3, -4, 5, -6, 7, -8, 9


