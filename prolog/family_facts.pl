progenitor(maria, jose).
progenitor(joão, josé).
progenitor(joão, ana).
progenitor(josé, júlia).
progenitor(josé, íris).
progenitor(íris, jorge).

masculino(joão).
masculino(josé).
masculino(jorge).

feminino(maria).
feminino(ana).
feminino(júlia).
feminino(íris).

pai(X,Y) :-
  progenitor(X,Y),
  masculino(X).

mãe(X,Y) :-
  progenitor(X,Y),
  feminino(X).

irmão(X,Y) :-
  progenitor(Z,X),
  progenitor(Z,Y),
  masculino(X).

irmã(X,Y) :-
  progenitor(Z,X),
  progenitor(Z,Y),
  feminino(X).


antepassado(X, Y) :-
  progenitor(X, Y).

antepassado(X, Y) :-
  progenitor(X, Z),
  antepassado(Z, Y).

nasceu(joão, pelotas).
nasceu(jean, paris).

fica(pelotas, rs).
fica(paris, frança).

gaúcho(X) :-
  nasceu(X, Z),
  fica(Z, rs).

:- go.
