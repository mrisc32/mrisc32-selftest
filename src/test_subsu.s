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

    BEGIN_TEST  test_subsu

    NOSA    no_saturating_ops

    ; Unsaturated should be the same as sub.
    ldi     s9, #9926
    ldi     s10, #1367
    subsu   s11, s9, s10
    CHECKEQ s11, 8559

    ; Saturate at min word.
    ldi     s9, #0x05432000
    ldi     s10,  #0x81234000
    subsu   s11, s9, s10
    CHECKEQ s11, 0x00000000

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ; Packed half-word.
    ldi     s9,  #0x7123f471
    ldi     s10, #0x81727999
    subsu.h s11, s9, s10
    CHECKEQ s11, 0x00007ad8

    ; Packed byte.
    ldi     s9,  #0x1298f085
    ldi     s10, #0x3470ff71
    subsu.b s11, s9, s10
    CHECKEQ s11, 0x00280014

no_packed_ops:
no_saturating_ops:

    END_TEST

