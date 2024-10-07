
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
assert(@all("no self reference"))  :-  { edge(N, N, _) }  =  0.
assert(@all("incident in", N))     :-  node(N),  edge(_, N, _).
assert(@all("incident out", N))    :-  node(N),  edge(N, _, _).
assert(@all("bi-edges", N))        :-  edge(N, _, _),  edge(_, N, _).
assert(@all("edge costs", A, B))   :-  edge(A, B, C),  C > 0,  C < 10.
assert(@all("cycle cost"))         :-  10  <=  #sum { C, A, B  :  step(A, B), edge(A, B, C) }  <  100.
assert(@all("number of steps"))    :-  { step(A, B) } = S,  S = { node(N) }.


#program test_the_big_one(base, general_checks).
edge(1 ,2 ,2). edge(2 ,4 ,2). edge(3 ,1 ,3). edge(4 ,1 ,1). edge(5 ,3 ,2). edge(6 ,2 ,4).
edge(1 ,3 ,3). edge(2 ,5 ,2). edge(3 ,4 ,2). edge(4 ,2 ,2). edge(5 ,4 ,2). edge(6 ,3 ,3).
edge(1 ,4 ,1). edge(2 ,6 ,4). edge(3 ,5 ,2).                edge(5 ,6 ,1). edge(6 ,5 ,1).
assert("steps")  :-  { step(1,2; 2,5; 5,6; 6,3; 3,4; 4,1) } = 6.
models(3).


#program test_small_graph_of_three_nodes(base, general_checks).
edge(1, 2, 1).  edge(2, 3, 1).  edge(3, 1, 1).            % problem instance
assert(@all("3 nodes"))  :-  { node(N) }  =  3.
assert("steps")  :-  { step(1,2; 2,3; 3,1) } = 3.
models(1).


#program test_minimal_graph(base, general_checks).
edge(1, 2, 1). edge(2, 1 ,1).                            % problem instance
assert(@all("2 nodes"))  :-  { node(N) } = 2.
assert("steps")  :-  { step(1,2; 2,1) } = 2.
models(1).


% Problem assignments:
%
% Run the tests with: 
%
%   $ asp-tests hamiltonian-cycle-2.lp
%
% 1. the "number of steps" test issues a warning; fix the test.
% 2. the "cycle cost" test fails; fix the test.
% 3. problem instance with only two nodes does not work; fix the code.


%%%% Output Control %%%%
#show step/2.
