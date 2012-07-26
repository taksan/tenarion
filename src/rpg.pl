:-[gulp].
:-[mundo].
:-[lexico].
:-[gramatica].
:-[io].
:-[auxiliar].

:-dynamic contexto/3, contexto_atual/1.
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

seta_contexto(Ctx):-
    retractall(contexto_atual(_)),
    assertz(contexto_atual(Ctx)).

dialogo:-
    once(readLine(P)),
    seta_contexto(jogador),
    s(Sem,P,[]),
    dereferencia_pronomes_na_sentenca(Sem),
    seta_contexto(computador),
    once(atualiza_contexto(Sem)),!,
        
    processar(Sem,Resposta),!,

	referencia_com_pronomes_na_sentenca(Resposta),
    s(Resposta,R,[]),
    seta_contexto(jogador),
    once(atualiza_contexto(Resposta)),
    
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

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema_real:T),
          (ato_fala:responder .. mensagem:positivo)):-
        \+ compound(T),
        PredAcao =.. [Relacao, A, T],
        PredAcao.

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema_real:T),
          (ato_fala:responder .. mensagem:negativo)):-
        \+ compound(T),
        PredAcao =.. [Relacao, A, T],
        \+ PredAcao.

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema:(acao: AcaoAuxiliar ..tema:T)),
          (ato_fala:responder .. mensagem:positivo)):-
    concat_atom([Relacao, '_', AcaoAuxiliar], RelacaoAuxiliar),
    PredAcao =.. [RelacaoAuxiliar, A, T],
    PredAcao.

processar((ato_fala:int_sim_nao ..agente_real:A ..acao:Relacao ..tema:(acao:AcaoAuxiliar ..tema:T)),
          (ato_fala:responder .. mensagem:negativo)):-
    concat_atom([Relacao, '_', AcaoAuxiliar], RelacaoAuxiliar),
    PredAcao =.. [RelacaoAuxiliar, A, T],
    \+ PredAcao.

% perguntas qu

processar(
    (ato_fala:interro_tema_desconhecido ..desconhecido:sim ..agente_real:desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num)),
    (ato_fala:recusar 
        ..desconhecido:sim 
        ..acao:saber
        ..num:sing
        ..tema:(acao:ser ..pessoa:terc ..num:Num ..tema:desconhecido(texto:Texto ..tipo:Tipo ..gen:Gen ..num:Num))
        ..agente:narrador
        ..pessoa:prim
        )):-
    adiciona_termo_a_definir(Texto, np(id:Texto ..tipo:Tipo ..num:Num ..gen:Gen)).

% encontra possibilidades de poder fazer alguma coisa
processar((ato_fala:interro_tema_desconhecido
           ..acao:Relacao
           ..agente_real:Agent
           ..tema: (
                tema:incog(TipoNp)..%oque,quem,onde
                subtema: (num:_ ..pessoa:PX ..subcat:_ ..acao:AcaoAlvo)
				)
        ),
        (ato_fala:informar 
			..agente_real:Agent 
			..acao:Relacao 
			..pessoa:terc
            ..tema:(acao:AcaoAlvo ..tema:TS ..pessoa:PX))
        ):-
    nonvar(Relacao),
    nonvar(AcaoAlvo),
    concat_atom([Relacao, '_', AcaoAlvo], RelacaoAuxiliar),
    PredAcao =.. [RelacaoAuxiliar, Agent, T],
    findall(T, (PredAcao), L),
    ( (\+ L = [], setof(A, member(A,L), L1));  L1 = L),
    filtrar(TipoNp, L1,TS).

processar((ato_fala:interro_tema_desconhecido ..desconhecido:nao ..agente_real:Agent .. acao:Relacao .. tema:incog(TipoNp)),
          (ato_fala:informar .. agente_real:Agent .. acao:Relacao ..tema_real:TS ..pessoa:terc)):-
    \+ compound(Agent),
    % TODO: o tipo do tema pode ser usado para restringir as respostas
    PredAcao =.. [Relacao, Agent, TemaSolucao],
    findall(TemaSolucao, (PredAcao), L),
    ( (\+ L = [], setof(A, member(A,L), L1));  L1 = L),
    filtrar(TipoNp, L1,TS).

