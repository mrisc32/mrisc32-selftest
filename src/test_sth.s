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

    BEGIN_TEST  test_sth

    ; Allocate room on the stack.
    add     sp, sp, #-16

    ; Immediate offset.
    ldi     r9, #0xf1234
    sth     r9, [sp]
    ldi     r9, #0xf5678
    sth     r9, [sp, #2]
    ldw     r11, [sp]
    CHECKEQ r11, 0x56781234

    ; Register offset.
    ldi     r9, #0xf8765
    ldi     r10, #0
    sth     r9, [sp, r10]
    ldi     r9, #0xf4321
    ldi     r10, #2
    sth     r9, [sp, r10]
    ldw     r11, [sp]
    CHECKEQ r11, 0x43218765

    ; Register offset with scale.
    ldi     r10, #1

    ldi     r9, #0xf8765
    sth     r9, [sp, r10*2]
    ldi     r9, #0xf4321
    sth     r9, [sp, r10*4]
    ldi     r9, #0xf9437
    sth     r9, [sp, r10*8]

    lduh    r11, [sp, #2]
    CHECKEQ r11, 0x8765
    lduh    r11, [sp, #4]
    CHECKEQ r11, 0x4321
    lduh    r11, [sp, #8]
    CHECKEQ r11, 0x9437

    ; Free stack space.
    add     sp, sp, #16

    END_TEST

