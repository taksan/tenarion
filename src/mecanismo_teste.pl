:-[string].

roda_testes:-
    cleanup_player,
    assert(jogador('foo')),
	assert(sexo_jogador(masc)),
	write('Test execution started'),nl,
	findall(Q, (current_predicate(Q/0),sub_string(Q,0,5,_,teste)),UnsortedTests),sort(UnsortedTests,SortedTests),
	roda_testes(SortedTests,TotalPassados,Total),
	TotalFalhados is Total-TotalPassados,
	write('PASSARAM: '),write(TotalPassados),nl,
	write('FALHARAM: '),write(TotalFalhados),nl,
	write('TOTAL:    '),write(Total),nl.

roda_testes([],0,0).

roda_testes([Teste|Outros],TotalPassados,Total):-
	executa(Teste,Passou),
	roda_testes(Outros,Passados,SubTotal),
	TotalPassados is Passados+Passou,
	Total is SubTotal+1.

executa(T,Passou):-
%	ignore((T=teste73,gspy(breakpoint))),
	clause(T,C),
	C=..[Pred,Pergunta,Esperado],!,
	NC=..[Pred,Pergunta,RespostaReal],!,
	ignore(NC),
	(nonvar(RespostaReal);RespostaReal='-empty-'),
	(Esperado=RespostaReal,
		(printpassed(C),Passou=1);
		printfailed(C,Esperado,RespostaReal),Passou=0
	).

printpassed(C):-
	is_verbose,
	write('PASSED: '),
	write(C),nl.
printpassed(_).

printfailed(C,Esperado,RespostaReal):-
	write('***FAILED : '),  write(C),nl,
	write('   Esperado: '), write(Esperado),nl,
	write('   Gerado  : '), write(RespostaReal),nl.

dado_pergunta_espero_resposta(Pergunta,Resposta):-
	processa_pergunta_gera_resposta(Pergunta,Resposta).

processa_pergunta_gera_resposta(PerguntaString,RespostaString):-
	converte_pergunta_para_lista(PerguntaString,Pergunta),!,
	processar_pergunta(Pergunta,Resposta,_),!,
	converte_resposta_para_string(Resposta,RespostaString).

