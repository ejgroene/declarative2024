
%%%%%%%% Problem Encoding %%%%%%%%

%%%% Preparation %%%%
% Infer nodes from edges. We use a simple disjunctive rule: head :- body.
node(N)  :-  edge(N, _, _).    % variable N,  wildcard _
node(N)  :-  edge(_, N, _).    % disjunction/or


%%%% Generation %%%%
% Choose an arbitrary step. We use conditional literal ("such that") + choice
step(A, B)  :  edge(A, B, _).

% If you have one step, choose a connected one, but not back.
step(B, C)  :  edge(B, C, _),  C <> A   :-   step(A, B).

% Path to given node via step's. We use a disjunctive rule with conjunction.
path(B)  :-  step(_, B).
path(C)  :-  path(B),  step(B, C).


%%%% Weeding %%%%
% We use a constraint.  "It cannot be that: ..."
:-  node(N),  not path(N).

% Select minimum costs. We use a set of tuples, with a conditional literal and a built-in function.
#minimize { C, A, B  :  step(A, B),  edge(A, B, C) }.


#program general_checks.
assert(@all("incident in", N))     :-  node(N),  edge(_, N, _).
assert(@all("incident out", N))    :-  node(N),  edge(N, _, _).
assert(@all("edge costs", A, B))   :-  edge(A, B, C),  C > 0,  C < 10.
assert(@all("cycle cost"))         :-  N = { node(_) }, N <= #sum { C, A, B  :  step(A, B),  edge(A, B, C) } < 100.
assert(@all("no self reference"))  :-  { edge(N, N, _) } = 0.
assert(@all("number of steps"))    :-  { step(A, B) } = S,  S = { node(N) }.


#program test_simple_graph(base, general_checks).
% problem instance
edge(1, 2, 1). edge(2, 3, 1).  edge(3, 1, 1).

% tests
assert(@all("3 nodes"))      :-  { node(N) } = 3.
models(3).


% Problem assignments:
% 1. incident tests fail; fix the tests.
% 2. problem instance with only two nodes does not work; fix the code.


%%%% Output Control %%%%
#show step/2.
