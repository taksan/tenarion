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

% contrai ou descontrai verbo indic + pronome
equivale(VerboMaisPronomeObliquo, [Verbo, Pronome]):-
	nonvar(Verbo), nonvar(Pronome),
	v((pessoa:indic),[Verbo],[]),
	pro((tipo_pro:reto),[Pronome],[]),
	string_length(Verbo,Len), 
	Len1 is Len-1, 
	sub_string(Verbo, 0, Len1, _, VerboSemR),
	string_length(Pronome,LenPron),
	LenPrin_1 is LenPron-1,
	sub_string(Pronome,1,LenPrin_1,_,PronomeObliquo),
	concat_atom([VerboSemR,'-',PronomeObliquo], VerboMaisPronomeObliquo).
	

equivale(VerboMaisPronomeObliquo, [Verbo, PronomeCompleto]):-
	nonvar(VerboMaisPronomeObliquo),
	atomic_list_concat([VerboSemR,Pronome],'-', VerboMaisPronomeObliquo),
	concat_atom([VerboSemR,r], Verbo),
	concat_atom([e,Pronome],PronomeCompleto).

