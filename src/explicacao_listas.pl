% por eqto, nao eh usado para nada.
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

