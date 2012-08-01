:-[gulp].
:-[mundo].
:-[lexico].
:-[gramatica].
:-[io].
:-[resolucao_pronomes].
:-[contexto].
:-[poder].
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
	(s(Sem,P,[]), processa_sentenca(Sem,R));
	(R=['desculpe, mas nao entendi.']).


processa_sentenca(Sem,R):-
    seta_contexto(jogador),
    substitui_pronomes_na_sentenca(Sem),!,
	processa_contexto(Sem),
    processar(Sem,Resposta),!,
	(
		gera_resposta(Resposta,R);
		R=['nao sei te responder.']
	).

gera_resposta(Resposta,R):-
	institui_pronomes_na_sentenca(Resposta),!,
    s(Resposta,R,[]), 
	seta_contexto(jogador), 
	once(atualiza_contexto(Resposta)).

processa_contexto(Sem):-
    once(atualiza_contexto(Sem)),

    seta_contexto(computador),
    once(atualiza_contexto(Sem)).

%
continuar(Sem):-
	nonvar(Sem),
	Sem=ato_fala:terminar,
    \+ falando_com(player, _),
	nl.

continuar(_):-
    dialogo.

/******* Integracao Semantica *******/

processar([],[]).

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema_real:T),
          (ato_fala:responder .. mensagem:Resposta)):-
        eh_tema_simples(T),
        PredAcao =.. [Relacao, A, T],
		(
        	(PredAcao,Resposta=positivo);
			Resposta=negativo
		).

% processamento de verbos sobre verbos
processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema:(acao: AcaoAuxiliar ..tema_real:T ..desconhecido:nao)),
          (ato_fala:responder .. mensagem:Resposta)):-
    PredAcaoAuxiliar =.. [AcaoAuxiliar, A, T],
	PredAcao =..[Relacao, PredAcaoAuxiliar],
	(
        	(PredAcao,Resposta=positivo);
			Resposta=negativo
	).

% perguntas na qual o tema é uma palavra desconhecida
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
          (ato_fala:informar .. agente_real:Agent .. acao:RelacaoResolvida ..tema_real:PacientesDeterminados)):-
    eh_tema_simples(Agent),
    % TODO: o tipo do tema pode ser usado para restringir as respostas
	determina_agente(Agent,AgenteDeterminado),
    PredAcao =.. [Relacao, AgenteDeterminado, TemaSolucao],
	PredToCheck=.. [Relacao, AgenteDeterminado, _],
	(	
		(
			clause(PredToCheck,_),
			findall(TemaSolucao, (PredAcao), L),
			( (\+ L = [], setof(A, member(A,L), L1));  L1 = L),
			filtrar(TipoNp, L1,PacientesDeterminados),
			ajuste_acao_de_acordo_com_resposta(PacientesDeterminados, Relacao,RelacaoResolvida)
		);
		(
			filtrar(TipoNp, [], PacientesDeterminados),
			RelacaoResolvida=Relacao
		)
	).

% o que ou quem        

processar((ato_fala:interro_agente_desconhecido ..desconhecido:nao ..agente_real:incog(Tipo) ..acao:Relacao ..tema_real:Tema),
   (ato_fala:informar .. agente_real:AgentesTraduzidos ..acao:RelacaoResolvida .. tema_real:TemaResolvido ..entidade:Tipo)):-
    ajuste_acao_ter_estar_em_caso_racional(Tema, Relacao, RelacaoAjustada),!,
	determina_agente(Tema,TemaDeterminado),
    PredAcao =.. [RelacaoAjustada, A, TemaDeterminado],
    findall(A, (PredAcao, entidade(A, Tipo)), L),
    ( (\+ L = [], setof(A, member(A,L), L1)) ; L1 = L),
    filtrar(L1,PossivelmenteAgente),
    determina_agente_e_tema_resultantes(Tipo, PossivelmenteAgente,Tema,AgentesTraduzidos,TemaResolvido),
	ajuste_acao_de_acordo_com_resposta(TemaResolvido, RelacaoAjustada,RelacaoResolvida).

