preposicao_exigida(exige_preposicao(Acao,Prep),Prep):-
	nonvar(Acao),
	nonvar(Prep).

preposicao_exigida(_,_).

id_para_acao(exige_preposicao(Acao,Prep),Acao):-
	nonvar(Acao),
	nonvar(Prep).

id_para_acao(Acao,Acao).

id_para_np(sn((id:I..quant:Quant ..poss:Poss..numero:Num)), 
		  	sn(id:I..quant:Quant ..poss:Poss..numero:Num)
		  ):-
	(nonvar(Quant); nonvar(Poss); nonvar(Num)).

id_para_np(I, sn(id:I..quant:Quant ..poss:Poss..numero:Num)):-
	nonvar(I),var(Quant),var(Poss),var(Num).

id_para_np(Substantivo,Substantivo).

is_positivo(T, _):-
	var(T).

is_positivo(T, nao):-
	nonvar(T),
	T=np([],_).

is_positivo(T, nao):-
	nonvar(T),
	T=(tema_real:np([],_)).

is_positivo(TX, IsPositivo):-
	nonvar(TX),
	TX=(tema_real:T),
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
equivale(contigo, [com, voce]).
equivale(nele, [em, ele]).
equivale(nela, [em, ela]).
equivale(dele, [de, ele]).
equivale(dela, [de, ela]).
equivale(deles, [de, eles]).
equivale(delas, [de, elas]).
equivale(daqui, [de, aqui]).

% contrai ou descontrai verbo indic + pronome
equivale(VerboMaisPronomeObliquo, [Verbo, Pronome]):-
	nonvar(Verbo), nonvar(Pronome),
	v((pessoa:indic),[Verbo],[]),
	pro((tipo_pro:reto),[Pronome],[]),
	
	equivale_verbo_ligado_obliquo(Verbo,VerboFlexionado),
	equilave_pronome_obliquo(Pronome,PronomeObliquo),

	concat_atom([VerboFlexionado,'-',PronomeObliquo], VerboMaisPronomeObliquo).
	
equivale(VerboMaisPronomeObliquo, [Verbo, PronomeCompleto]):-
	nonvar(VerboMaisPronomeObliquo),
	atomic_list_concat([VerboFlexionado,Pronome],'-', VerboMaisPronomeObliquo),
	concat_atom([VerboFlexionado,r], Verbo),
	concat_atom([e,Pronome],PronomeCompleto).

equivale_verbo_ligado_obliquo(Verbo,VerboFlexionado):-
	string_length(Verbo,Len), 
	Len1 is Len-1, 
	sub_string(Verbo, 0, Len1, _, VerboFlexionado).

equilave_pronome_obliquo(ela,la).
equilave_pronome_obliquo(elas,las).
equilave_pronome_obliquo(ele,lo).
equilave_pronome_obliquo(eles,los).
