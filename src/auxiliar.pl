% Predicados auxiliares

%%%% verifica se é possivel executar o predicado, sem causar efeitos colaterais
poder(Predicado):-
	once((clause(Predicado, Clausulas), extrai_poder(Clausulas, PredicadoPoder))),
	PredicadoPoder.

extrai_poder((Clausula,Outras),(FatoNovo,OutrasR)):-
	filtra_clausula(Clausula,FatoNovo),
	extrai_poder(Outras,OutrasR).

extrai_poder((Clausula,Outras),OutrasR):-
	\+ filtra_clausula(Clausula,_),
	extrai_poder(Outras,OutrasR).


extrai_poder((Clausula),FatoNovo):-
	filtra_clausula(Clausula,FatoNovo).

extrai_poder((Clausula),true):-
	\+filtra_clausula(Clausula,_).


filtra_clausula(Clausula, FatoNovo):-
	Clausula=..[Assert,PredInterno],
	starts_with(Assert,assert),!,
	FatoNovo=..[nao, PredInterno].

filtra_clausula(Clausula, true):-
	Clausula=..[Retract,_],
	starts_with(Retract,retract),!,
	fail.

filtra_clausula(Clausula,Clausula).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

motivos_para_nao_poder(Predicado,PorqueNao):-
	clause(Predicado, Clausulas),
	verificar_se_pode(Clausulas,PorqueNao).

verificar_se_pode((Clausula,Outras),PorqueNao):-
	Clausula=poder_especifico(_),
	(
		motivos_para_nao_poder(Clausula,Resultado),
		(
			( Resultado=[], verificar_se_pode(Outras,PorqueNao) );
			transforma_asserts_ja(Resultado,PorqueNao)
		)
	).

verificar_se_pode(((A;B),Outras),PorqueNao):-
	((testa_clausula(A); testa_clausula(B)), verificar_se_pode(Outras,PorqueNao));
	transforma_asserts_ja(A,PorqueNao).

verificar_se_pode((Clausula,Outras),PorqueNao):-
	(testa_clausula(Clausula), verificar_se_pode(Outras,PorqueNao));
	transforma_asserts_ja(Clausula,PorqueNao).

verificar_se_pode((UltimaClausula),PorqueNao):-
	(testa_clausula(UltimaClausula),PorqueNao=[]);
	transforma_asserts_ja(UltimaClausula,PorqueNao).

testa_clausula(Clausula):-
	Clausula=..[Assert,FatoNovo],
	notrace(starts_with(Assert,assert)),!,
	\+ FatoNovo.

testa_clausula(Clausula):-
	Clausula=..[Assert,_],
	notrace(starts_with(Assert,retract)),!.

testa_clausula(Clausula):-
	Clausula.

starts_with(String,Prefix):-
	\+compound(String),
	sub_string(String, 0, _,_,Prefix).

transforma_asserts_ja(Pred, ja(Nucleo)):-
	Pred=..[Assert,Nucleo],
	notrace(starts_with(Assert,assert)),!.

transforma_asserts_ja(Pred, Pred).

