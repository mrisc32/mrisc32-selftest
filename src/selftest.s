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
;  s1 = test_result_fun
;-----------------------------------------------------------------------------

    .p2align 2
    .global selftest_run
    .func   selftest_run

selftest_run:
    add     sp, sp, #-20
    stw     lr, sp, #0
    stw     s16, sp, #4
    stw     s17, sp, #8
    stw     s18, sp, #12
    stw     s19, sp, #16

    ; s16 = Pointer to the list of tests.
    addpchi s16, #tests@pchi
    add     s16, s16, #tests+4@pclo

    ; s17 = Total test result.
    ldi     s17, #-1

    ; s18 = test_result_fun
    mov     s18, s1

    ; s19 = test_no
    ldi     s19, #0

loop:
    ldw     s1, s16, s19*4  ; Load the next test
    bz      s1, done        ; (exit when there are no more tests)

    ; Call the test function.
    jl      s1
    and     s17, s17, s1    ; Update the total test result

    ; Call the test result function.
    ;  s1 = test result (pass/fail)
    ;  s2 = test number
    bz      s18, no_callback
    mov     s2, s19
    jl      s18

no_callback:
    add     s19, s19, #1
    b       loop

done:
    mov     s1, s17         ; Return the total test result

    ldw     lr, sp, #0
    ldw     s16, sp, #4
    ldw     s17, sp, #8
    ldw     s18, sp, #12
    ldw     s19, sp, #16
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
    ; Note: BEGIN_TEST has preserved LR in S1 before calling this function.
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
    stw     s1, sp, #40     ; Actually: S1 = LR for the test function.

    ; s25 holds the test result (TRUE by default).
    ldi     s25, #-1

    ; Return to the test
    ret

    .endfunc

    .p2align 2
    .global selftest_epilogue
    .func   selftest_epilogue

selftest_epilogue:
    ; This is sibling-called from END_TEST.

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
    .word   test_asr
    .word   test_lsl
    .word   test_lsr
    .word   test_shuf
    .word   test_sel
    .word   test_clz
    .word   test_popcnt
    .word   test_rev
    .word   test_pack
    .word   test_packs
    .word   test_packsu

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

    .word   test_addpchi

    .word   test_adds
    .word   test_addsu

    .word   test_fadd

    .word   0

