:-[gulp].
:-[mundo].
:-[lexico].
:-[gramatica].
:-[io].

:-dynamic contexto/2.
/*
 Programa principal que controla o jogo

 Para executar, é só escrever a consulta "jogar".
*/

cleanup_player:-
        jogador(_),
        retract(jogador(_)).

cleanup_player.

jogar:-
        once(cleanup_player),
        write('Bem Vindo ao mundo de Fagageh!'),
        nl,
        write('Qual o seu sexo (F/M/I)? '),
%        readText([Sex|_]),
		Sex='m',
        assert(sexoJogador(Sex)),
        ((Sex = 'm', T='aventureiro'); (T='aventureira')),
        write('Digite seu nome, nobre '),
        write(T), write(': '),
%        readText([Nome|_]),
		Nome='Fulk',
		assert(jogador(Nome)),!,
        dialogo.

dialogo:-
    once(readLine(P)),
	s(Sem,P,[]),
	processar(Sem,Resposta),
    notrace(once(atualiza_contexto(Sem, Resposta))),!,
	s(Resposta,R,[]),
	writeLine(R),
	continuar(Sem).

dialogo:-
	writeLine(['hã', hein, '?']),
	dialogo.

continuar(ato_fala:terminar):-
        falando_com(voce, X),
        retract(falando_com(voce, X)),
        dialogo.

continuar(ato_fala:terminar).

continuar(_):-
	dialogo.

/******* Integracao Semantica *******/

processar([],[]).

processar((ato_fala:int_sim_nao ..agente:A ..acao:Relacao ..tema:T),
          (ato_fala:responder .. mensagem:positivo)):-
        PredAcao =.. [Relacao, A, T],
        PredAcao.

processar((ato_fala:int_sim_nao ..agente:A ..acao:Relacao ..tema:T),
          (ato_fala:responder .. mensagem:negativo)):-
        PredAcao =.. [Relacao, A, T],
        \+ PredAcao.

processar((ato_fala:int_sim_nao_aux ..agente:A ..acao_aux: AcaoAuxiliar ..acao:Relacao ..tema:T),
          (ato_fala:responder .. mensagem:positivo)):-
		concat_atom([AcaoAuxiliar, '_', Relacao], RelacaoAuxiliar),
        PredAcao =.. [RelacaoAuxiliar, A, T],
        PredAcao.

processar((ato_fala:int_sim_nao_aux ..agente:A ..acao_aux:AcaoAuxiliar ..acao:Relacao ..tema:T),
          (ato_fala:responder .. mensagem:negativo)):-
		concat_atom([AcaoAuxiliar, '_', Relacao], RelacaoAuxiliar),
        PredAcao =.. [RelacaoAuxiliar, A, T],
        \+ PredAcao.

% perguntas qu
processar((ato_fala:interro_qu ..agente:incog(Tipo) ..acao:Relacao ..tema:T),
   (ato_fala:informar .. agente:W ..acao:RelacaoAjustada .. tema:T1 ..pessoa:terc ..entidade:Tipo)):-
		write('Relacao '),write(Relacao),nl,
		write('tema '), write(T), nl,
		write('tipo '), write(Tipo), nl,
		ajuste_acao_ter_estar_em_caso_racional(T, Relacao, RelacaoAjustada),!,
		write('Relacao ajustada '),write(RelacaoAjustada),nl,
        PredAcao =.. [RelacaoAjustada, A, T],
		findall(A, (PredAcao, entidade(A, Tipo)), L),
        ( (\+ L = [], setof(A, member(A,L), L1)) ; L1 = L),
        filtrar(L1,W),
        novo_agente(T,T1).

ajuste_acao_ter_estar_em_caso_racional(QuemTemOuEsta, ter, estar):-
	racional(QuemTemOuEsta).

ajuste_acao_ter_estar_em_caso_racional(QuemTemOuEsta, A, A).


processar((ato_fala:interro_adv.. agente:Agent .. acao:Relacao .. tema:T),
          (ato_fala:informar .. agente:Ag .. acao:Relacao ..tema:TS ..pessoa:terc)):-
        PredAcao =.. [Relacao, Agent, T],
		findall(T, (PredAcao), L),
        ( (\+ L = [], setof(A, member(A,L), L1));
          L1 = L),
        filtrar(L1,TS),
        novo_agente(Agent, Ag).

