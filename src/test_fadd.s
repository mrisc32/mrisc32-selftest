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

    BEGIN_TEST  test_fadd

    NOFM    no_fpu

    ldi     r9,  #0x3f800000    ; 1.0
    ldi     r10, #0x3f800000    ; 1.0
    fadd    r11, r9, r10
    CHECKEQ r11, 0x40000000     ; 2.0

    ldi     r9,  #0xbf800000    ; -1.0
    ldi     r10, #0xbf800000    ; -1.0
    fadd    r11, r9, r10
    CHECKEQ r11, 0xc0000000     ; -2.0

    ldi     r9,  #0x3f800000    ; 1.0
    ldi     r10, #0xbf800000    ; -1.0
    fadd    r11, r9, r10
    CHECKEQ r11, 0x00000000     ; 0.0

    ldi     r9,  #0xc49a4000    ; -1234.0
    ldi     r10, #0x00000000    ; 0.0
    fadd    r11, r9, r10
    CHECKEQ r11, 0xc49a4000     ; -1234.0

    ldi     r9,  #0xc76cee00    ; -60654.0
    ldi     r10, #0x47f1bb00    ; 123766.0
    fadd    r11, r9, r10
    CHECKEQ r11, 0x47768800     ; 63112.0

    ldi     r9,  #0x58635fa9    ; 1.0e15
    ldi     r10, #0x3f800000    ; 1.0
    fadd    r11, r9, r10
    CHECKEQ r11, 0x58635fa9     ; 1.0e15

    ldi     r9,  #0x7f7f0000    ; 3.38953138925e+38
    ldi     r10, #0x7f7d8000    ; 3.36959296931e+38
    fadd    r11, r9, r10
    CHECKEQ r11, 0x7f800000     ; Inf

    ldi     r9,  #0x7f7f0000    ; 3.38953138925e+38
    ldi     r10, #0xff7d8000    ; -3.36959296931e+38
    fadd    r11, r9, r10
    CHECKEQ r11, 0x7bc00000     ; 1.99384199368e+36

    ldi     r9,  #0x7f800000    ; Inf
    ldi     r10, #0xff800000    ; -Inf
    fadd    r11, r9, r10
    CHECKNAN r11                ; NaN

    ; Can we do packed operations?
    NOPM    no_packed_ops

    ; TODO(m): Add packed operations tests!

no_packed_ops:
no_fpu:

    END_TEST