% o que ou quem        

processar((ato_fala:interro_agente_desconhecido ..desconhecido:nao ..agente_real:incog(Tipo) ..acao:Relacao ..tema_real:T),
   (ato_fala:informar .. agente_real:AgentesTraduzidos ..acao:RelacaoAjustada .. tema_real:T ..pessoa:terc ..entidade:Tipo)):-
    ajuste_acao_ter_estar_em_caso_racional(T, Relacao, RelacaoAjustada),!,
    PredAcao =.. [RelacaoAjustada, A, T],
    findall(A, (PredAcao, entidade(A, Tipo)), L),
    ( (\+ L = [], setof(A, member(A,L), L1)) ; L1 = L),
    filtrar(Tipo,L1,W),
    traduz_agente_para_evitar_ambiguidade(W, AgentesTraduzidos).

processar((ato_fala:informar .. agente_real:A .. acao:Relacao .. tema_real:T),
          (ato_fala:responder .. mensagem:ok)):-
    determina_agente(A, Ag),
    PredAcao =.. [Relacao, Ag, T],
    notrace(PredAcao).

processar((ato_fala:informar .. agente_real:A .. acao:Relacao .. tema_real:T),
          (ato_fala:informar
           ..agente_real:voce
           ..acao:poder 
           ..positivo:nao 
           ..pessoa:terc
           ..tema:(tema_eh_agente_ou_complemento:complemento ..acao:Relacao ..pessoa:indic ..num:sing ..tema:T)
		   ..porque:Porque
          )):-
    determina_agente(A, Ag),
    PredAcao =.. [Relacao, Ag, T],
    \+ notrace(PredAcao),
	concat_atom([poder_,Relacao], PoderRelacao),
	PredPoder=..[PoderRelacao, Ag, T],
	gera_explicacao_falhas(PredPoder, Porque).

%%% acao cujo resultado eh descritivo
processar((ato_fala:informar ..agente_real:A .. acao:Relacao .. tema_real:T),
          (ato_fala:descrever ..mensagem:R)):-
        PredAcao =.. [Relacao, A, T, R],
        notrace(PredAcao).

processar((ato_fala:terminar),(ato_fala:terminar .. mensagem:tchau)).

processar((ato_fala:responder ..mensagem:oi),(ato_fala:responder .. mensagem:oi)).
processar((ato_fala:responder ..mensagem:oi ..tema_real:T),(ato_fala:responder .. mensagem:oi)):-
    falando_com(voce, T).

% se o processar falhar
processar(_, []):-
        write('Ha algo errado na sua pergunta.'), !.

% converte o verbo ter para estar se o alvo eh racional; isso corrige o problema de personagens serem possuidos por coisas
%ajuste_acao_ter_estar_em_caso_racional(QuemTemOuEsta, ter, estar):-
%    racional(QuemTemOuEsta).
ajuste_acao_ter_estar_em_caso_racional(_, A, A).

traduz_agente_para_evitar_ambiguidade([],[]).
traduz_agente_para_evitar_ambiguidade(voce, voce).
traduz_agente_para_evitar_ambiguidade(A,A):-
    \+ is_list(A).
traduz_agente_para_evitar_ambiguidade([voce|Resto], [voce|Resto]).
traduz_agente_para_evitar_ambiguidade([Alguem|Resto], [Alguem|RestoRes]):-
    \+ Alguem = voce,
    traduz_agente_para_evitar_ambiguidade(Resto, RestoRes).

% normalizacao    
filtrar(TipoNp,[], np([],TipoNp)).
filtrar(_,X,Y):-
    filtrar(X,Y).
filtrar([X],X):-!.
filtrar(X,X):-!.

