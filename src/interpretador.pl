:-[mundo].
:-[lexico].
:-[gramatica].
:-[contexto].
:-[poder].
:-[explicacao].

/******* Integracao Semantica *******/

% se em qualquer sentenca o usuario fornceu um "agente" que eh um substantivo desconhecido,
% este caso sera processado nessa regra
processar(
    (desconhecido:sim 
	 ..agente_real:desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num)),
	Resposta):-
	resposta_para_substantivo_desconhecido(
		desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num),
		Resposta).
/*
processar(
    (desconhecido:sim 
	 ..tema_real:desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num)),
	Resposta):-
	nonvar(Texto),
	resposta_para_substantivo_desconhecido(
		desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num),
		Resposta).
*/
processar(
    (desconhecido:sim 
	 ..tema_real:subtema:desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num)),
	Resposta):-
	nonvar(Texto),
	resposta_para_substantivo_desconhecido(
		desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num),
		Resposta).

processar((agente_real:IdPessoa ..agente:IdPessoa ..gen:G ..num:N), Resposta):-
	resposta_para_pessoa_desconhecida(IdPessoa,G,N,Resposta).

processar((tema_real:IdPessoa ..tema:IdPessoa ..gen:G ..num:N), Resposta):-
	resposta_para_pessoa_desconhecida(IdPessoa,G,N,Resposta).

% processamento de dialogo de verdade
processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema_real:T),
          RespostaTracos):-
        eh_tema_simples(T),
        PredAcao =.. [Relacao, A, T],
		interpretacao_do_interlocutor(PredAcao,PredContextualizado),
		(
        	(PredContextualizado,Resposta=positivo);
			Resposta=negativo
		),
		resposta_do_interlocutor(
			PredContextualizado,
			(ato_fala:responder .. mensagem:Resposta),
			RespostaTracos)
		.

% processar perguntas do tipo "eu posso pegar X?"
processar((ato_fala:int_sim_nao 
			..agente_real:A 
			..acao:Relacao 
			..tema:(acao: AcaoAuxiliar ..tema_real:T ..desconhecido:nao)),
          (ato_fala:responder .. mensagem:Resposta)):-
    PredAcaoAuxiliar =.. [AcaoAuxiliar, A, T],
	PredAcao =..[Relacao, PredAcaoAuxiliar],

	interpretacao_do_interlocutor(PredAcao,PredContextualizado),
	(
        	(PredContextualizado,Resposta=positivo);
			Resposta=negativo
	),
	resposta_do_interlocutor(
		PredContextualizado,
		(ato_fala:responder .. mensagem:Resposta),
		RespostaTracos).

% processa perguntas do tipo "o que eu posso ... ou onde eu posso ir"
processar((ato_fala:interro_tema_incognito
           ..acao:Relacao
           ..agente_real:Agente
           ..tema: Tema        
		   ),
        (ato_fala:informar 
			..agente_real:Agente 
			..acao:Relacao 
			..pessoa:terc
            ..tema:Resposta)
        ):-
	Tema=(tema_real:incog(TipoNp).. subtema: (acao:AcaoAlvo) ..acao_aux:Relacao),

	resposta_para_tema_incognito(AcaoAlvo, Agente, Tema, TipoNp, Resposta),
	% adiciona tracos necessarios para resposta ficar correta
	Resposta=(tema_eh_agente_ou_complemento:complemento ..pessoa:indic).

processar((ato_fala:interro_tema_incognito 
			..desconhecido:nao 
			..agente_real:Agente 
			..acao:Relacao 
			..tema_real:incog(TipoNp)),
		  Resposta):-
	
	resposta_para_tema_incognito(Relacao, Agente, incog(TipoNp), TipoNp, Resposta).
	
processar((ato_fala:interro_agente_incognito 
			..desconhecido:nao 
			..agente_real:incog(TipoNp) 
			..acao:Relacao 
			..tema_real:Tema),
			Resposta):-
	resposta_para_tema_incognito( Relacao, incog(TipoNp), Tema, TipoNp, Resposta).
	
