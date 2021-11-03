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

    BEGIN_TEST  test_mulhi

    ; Register operands.
    ldi     r9, #123456
    ldi     r10, #-9456775
    mulhi   r11, r9, r10
    CHECKEQ r11, 0xfffffef0

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ldi     r9, #0x1234a698
    ldi     r10, #0xa7ef83a3

    ; Packed half-word.
    mulhi.h r11, r9, r10
    CHECKEQ r11, 0xf9bc2b6e

    ; Packed byte.
    mulhi.b r11, r9, r10
    CHECKEQ r11, 0xf9fc2b25

no_packed_ops:

    END_TEST