/* Resolucao e manutencao de contexto */
%contexto_atual(jogador).

%% mantem mapeamento para ultimas referencias por genero
% aqui eh igual para o computador e para o jogador

    
contexto(jogador, (tipo_pro:voce ..num:sing ..pessoa:terc ..pron:voce) , X):-
    falando_com(voce, X).
    
% qdo o jogador usa pronome "eu"
contexto(jogador, (tipo_pro:reto ..pessoa:prim ..num:sing), voce).% 

contexto(jogador, (tipo_pro:advb ..tipo_adv:lugar ..adv:aqui), Lugar):-
    estar(voce, Lugar).        

% contexto do computador
contexto(computador,(tipo_pro:voce ..num:sing ..pessoa:terc ..pron:voce),voce).
contexto(computador,(tipo_pro:voce ..num:sing ..pessoa:terc ..pron:voce),jogador).
    
contexto(computador, (tipo_pro:advb ..tipo_adv:lugar ..adv:aqui), Lugar):-
    estar(voce, Lugar).        
    

%% atualiza o contexto de acordo com a pergunta e com a resposta
atualiza_advb_aqui:-
    (
        contexto_atual(Ctx),
        estar(voce, Lugar),
        \+contexto(Ctx, (tipo_adv:lugar ..adv:aqui), Lugar),
        asserta(contexto(Ctx, (tipo_pro:advb ..tipo_adv:lugar ..adv:aqui), Lugar))
    ).
atualiza_advb_aqui:-
    true.
    
atualiza_contexto((agente:AgResp ..tema_real:TemaResp)):-
    atualiza_advb_aqui,
    atualiza_contexto_denotado_por(TemaResp),
    atualiza_contexto_denotado_por(AgResp).
    % o agente eh usado por segundo para preferir usar o pronome para designar o agente

atualiza_contexto_denotado_por([]).

% se o jogador perguntou onde estah,remove _aqui_ do contexto
atualiza_contexto_denotado_por(incog(onde)):-
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:advb ..tipo_adv:lugar ..adv:aqui),Local),
    retractall(contexto(Ctx,_,Local)).

atualiza_contexto_denotado_por(TemaOuAgente):-
    \+ is_list(TemaOuAgente),
    quem_denota(Tracos , TemaOuAgente),  
    atualiza_pessoa(Tracos , TemaOuAgente).

atualiza_contexto_denotado_por([jogador|Resto]):-
    atualiza_contexto_denotado_por(Resto).

atualiza_contexto_denotado_por([TemaOuAgente|Resto]):-
    atualiza_contexto_denotado_por(TemaOuAgente),
    atualiza_contexto_denotado_por(Resto).

atualiza_contexto_denotado_por(_).
    
atualiza_pessoa((tipo_pro:voce),_).
atualiza_pessoa(_,voce).
    
atualiza_pessoa(Pessoa, NovoValor):-
    nonvar(NovoValor),
    nonvar(Pessoa),
    contexto_atual(Ctx),
    retractall(contexto(Ctx, Pessoa, _)),
    asserta(contexto(Ctx, Pessoa, NovoValor)).

atualiza_pessoa(_ , _).


% DENOTA EH SEMPRE USADO PARA DETERMINAR O USO DE PRONOME
%% determinacao do agente baseado no contexto
valida_locutor(Ag):-
    falando_com(voce, Interlocutor),
    member(Ag, [voce,Interlocutor]).

%denota((tipo_pro:voce), jogador).
denota((tipo_pro:pron_ninguem(quem)), ninguem).
denota((tipo_pro:pron_ninguem(oque)), nada).
denota((tipo_pro:relativo ..pron:onde), onde).
    
% vai determinar se o Ag vai usar o pronome "eu" para se designar.
denota((tipo_pro:reto ..num:sing ..pessoa:prim ..gen:G), Ag):-
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:reto.. num:sing ..pessoa:prim ..gen:G), Ag),
    valida_locutor(Ag).
        
