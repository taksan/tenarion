% Predicados auxiliares
determina_predicados_que_falharam(Predicate, Failed):-
	clause(Predicate, R),
	determina_falha(R, Failed).

determina_falha(((A;B),_), [A]):-
	\+ A,
	\+ B.

determina_falha((A,Rest),Failed):-
	A,
	determina_falha(Rest,Failed).

determina_falha((A,Rest),[A|Failed]):-
	\+A,
	determina_falha(Rest,Failed).

determina_falha((Q),[]):-
	Q.
determina_falha((Q),[Q]):-
	\+ Q.

