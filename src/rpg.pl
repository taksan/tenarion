:-[gulp].
:-[mundo].
:-[lexico].
:-[gramatica].
:-[io].

:-dynamic contexto/2.
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
        write('Bem Vindo ao mundo de Fagageh!'),
        nl,
        write('Qual o seu sexo (F/M/I)? '),
%        readText([Sex|_]),
		Sex='m',
        assert(sexoJogador(Sex)),
        ((Sex = 'm', T='aventureiro'); (T='aventureira')),
        write('Digite seu nome, nobre '),
        write(T), write(': '),
%        readText([Nome|_]),
		Nome='Fulk',
		assert(jogador(Nome)),!,
        dialogo.

dialogo:-
    once(readLine(P)),
%	contexto_pronomial(jogador),
	s(Sem,P,[]),
	once(atualiza_contexto(Sem, [])),!,	
	processar(Sem,Resposta),!,
 %   	contexto_pronomial(computador),
	s(Resposta,R,[]),
	once(atualiza_contexto([], Resposta)),!,
	writeLine(R),
	continuar(Sem).

dialogo:-
	writeLine(['hã', hein, '?']),
	dialogo.

continuar(ato_fala:terminar):-
        falando_com(voce, X),
        retract(falando_com(voce, X)),
        dialogo.

continuar(ato_fala:terminar).

continuar(_):-
	dialogo.

/******* Integracao Semantica *******/

processar([],[]).

processar((ato_fala:int_sim_nao ..agente:A ..acao:Relacao ..tema:T),
          (ato_fala:responder .. mensagem:positivo)):-
		\+ compound(T),
        PredAcao =.. [Relacao, A, T],
        PredAcao.

processar((ato_fala:int_sim_nao ..agente:A ..acao:Relacao ..tema:T),
          (ato_fala:responder .. mensagem:negativo)):-
		\+ compound(T),
        PredAcao =.. [Relacao, A, T],
        \+ PredAcao.

processar((ato_fala:int_sim_nao ..agente:A ..acao:Relacao ..tema:(acao: AcaoAuxiliar ..tema:T)),
          (ato_fala:responder .. mensagem:positivo)):-
	concat_atom([AcaoAuxiliar, '_', Relacao], RelacaoAuxiliar),
        PredAcao =.. [RelacaoAuxiliar, A, T],
        PredAcao.

processar((ato_fala:int_sim_nao ..agente:A ..acao:Relacao ..tema:(acao:AcaoAuxiliar ..tema:T)),
          (ato_fala:responder .. mensagem:negativo)):-
	concat_atom([AcaoAuxiliar, '_', Relacao], RelacaoAuxiliar),
        PredAcao =.. [RelacaoAuxiliar, A, T],
        \+ PredAcao.

% perguntas qu

processar(
	(ato_fala:interro_tema_desconhecido ..indefinido:sim ..agente:indefinido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num)),
	(ato_fala:recusar 
		..indefinido:sim 
		..acao:entender
		..num:sing
		..tema:(acao:ser ..pessoa:terc ..num:Num ..tema:indefinido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num))
		..agente:narrador
		..pessoa:prim
		)):-
	adiciona_termo_a_definir(Texto, np(id:Texto ..tipo:Tipo ..num:Num ..gen:Gen)).

% encontra possibilidades de poder fazer alguma coisa
processar((ato_fala:interro_tema_desconhecido ..agente:Agent ..acao:Relacao ..tema:(acao: AcaoAuxiliar ..tema:T)),
	   (ato_fala:informar .. agente:Agent .. acao:Relacao ..tema:TS ..pessoa:terc)):-
	nonvar(AcaoAuxiliar),
	nonvar(Relacao),
	concat_atom([AcaoAuxiliar, '_', Relacao], RelacaoAuxiliar),
        PredAcao =.. [RelacaoAuxiliar, A, T],
	findall(T, (PredAcao), L),
        ( (\+ L = [], setof(A, member(A,L), L1));  L1 = L),
        filtrar(L1,TS).

