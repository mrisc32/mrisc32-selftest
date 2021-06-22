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

    BEGIN_TEST  test_addsu

    NOSA    no_saturating_ops

    ; Unsaturated should be the same as add.
    ldi     r9, #1367
    ldi     r10, #9926
    addsu   r11, r9, r10
    CHECKEQ r11, 11293

    ; Saturate at max word.
    ldhi    r9,  #0x7ffff000
    ldhi    r10, #0x85432000
    addsu   r11, r9, r10
    CHECKEQ r11, 0xffffffff

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ; Packed half-word.
    ldi     r9,  #0x12348471
    ldi     r10, #0x43f17f72
    addsu.h r11, r9, r10
    CHECKEQ r11, 0x5625ffff

    ; Packed byte.
    ldi     r9,  #0x12730185
    ldi     r10, #0x3468ff81
    addsu.b r11, r9, r10
    CHECKEQ r11, 0x46dbffff

no_packed_ops:
no_saturating_ops:

    END_TEST

