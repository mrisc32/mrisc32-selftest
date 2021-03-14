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

    BEGIN_TEST  test_j

    ; Set LR to a known value so that we can check that it's not modified.
    ldi     lr, #123

    ; PC-relative (short)
    j       pc, #right1@pc

wrong1:
    FAIL

right1:

    ; PC-relative (long)
    addpchi s9, #right2@pchi
    j       s9, #right2+4@pclo

wrong2:
    FAIL

right2:

    ; Absolute (long)
    ldhi    s9, #right3@hi
    j       s9, #right3@lo

wrong3:
    FAIL

right3:

    ; Register-offset
    addpchi s9, #jump_base@pchi
    add     s9, s9, #jump_base+4@pclo
    ldi     s10, #0
    ldi     s11, #123
    j       s9, #8

jump_base:
    add     s11, s10, #1
    add     s10, s11, #1
    add     s11, s10, #1    ; This is where we should land
    add     s10, s11, #1
    add     s11, s10, #1

    CHECKEQ s11, 3


    ; Check that LR was not modified.
    CHECKEQ lr, 123

    END_TEST

