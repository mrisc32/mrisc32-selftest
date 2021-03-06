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

    BEGIN_TEST  test_and

    ; Immediate operand.
    ldi     s9, #0x00023456
    and     s10, s9, #0x00000f55
    CHECKEQ s10, 0x00000454

    ; Register operands.
    ldi     s9, #0x00023456    ; Neg: 0xfffdcba9
    ldi     s10, #0xffff0000   ; Neg: 0x0000ffff
    and     s11, s9, s10
    CHECKEQ s11, 0x00020000
    and.pn  s11, s9, s10
    CHECKEQ s11, 0x00003456
    and.np  s11, s9, s10
    CHECKEQ s11, 0xfffd0000
    and.nn  s11, s9, s10
    CHECKEQ s11, 0x0000cba9

    END_TEST

