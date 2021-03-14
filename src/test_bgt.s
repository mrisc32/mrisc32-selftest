; -*- mode: mr32asm; tab-width: 4; indent-tabgt-mode: nil; -*-
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

    BEGIN_TEST  test_bgt

    ldi     s9, #42     ; true
    ldi     s10, #0     ; false
    ldi     s11, #-42   ; false

    bgt     s9, right1
    bgt     s10, wrong1
    bgt     s11, wrong1
wrong1:
    FAIL
right1:

    bgt     s10, wrong2
    bgt     s9, right2
    bgt     s11, wrong2
wrong2:
    FAIL
right2:

    bgt     s10, wrong3
    bgt     s11, wrong3
    bgt     s9, right3
wrong3:
    FAIL
right3:

    END_TEST

