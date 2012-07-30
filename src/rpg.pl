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
		(
	        (Sex = 'm', 
				T='aventureiro', assert(sexo_jogador(masc)))
			;
				(T='aventureira', assert(sexo_jogador(fem)))
		),
        write('Digite seu nome, nobre '),
        write(T), write(': '),
        readText([Nome|_]),
        assert(jogador(Nome)),!,
        dialogo.

seta_contexto(Ctx):-
    retractall(contexto_atual(_)),
    assertz(contexto_atual(Ctx)).

dialogo:-
    once(readLine(P)),
	processar_pergunta(P,R,Sem),!,
    writeLine(R),
    continuar(Sem).

dialogo:-
    writeLine(['desculpe, mas não entendi']),
    dialogo.

processar_pergunta(P,R,Sem):-
    seta_contexto(jogador),
    s(Sem,P,[]),
    substitui_pronomes_na_sentenca(Sem),!,
    once(atualiza_contexto(Sem)),
    seta_contexto(computador),
    once(atualiza_contexto(Sem)),

    processar(Sem,Resposta),!,
	
	institui_pronomes_na_sentenca(Resposta),!,
    s(Resposta,R,[]),
    seta_contexto(jogador),
    once(atualiza_contexto(Resposta)).

continuar(ato_fala:terminar):-
        falando_com(player, X),
        retract(falando_com(player, X)),
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

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema_real:T ..desconhecido:nao),
          (ato_fala:responder .. mensagem:negativo)):-
        \+ compound(T),
        PredAcao =.. [Relacao, A, T],
        \+ PredAcao.

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema:(acao: AcaoAuxiliar ..tema_real:T ..desconhecido:nao)),
          (ato_fala:responder .. mensagem:positivo)):-
    PredAcaoAuxiliar =.. [AcaoAuxiliar, A, T],
	PredAcao =..[Relacao, PredAcaoAuxiliar],
    PredAcao.

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema:(acao:AcaoAuxiliar ..tema_real:T) ..desconhecido:nao),
          (ato_fala:responder .. mensagem:negativo)):-
    PredAcaoAuxiliar =.. [AcaoAuxiliar, A, T],
	PredAcao =..[Relacao, PredAcaoAuxiliar],
    \+ PredAcao.

% perguntas qu
processar(
    (ato_fala:interro_tema_desconhecido ..desconhecido:sim ..agente_real:desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num)),
    (ato_fala:recusar 
        ..desconhecido:sim 
        ..acao:saber
        ..num:sing
        ..tema:(acao:ser ..pessoa:terc ..num:Num ..tema_real:desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num))
        ..agente:eu
        ..pessoa:prim
        )):-
    adiciona_termo_a_definir(Texto, np(id:Texto ..tipo:Tipo ..num:Num ..gen:Gen)).

% encontra possibilidades de poder fazer alguma coisa
processar((ato_fala:interro_tema_desconhecido
           ..acao:Relacao
           ..agente_real:Agent
           ..tema: (
                tema_real:incog(TipoNp)..%oque,quem,onde
                subtema: (num:_ ..pessoa:_ ..subcat:_ ..acao:AcaoAlvo)
				)
        ),
        (ato_fala:informar 
			..agente_real:Agent 
			..acao:Relacao 
			..pessoa:terc
            ..tema:(tema_eh_agente_ou_complemento:complemento ..acao:AcaoAlvo ..tema_real:TemaSolucao ..pessoa:indic))
        ):-
    nonvar(Relacao),
    nonvar(AcaoAlvo),
	PredAcaoAuxiliar =..[AcaoAlvo, Agent, T],
    PredAcao =.. [Relacao, PredAcaoAuxiliar],
    findall(T, (PredAcao), L),
    ( (\+ L = [], setof(A, member(A,L), L1));  L1 = L),
    filtrar(TipoNp, L1,TemaSolucao).

processar((ato_fala:interro_tema_desconhecido ..desconhecido:nao ..agente_real:Agent .. acao:Relacao .. tema_real:incog(TipoNp)),
          (ato_fala:informar .. agente_real:Agent .. acao:Relacao ..tema_real:TS)):-
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
           ..agente_real:player
           ..acao:poder 
           ..positivo:nao 
           ..pessoa:terc
           ..tema:(tema_eh_agente_ou_complemento:complemento ..acao:Relacao ..pessoa:indic ..num:sing ..tema_real:T)
		   ..porque:Porque
          )):-
    determina_agente(A, Ag),
    PredAcao =.. [Relacao, Ag, T],
    \+ PredAcao,
	motivos_para_nao_poder(PredAcao, PorqueNao),
	gera_explicacao(PorqueNao, Porque).

%%% acao cujo resultado eh descritivo
processar((ato_fala:informar ..agente_real:A .. acao:Relacao .. tema_real:T),
          (ato_fala:descrever ..mensagem:R)):-
        PredAcao =.. [Relacao, A, T, R],
        PredAcao.

processar((ato_fala:terminar),(ato_fala:terminar .. mensagem:tchau)).

processar((ato_fala:responder ..mensagem:oi),(ato_fala:responder .. mensagem:oi)).
processar((ato_fala:responder ..mensagem:oi ..tema_real:T),(ato_fala:responder .. mensagem:oi)):-
    falando_com(player, T).

% se o processar falhar
processar(_, []):-
        write('Ha algo errado na sua pergunta.'), !.

% converte o verbo ter para estar se o alvo eh racional; isso corrige o problema de personagens serem possuidos por coisas
%ajuste_acao_ter_estar_em_caso_racional(QuemTemOuEsta, ter, estar):-
%    racional(QuemTemOuEsta).
ajuste_acao_ter_estar_em_caso_racional(_, A, A).

traduz_agente_para_evitar_ambiguidade(A,A).

% normalizacao    
filtrar(TipoNp,[], np([],TipoNp)).
filtrar(_,X,Y):-
    filtrar(X,Y).
filtrar([X],X):-!.
filtrar(X,X):-!.

