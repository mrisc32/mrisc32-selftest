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

    BEGIN_TEST  test_stb

    ; Allocate room on the stack.
    add     sp, sp, #-16

    ; Immediate offset.
    ldi     s9, #0x3f12
    stb     s9, sp, #0
    ldi     s9, #0x3f34
    stb     s9, sp, #1
    ldi     s9, #0x3f56
    stb     s9, sp, #2
    ldi     s9, #0x3f78
    stb     s9, sp, #3
    ldw     s11, sp, #0
    CHECKEQ s11, 0x78563412

    ; Register offset.
    ldi     s9, #0x3f87
    ldi     s10, #0
    stb     s9, sp, s10
    ldi     s9, #0x3f65
    ldi     s10, #1
    stb     s9, sp, s10
    ldi     s9, #0x3f43
    ldi     s10, #2
    stb     s9, sp, s10
    ldi     s9, #0x3f21
    ldi     s10, #3
    stb     s9, sp, s10
    ldw     s11, sp, #0
    CHECKEQ s11, 0x21436587

    ; Register offset with scale.
    ldi     s10, #1

    ldi     s9, #0x3f87
    stb     s9, sp, s10*2
    ldi     s9, #0x3f65
    stb     s9, sp, s10*4
    ldi     s9, #0x3f43
    stb     s9, sp, s10*8

    ldub    s11, sp, #2
    CHECKEQ s11, 0x87
    ldub    s11, sp, #4
    CHECKEQ s11, 0x65
    ldub    s11, sp, #8
    CHECKEQ s11, 0x43

    ; Free stack space.
    add     sp, sp, #16

    END_TEST

