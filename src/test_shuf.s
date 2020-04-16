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

    BEGIN_TEST  test_shuf

    ; Immediate operand.
    ldi     s9, #0x12ab8234

    shuf    s10, s9, #0b0000000000000
    CHECKEQ s10, 0x34343434

    shuf    s10, s9, #0b0000001010011
    CHECKEQ s10, 0x3482ab12

    shuf    s10, s9, #0b1101101001000
    CHECKEQ s10, 0xffff8234

    shuf    s10, s9, #0b0101101001000
    CHECKEQ s10, 0x00008234

    ; Register operands.
    ldi     s9, #0x8012
    ldi     s10, #0b1101101001000
    shuf    s11, s9, s10
    CHECKEQ s11, 0xffff8012

    ldi     s9, #0x11223344
    ldi     s10, #0b0000011010001
    shuf    s11, s9, s10
    CHECKEQ s11, 0x44112233

    END_TEST

