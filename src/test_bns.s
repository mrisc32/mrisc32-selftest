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

    BEGIN_TEST  test_bns

    ldi     s9, #1      ; true
    ldi     s10, #0     ; true
    ldi     s11, #-1    ; false

    bns     s9, right1
    bns     s11, wrong1
wrong1:
    CHECKEQ z, 1
right1:

    bns     s10, right2
    bns     s11, wrong2
wrong2:
    CHECKEQ z, 1
right2:

    bns     s11, wrong3
    bns     s9, right3
wrong3:
    CHECKEQ z, 1
right3:

    bns     s11, wrong4
    bns     s10, right4
wrong4:
    CHECKEQ z, 1
right4:

    END_TEST

