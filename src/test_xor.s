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

    BEGIN_TEST  test_xor

    ; Immediate operand.
    ldi     r9, #0x00023456
    xor     r10, r9, #0x00000f55
    CHECKEQ r10, 0x00023b03

    ; Register operands.
    ldi     r9, #0x00023456    ; Neg: 0xfffdcba9
    ldi     r10, #0xffff0000   ; Neg: 0x0000ffff
    xor     r11, r9, r10
    CHECKEQ r11, 0xfffd3456
    xor.pn  r11, r9, r10
    CHECKEQ r11, 0x0002cba9
    xor.np  r11, r9, r10
    CHECKEQ r11, 0x0002cba9
    xor.nn  r11, r9, r10
    CHECKEQ r11, 0xfffd3456

    END_TEST

