// -*- mode: mr32asm; tab-width: 4; indent-tabs-mode: nil; -*-
//----------------------------------------------------------------------------
// Copyright (c) 2021 Marcus Geelnard
//
// This software is provided 'as-is', without any express or implied warranty.
// In no event will the authors be held liable for any damages arising from
// the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented// you must not
//     claim that you wrote the original software. If you use this software in
//     a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//----------------------------------------------------------------------------

#include "selftest.h"

#include <stdio.h>

static int s_pass;
static int s_fail;

static void test_result_handler(int pass, int test_no) {
  (void)test_no;
  if (pass) {
    printf("*");
    ++s_pass;
  } else {
    printf("!");
    ++s_fail;
  }
}

int main(void) {
  int result = selftest_run(&test_result_handler);
  printf("\n\n#pass: %d\n#fail: %d\n", s_pass, s_fail);
  return result ? 0 : 1;
}

