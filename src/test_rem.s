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

    BEGIN_TEST  test_rem

    ; Immediate operand.
    ldi     r9, #123456
    rem     r10, r9, #42
    CHECKEQ r10, 18

    ; Register operands.
    ldi     r9, #123400
    ldi     r10, #-945
    rem     r11, r9, r10
    CHECKEQ r11, 550

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ldi     r9, #0xa7ef83a3
    ldi     r10, #0x1134a698

    ; Packed half-word.
    rem.h   r11, r9, r10
    CHECKEQ r11, 0xfdf3dd0b

    ; Packed byte.
    rem.b   r11, r9, r10
    CHECKEQ r11, 0xfcefdda3

no_packed_ops:

    END_TEST

