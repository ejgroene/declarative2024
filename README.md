# declarative2024
Session on Declarative 2024 on In-Source Testing in Answer Set Programming (ASP)

This repository contains support materials for the session:

1. example sources in ASP
2. Codespace for working with asp-selftest and the examples.
3. slides, if I find a way to do that in markdown.

Start the Codespace.


Run the tests in `hamiltonian-cycle.lp` with:

  $ clingo 0 hamiltonian-cycle.lp

Run the tests in `hamiltonian-cycle-2.lp` (and `hamiltonian-cycle-3.lp`) with:

  $ asp-tests 0 hamiltonian-cycle-2.lp

At the end of each file is an explanation of the problems (failing tests) and challenges to fix the test or the code.