processar((ato_fala:interro_tema_desconhecido ..indefinido:nao ..agente:Agent .. acao:Relacao .. tema:incog(_)),
          (ato_fala:informar .. agente:Agent .. acao:Relacao ..tema:TS ..pessoa:terc)):-
	\+ compound(Agent),
	% TODO: o tipo do tema pode ser usado para restringir as respostas
        PredAcao =.. [Relacao, Agent, TemaSolucao],
	findall(TemaSolucao, (PredAcao), L),
        ( (\+ L = [], setof(A, member(A,L), L1));  L1 = L),
        filtrar(L1,TS).

% o que ou quem        

processar((ato_fala:interro_agente_desconhecido ..indefinido:nao ..agente:incog(Tipo) ..acao:Relacao ..tema:T),
   (ato_fala:informar .. agente:AgentesTraduzidos ..acao:RelacaoAjustada .. tema:T ..pessoa:terc ..entidade:Tipo)):-
	ajuste_acao_ter_estar_em_caso_racional(T, Relacao, RelacaoAjustada),!,
        PredAcao =.. [RelacaoAjustada, A, T],
	findall(A, (PredAcao, entidade(A, Tipo)), L),
        ( (\+ L = [], setof(A, member(A,L), L1)) ; L1 = L),
        filtrar(L1,W),
        traduz_agente_para_evitar_ambiguidade(W, AgentesTraduzidos).

processar((ato_fala:informar .. agente:A .. acao:Relacao .. tema:T),
          (ato_fala:responder .. mensagem:ok)):-
	determina_agente(A, Ag),
        PredAcao =.. [Relacao, Ag, T],
        notrace(PredAcao).

processar((ato_fala:informar .. agente:A .. acao:Relacao .. tema:T),
          (ato_fala:recusar .. agente:jogador .. acao:Relacao .. tema:T)):-
	determina_agente(A, Ag),
        PredAcao =.. [Relacao, Ag, T],
        \+ notrace(PredAcao).

%%% acao cujo resultado eh descritivo
processar((ato_fala:informar ..agente:A .. acao:Relacao .. tema:T),
          (ato_fala:descrever ..mensagem:R)):-
        PredAcao =.. [Relacao, A, T, R],
        notrace(PredAcao).

processar((ato_fala:terminar),(ato_fala:terminar .. mensagem:tchau)).

processar((mensagem:oi),(ato_fala:responder .. mensagem:oi)).
processar((mensagem:oi ..tema:T),(ato_fala:responder .. mensagem:oi)):-
	falando_com(voce, T).

% se o processar falhar
processar(_, []):-
        write('Ha algo errado na sua pergunta.'), !.

% converte o verbo ter para estar se o alvo eh racional; isso corrige o problema de personagens serem possuidos por coisas
ajuste_acao_ter_estar_em_caso_racional(QuemTemOuEsta, ter, estar):-
	racional(QuemTemOuEsta).
ajuste_acao_ter_estar_em_caso_racional(_, A, A).

traduz_agente_para_evitar_ambiguidade([],[]).
traduz_agente_para_evitar_ambiguidade(voce, jogador).
traduz_agente_para_evitar_ambiguidade([voce|Resto], [jogador|Resto]).
traduz_agente_para_evitar_ambiguidade([Alguem|Resto], [Alguem|RestoRes]):-
	\+ Alguem = voce,
	traduz_agente_para_evitar_ambiguidade(Resto, RestoRes).

% normalizacao	
filtrar([X],X):-!.
filtrar(X,X):-!.

/* Resolucao e manutencao de contexto */

%% mantem mapeamento para ultimas referencias por genero
contexto((classe:pro ..tipo_pro:voce) , X):-
	falando_com(voce, X).
contexto((classe:advb ..tipo_adv:lugar ..adv:aqui),Lugar):-
	estar(voce, Lugar).	
%contexto((pessoa:terc ..gen:fem ..num:sing), quem).
%contexto((pessoa:terc ..gen:masc ..num:sing), quem).
contexto((classe:np ..pessoa:prim ..num:sing), voce). 

%% atualiza o contexto de acordo com a pergunta e com a resposta
atualiza_pron_voce(vindo_de_pergunta):-
	atualiza_pessoa((classe:pro ..tipo_pro:voce) , voce),
	atualiza_advb_aqui.
	
atualiza_pron_voce(vindo_de_resposta):-
	falando_com(voce, X),
	atualiza_pessoa((classe:pro ..tipo_pro:voce) , X),
	atualiza_advb_aqui.	