processar((ato_fala:informar .. agente_real:Ag .. acao:Relacao .. tema_real:T),
          Resposta):-
    PredAcao =.. [Relacao, Ag, T],
	PredToCheck=.. [Relacao, Ag, _],
	clause(PredToCheck,_), 
	(
		(
			PredAcao, Resposta=(ato_fala:responder .. mensagem:ok)
		);
		(
			motivos_para_nao_poder(PredAcao, PorqueNao),
			gera_explicacao(PorqueNao, Porque),
			Resposta=(ato_fala:informar
				   ..agente_real:player
				   ..acao:poder 
				   ..positivo:nao 
				   ..pessoa:terc
				   ..tema:(tema_eh_agente_ou_complemento:complemento ..acao:Relacao ..pessoa:indic ..num:sing ..tema_real:T)
				   ..porque:Porque
				  )
		)
	);
	Resposta=(ato_fala:informar
		   ..agente_real:player
		   ..acao:poder 
		   ..positivo:nao 
		   ..pessoa:terc
		   ..tema:(tema_eh_agente_ou_complemento:complemento ..acao:Relacao ..pessoa:indic ..num:sing ..tema_real:T)
		  ).

%%% acao cujo resultado eh descritivo
processar((ato_fala:informar ..agente_real:A .. acao:Relacao .. tema_real:T),
          (ato_fala:descrever ..mensagem:R)):-
        PredAcao =.. [Relacao, A, T, R],
        PredAcao.

processar((ato_fala:terminar),(ato_fala:terminar .. mensagem:tchau)):-
    falando_com(player, Quem),
    retract(falando_com(player, Quem)).

processar((ato_fala:responder ..mensagem:oi),(ato_fala:responder .. mensagem:oi)).
processar((ato_fala:responder ..mensagem:oi ..tema_real:T),(ato_fala:responder .. mensagem:oi)):-
    falando_com(player, T).

% se o processar falhar
processar(_, []).

determina_agente_e_tema_resultantes(TipoNp, [],Paciente,Paciente,np([],TipoNp)):-
	racional(Paciente).

determina_agente_e_tema_resultantes(TipoNp, [],Paciente,np([],TipoNp),Paciente):-
	\+ racional(Paciente).

determina_agente_e_tema_resultantes(TipoNp,TalvezAgente,Paciente,Paciente,TalvezAgente):-
	racional(Paciente),
	entidade(TalvezAgente,TipoNp).

determina_agente_e_tema_resultantes(_,TalvezAgente,Paciente,TalvezAgente,Paciente):-
	racional(TalvezAgente).

determina_agente_e_tema_resultantes(_,Agente,Paciente,Agente,Paciente).

% converte o verbo ter para estar se o alvo eh racional; isso corrige o problema de personagens serem possuidos por coisas
ajuste_acao_ter_estar_em_caso_racional(QuemTemOuEsta, ter, estar):-
    racional(QuemTemOuEsta).
ajuste_acao_ter_estar_em_caso_racional(_, A, A).


ajuste_acao_de_acordo_com_resposta(Alvo, estar,exige_preposicao(estar,com)):-
	racional(Alvo).

ajuste_acao_de_acordo_com_resposta(_, R,R).



% normalizacao    
filtrar(TipoNp,[], np([],TipoNp)).
filtrar(_,X,Y):-
    filtrar(X,Y).
filtrar([X],X):-!.
filtrar(X,X):-!.

determina_agente(comp_nominal(A,B),A):-
	estar(A,B).

determina_agente(comp_nominal(A,B),B):-
	dono(B,A).

determina_agente(comp_nominal(A,B),Quem):-
	ser(comp_nominal(A,B),Quem).
	
determina_agente(A,A).

eh_tema_simples(Ag):-
	\+ Ag=incog(_),
	\+ has_features(Ag).
