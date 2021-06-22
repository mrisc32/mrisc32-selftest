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

    BEGIN_TEST  test_sel

    ; Immediate operand.
    ldi     r9,  #0x0f0ff0f0
    ldi     r10, #0x12345678

    mov     r12, r9
    sel     r12, r10, #0x1234
    CHECKEQ r12, 0x02045274

    ; Register operands.
    ldi     r11, #0x9abcdef0

    mov     r12, r9
    sel     r12, r10, r11
    CHECKEQ r12, 0x92b45e70

    mov     r12, r9
    sel.132 r12, r10, r11
    CHECKEQ r12, 0x1a3cd6f8

    mov     r12, r10
    sel.213 r12, r9, r11
    CHECKEQ r12, 0x92b45e70

    mov     r12, r10
    sel.231 r12, r9, r11
    CHECKEQ r12, 0x1a3cd6f8

    END_TEST

