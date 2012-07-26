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


cria_np_desconhecido(IsDesconhecido,_, _, _, _):-
	var(IsDesconhecido),
	IsDesconhecido = nao.

cria_np_desconhecido(sim, Texto, T, G, N):-
	nonvar(T), nonvar(G), nonvar(N), nonvar(Texto),
	asserta(np_desconhecido(Texto, desconhecido(texto: Texto ..tipo:T ..gen:G ..num:N))).

cria_np_desconhecido(IsDesconhecido,Texto, _, _, _):-
	( var(IsDesconhecido) ; IsDesconhecido = nao ),
	clause(np_desconhecido, _),
	np_desconhecido(Texto, _),
	retract(np_desconhecido(Texto, _)).
	
cria_np_desconhecido(_,_,_,_,_).

determina_desconhecido(IdentidadeDesconhecido, sim, Tracos):-
	np_desconhecido(IdentidadeDesconhecido, Tracos),!,
	retract(np_desconhecido(IdentidadeDesconhecido, _)).

determina_desconhecido(IdentidadeDesconhecido, nao, IdentidadeDesconhecido):-
	\+ np_desconhecido(IdentidadeDesconhecido, _).

determina_desconhecido(A, _,A):-
	\+ compound(A),
	retractall(np_desconhecido).

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
equivale(contigo, [em, voce]).
equivale(nele, [em, ele]).
equivale(nela, [em, ela]).
equivale(dele, [de, ele]).
equivale(dela, [de, ela]).
equivale(deles, [de, eles]).
equivale(delas, [de, elas]).

