% tratamento de casos desconhecidos
is_positivo(T, _):-
	var(T).

is_positivo(T, nao):-
	nonvar(T),
	T=np([],_).

is_positivo(T, nao):-
	nonvar(T),
	T=(tema:np([],_)).

is_positivo(TX, IsPositivo):-
	nonvar(TX),
	TX=(tema:T),
	is_positivo(T, IsPositivo).

is_positivo(T, sim):-
	nonvar(T),
	is_list(T).

is_positivo(T,sim):-
	nonvar(T),
	\+compound(T).

is_positivo(T,sim):-
	nonvar(T),
	\+is_list(T).

%%%%%%%% Utilizado para contracoes/quebra
%% eh usado no IO
equivale(na, [em, a]).
equivale(numa, [em, uma]).
equivale(no, [em, o]).
equivale(num, [em, um]).
equivale(da, [de, a]).
equivale(das, [de, as]).
equivale(do, [de, o]).
equivale(dos, [de, os]).
equivale(comigo, [em, eu]).
equivale(comigo, [com, eu]).
equivale(contigo, [em, voce]).
equivale(nele, [em, ele]).
equivale(nela, [em, ela]).
equivale(dele, [de, ele]).
equivale(dela, [de, ela]).
equivale(deles, [de, eles]).
equivale(delas, [de, elas]).

