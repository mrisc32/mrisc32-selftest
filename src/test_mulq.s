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

    BEGIN_TEST  test_mulq

    ; Positive values.
    ldi     r9, #0x39431365
    ldi     r10, #0x65432137
    mulq    r11, r9, r10
    CHECKEQ r11, 0x2d4cf545

    ; Negative result.
    ldi     r9, #0x39431365
    ldi     r10, #0xe5432137
    mulq    r11, r9, r10
    CHECKEQ r11, 0xf409e1e0

    ; Saturating negative values 1.
    ldi     r9, #0x80000000
    ldi     r10, #0x80000000
    mulq    r11, r9, r10
    CHECKEQ r11, 0x7fffffff

    ; "Saturating" negative values 2.
    ldi     r9, #0x80000000
    ldi     r10, #0x80000001
    mulq    r11, r9, r10
    CHECKEQ r11, 0x7fffffff
    mulq    r11, r10, r9
    CHECKEQ r11, 0x7fffffff

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ldi     r9, #0x1234a698
    ldi     r10, #0xa7ef83a3

    ; Packed half-word.
    mulq.h  r11, r9, r10
    CHECKEQ r11, 0xf37956dd

    ; Packed byte.
    mulq.b  r11, r9, r10
    CHECKEQ r11, 0xf3f9574b

no_packed_ops:

    END_TEST

