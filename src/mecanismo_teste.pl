roda_testes:-
    cleanup_player,
    assert(jogador('foo')),
	assert(sexo_jogador(masc)),
	write('Test execution started'),nl,
	roda_teste(1).

roda_teste(N):-
	concat_atom([teste,N],NomeTeste),
	\+ clause(NomeTeste,_).

roda_teste(N):-
	concat_atom([teste,N],NomeTeste),
	clause(NomeTeste,_),
	T=..[NomeTeste],
	executa(T),
	NNext is N+1,
	roda_teste(NNext).

executa(T):-
	T,
	clause(T,C),
	write('PASSED: '),
	write(C),nl.

executa(T):-
	clause(T,C),
	C=..[Pred,Pergunta,Esperado],!,
	NC=..[Pred,Pergunta,RespostaReal],!,
	ignore(NC),
	write('***FAILED : '),  write(C),nl,
	write('   Esperado: '), write(Esperado),nl,
	write('   Gerado  : '), write(RespostaReal),nl.

dado_pergunta_espero_resposta(Pergunta,Resposta):-
	processa_pergunta_gera_resposta(Pergunta,Resposta).

processa_pergunta_gera_resposta(PerguntaString,RespostaString):-
	converte_pergunta_para_lista(PerguntaString,Pergunta),!,
	processar_pergunta(Pergunta,Resposta,_),!,
	converte_resposta_para_string(Resposta,RespostaString).

converte_pergunta_para_lista(PerguntaString,PerguntaArray):-
	adapt_punctuation(PerguntaString,PerguntaString1),
	atomic_list_concat(PerguntaC,' ',PerguntaString1),!,
	contraido(PerguntaC,PerguntaArray).

converte_resposta_para_string(RespostaLista,RespostaString):-
	contraido(RespostaC, RespostaLista),
	toString(RespostaC,RespostaString).

adapt_punctuation(SIn,SOut):-
	string_length(SIn,Len), 
	Len1 is Len-1, 
	sub_string(SIn, 0, Len1, _, Sub),
	sub_string(SIn, Len1, 1,_,Punct),
	concat_atom([Sub,' ',Punct], SOut).

contraido([],[]).

contraido([Contraido|Resto],[A,B|Restocontraidodo]):-
	equivale(Contraido,[A,B]),
	contraido(Resto,Restocontraidodo).

contraido([A|Resto],[A|Restocontraidodo]):-
	contraido(Resto,Restocontraidodo).

contraido([A,B],[A,B]).

toString([],'').

toString([H],H).

toString([H,,|Tail],String):-
	toString(Tail,StringResto),
	concat_atom([H, ', ', StringResto],String).

toString([H,Q],String):-
	member(Q,[.,?]),
	concat_atom([H, Q],String).

toString([H|Tail],String):-
	toString(Tail,StringResto),
	concat_atom([H, ' ', StringResto],String).

