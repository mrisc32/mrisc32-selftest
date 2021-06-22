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

    .text

;-----------------------------------------------------------------------------
; typedef void (*test_result_fun_t)(int pass, int test_no);
;
; int selftest_run(test_result_fun_t test_result_fun);
;
;  r1 = test_result_fun
;-----------------------------------------------------------------------------

    .p2align 2
    .global selftest_run
    .func   selftest_run

selftest_run:
    add     sp, sp, #-20
    stw     lr, sp, #0
    stw     r16, sp, #4
    stw     r17, sp, #8
    stw     r18, sp, #12
    stw     r19, sp, #16

    ; r16 = Pointer to the list of tests.
    addpchi r16, #tests@pchi
    add     r16, r16, #tests+4@pclo

    ; r17 = Total test result.
    ldi     r17, #-1

    ; r18 = test_result_fun
    mov     r18, r1

    ; r19 = test_no
    ldi     r19, #0

loop:
    ldw     r1, r16, r19*4  ; Load the next test
    bz      r1, done        ; (exit when there are no more tests)

    ; Call the test function.
    jl      r1
    and     r17, r17, r1    ; Update the total test result

    ; Call the test result function.
    ;  r1 = test result (pass/fail)
    ;  r2 = test number
    bz      r18, no_callback
    mov     r2, r19
    jl      r18

no_callback:
    add     r19, r19, #1
    b       loop

done:
    mov     r1, r17         ; Return the total test result

    ldw     lr, sp, #0
    ldw     r16, sp, #4
    ldw     r17, sp, #8
    ldw     r18, sp, #12
    ldw     r19, sp, #16
    add     sp, sp, #20
    ret

    .endfunc


;-----------------------------------------------------------------------------
; Test prologue and epilogue functions.
;-----------------------------------------------------------------------------

    .p2align 2
    .global selftest_prologue
    .func   selftest_prologue

selftest_prologue:
    ; This is called from BEGIN_TEST.
    ; Note: BEGIN_TEST has preserved LR in R1 before calling this function.
    add     sp, sp, #-48
    stw     r16, sp, #0
    stw     r17, sp, #4
    stw     r18, sp, #8
    stw     r19, sp, #12
    stw     r20, sp, #16
    stw     r21, sp, #20
    stw     r22, sp, #24
    stw     r23, sp, #28
    stw     r24, sp, #32
    stw     r25, sp, #36
    stw     r26, sp, #40
    stw     r1, sp, #44     ; Actually: R1 = LR for the test function.

    ; r26 holds the test result (TRUE by default).
    ldi     r26, #-1

    ; Return to the test
    ret

    .endfunc

    .p2align 2
    .global selftest_epilogue
    .func   selftest_epilogue

selftest_epilogue:
    ; This is sibling-called from END_TEST.

    ; Move the test result to r1 (the return value).
    mov     r1, r26

    ; Restore r16-r26 & lr
    ldw     r16, sp, #0
    ldw     r17, sp, #4
    ldw     r18, sp, #8
    ldw     r19, sp, #12
    ldw     r20, sp, #16
    ldw     r21, sp, #20
    ldw     r22, sp, #24
    ldw     r23, sp, #28
    ldw     r24, sp, #32
    ldw     r25, sp, #36
    ldw     r26, sp, #40
    ldw     lr, sp, #44
    add     sp, sp, #48

    ; Return from the test
    ret

    .endfunc


    .section .rodata

;-----------------------------------------------------------------------------
; The test list. When a new test source file is added, also add the test here.
;-----------------------------------------------------------------------------

    .p2align 2
tests:
    .word   test_cpuid
    .word   test_or
    .word   test_and
    .word   test_xor
    .word   test_add
    .word   test_sub
    .word   test_seq
    .word   test_sne
    .word   test_slt
    .word   test_sltu
    .word   test_sle
    .word   test_sleu
    .word   test_min
    .word   test_max
    .word   test_minu
    .word   test_maxu
    .word   test_ebf
    .word   test_ebfu
    .word   test_mkbf
    .word   test_shuf
    .word   test_sel
    .word   test_clz
    .word   test_popcnt
    .word   test_rev
    .word   test_pack
    .word   test_packhi
    .word   test_packhir
    .word   test_packhiur
    .word   test_packs
    .word   test_packsu

    .word   test_mulq
    .word   test_mulqr

    .word   test_ldb
    .word   test_ldub
    .word   test_ldh
    .word   test_lduh
    .word   test_ldw
    .word   test_ldea
    .word   test_stb
    .word   test_sth
    .word   test_stw
    .word   test_ldli
    .word   test_ldhi

    .word   test_j
    .word   test_jl
    .word   test_bz
    .word   test_bnz
    .word   test_bs
    .word   test_bns
    .word   test_blt
    .word   test_bge
    .word   test_ble
    .word   test_bgt

    .word   test_ldwpc
    ; Note: stwpc fails to link when BSS is too far from the code
    .word   test_addpchi

    .word   test_adds
    .word   test_addsu
    .word   test_addh
    .word   test_addhu
    .word   test_addhr
    .word   test_addhur
    .word   test_subs
    .word   test_subsu
    .word   test_subh
    .word   test_subhu
    .word   test_subhr
    .word   test_subhur

    .word   test_fadd

    .word   0

