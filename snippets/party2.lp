% available drinks
beverage(wine, 11).
beverage(beer,  5).
beverage(soda,  0).

% choice: party or not
party(fun); party(aa).

% when party, drink some
{ drink(D, P) : beverage(D, P),  P > 0 } = 1  :-  party(fun).
{ drink(D, P) : beverage(D, P),  P = 0 } = 1  :-  party(aa).

#show party/1.
#show drink/2.
