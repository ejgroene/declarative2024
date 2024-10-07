# declarative2024: In-Source Testing in ASP

Session on [Declarative 2024](https://declarative.amsterdam/program) on In-Source Testing in Answer Set Programming (ASP).

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

    $ asp-tests --silent hamiltonian-cycle-*.lp

(--silent skips the Python in-source tests)

At the end of each file is an explanation of the problems (failing tests) and challenges to fix the test or the code.

Begin with `1`.  This contains ad-hoc tests and a test that fails, which we can't fix. I'll explain why during the session.

Proceed with `2`.  This contains test programs using Clingo's `#program` with automated check on each `assert`. Plus a new challenge.

Proceed with `3`.  This contains solutions for the problems above, plus a new challenge.