% vai determinar quem o pronome designa OU qual pronome designa Quem
denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem):-
    nonvar(Quem),
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem),
    % se acabou de determinar o pronome para Quem, evita que seja usado de novo
    % consecutivamente na mesma sentenca, solucionado o problema de responder "o que ela eh?"
    retract(contexto(Ctx,(tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem)).

denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem):-
    var(Quem),
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem).

    
denota((tipo_pro:relativo ..pron:Pron), P):-
    nonvar(Pron),
    P=Pron.

% para aceitar o pronome prp.dito
denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem):-
    pro((tipo_pro:T ..gen:G ..num:N ..pessoa:P ..pron:Pron),[Quem],[]).
    
quem_denota((tipo_pro:reto ..num:N ..gen:G ..pessoa:terc), X):-
    \+ compound(X), 
    nonvar(X),
    np((id:X ..num:N ..gen:G ..desconhecido:nao), Texto, []),
    nonvar(Texto).

quem_denota((tipo_pro:reto ..num:N ..gen:G ..pessoa:terc ..desconhecido:sim), X):-
    \+ compound(X), 
    nonvar(X),
    np((num:N ..gen:G ..desconhecido:sim), [X], []).

%% determinacao do lugar baseado no contexto
denota_lugar(aqui, L):-
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:advb ..tipo_adv:lugar ..adv:aqui), L).

denota_lugar(nenhum, []).

adiciona_termo_a_definir(Termo, Definicao).

roda_testes:-
    cleanup_player,
    assert(jogador('foo')),
    dado_pergunta_espero_resposta(['o','que','tem','aqui','?'], [o,barco,,,uma,corda,,,algumas,minhocas,,,uma,vara,de,pescar,e,algumas,tabuas,estao,em,o,ancoradouro,.]).

dado_pergunta_espero_resposta(Pergunta,Resposta):-
    seta_contexto(jogador),
    s(Sem, Pergunta, []),
    seta_contexto(computador),
    once(atualiza_contexto(Sem)),!,
    processar(Sem,Resp),
    s(Resp, Resposta, []),
    seta_contexto(jogador),
    once(atualiza_contexto(Resposta)).

determina_agente((pessoa:indic ..num:sing), voce).
determina_agente(A,A).

gera_explicacao_falhas(Pred,Explicacao):-
	determina_predicados_que_falharam(Pred, Causa), gera_porque_nao(Causa,ExplicacaoDesnormalizada),
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

gera_porque_nao([Pred|RestoPredicados], [(predicado:Acao ..positivo:nao ..agente:Agente ..tema_possivel:Tema)|Resto]):-
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

dereferencia_pronomes_na_sentenca(tema:TemaTalvezPronome ..tema_real:TemaTraduzido ..agente:AgenteTalvezPronome ..agente_real:AgenteTraduzido):-
	dereferencia_pronome(TemaTalvezPronome,TemaTraduzido),
	dereferencia_pronome(AgenteTalvezPronome,AgenteTraduzido).

dereferencia_pronome(TalvezPronome, Traduzido):-
	\+ compound(TalvezPronome),
	pro((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TalvezPronome),_,[]),
	denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TalvezPronome), Traduzido).

dereferencia_pronome(NaoPronome, NaoPronome).

referencia_com_pronomes_na_sentenca(tema_real:TemaReal ..tema:TemaReferenciado ..agente_real:AgenteReal ..agente:AgenteReferenciado):-
	referencia_com_pronome(TemaReal, TemaReferenciado),
	referencia_com_pronome(AgenteReal, AgenteReferenciado).

referencia_com_pronome(TemaReal, TemaReferenciado):-
	\+ compound(TemaReal),
	quem_denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P),TemaReal),
	denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P), TemaReal),
	pro((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TemaReferenciado),_,[]).

referencia_com_pronome(TemaReal, TemaReal).

referencia_com_pronomes_na_sentenca(tema_real:TemaReal ..tema:TemaReal ..agente_real:AgenteReal ..agente:AgenteReal).





