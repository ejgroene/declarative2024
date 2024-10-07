
%%%%%%%% Problem Instance %%%%%%%%

% edge(From, To, Cost). We use facts.
edge(1 ,2 ,2). edge(2 ,4 ,2). edge(3 ,1 ,3). edge(4 ,1 ,1). edge(5 ,3 ,2). edge(6 ,2 ,4).
edge(1 ,3 ,3). edge(2 ,5 ,2). edge(3 ,4 ,2). edge(4 ,2 ,2). edge(5 ,4 ,2). edge(6 ,3 ,3).
edge(1 ,4 ,1). edge(2 ,6 ,4). edge(3 ,5 ,2).                edge(5 ,6 ,1). edge(6 ,5 ,1).


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


%%%% Ad-Hoc Tests %%%%
assert("6 nodes")            :-  { node(_) } = 6.
assert("no self reference")  :-  { edge(N, N, _) }  =  0.
assert("incident in", N)     :-  node(N),  edge(_, N, _).
assert("incident out", N)    :-  node(N),  edge(N, _, _).
assert("bi-edges", N)        :-  edge(N, _, _), edge(_, N, _).
assert("edge costs", A, B)   :-  edge(A, B, C),  C > 0,  C < 10.
assert("cycle cost")         :-  10  <  #sum { C, A, B  :  step(A, B),  edge(A, B, C) }  <  14.
assert("number of steps")    :-  { step(A, B) } = S,  S = { node(N) }.
assert("steps")              :-  { step(1,2; 2,5; 5,6; 6,3; 3,4; 4,1) } = 6.
models(3).

ensure(assert(
    "6 nodes";
    "no self reference";
    "incident in", N;
    "incident out", N;
    "bi-edges", N;
    "cycle cost";
    "number of steps";
    "steps"
    ))  :-
        node(N).                          % careful: no nodes, no ensure's.

ensure(node(1; 2; 3; 4; 5; 6)).           % safest way to make sure there are nodes.

ensure(assert("edge costs", A, B))  :-
    edge(A, B, _).                        % careful: no edges, no ensure's.


% Problems with these tests:
%
% 0. Test "steps" fails.  Why?  We can't fix it.  Why?
% 1. test fixtures are fixed; we want different graphs for testing
% 2. use of ensure is cumbersome
% 3. use #show for every cardinality of assert
%
% It does work for general input validation however.
%
% Next: test #program's.


%%%% Output Control %%%%
#show step/2.
#show assert/1.
#show assert/2.
#show assert/3.
