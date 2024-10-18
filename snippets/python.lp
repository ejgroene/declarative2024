#script (python)
from clingo import Function

def make_atom(name, arg):
    return Function(name.name, [arg])

#end.

beverage(wine, 11).
beverage(beer,  5).

drink(@make_atom(B, P))  :-  beverage(B, P).
