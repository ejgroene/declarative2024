% facts (atoms)
beer(valdieu, 8).
beer(radler, 0).
pils(gulpener, 6).
ale(kilkenny, 4).

% rule: head :- body
alcoholic(B)  :-  beer(B, _).

% disjunction
beer(B, A)  :-  pils(B, A).
beer(B, A)  :-  ale(B, A).

% conjunction
special(B)  :-  beer(B, A),  A > 5.

% choice
{ drink(radler, 0) }.
{ drink(B, A) }  :-  beer(B, A).

% constraint, it cannot be that...
:-  drink(B, A),  A = 0.

% conditional literals ('such that') and aggregate
specials(T)  :-  T = { beer(B, A)  :  special(B) }.

% output control
#show drink/2.
#show specials/1.
