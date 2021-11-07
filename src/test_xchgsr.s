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

    BEGIN_TEST  test_xchgsr

    ;-------------------------------------------------------------------------
    ; Consistency checks for the CPU maximum vector length.
    ;-------------------------------------------------------------------------

    ; Expected minimum value for max vector length.
    ;  r12 <- minimum max vector length
    ;  r13 <- minimum log2(max vector length)
    ;  r14 <- maximum max vector length
    ;  r15 <- maximum log2(max vector length)
    ldi     r12, #0
    ldi     r13, #0
    ldi     r14, #0
    ldi     r15, #0
    NOVM   1f
    ldi     r12, #16            ; The minimum vector register length is 16
    ldi     r13, #4
    ldi     r14, #0xffffffff
    ldi     r15, #31
1:

    ; 0x00000010 -> MAX_VL
    xchgsr   r11, z, #0x00000010

    ; Make sure that MAX_VL is within the valid range.
    sleu    r9, r12, r11
    CHECKEQ r9, 0xffffffff
    sleu    r9, r11, r14
    CHECKEQ r9, 0xffffffff

    ; 0x00000011 -> LOG2_MAX_VL
    xchgsr  r11, z, #0x00000011

    ; Make sure that LOG2_MAX_VL is within the valid range.
    sleu    r9, r13, r11
    CHECKEQ r9, 0xffffffff
    sleu    r9, r11, r15
    CHECKEQ r9, 0xffffffff


    ;-------------------------------------------------------------------------
    ; Consistency checks for CPU features.
    ;-------------------------------------------------------------------------

    ; 0x00000000 -> CPU_FEATURES_0
    xchgsr  r11, z, #0x00000000

    ; Make sure that the upper bits are all zero (only the lower 4 bits have
    ; meaning).
    and     r12, r11, #~0x0000000f
    CHECKEQ r12, 0


    ;-------------------------------------------------------------------------
    ; All reserved system registered should return zero.
    ;-------------------------------------------------------------------------

    ; Make a few samples (checking all possibilities would take too long, and
    ; would flood debug traces).
    ldi     r10, #0x00000012
1:
    xchgsr  r11, z, r10
    CHECKEQ r11, 0

    lsl     r12, r10, #9
    xchgsr  r11, z, r12
    CHECKEQ r11, 0

    add     r10, r10, #1
    sle     r11, r10, #0x00000014
    bs      r11, 1b

    END_TEST

