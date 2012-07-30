%:-[gulp].

gera_explicacao(PorqueNao, Explicacao):-
	gera_tracos_explicao(PorqueNao, Explicacao),
	normaliza_tracos_explicacao(Explicacao).

gera_tracos_explicao(ja(Pred),(predicado:Acao ..positivo:ja ..agente:Agente ..tema_possivel:Tema)):-
	Pred =..[Acao,Agente,Tema].

gera_tracos_explicao(ja(Pred),(predicado:Acao ..positivo:ja ..agente:Agente ..tema_possivel:_)):-
	Pred =..[Acao,Agente].

gera_tracos_explicao(nao(Pred),(predicado:Acao ..positivo:sim ..agente:Agente ..tema_possivel:Tema)):-
	Pred =..[Acao,Agente,Tema].

gera_tracos_explicao(nao(Pred),(predicado:Acao ..positivo:sim ..agente:Agente ..tema_possivel:_)):-
	Pred =..[Acao,Agente].

gera_tracos_explicao(Pred,(predicado:Acao ..positivo:nao ..agente:Agente ..tema_possivel:Tema)):-
	Pred =..[Acao,Agente,Tema].

gera_tracos_explicao(Pred,(predicado:Acao ..positivo:nao ..agente:Agente ..tema_possivel:_)):-
	Pred =..[Acao,Agente].

normaliza_tracos_explicacao(Normalizado):-
	Normalizado=(predicado:Acao ..acao:Acao ..tema_possivel:Tema ..tema_real:Tema),
	eh_verbo(Acao).

normaliza_tracos_explicacao(Normalizado):-
	Normalizado=(predicado:Predicado ..acao:Acao ..tema_possivel:Tema ..tema_real:Predicado ..complemento_nominal:Tema),
	tipo_adjetivo(Predicado,Acao).

normaliza_tracos_explicacao(Normalizado):-
	Normalizado=(agente:_ ..positivo:_ ..predicado:Predicado ..acao:ser ..tema_possivel:Tema ..tema_real:Predicado ..complemento_nominal:Tema).

%%%%%%%%% daqui para baixo opera sobre listas
gera_explicacao_falhas(Pred,Explicacao):-
	determina_predicados_que_falharam(Pred, Causa), 
	gera_porque_nao(Causa,ExplicacaoDesnormalizada),
	normaliza_explicacao(ExplicacaoDesnormalizada, Explicacao).

gera_porque_nao([],[]).

gera_porque_nao((Pred,RestoPredicados),[Tracos|Resto]):-
	gera_tracos_explicao(Pred,Tracos),
	gera_porque_nao(RestoPredicados,Resto).

normaliza_explicacao([],[]).

normaliza_explicacao([Normalizado|Resto]):-
	normaliza_tracos_explicacao(Normalizado),
	normaliza_explicacao(Resto).

normaliza_explicacao([Normalizado|Resto]):-
	normaliza_tracos_explicacao(Normalizado),
	normaliza_explicacao(Resto).

eh_verbo(Verbo):-
	v(acao:Verbo, _, []).

tipo_adjetivo(Adjetivo,Tipo):-
	a(adj:Adjetivo ..tipo:Tipo,[_],[]).
