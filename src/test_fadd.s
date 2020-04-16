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

    NOSA    no_fpu

    ldi     s9,  #0x3f800000    ; 1.0
    ldi     s10, #0x3f800000    ; 1.0
    fadd    s11, s9, s10
    CHECKEQ s11, 0x40000000     ; 2.0

    ldi     s9,  #0x40490fdb    ; 3.141592... (PI)
    ldi     s10, #0x3f800000    ; 1.0
    fadd    s11, s9, s10
    CHECKEQ s11, 0x408487ee     ; 4.141592...

    ldi     s9,  #0x58635fa9    ; 1.0e15
    ldi     s10, #0x3f800000    ; 1.0
    fadd    s11, s9, s10
    CHECKEQ s11, 0x58635fa9     ; 1.0e15

    ldi     s9,  #0xc49a4000    ; -1234.0
    ldi     s10, #0x00000000    ; 0.0
    fadd    s11, s9, s10
    CHECKEQ s11, 0xc49a4000     ; -1234.0

    ldi     s9,  #0xc76cee00    ; -60654.0
    ldi     s10, #0x47f1bb00    ; 123766.0
    fadd    s11, s9, s10
    CHECKEQ s11, 0x47768800     ; 63112.0

    ldi     s9,  #0x3f7d70a4    ; 0.99000...
    ldi     s10, #0x3f7d70a4    ; 0.99000...
    fadd    s11, s9, s10
    CHECKEQ s11, 0x3ffd70a4     ; 1.98000...

    ldi     s9,  #0xbf7d70a4    ; -0.99000...
    ldi     s10, #0xbf7d70a4    ; -0.99000...
    fadd    s11, s9, s10
    CHECKEQ s11, 0xbffd70a4     ; -1.98000...

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ; TODO(m): Add packed operations tests!

no_packed_ops:
no_fpu:

    END_TEST

