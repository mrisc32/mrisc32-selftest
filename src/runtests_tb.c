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

unsigned char* const g_results = (unsigned char*)0x00010000U;

static void test_result_handler(int pass, int test_no) {
  g_results[test_no] = (unsigned char)pass;
}

int main(void) {
  int result = selftest_run(&test_result_handler);
  return result ? 0 : 1;
}

