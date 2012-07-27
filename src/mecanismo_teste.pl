roda_testes:-
    cleanup_player,
    assert(jogador('foo')),
	write('Test execution started'),nl,
	roda_teste(1),
	write('Test execution finished'),nl.

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

processa_pergunta_gera_resposta(PerguntaString1,RespostaString):-
	adapt_punctuation(PerguntaString1,PerguntaString),
	atomic_list_concat(Pergunta,' ',PerguntaString),!,
    seta_contexto(jogador),!,
    s(Sem, Pergunta, []),!,
    substitui_pronomes_na_sentenca(Sem),!,
    seta_contexto(computador),!,
    once(atualiza_contexto(Sem)),!,
    processar(Sem,Res),!,
	institui_pronomes_na_sentenca(Res),!,
    s(Res, Resposta, []),!,
    seta_contexto(jogador),!,
    once(atualiza_contexto(Res)),!,
	toString(Resposta,RespostaString),!.

adapt_punctuation(SIn,SOut):-
	string_length(SIn,Len), 
	Len1 is Len-1, 
	sub_string(SIn, 0, Len1, _, Sub),
	sub_string(SIn, Len1, 1,_,Punct),
	concat_atom([Sub,' ',Punct], SOut).

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

