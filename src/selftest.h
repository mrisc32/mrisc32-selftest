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

#ifndef SELFTEST_H_
#define SELFTEST_H_

/// @brief Callback function prototype.
/// @param pass Whether or not the test passed (0 = fail)
/// @param test_no The number of the test that passed/failed
typedef void (*test_result_fun_t)(int pass, int test_no);

/// @brief Run all the selftests.
///
/// For each test, the callback function is called.
/// @param test_result_fun The test callback function.
/// @returns a non-zero number if all tests passed.
int selftest_run(test_result_fun_t test_result_fun);

#endif  // SELFTEST_H_

