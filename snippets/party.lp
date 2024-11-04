% available drinks
beverage(wine, 11).
beverage(beer,  5).
beverage(soda,  0).

% choice: party or not
{ party }.

% when party, drink some
{ drink(D, P) }  :-  party,  beverage(D, P).

#show party/0.
#show drink/2.