processar((ato_fala:informar .. agente_real:Ag .. acao:Relacao .. tema_real:T),
          Resposta):-
	determina_entidade_referenciada(T,PacienteDeterminado),
    PredAcao =.. [Relacao, Ag, PacienteDeterminado],
	existe_predicado(Relacao),
	(
		(
			interpretacao_do_interlocutor(PredAcao,PredContextualizado),
			PredContextualizado, 
			resposta_do_interlocutor(
				PredContextualizado,
				(ato_fala:responder .. mensagem:ok),%default
				Resposta)
		);
		(
			motivos_para_nao_poder(PredAcao, PorqueNao),
			gera_explicacao(PorqueNao, Porque),
			Resposta=(ato_fala:informar
				   ..agente_real:player
				   ..acao:poder 
				   ..positivo:nao 
				   ..pessoa:terc
				   ..tema:(tema_eh_agente_ou_complemento:complemento 
				   			..acao:Relacao 
							..pessoa:indic 
							..num:sing 
							..tema_real:T)
				   ..porque:Porque
				  )
		)
	);
	Resposta=(ato_fala:informar
		   ..agente_real:player
		   ..acao:poder 
		   ..positivo:nao 
		   ..pessoa:terc
		   ..tema:(tema_eh_agente_ou_complemento:complemento 
		   			..acao:Relacao 
					..pessoa:indic 
					..num:sing 
					..tema_real:T)
		  ).

processar((ato_fala:terminar),(ato_fala:terminar .. mensagem:tchau)):-
    falando_com(player, Quem),
    retract(falando_com(player, Quem)),
	ignore((Quem\=narrador,assert(falando_com(player,narrador)))).
processar((ato_fala:terminar),(ato_fala:terminar .. mensagem:tchau)):-
	falando_com(player,narrador),
	halt.

processar((ato_fala:responder ..mensagem:oi),(ato_fala:responder ..mensagem:oi)).

processar((ato_fala:responder ..mensagem:oi ..tema_real:T),(ato_fala:responder .. mensagem:oi)):-
    falando_com(player, T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

resposta_para_substantivo_desconhecido(
	desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num),
	(ato_fala:recusar 
        ..desconhecido:sim 
        ..acao:saber
        ..num:sing
        ..tema:(acao:ser ..pessoa:terc ..num:Num 
			..tema_real:desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num))
        ..agente:eu
        ..pessoa:prim
        )):-
    adiciona_termo_a_definir(Texto, np(id:Texto ..tipo:Tipo ..num:Num ..gen:Gen)).

resposta_para_pessoa_desconhecida(IdPessoa,G,N,
	(ato_fala:interro_agente_incognito
		..agente:incog(quem)
		..tema:IdPessoa
		..verbo:ser
		..pessoa:terc
		..gen:G
		..num:N
	)):-
	racional(IdPessoa),
	determina_entidade_referenciada(IdPessoa,Determinado),!,
	Determinado\=player,
	\+conhecer(player,Determinado).

resposta_para_tema_incognito(
				Relacao,
				Agente,
				Tema,
				TipoNp,
				RespostaFinal
				):-

	RespostaDefault=(ato_fala:informar 
				..agente_real:AgenteResolvido
				..acao:RelacaoResolvida 
				..tema_real:TemaResolvido
				..positivo:IsPositivo),

	determina_entidade_referenciada(Agente,AgenteDeterminado),
	determina_entidade_referenciada(Tema,TemaDeterminado),

	monta_predicado_para_resolucao(Relacao,AgenteDeterminado,TemaDeterminado,Incognita,PredAcao),
	(	
		(
			existe_predicado(PredAcao),
			interpretacao_do_interlocutor(PredAcao,PredContextualizado),
			findall(Incognita, (PredContextualizado,entidade(Incognita,TipoNp)), L),
			( (\+ L = [], setof(A, member(A,L), L1));  L1 = L),
			normaliza_substantivos_resposta(TipoNp, L1,ElementosResultantes),
			elementos_resposta(Relacao,
								Agente,
								Tema,
								ElementosResultantes,
								AgenteResolvido,
								TemaResolvido,
								RelacaoResolvida,
								IsPositivo),
			resposta_do_interlocutor(PredContextualizado,RespostaDefault,RespostaFinal)
		);
		(
			AgenteResolvido=Agente,
			normaliza_substantivos_resposta(TipoNp, [], TemaResolvido),
			RelacaoResolvida=Relacao,
			RespostaFinal=RespostaDefault
		)
	).

