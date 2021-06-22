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
;  r1, r2 - Temporary scratch registers.
;  r26    - The global test result.
;
; Do not use those registers in the test funcions.
;-----------------------------------------------------------------------------

.macro  BEGIN_TEST name:req
    .text
    .p2align    2
    .global     \name
    .func       \name
\name\():
    ; Preserve LR in R1 and call selftest_prologue().
    mov     r1, lr
    jl      pc, #selftest_prologue@pc
.endm

.macro  END_TEST
    ; Make a sibling-call to selftest_epilogue().
    j       pc, #selftest_epilogue@pc
    .endfunc
.endm

.macro  CHECKEQ reg:req, value:req
    ldi     r1, #\value
    seq     r1, \reg, r1
    and     r26, r26, r1
.endm

.macro  FAIL
    ldi     r26, #0
.endm

.macro  CHECKNAN reg:req
    ldi     r1, #0x7f800000
    and     r2, \reg, r1
    seq     r1, r2, r1      ; reg & 0x7f800000 == 0x7f800000
    and     r26, r26, r1
    ldi     r1, #0x007fffff
    and     r1, \reg, r1
    sne     r1, r1, z       ; reg & 0x007fffff != 0
    and     r26, r26, r1
.endm

.macro  NOVEC skiplabel:req
    ldi     r1, #1
    cpuid   r1, r1, z
    and     r1, r1, #1      ; VEC (vector operations)?
    bz      r1, \skiplabel
.endm

.macro  NOPO skiplabel:req
    ldi     r1, #1
    cpuid   r1, r1, z
    and     r1, r1, #2      ; PO (packed operations)?
    bz      r1, \skiplabel
.endm

.macro  NOMUL skiplabel:req
    ldi     r1, #1
    cpuid   r1, r1, z
    and     r1, r1, #4      ; MUL (multiply operations)?
    bz      r1, \skiplabel
.endm

.macro  NODIV skiplabel:req
    ldi     r1, #1
    cpuid   r1, r1, z
    and     r1, r1, #8      ; DIV (division operations)?
    bz      r1, \skiplabel
.endm

.macro  NOSA skiplabel:req
    ldi     r1, #1
    cpuid   r1, r1, z
    and     r1, r1, #16     ; SA (saturating operations)?
    bz      r1, \skiplabel
.endm

.macro  NOFP skiplabel:req
    ldi     r1, #1
    cpuid   r1, r1, z
    and     r1, r1, #32     ; FP (floating point operations)?
    bz      r1, \skiplabel
.endm

.macro  NOSQRT skiplabel:req
    ldi     r1, #1
    cpuid   r1, r1, z
    and     r1, r1, #64     ; SQRT?
    bz      r1, \skiplabel
.endm

