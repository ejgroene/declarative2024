# declarative2024: In-Source Testing in ASP

Session on [Declarative 2024](https://declarative.amsterdam/program) on In-Source Testing in Answer Set Programming (ASP)

This repository contains support materials for the session:

1. example sources in ASP
2. Codespace for working with asp-selftest and the examples.
3. slides, if I find a way to do that in markdown.

# Codespace

Start the Codespace using Code -> Codespaces.

Blockers and privacy protections might get in the way.

 * Safari: does not work
 * Firefox: click the shield next to the URL and turn of `advanced privacy protections`.

# Run tests

Run the tests in `hamiltonian-cycle-*.lp` with:

  $ asp-tests 0 hamiltonian-cycle-*.lp

At the end of each file is an explanation of the problems (failing tests) and challenges to fix the test or the code.
