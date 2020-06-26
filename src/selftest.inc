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
;
; Register allocation: In addition to the regular MRISC32 ABI rules (callee
; saved regs etc), the test macros do the following allocations:
;
;  s1, s2 - Temporary scratch registers.
;  s25    - The global test result.
;
; Do not use those registers in the test funcions.
;-----------------------------------------------------------------------------

.macro  BEGIN_TEST name:req
    .text
    .p2align    2
    .global     \name
    .func       \name
\name\():
    ; Preserve LR in S1 and call selftest_prologue().
    mov     s1, lr
    jl      pc, #selftest_prologue@pc
.endm

.macro  END_TEST
    ; Make a sibling-call to selftest_epilogue().
    j       pc, #selftest_epilogue@pc
    .endfunc
.endm

.macro  CHECKEQ reg:req, value:req
    ldi     s1, #\value
    seq     s1, \reg, s1
    and     s25, s25, s1
.endm

.macro  CHECKNAN reg:req
    ldi     s1, #0x7f800000
    and     s2, \reg, s1
    seq     s1, s2, s1      ; reg & 0x7f800000 == 0x7f800000
    and     s25, s25, s1
    ldi     s1, #0x007fffff
    and     s1, \reg, s1
    sne     s1, s1, z       ; reg & 0x007fffff != 0
    and     s25, s25, s1
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

