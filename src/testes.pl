:-[rpg].

% Siga a sequencia e nomenclatura, o mecanismo de testes depende delas para funcionar.
teste1:-
    dado_pergunta_espero_resposta('o que tem aqui?', 'o barco, uma corda, algumas minhocas, uma vara de pescar e algumas tabuas estao aqui.').
teste2:- 
    dado_pergunta_espero_resposta('quem estah aqui?', 'voce e o zulu estao aqui.').
teste3:- 
    dado_pergunta_espero_resposta('onde eu estou?', 'voce estah em o ancoradouro.').
teste4:-
    dado_pergunta_espero_resposta('onde eu posso ir?', 'voce pode ir para a carpintaria.').
teste5:-
    dado_pergunta_espero_resposta('o que eu posso pegar?', 'voce pode pegar algumas minhocas, uma vara de pescar e algumas tabuas.').
teste6:-
    dado_pergunta_espero_resposta('onde estah a corda?', 'ela estah em o ancoradouro e em o barco.').
teste7:-
    dado_pergunta_espero_resposta('eu posso pegar a corda?', 'nao').
teste8:-
    dado_pergunta_espero_resposta('eu pego ela.', 'voce nao pode pegar ela.').
teste9:-
    dado_pergunta_espero_resposta('o que eu tenho?', 'voce tem um cartao de credito, a identidade e a sua mao.').
teste10:-
    dado_pergunta_espero_resposta('as minhocas estao aqui?', 'sim').
teste11:-
    dado_pergunta_espero_resposta('o que sao elas?', 'elas sao algumas minhocas.').
teste12:-
    dado_pergunta_espero_resposta('eu pego elas.', 'ok').
teste13:-
    dado_pergunta_espero_resposta('o que eu tenho?', 'voce tem um cartao de credito, a identidade, algumas minhocas e a sua mao.').
teste14:-
    dado_pergunta_espero_resposta('o barco estah aqui?', 'sim').
teste15:-
    dado_pergunta_espero_resposta('o que eh ele?', 'ele eh o barco.').
teste16:-
    dado_pergunta_espero_resposta('onde estah o zulu?', 'ele estah em o ancoradouro.').
teste17:-
    dado_pergunta_espero_resposta('o que eh ele?', 'ele eh o barco.').
teste18:-
    dado_pergunta_espero_resposta('quem eh ele?', 'ele eh o zulu.').
teste19:-
	dado_pergunta_espero_resposta('quem estah em o caixa eletronico?', 'ninguem estah em ele.').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daqui para baixo, mecanismos internos para execucao dos testes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

:-roda_testes.
:-halt.
