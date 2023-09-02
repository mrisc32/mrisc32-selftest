## This repo has moved to: https://gitlab.com/mrisc32/mrisc32-selftest

# MRISC32 selftest suite

This is a suite of micro tests in the form of small programs (usually written in assembler) that checks the behaviour of program execution against the MRISC32 ISA specification.

The tests are intended to be run on implementations of the MRISC32 ISA (such as a CPU or a simulator).

While this suite does not provide full test coverage of an implementation, it is a useful tool for catching certain common errors.

One of the goals of the test suite is that all test shall be very fast, so that it is feasible to include the selftest as part of a machine boot sequence, for instance.
