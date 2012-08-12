% Predicados auxiliares

:-dynamic(ignore_non_asserts/0).

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

motivos_para_nao_poder(Predicado,Motivos):-
	clause(Predicado, Clausulas),
	verificar_se_pode_asserts(Clausulas,PorqueJaEhVerdade),
	(
			PorqueJaEhVerdade\=[], Motivos=PorqueJaEhVerdade;
			verificar_se_pode(Clausulas,PorqueNao),Motivos=PorqueNao
	).

verificar_se_pode_asserts(Clausulas,PorqueNao):-
	asserta(ignore_non_asserts),
	ignore(verificar_se_pode(Clausulas,PorqueNao)),
	retract(ignore_non_asserts).

verificar_se_pode((Clausula,Outras),PorqueNao):-
	Clausula=poder_especifico(_),
	(
		motivos_para_nao_poder(Clausula,Resultado),
		(
			( Resultado=[], verificar_se_pode(Outras,PorqueNao) );
			transforma_asserts_ja(Resultado,PorqueNao)
		)
	).

verificar_se_pode((Clausula,Outras),PorqueNao):-
	Clausula=sinonimo(PredicadoSinonimo),
	(
		motivos_para_nao_poder(PredicadoSinonimo,Resultado),
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
	UltimaClausula=sinonimo(PredicadoSinonimo),
	(
		motivos_para_nao_poder(PredicadoSinonimo,Resultado),
		(
			Resultado=[];
			transforma_asserts_ja(Resultado,PorqueNao)
		)
	).

verificar_se_pode((UltimaClausula),PorqueNao):-
	(testa_clausula(UltimaClausula),PorqueNao=[]);
	transforma_asserts_ja(UltimaClausula,PorqueNao).

testa_clausula(Clausula):-
	ignore_non_asserts,
	Clausula=..[NomePred|_],
	notrace(\+starts_with(NomePred,assert)),!.

testa_clausula(Clausula):-
	Clausula=..[NomePred,FatoNovo],
	notrace(starts_with(NomePred,assert)),!,
	\+ FatoNovo.

% clausulas que comecam com retract e colateral nao sao testadas para
% evitar que a verificacao altere o estado
testa_clausula(Clausula):-
	Clausula=..[NomePred,_],
	notrace(starts_with(NomePred,retract)),!.

testa_clausula(Clausula):-
	Clausula=..[NomePred|_],
	notrace(starts_with(NomePred,colateral)).

testa_clausula(Clausula):-
	Clausula.

starts_with(String,Prefix):-
	\+compound(String),
	sub_string(String, 0, _,_,Prefix).

transforma_asserts_ja(Pred, ja(Nucleo)):-
	Pred=..[Assert,Nucleo],
	notrace(starts_with(Assert,assert)),!.

transforma_asserts_ja(Pred, Pred).
