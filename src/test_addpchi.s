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

    BEGIN_TEST  test_addpchi

    ; ADDPCHI can copy PC.
    ; We use JL as the second way to query the PC register value.
    jl      pc, #1f@pc          ; This sets LR = PC + 4
1:
    addpchi r10, #0             ; This sets R10 = PC
    seq     r10, r10, lr
    CHECKEQ r10, -1

    ; ADDPCHI is equal to pc + hi operand.
    ; Note: Instruction order and size is critical for the correct
    ; calculation of PC.
    ldi     r11, #0x12345000+4  ; Delta between ADDPCHI insns = +4
    addpchi r9, #0
    addpchi r10, #0x12345000
    add     r9, r9, r11
    seq     r10, r9, r10
    CHECKEQ r10, -1

    END_TEST

