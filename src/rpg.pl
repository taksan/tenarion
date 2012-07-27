:-[gulp].
:-[mundo].
:-[lexico].
:-[gramatica].
:-[io].
:-[auxiliar].
:-[resolucao_pronomes].
:-[contexto].
:-[explicacao].

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
        write('Bem Vindo ao mundo de Tenarion!'),
        nl,
        write('Qual o seu sexo (F/M/I)? '),
        readText([Sex|_]),
        assert(sexoJogador(Sex)),
        ((Sex = 'm', T='aventureiro'); (T='aventureira')),
        write('Digite seu nome, nobre '),
        write(T), write(': '),
        readText([Nome|_]),
        assert(jogador(Nome)),!,
        dialogo.

testar:-
        once(cleanup_player),
        write('Bem Vindo ao mundo de Fagageh!'),
        nl,
        write('Qual o seu sexo (F/M/I)? '),
        Sex='m',
        assert(sexoJogador(Sex)),
        ((Sex = 'm', T='aventureiro'); (T='aventureira')),
        write('Digite seu nome, nobre '),
        write(T), write(': '),
        Nome='Fulk',
        assert(jogador(Nome)),!,
        dialogo.



seta_contexto(Ctx):-
    retractall(contexto_atual(_)),
    assertz(contexto_atual(Ctx)).

dialogo:-
    once(readLine(P)),!,
    seta_contexto(jogador),
    s(Sem,P,[]),
    substitui_pronomes_na_sentenca(Sem),
    seta_contexto(computador),
    once(atualiza_contexto(Sem)),

    processar(Sem,Resposta),!,

	institui_pronomes_na_sentenca(Resposta),
    s(Resposta,R,[]),!,
    seta_contexto(jogador),
    once(atualiza_contexto(Resposta)),

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

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema_real:T),
          (ato_fala:responder .. mensagem:positivo)):-
        \+ compound(T),
        PredAcao =.. [Relacao, A, T],
        PredAcao.

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema_real:T),
          (ato_fala:responder .. mensagem:negativo)):-
        \+ compound(T),
        PredAcao =.. [Relacao, A, T],
        \+ PredAcao.

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema:(acao: AcaoAuxiliar ..tema_real:T)),
          (ato_fala:responder .. mensagem:positivo)):-
    concat_atom([Relacao, '_', AcaoAuxiliar], RelacaoAuxiliar),
    PredAcao =.. [RelacaoAuxiliar, A, T],
    PredAcao.

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema:(acao:AcaoAuxiliar ..tema_real:T)),
          (ato_fala:responder .. mensagem:negativo)):-
    concat_atom([Relacao, '_', AcaoAuxiliar], RelacaoAuxiliar),
    PredAcao =.. [RelacaoAuxiliar, A, T],
    \+ PredAcao.

% perguntas qu

processar(
    (ato_fala:interro_tema_desconhecido ..desconhecido:sim ..agente_real:desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num)),
    (ato_fala:recusar 
        ..desconhecido:sim 
        ..acao:saber
        ..num:sing
        ..tema:(acao:ser ..pessoa:terc ..num:Num ..tema_real:desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num))
        ..agente:narrador
        ..pessoa:prim
        )):-
    adiciona_termo_a_definir(Texto, np(id:Texto ..tipo:Tipo ..num:Num ..gen:Gen)).

% encontra possibilidades de poder fazer alguma coisa
processar((ato_fala:interro_tema_desconhecido
           ..acao:Relacao
           ..agente_real:Agent
           ..tema: (
                tema_real:incog(TipoNp)..%oque,quem,onde
                subtema: (num:_ ..pessoa:PX ..subcat:_ ..acao:AcaoAlvo)
				)
        ),
        (ato_fala:informar 
			..agente_real:Agent 
			..acao:Relacao 
			..pessoa:terc
            ..tema:(acao:AcaoAlvo ..tema_real:TS ..pessoa:PX))
        ):-
    nonvar(Relacao),
    nonvar(AcaoAlvo),
    concat_atom([Relacao, '_', AcaoAlvo], RelacaoAuxiliar),
    PredAcao =.. [RelacaoAuxiliar, Agent, T],
    findall(T, (PredAcao), L),
    ( (\+ L = [], setof(A, member(A,L), L1));  L1 = L),
    filtrar(TipoNp, L1,TS).

