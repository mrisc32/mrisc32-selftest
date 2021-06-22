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

    BEGIN_TEST  test_ldea

    ldi     r9, #0x12345678

    ; Immediate offset.
    ldea    r10, r9, #0
    CHECKEQ r10, 0x12345678

    ldea    r10, r9, #42
    CHECKEQ r10, 0x123456a2

    ldea    r10, r9, #-42
    CHECKEQ r10, 0x1234564e


    ; Register offset.
    ldi     r10, #42
    ldea    r10, r9, r10
    CHECKEQ r10, 0x123456a2

    ldi     r10, #-42
    ldea    r10, r9, r10
    CHECKEQ r10, 0x1234564e

    ; Register offset with scale.
    ldi     r10, #1

    ldea    r11, r9, r10*2
    CHECKEQ r11, 0x1234567a

    ldea    r11, r9, r10*4
    CHECKEQ r11, 0x1234567c

    ldea    r11, r9, r10*8
    CHECKEQ r11, 0x12345680

    END_TEST

