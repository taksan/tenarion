%:-[gulp].

gera_explicacao(PorqueNao, Explicacao):-
	gera_tracos_explicao(PorqueNao, Explicacao),
	normaliza_tracos_explicacao(Explicacao).

gera_tracos_explicao(ja(Pred),(predicado:Acao ..positivo:ja ..agente_real:Agente ..tema_possivel:Tema)):-
	Pred =..[Acao,Agente,Tema].

gera_tracos_explicao(ja(Pred),(predicado:Acao ..positivo:ja ..agente_real:Agente ..tema_possivel:_)):-
	Pred =..[Acao,Agente].

gera_tracos_explicao(nao(Pred),(predicado:Acao ..positivo:sim ..agente_real:Agente ..tema_possivel:Tema)):-
	Pred =..[Acao,Agente,Tema].

gera_tracos_explicao(nao(Pred),(predicado:Acao ..positivo:sim ..agente_real:Agente ..tema_possivel:_)):-
	Pred =..[Acao,Agente].

gera_tracos_explicao(Pred,(predicado:Acao ..positivo:nao ..agente_real:Agente ..tema_possivel:Tema)):-
	Pred =..[Acao,Agente,Tema].

gera_tracos_explicao(Pred,(predicado:Acao ..positivo:nao ..agente_real:Agente ..tema_possivel:_)):-
	Pred =..[Acao,Agente].

normaliza_tracos_explicacao(Normalizado):-
	Normalizado=(predicado:Acao ..acao:Acao ..tema_possivel:Tema ..tema_real:Tema),
	eh_verbo(Acao).

normaliza_tracos_explicacao(Normalizado):-
	Normalizado=(predicado:Predicado ..acao:locucao(Acao,Predicado) ..tema_possivel:Tema ..tema_real:Tema),
	verbo_da_locucao(Predicado,Acao).

normaliza_tracos_explicacao(Normalizado):-
	Normalizado=(predicado:Predicado ..acao:Acao ..tema_real:Predicado),
	tipo_adjetivo(Predicado,Acao).

normaliza_tracos_explicacao(Normalizado):-
	Normalizado=(predicado:Predicado ..tema_possivel:Tema ..tema_real:comp_nominal(Predicado,Tema)),
	% verifica se faz sentido combinar num compl. nominal
	ser(comp_nominal(Predicado,Tema),_).

normaliza_tracos_explicacao(Normalizado):-
	Normalizado=(agente_real:_ ..positivo:_ ..predicado:Predicado ..acao:ser ..tema_possivel:_ ..tema_real:Predicado).

eh_verbo(Verbo):-
	v(acao:Verbo, _, []).

verbo_da_locucao(Locucao,Verbo):-
	loc(id:Locucao ..verbo:Verbo,[_],[]).

tipo_adjetivo(Adjetivo,Verbo):-
	a(adj:Adjetivo ..tipo:Verbo,[_],[]).
