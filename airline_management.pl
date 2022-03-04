route(lasVegas,newJersey,harry_Ried_International_airport,2000).
route(lasVegas,newJersey,north_vegas_airport,1300).
route(lasVegas,newJersey,cheyenne_air,880).
route(lasVegas,newYork,harry_Ried_International_airport,1600).
route(newYork,lasVegas,newWark_airport,1100).
route(newYork,lasVegas,keneddy_airport,900).
route(lasVegas,newYork,north_vegas_airport,700).
route(florida,dallas,orlando_sanford_international_airport,3000).
route(florida,dallas,miami_international_airport,3000).
route(florida,maryland,miami_international_airport,2000).
route(florida,texas,miami_international_airport,2000).
route(maryland,texas,baltimore_international_airport,1000).
route(texas,chicago,texas_international_airport,4000).
route(dallas,maryland,dallas_fortworth,3000).
route_exist(A,B):-
    (route(A,B,_,_);
    route(B,A,_,_);
    (route(A,X,_,_),route(X,B,_,_))
    ).
count_flight(A,B):-
    aggregate_all(count, route_exist(A,B), Count),
    format("number of flights are ~w",[Count]),
    nl.
direct_flight(A,B):-
        
        route(A,B,C,D),
        nl,
        format("Direct flight from ~w to ~w : boarding from ~w",[A,B,C]),
        nl;
        route(B,A,C,D),
        nl,
       format("Direct flight from ~w to ~w : boarding from ~w",[B,A,C]).
min_num([A], A).
min_num([H|R], N):-
    min_num(R, RN),
    N is min(H, RN).
     
min_cost(A,B):-
    findall(D,route(A,B,C,D),List1),
    findall(C,route(A,B,C,D),List2),
    min_num(List1,N),
    format("Minimum cost from ~w to ~w is Rs ~w",[A,B,N]),
    indexOf(List1,N,Index),
    nth0(Index, List2, Elem),
    nl,
    format("Airport: ~w",[Elem]),
    nl;
    findall(D,route(B,A,C,D),List1),
    findall(C,route(B,A,C,D),List2),
    min_num(List1,N),
    nl,
    format("Minimum cost from ~w to ~w is Rs ~w",[B,A,N]),
    indexOf(List1,N,Index),
    nth0(Index, List2, Elem),
    nl,
    format("Airport: ~w",[Elem]),
    nl.
    


indexOf([Element|_], Element, 0). 
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1), 
  Index is Index1+1.  
    

connected_flight(A,B):-
    route(A,X,C,_),
    route(X,B,D,_),
    format("~w to ~w",[A,B]),
    nl,
    format("initial boarding: ~w",[C]),
    nl,
    format("halt: ~w",X),
    nl,
   
    format("Final boarding: ~w",[D]);
    nl,
    route(B,X,C,_),
    route(X,A,D,_),
    nl,
    format("~w to ~w",[B,A]),
    nl,
    format("initial boarding: ~w",[C]),
    nl,
    format("halt: ~w",X),
    nl,
   
    format("Final boarding: ~w",[D]).
%queries
%min_cost(lasVegas,newJersey)
%direct_flight(florida,texas)
%connected_flight(florida,maryland)