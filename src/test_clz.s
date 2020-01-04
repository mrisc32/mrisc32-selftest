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

    BEGIN_TEST  test_clz

    ldi     s9, #0x00000000
    clz     s10, s9
    CHECKEQ s10, 32

    ldi     s9, #0x00000001
    clz     s10, s9
    CHECKEQ s10, 31

    ldi     s9, #0x00000002
    clz     s10, s9
    CHECKEQ s10, 30

    ldi     s9, #0x00008153
    clz     s10, s9
    CHECKEQ s10, 16

    ldhi    s9, #0x08153000
    clz     s10, s9
    CHECKEQ s10, 4

    ldhi    s9, #0x7e7df000
    clz     s10, s9
    CHECKEQ s10, 1

    ldi     s9, #-1
    clz     s10, s9
    CHECKEQ s10, 0

    END_TEST

