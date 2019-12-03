%%%-------------------------------------------------------------------
%%% @author likro
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. Dez 2019 10:07
%%%-------------------------------------------------------------------
-module('Uebung1').
-author("likro").

%% API
-export([createList/0, getVielfache/1, getLast/1, shiftRight/1, getFibonacci/1, getSumOfInverse/1, sort/1, getPrimes/1]).

%% Aufgabe 1 a)
createList() ->
  createList(1,100).
createList(From, To) ->
  createList(To, From, []).
createList(To, I, List) when I > To ->
  List;
createList(To, I, List) ->
  createList(To, I + 1, List ++ [I]).


%% Aufgabe 1 b)
getVielfache(A) ->
  getVielfache(A, 100).
getVielfache(A, Max) ->
  getVielfache([], A, A, Max).

getVielfache(L, ToAdd, Sum, Max) when Sum + ToAdd =< Max ->
  getVielfache(L ++ [Sum + ToAdd], ToAdd, Sum + ToAdd, Max);
getVielfache(L, ToAdd, Counter, Max) when Counter + ToAdd > Max ->
  L.


%% Aufgabe 1 c)
shiftRight(List) ->
  addAllButLast([getLast(List)], List).

addAllButLast(ListToAdd, List) when length(List) == 1 ->
  ListToAdd;
addAllButLast(ListToAdd, [H|T]) ->
  addAllButLast(ListToAdd ++ [H], T).


%% Aufgabe 1 d)
getLast([H|T]) ->
  getLast(T, H).
getLast([H|T], _) ->
  getLast(T, H);
getLast([], FirstElementOfLastIteration) ->
  FirstElementOfLastIteration.

%% Aufgabe 2 a)
getFibonacci(N) ->
  getFibonacci(N , 1, [0,1], 1, 0).
getFibonacci(N, I, List, _, _) when I >= N ->
  List;
getFibonacci(N, I, List, LastElement, SecondLastElement) ->
  getFibonacci(N, I + 1, List ++ [SecondLastElement + LastElement], SecondLastElement + LastElement, LastElement).


%% Aufgabe 2 b)
getSumOfInverse(N) ->
  getSumOfInverse(N , 1, 0).
getSumOfInverse(N, I, Sum) when I > N ->
  Sum;
getSumOfInverse(N, I, Sum) ->
  getSumOfInverse(N, I + 1, Sum + (1 / I)).


%% Aufgabe 3
%% this function implements the pseudo code from wikipedia https://de.wikipedia.org/wiki/Mergesort

%%  funktion mergesort(liste);
%%    falls (Größe von liste <= 1) dann antworte liste
%%    sonst
%%      halbiere die liste in linkeListe, rechteListe
%%      linkeListe = mergesort(linkeListe)
%%      rechteListe = mergesort(rechteListe)
%%      antworte merge(linkeListe, rechteListe)

%%  funktion merge(linkeListe, rechteListe);
%%    neueListe
%%    solange (linkeListe und rechteListe nicht leer)
%%    |    falls (erstes Element der linkeListe <= erstes Element der rechteListe)
%%    |    dann füge erstes Element linkeListe in die neueListe hinten ein und entferne es aus linkeListe
%%    |    sonst füge erstes Element rechteListe in die neueListe hinten ein und entferne es aus rechteListe
%%    solange_ende
%%    solange (linkeListe nicht leer)
%%    |    füge erstes Element linkeListe in die neueListe hinten ein und entferne es aus linkeListe
%%    solange_ende
%%    solange (rechteListe nicht leer)
%%    |    füge erstes Element rechteListe in die neueListe hinten ein und entferne es aus rechteListe
%%    solange_ende
%%    antworte neueListe

sort(List) when length(List) =< 1 ->
  List;
sort(List) ->
  merge(sort(getLeftHalf(List)), sort(getRightHalf(List))).

merge(Left, Right) ->
  merge(Left, Right, []).
merge([LH|LT], [RH|RT], SortList) when LH < RH ->
  merge(LT, [RH] ++ RT, SortList ++ [LH]);
merge([LH|LT], [RH|RT], SortList) when LH >= RH ->
  merge([LH] ++ LT, RT, SortList ++ [RH]);
merge([], [RH|RT], SortList) ->
  merge([], RT, SortList ++ [RH]);
merge([LH|LT], [], SortList)  ->
  merge(LT, [], SortList ++ [LH]);
merge([], [], SortList) ->
  SortList.

%% helper method to get the left and the right half of a list
%% left get the middle element, if it exists
getLeftHalf(List) ->
  getLeftHalf(List, [], 0 , length(List)).
getLeftHalf([H|T], Left, I, EntireLength) when I < round(EntireLength / 2) ->
  getLeftHalf(T, Left ++ [H], I + 1, EntireLength);
getLeftHalf(_, Left, _,  _) ->
  Left.

getRightHalf(List) ->
  getRightHalf(List, [], 0 , length(List)).
getRightHalf([_|T], Right, I, EntireLength) when I < round(EntireLength / 2) ->
  getRightHalf(T, Right, I + 1, EntireLength);
getRightHalf([H|T], Right, I, EntireLength) ->
  getRightHalf(T, Right ++ [H], I + 1, EntireLength);
getRightHalf([], Right, _,  _) ->
  Right.


%% Aufgabe 4
%% Calculates all primes in the given range with the method Sieve of Eratosthenes.
getPrimes(N) ->
  getPrimes(createList(2, N), N, []).
getPrimes([], _ , Primes) ->
  Primes;
getPrimes([WorkingListH | WorkingListT], N, Primes) ->
  getPrimes(removeListFromList(WorkingListT, getVielfache(WorkingListH, N)), N, Primes ++ [WorkingListH]).


%% Helper method to remove all occurrences of a given value from a list
removeFromList(RemoveFrom, ToRemove) ->
  removeFromList(RemoveFrom, ToRemove, []).
removeFromList([], _, WorkList) ->
  WorkList;
removeFromList([RemoveFromH | RemoveFromT], ToRemove, WorkList) when RemoveFromH == ToRemove ->
  removeFromList(RemoveFromT, ToRemove, WorkList);
removeFromList([RemoveFromH | RemoveFromT], ToRemove, WorkList) ->
  removeFromList(RemoveFromT, ToRemove, WorkList ++ [RemoveFromH]).

%%helper method to remove a list of values form a list
removeListFromList(RemoveFrom, []) ->
  RemoveFrom;
removeListFromList(RemoveFrom, [ToRemoveH | ToRemoveT]) ->
  removeListFromList(removeFromList(RemoveFrom, ToRemoveH), ToRemoveT).


