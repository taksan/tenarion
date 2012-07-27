%:-[gulp].

gera_explicacao_falhas(Pred,Explicacao):-
	determina_predicados_que_falharam(Pred, Causa), 
	gera_porque_nao(Causa,ExplicacaoDesnormalizada),
	normaliza_explicacao(ExplicacaoDesnormalizada, Explicacao).

gera_porque_nao([],[]).

gera_porque_nao((nao(Pred),RestoPredicados),[(predicado:Acao ..positivo:sim ..agente:Agente ..tema_possivel:Tema)|Resto]):-
	Pred =..[Acao,Agente,Tema],
	gera_porque_nao(RestoPredicados,Resto).

gera_porque_nao((Pred,RestoPredicados),[(predicado:Acao ..positivo:nao ..agente:Agente ..tema_possivel:Tema)|Resto]):-
	Pred =..[Acao,Agente,Tema],
	gera_porque_nao(RestoPredicados,Resto).

gera_porque_nao([nao(Pred)|RestoPredicados], [(predicado:Acao ..positivo:sim ..agente:Agente ..tema_possivel:Tema)|Resto]):-
	Pred =..[Acao,Agente,Tema],
	gera_porque_nao(RestoPredicados,Resto).

gera_porque_nao([Pred|RestoPredicados], [(predicado:Acao ..positivo:nao ..agente:Agente ..tema_possivel:_)|Resto]):-
	Pred =..[Acao,Agente],
	gera_porque_nao(RestoPredicados,Resto).


gera_porque_nao([Pred|RestoPredicados], [(predicado:Acao ..positivo:nao ..agente:Agente ..tema_possivel:Tema)|Resto]):-
	Pred =..[Acao,Agente,Tema],
	gera_porque_nao(RestoPredicados,Resto).

normaliza_explicacao([],[]).

normaliza_explicacao([Normalizado|RestoDesnormalizado],[Normalizado|Resto]):-
	Normalizado=(predicado:Acao ..acao:Acao ..tema_possivel:Tema ..tema_real:Tema),
	eh_verbo(Acao),
	normaliza_explicacao(RestoDesnormalizado, Resto).

normaliza_explicacao([Normalizado|RestoDesnormalizado],[Normalizado|Resto]):-
	Normalizado=(predicado:Predicado ..acao:ser ..tema_possivel:Tema ..tema_real:Predicado ..complemento_nominal:Tema ),
	\+ eh_verbo(Predicado),
	normaliza_explicacao(RestoDesnormalizado, Resto).

eh_verbo(Verbo):-
	v(acao:Verbo, _, []).