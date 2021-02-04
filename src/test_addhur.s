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

    BEGIN_TEST  test_addhur

    NOSA    no_saturating_ops

    ; Rounding.
    ldi     s9,  #0x7fffffff
    ldi     s10, #0x65432124
    addhur  s11, s9, s10
    CHECKEQ s11, 0x72a19092

    ; Unsigned operands.
    ldi     s9,  #0xffffff85  ; (-123)
    ldi     s10, #0x0000007c  ; (124)
    addhur  s11, s9, s10
    CHECKEQ s11, 0x80000001

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ; Packed half-word.
    ldi     s9,  #0x71238471
    ldi     s10, #0x81727999
    addhur.h s11, s9, s10
    CHECKEQ s11, 0x794b7f05

    ; Packed byte.
    ldi     s9,  #0x13700185
    ldi     s10, #0x3468ff81
    addhur.b s11, s9, s10
    CHECKEQ s11, 0x246c8083

no_packed_ops:
no_saturating_ops:

    END_TEST

