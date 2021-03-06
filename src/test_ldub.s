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

    BEGIN_TEST  test_ldub

    add     s9, pc, #data@pc

    ; Immediate offset.
    ldub    s11, s9, #0
    CHECKEQ s11, 1

    ldub    s11, s9, #2
    CHECKEQ s11, 3

    ldub    s11, s9, #3
    CHECKEQ s11, 0x000000fc

    ; Register offset.
    ldub    s11, s9, z
    CHECKEQ s11, 1

    ldi     s10, #7
    ldub    s11, s9, s10
    CHECKEQ s11, 0x000000f8

    ; Register offset with scale.
    ldi     s10, #1

    ldub    s11, s9, s10*2
    CHECKEQ s11, 3

    ldub    s11, s9, s10*4
    CHECKEQ s11, 5

    ldub    s11, s9, s10*8
    CHECKEQ s11, 9

    END_TEST

data:
    .byte   1, -2, 3, -4, 5, -6, 7, -8, 9


