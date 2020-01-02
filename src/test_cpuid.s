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

    BEGIN_TEST  test_cpuid

    ;-------------------------------------------------------------------------
    ; Consistency checks for the CPU maximum vector length.
    ;-------------------------------------------------------------------------

    ; Expected minimum value for max vector length.
    ;  s12 <- minimum max vector length
    ;  s13 <- minimum log2(max vector length)
    ;  s14 <- maximum max vector length
    ;  s15 <- maximum log2(max vector length)
    ldi     s12, #0
    ldi     s13, #0
    ldi     s14, #0
    ldi     s15, #0
    NOVEC   1f
    ldi     s12, #16            ; The minimum vector register length is 16
    ldi     s13, #4
    ldi     s14, #0xffffffff
    ldi     s15, #31
1:

    ; 0x00000000:0x00000000 -> MaxVectorLength
    ldi     s9, #0x00000000
    ldi     s10, #0x00000000
    cpuid   s11, s9, s10

    ; Make sure that MaxVectorLength is within the valid range.
    sleu    s9, s12, s11
    CHECKEQ s9, 0xffffffff
    sleu    s9, s11, s14
    CHECKEQ s9, 0xffffffff

    ; 0x00000000:0x00000001 -> Log2MaxVectorLength
    ldi     s9, #0x00000000
    ldi     s10, #0x00000001
    cpuid   s11, s9, s10

    ; Make sure that Log2MaxVectorLength is within the valid range.
    sleu    s9, s13, s11
    CHECKEQ s9, 0xffffffff
    sleu    s9, s11, s15
    CHECKEQ s9, 0xffffffff


    ;-------------------------------------------------------------------------
    ; Consistency checks for CPU features.
    ;-------------------------------------------------------------------------

    ; 0x00000001:0x00000000 -> BaseFeatures
    ldi     s9, #0x00000001
    ldi     s10, #0x00000000
    cpuid   s11, s9, s10

    ; Make sure that the upper bits are all zero (only the lower 7 bits have
    ; meaning).
    bic     s12, s11, #0x0000007f
    CHECKEQ s12, 0


    ;-------------------------------------------------------------------------
    ; All unallocated CPUID commands should return zero.
    ;-------------------------------------------------------------------------

    ; Make a few samples (checking all possibilities would take too long).
    ldi     s9, #0x00000002
1:
    ldi     s10, #0x00000000
2:
    cpuid   s11, s9, s10
    CHECKEQ s11, 0

    lsl     s11, s9, #15
    lsl     s12, s10, #9
    cpuid   s11, s11, s12
    CHECKEQ s11, 0

    add     s10, s10, #1
    slt     s11, s10, #236
    bs      s11, 2b
    add     s9, s9, #1
    slt     s11, s9, #599
    bs      s11, 1b

    END_TEST