resposta_do_interlocutor(zulu(ser(A,B)),(ato_fala:responder),(ato_fala:responder..mensagem:oi ..tema:Quem)):-
	member(player,[A,B]),
	jogador(Quem).

resposta_do_interlocutor(zulu(ser(Quem,B)),RespostaDada,RespostaNova):-
	var(Quem),nonvar(B),B=zulu,
	\+conhecer(zulu,player),
	RespostaDada=(ato_fala:informar ..ligacao:'.'),
	PerguntaResposta=(ato_fala:interro_agente_incognito ..acao:ser ..pessoa:terc ..tema:voce ..agente:incog(quem)),
	RespostaNova=(ato_fala:composto ..composicao:[RespostaDada, PerguntaResposta]).

resposta_do_interlocutor(Predicate,_,Resposta):-
	clause(Predicate, Clauses),
	encontra_evento(Clauses, Resposta),
	Resposta\=[].

resposta_do_interlocutor(_,Default,Default).

encontra_evento((),[]).

encontra_evento((evento(Resposta)),Resposta).
encontra_evento((evento(Resposta),_),Resposta).

encontra_evento((_,Resto),Resposta):-
	encontra_evento(Resto,Resposta).


interpretacao_do_interlocutor(Pred,PredContextualizado):-
	falando_com(player,Quem),
	existe_predicado(Quem),
	PredContextualizado=..[Quem,Pred].

interpretacao_do_interlocutor(Pred,Pred).


monta_predicado_para_resolucao(
	Acao,
	Agente,
	incog((quanto,Substantivo)),
	Incognita,
	Predicado):-
	Predicado=quanto(Agente,Acao,Substantivo,Incognita).

monta_predicado_para_resolucao(
	adj_advb(Acao,tipo:verbal ..prep:para ..verbo:Predicativo),
	Agente,
	incog(_),
	Incognita,
	Predicado
	):-
	nonvar(Acao),
	PredAdvb=..[Predicativo, Agente, Incognita],
	Predicado=..[Acao, Agente, PredAdvb].

monta_predicado_para_resolucao(AcaoAlvo,
				Agente,
                (tema_real:incog(_).. subtema: (acao:AcaoAlvo) ..acao_aux:Relacao),
				Incognita,
				Predicado):-
	PredAcaoAuxiliar =..[AcaoAlvo, Agente, Incognita],
    Predicado =.. [Relacao, PredAcaoAuxiliar].

%monta_predicado_para_resolucao(Relacao,incog(quanto),Tema,Incognita,Predicado):-
%   Predicado =.. [Relacao, Tema, Incognita].


monta_predicado_para_resolucao(Relacao,Agente,incog(_),Incognita,Predicado):-
    Predicado =.. [Relacao, Agente, Incognita].

monta_predicado_para_resolucao(Relacao,incog(_),Tema,Incognita,Predicado):-
    Predicado =.. [Relacao, Incognita, Tema].

% caso especifico de "quem" vazio, vira eu nao sei
elementos_resposta(ser,incog(quem),_,np([],_),Interlocutor,[],saber,nao):-
	falando_com(player,Interlocutor).
elementos_resposta(ser,_,incog(quem),np([],_),Interlocutor,[],saber,nao):-
	falando_com(player,Interlocutor).

% outro caso de uso de pronome, mas dessa vez possessivo
elementos_resposta(ser,incog(qual),TemaRes,Resposta,TemaRes,Resposta,ser,_):-
	TemaRes=comp_nominal(seu,_).

elementos_resposta(ser,incog(qual),TemaRes,np([],qual),TemaRes,np([],qual),ser,_).

% se for usar pronome, prefere colocar o pronome como agente
elementos_resposta(ser,incog(quem),TemaRes,Resposta,TemaRes,Resposta,ser,sim):-
	institui_pronome(TemaRes,TemaRef),
	TemaRes\=TemaRef.

