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

    BEGIN_TEST  test_pack

    NOPM    no_packed_ops

    ldi     r9,  #0x87654321
    ldi     r10, #0x12345678

    pack    r11, r9, r10
    CHECKEQ r11, 0x43215678

    ; Packed half-word.
    pack.h  r11, r9, r10
    CHECKEQ r11, 0x65342178

    ; Packed byte.
    pack.b  r11, r9, r10
    CHECKEQ r11, 0x72543618

no_packed_ops:

    END_TEST

