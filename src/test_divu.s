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

    BEGIN_TEST  test_divu

    ; Immediate operand.
    ldi     r9, #123456
    divu    r10, r9, #42
    CHECKEQ r10, 2939

    ; Register operands.
    ldi     r9, #4294966351
    ldi     r10, #123400
    divu    r11, r9, r10
    CHECKEQ r11, 34805

    ; Can we do packed operations?
    NOPM    no_packed_ops

    ldi     r9, #0xa7efa698
    ldi     r10, #0x113483a3

    ; Packed half-word.
    divu.h  r11, r9, r10
    CHECKEQ r11, 0x00090001

    ; Packed byte.
    divu.b  r11, r9, r10
    CHECKEQ r11, 0x09040100

no_packed_ops:

    END_TEST

