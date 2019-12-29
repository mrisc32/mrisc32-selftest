; -*- mode: mr32asm; tab-width: 4; indent-tabs-mode: nil; -*-
;-----------------------------------------------------------------------------
; Copyright (c) 2019 Marcus Geelnard
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

;-----------------------------------------------------------------------------
; Test macros for the MRISC32 selftest framework.
;-----------------------------------------------------------------------------

.macro  BEGIN_TEST name:req
    .text
    .p2align    2
    .global     \name
    .func       \name

\name\():
    ; Save s16-s25 & lr
    add     sp, sp, #-44
    stw     s16, sp, #0
    stw     s17, sp, #4
    stw     s18, sp, #8
    stw     s19, sp, #12
    stw     s20, sp, #16
    stw     s21, sp, #20
    stw     s22, sp, #24
    stw     s23, sp, #28
    stw     s24, sp, #32
    stw     s25, sp, #36
    stw     lr, sp, #40

    ; s25 holds the test result (TRUE by default).
    ldi     s25, #-1
.endm

.macro  END_TEST
    ; Move the test result to s1 (the return value).
    mov     s1, s25

    ; Restore s16-s25 & lr
    ldw     s16, sp, #0
    ldw     s17, sp, #4
    ldw     s18, sp, #8
    ldw     s19, sp, #12
    ldw     s20, sp, #16
    ldw     s21, sp, #20
    ldw     s22, sp, #24
    ldw     s23, sp, #28
    ldw     s24, sp, #32
    ldw     s25, sp, #36
    ldw     lr, sp, #40
    add     sp, sp, #44

    ; Return from the test
    j       lr

    .endfunc
.endm

.macro  CHECKEQ reg:req, value:req, tmpreg=s1
    ldhi    \tmpreg, #\value@hi
    or      \tmpreg, \tmpreg, #\value@lo
    seq     \tmpreg, \reg, \tmpreg
    and     s25, s25, \tmpreg
.endm

.macro  NOVEC skiplabel:req
    ldi     s1, #1
    cpuid   s1, s1, z
    and     s1, s1, #1      ; VEC (vector operations)?
    bz      s1, \skiplabel
.endm

.macro  NOPO skiplabel:req
    ldi     s1, #1
    cpuid   s1, s1, z
    and     s1, s1, #2      ; PO (packed operations)?
    bz      s1, \skiplabel
.endm

.macro  NOMUL skiplabel:req
    ldi     s1, #1
    cpuid   s1, s1, z
    and     s1, s1, #4      ; MUL (multiply operations)?
    bz      s1, \skiplabel
.endm

.macro  NODIV skiplabel:req
    ldi     s1, #1
    cpuid   s1, s1, z
    and     s1, s1, #8      ; DIV (division operations)?
    bz      s1, \skiplabel
.endm

.macro  NOSA skiplabel:req
    ldi     s1, #1
    cpuid   s1, s1, z
    and     s1, s1, #16     ; SA (saturating operations)?
    bz      s1, \skiplabel
.endm

.macro  NOFP skiplabel:req
    ldi     s1, #1
    cpuid   s1, s1, z
    and     s1, s1, #32     ; FP (floating point operations)?
    bz      s1, \skiplabel
.endm

.macro  NOSQRT skiplabel:req
    ldi     s1, #1
    cpuid   s1, s1, z
    and     s1, s1, #64     ; SQRT?
    bz      s1, \skiplabel
.endm