processar((ato_fala:interro_tema_desconhecido ..desconhecido:nao ..agente_real:Agent .. acao:Relacao .. tema_real:incog(TipoNp)),
          (ato_fala:informar .. agente_real:Agent .. acao:Relacao ..tema_real:TS ..pessoa:terc)):-
    \+ compound(Agent),
    % TODO: o tipo do tema pode ser usado para restringir as respostas
    PredAcao =.. [Relacao, Agent, TemaSolucao],
    findall(TemaSolucao, (PredAcao), L),
    ( (\+ L = [], setof(A, member(A,L), L1));  L1 = L),
    filtrar(TipoNp, L1,TS).

% o que ou quem        

processar((ato_fala:interro_agente_desconhecido ..desconhecido:nao ..agente_real:incog(Tipo) ..acao:Relacao ..tema_real:T),
   (ato_fala:informar .. agente_real:AgentesTraduzidos ..acao:RelacaoAjustada .. tema_real:T ..pessoa:terc ..entidade:Tipo)):-
    ajuste_acao_ter_estar_em_caso_racional(T, Relacao, RelacaoAjustada),!,
    PredAcao =.. [RelacaoAjustada, A, T],
    findall(A, (PredAcao, entidade(A, Tipo)), L),
    ( (\+ L = [], setof(A, member(A,L), L1)) ; L1 = L),
    filtrar(Tipo,L1,W),
    traduz_agente_para_evitar_ambiguidade(W, AgentesTraduzidos).

processar((ato_fala:informar .. agente_real:A .. acao:Relacao .. tema_real:T),
          (ato_fala:responder .. mensagem:ok)):-
    determina_agente(A, Ag),
    PredAcao =.. [Relacao, Ag, T],
    PredAcao.

processar((ato_fala:informar .. agente_real:A .. acao:Relacao .. tema_real:T),
          (ato_fala:informar
           ..agente_real:voce
           ..acao:poder 
           ..positivo:nao 
           ..pessoa:terc
           ..tema:(tema_eh_agente_ou_complemento:complemento ..acao:Relacao ..pessoa:indic ..num:sing ..tema_real:T)
		   ..porque:Porque
          )):-
    determina_agente(A, Ag),
    PredAcao =.. [Relacao, Ag, T],
    \+ notrace(PredAcao),
	concat_atom([poder_,Relacao], PoderRelacao),
	PredPoder=..[PoderRelacao, Ag, T],
	gera_explicacao_falhas(PredPoder, Porque).

%%% acao cujo resultado eh descritivo
processar((ato_fala:informar ..agente_real:A .. acao:Relacao .. tema_real:T),
          (ato_fala:descrever ..mensagem:R)):-
        PredAcao =.. [Relacao, A, T, R],
        PredAcao.

processar((ato_fala:terminar),(ato_fala:terminar .. mensagem:tchau)).

processar((ato_fala:responder ..mensagem:oi),(ato_fala:responder .. mensagem:oi)).
processar((ato_fala:responder ..mensagem:oi ..tema_real:T),(ato_fala:responder .. mensagem:oi)):-
    falando_com(voce, T).

% se o processar falhar
processar(_, []):-
        write('Ha algo errado na sua pergunta.'), !.

% converte o verbo ter para estar se o alvo eh racional; isso corrige o problema de personagens serem possuidos por coisas
%ajuste_acao_ter_estar_em_caso_racional(QuemTemOuEsta, ter, estar):-
%    racional(QuemTemOuEsta).
ajuste_acao_ter_estar_em_caso_racional(_, A, A).

traduz_agente_para_evitar_ambiguidade([],[]).
traduz_agente_para_evitar_ambiguidade(voce, voce).
traduz_agente_para_evitar_ambiguidade(A,A):-
    \+ is_list(A).
traduz_agente_para_evitar_ambiguidade([voce|Resto], [voce|Resto]).
traduz_agente_para_evitar_ambiguidade([Alguem|Resto], [Alguem|RestoRes]):-
    \+ Alguem = voce,
    traduz_agente_para_evitar_ambiguidade(Resto, RestoRes).

% normalizacao    
filtrar(TipoNp,[], np([],TipoNp)).
filtrar(_,X,Y):-
    filtrar(X,Y).
filtrar([X],X):-!.
filtrar(X,X):-!.