elementos_resposta(Relacao,Agente,incog(oque),RespostaListaBiTransitivos,Agente,Resposta,Relacao,_):-
	nonvar(RespostaListaBiTransitivos), is_list(RespostaListaBiTransitivos),
	RespostaListaBiTransitivos=[Primeiro|_],
	has_features(Primeiro),
	obtem_sets_tema1_tema2(RespostaListaBiTransitivos,Resposta,_).

elementos_resposta(Relacao,incog(TipoNp),PacienteViraAgente,RespostaViraPaciente,PacienteViraAgente,RespostaViraPaciente,Relacao,_):-
	member(TipoNp,[quanto,qual]).

elementos_resposta(Acao,incog(TipoNp),TemaRes,Resposta,Resposta,TemaRes,AcaoRes,_):-
	nonvar(TipoNp),
	ajuste_acao_de_acordo_com_resposta(TemaRes,Acao,AcaoRes).

elementos_resposta(Acao,AgenteRes,incog(TipoNp),Resposta,AgenteRes,Resposta,AcaoRes,_):-
	nonvar(TipoNp),
	ajuste_acao_de_acordo_com_resposta(Resposta,Acao,AcaoRes).

elementos_resposta(_,Agente,TemaOriginal,Resposta, Agente,Resposta,AcaoAlvo,_):-
	TemaOriginal=(tema_real:incog(_).. subtema: (acao:AcaoAlvo)).

ajuste_acao_de_acordo_com_resposta(Alvo, estar,exige_preposicao(estar,com)):-
	racional(Alvo).

ajuste_acao_de_acordo_com_resposta(_, R,R).

obtem_sets_tema1_tema2(B,Temas1,Temas2):-
	separa_tema1_tema2(B,T1,T2),	
	list_to_set(T1,Temas1),
	list_to_set(T2,Temas2).

separa_tema1_tema2([],[],[]).
separa_tema1_tema2([tema1:T1..tema2:T2|BTail],[T1|T1Tail],[T2|T2Tail]):-
	separa_tema1_tema2(BTail,T1Tail,T2Tail).

% normalizacao    
normaliza_substantivos_resposta(TipoNp,[], np([],TipoNp)).
normaliza_substantivos_resposta(_,X,Y):-
    normaliza_substantivos_resposta(X,Y).

normaliza_substantivos_resposta([],[]).

normaliza_substantivos_resposta([X],Y):-
	referencia(X,Y).

normaliza_substantivos_resposta(X,Y):-
	\+is_list(X),
	referencia(X,Y).

normaliza_substantivos_resposta([X,Z],[Y,W]):-
	referencia(X,Y),
	referencia(Z,W).

normaliza_substantivos_resposta([X|Resto],[Y|RestoFilrado]):-
	referencia(X,Y),
	normaliza_substantivos_resposta(Resto,RestoFilrado).

referencia([],[]).
referencia(X,X):-
	pro(pron:X,_,[]).

referencia(player,player).
referencia(Q,Q):-
	jogador(Q).

referencia(X,Y):-
	racional(X),
	\+conhecer(player,X),
	(
		descreve(X,Y);
		(np(id:X ..gen:masc,[_],[]),Y=homem);
		Y=mulher
	).
referencia(X,X).

determina_entidade_referenciada(A,A):-
	var(A).

determina_entidade_referenciada(comp_nominal(A,B),A):-
	estar(A,B).

determina_entidade_referenciada(comp_nominal(A,B),B):-
	dono(B,A).

determina_entidade_referenciada(comp_nominal(A,B),Quem):-
	ser(comp_nominal(A,B),Quem).

determina_entidade_referenciada(A,B):-
	\+compound(A),
	estar(player,Aqui),
	estar(B,Aqui),
	ser(A,B).

determina_entidade_referenciada(A,B):-
	\+compound(A),
	estar(player,Aqui),
	estar(B,Aqui),
	ser(comp_nominal(A,_),B).

determina_entidade_referenciada(A,A).

eh_tema_simples(Ag):-
	\+ Ag=incog(_),
	\+ has_features(Ag).


existe_predicado(Predicado):-
	Predicado=..[Pred|Terms], 
	length(Terms,TermsLen),
	current_predicate(Pred/TermsLen).

existe_predicado(Pred):-
	\+compound(Pred),
	current_predicate(Pred/_).


nadadica:-
	1=1.
