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
-export([createList/0, getVielfache/1, getLast/1, shiftRight/1, getFibonacci/1]).

%% Aufgabe 1 a)
createList() ->
  lists:seq(0,100).


%% Aufgabe 1 b)
getVielfache(A) ->
  getVielfache([A], A, A).

getVielfache(L, ToAdd, Sum) when Sum + ToAdd < 100 ->
  getVielfache(L ++ [Sum + ToAdd], ToAdd, Sum + ToAdd);
getVielfache(L, ToAdd, Counter) when Counter + ToAdd >= 100 ->
  [L].


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