processar((ato_fala:informar .. agente:A .. acao:Relacao .. tema:T),
          (ato_fala:responder .. mensagem:ok)):-
        PredAcao =.. [Relacao, A, T],
        notrace(PredAcao).

processar((ato_fala:informar .. agente:A .. acao:Relacao .. tema:T),
          (ato_fala:recusar .. agente:voce_resp .. acao:Relacao .. tema:T)):-
        PredAcao =.. [Relacao, A, T],
        \+ notrace(PredAcao).

%%% acao cujo resultado eh descritivo
processar((ato_fala:informar ..agente:A .. acao:Relacao .. tema:T),
          (ato_fala:descrever ..mensagem:R)):-
        PredAcao =.. [Relacao, A, T, R],
        notrace(PredAcao).

processar((ato_fala:terminar),(ato_fala:terminar .. mensagem:tchau)).

processar((mensagem:oi),(ato_fala:responder .. mensagem:oi)).

% se o processar falhar
processar(_, []):-
        write('Ha algo errado na sua pergunta.'), !.

% normalizacao	
filtrar([X],X):-!.
filtrar(X,X):-!.

/* Resolucao e manutencao de contexto */

%% mantem mapeamento para ultimas referencias por genero
contexto((pessoa:terc ..gen:fem ..num:sing), '$').

contexto((pessoa:terc ..gen:masc ..num:sing), '$'). 

%% atualiza o contexto de acordo com a pergunta e com a resposta

atualiza_contexto([], []).

atualiza_contexto((agente:AgPerg ..tema:TemaPerg), []):-
        denota(Pessoa1, AgPerg),  atualiza_pessoa(Pessoa1, AgPerg),
        denota(Pessoa2, TemaPerg), atualiza_pessoa(Pessoa2, TemaPerg).

atualiza_contexto([], (agente:AgResp ..tema:TemaResp)):-
        denota(Pessoa3, AgResp),  atualiza_pessoa(Pessoa3, AgResp),
        denota(Pessoa4, TemaResp), atualiza_pessoa(Pessoa4, TemaResp).

atualiza_contexto((agente:AgPerg ..tema:TemaPerg),
                  (agente:AgResp ..tema:TemaResp)):-
        denota(Pessoa1, AgPerg),  atualiza_pessoa(Pessoa1, AgPerg),
        denota(Pessoa2, TemaPerg), atualiza_pessoa(Pessoa2, TemaPerg),
        denota(Pessoa3, AgResp),  atualiza_pessoa(Pessoa3, AgPerg),
        denota(Pessoa4, TemaResp), atualiza_pessoa(Pessoa4, TemaResp).

atualiza_pessoa(Pessoa, NovoValor):-
        nonvar(NovoValor),
        retract(contexto(Pessoa, _)),
        assert(contexto(Pessoa, NovoValor)).

atualiza_pessoa(_ , _).

%% determinacao do agente baseado no contexto
denota((tipo_pro:pron_qu ..pron:P), P).

denota((tipo_pro:pron_ninguem(quem)), ninguem).

denota((tipo_pro:pron_ninguem(oque)), nada).

denota((tipo_pro:reto ..num:sing ..pessoa:prim ..gen:G), Ag):-
        contexto((num:sing ..pessoa:prim ..gen:G), Ag).

denota((tipo_pro:voce), X):-
        (falando_com(voce, X);
         \+ (falando_com(voce, _), X = narrador)).

denota((tipo_pro:voce ..num:sing ..pessoa:terc), voce_resp):-!.

denota((tipo_pro:reto ..num:sing ..pessoa:prim), voce).

denota((tipo_pro:reto ..num:N ..gen:G ..pessoa:terc), X):-
        np((num:N ..gen:G), [X], []).

novo_agente(voce, voce_resp).

novo_agente(A, A).

%% determinacao do lugar baseado no contexto
denota_lugar(aqui, L):-
        estar(voce, L).

denota_lugar(onde, onde).