atualiza_advb_aqui:-
	contexto((classe:advb ..tipo_adv:relativo ..adv:aqui),_);
	(
		estar(voce, Lugar),
		asserta(contexto((classe:advb ..tipo_adv:lugar ..adv:aqui), Lugar))
	).
	
atualiza_contexto([], []).

atualiza_contexto((agente:incog(_) ..tema:_), []):-
	atualiza_pron_voce(vindo_de_pergunta).        

atualiza_contexto((agente:_ ..tema:incog(onde)), []):-
	atualiza_pron_voce(vindo_de_pergunta),
	contexto((classe:advb ..tipo_adv:lugar ..adv:aqui),Local),
	retractall(contexto(_,Local)).


atualiza_contexto((agente:_ ..tema:incog(_)), []):-
	atualiza_pron_voce(vindo_de_pergunta).

atualiza_contexto((agente:AgPerg ..tema:TemaPerg), []):-
        quem_denota(TracosPessoa1, AgPerg),  atualiza_pessoa(TracosPessoa1, AgPerg),
        quem_denota(TracosPessoa2, TemaPerg), atualiza_pessoa(TracosPessoa2, TemaPerg),
	atualiza_pron_voce(vindo_de_pergunta).        

atualiza_contexto([], (agente:AgResp ..tema:TemaResp)):-
        quem_denota(TracosPessoa3, AgResp),  atualiza_pessoa(TracosPessoa3, AgResp),
        quem_denota(TracosPessoa4, TemaResp), atualiza_pessoa(TracosPessoa4, TemaResp),
	atualiza_pron_voce(vindo_de_resposta).        

atualiza_pessoa(Pessoa, NovoValor):-
        nonvar(NovoValor),
        retractall(contexto(_, NovoValor)),
        retractall(contexto(Pessoa, _)),
        asserta(contexto(Pessoa, NovoValor)).

atualiza_pessoa(_ , _).


%% determinacao do agente baseado no contexto
denota((classe:pro ..tipo_pro:voce), jogador).
denota((tipo_pro:pron_ninguem(quem)), ninguem).
denota((tipo_pro:pron_ninguem(oque)), nada).
denota((tipo_pro:relativo ..pron:onde), onde).
denota((classe:C ..tipo_pro:relativo ..pron:P), Alvo):-
	contexto((classe:C ..tipo_pro:relativo ..pron:P), Alvo).
	
denota((tipo_pro:reto ..num:sing ..pessoa:prim ..gen:G), Ag):-
	\+ denota_lugar(aqui, Ag),
        contexto((num:sing ..pessoa:prim ..gen:G), Ag).
        
denota((classe:C ..tipo_pro:voce), X):-
	contexto((classe:C.. tipo_pro:voce), X).	
	
denota((tipo_pro:reto ..num:sing ..pessoa:prim), voce).
	
denota((tipo_pro:reto ..num:N ..gen:G ..pessoa:terc), X):-
	contexto((num:N ..gen:G ..pessoa:terc), X),!.

denota((tipo_pro:pron_qu ..pron:P), P).


quem_denota((tipo_pro:reto ..num:N ..gen:G ..pessoa:terc), X):-
	\+ compound(X),
	nonvar(X),
        np((num:N ..gen:G), [X], []).

quem_denota(Tracos, Substantivo):-
	denota(Tracos, Substantivo).

%% determinacao do lugar baseado no contexto
denota_lugar(aqui, L):-
	contexto((classe:advb ..tipo_adv:lugar ..adv:aqui), L).

denota_lugar(onde, onde).

denota_lugar(nenhum, []).

adiciona_termo_a_definir(Termo, Definicao).

roda_testes:-
	dado_pergunta_espero_resposta(['o','que','tem','aqui','?'], [o,barco,,,uma,corda,,,algumas,minhocas,,,uma,vara,de,pescar,e,algumas,tabuas,estao,em,o,ancoradouro,.]).

dado_pergunta_espero_resposta(Pergunta,Resposta):-
	s(Sem, Pergunta, []),
	processar(Sem,Resp),
	s(Resp, Resposta, []).

determina_agente((pessoa:indic ..num:sing), voce).
determina_agente(A,A).
