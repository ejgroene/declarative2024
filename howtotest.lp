edge(0, 1).
edge(1, 0).

node(N)  :-  edge(N, _).

{ start(N) :  node(N) } = 1.

#program test_it(base).
assert(@all("node exists", N))  :-  node(N).
assert(@any("start", N))  :-  start(N).
assert(@all("no self reference"))  :-  { edge(N, N) } = 0.
assert(@models(2)).
