/************************************************
*          MODULO DE DESCRICAO DO MUNDO         *
************************************************/
:- dynamic(estar/2), dynamic(ultima_tabua/1),
   dynamic(falando_com/2), dynamic(defeito/2),
   dynamic(comprimento/2), dynamic(invisivel/1),
   dynamic(jogador/1),dynamic(estado),
   dynamic(consertado/1),dynamic(pregado/2),
   dynamic(amarrado/2),dynamic(digitado/2),
   dynamic(selecionado/2),
   dynamic(conhecer/2),dynamic(dono/2),
   dynamic(dinheiro_do_jogador/2),
   discontiguous(poder_especifico/1).

:-[fatos].

/* LOCAL INICIAL DE JOGO */
estar(player, embarcadouro).
falando_com(player, narrador).

/**** Predicados auxiliares para informacao ****/

nao(Predicado):-
    \+ Predicado.

inventario(Obj):-
        examinar(player, Obj).

/**** Localizacao dos objetos no mundo */

quanto(Quem,ter,dinheiro,Incognita):-
	Incognita=sn(id:prata ..numero:Saldo),
	dinheiro_do_jogador(Quem,Saldo).

quanto(Onde,ter,dinheiro,Incognita):-
	Incognita=sn(id:prata ..numero:_),
	estar(Incognita,Onde).


% Ter é um verbo especial, porque nem sempre significa
% que a o individuo realmente tem consigo

% ter para VENDER
ter(Quem,Verbo):-
	nonvar(Verbo),
	Verbo=vender(Quem,(tema1:Oque..tema2:ParaQuem)),
	poder(vender(Quem,(tema1:Oque..tema2:ParaQuem))).

/* DETERMINA O QUE O OBJETO X TEM */

ter(Quem, OQue):-
    ( var(OQue); \+ racional(OQue) ),
    estar(OQue,OndeEsta),
    estar(OQue, Quem),
    OndeEsta=Quem.

ter(Quem, OQue):-
	nonvar(Quem),Quem=player,
	(estar(OQue,player);
		(OQue=sn(id:prata ..numero:Saldo),dinheiro_do_jogador(player,Saldo))
	).

ter(player, ferramentas):-
    ter(player,pregos),
    ter(player,tabuas),
    ter(player,martelo),
	ter(player,chiclete).
    
pertencer(OQue,A_Quem):-
    ter(A_Quem, OQue).

perto(X, Y):-
        adjacente(X,Y).

perto(X, Y):-
        adjacente(Y,X).

perto(X, Y):-
        estar(Y, X).

perto(X, Y):-
        estar(X, Y).


/* Verificacao sobre um conjunto de objetos */
estar(QueCoisas, Lug):-
        nonvar(QueCoisas),
        is_list(QueCoisas),
        estar_conj(QueCoisas, Lug).

estar(Algo, Onde):-
	nonvar(Algo),nonvar(Onde),
	estar(OQue,Onde),
	\+local(OQue),
	estar(Algo,OQue).


estar_conj([OQue], Lug):-
        estar(OQue, Lug).

estar_conj([X|R], Lug):-
        estar(X, Lug),
        estar(R, Lug).

/* *** DEFINICAO P/ DETECTAR SE UM OBJETO ESTA EM ALGUM LUGAR INDIRETAMENTE */

% Diretamente
estar_em(OQue, Onde):-
        estar(OQue, Onde).

% Pergunta em quais lugares esta X
estar_em(OQue, QueLugares):-
        \+ var(OQue), !,
        findall(Onde, estar(OQue, Onde), L),
        member(E, L),
        estar_em(E, QueLugares).

% Pergunta quais objetos estao em Y
estar_em(QueCoisas, Onde):-
        \+ var(Onde), !,
        findall(Z, estar(Z, Onde), L),
        member(E, L),
        estar_em(QueCoisas, E).

% Resulta em todos os pares possiveis
estar_em(X, Y):-
        setof(E1, estar(E1, _), L1),
        member(X, L1),
        estar_em(X, Y).

/* *** PROPRIEDADES DOS OBJETOS */

navegavel(X):-
        flutua(X),
        tamanho(X, grande),
        nao(quebrado(X)).

/* SER */
ser(Res,comp_nominal(NomePred,Alvo)):-
	nonvar(NomePred),
	Pred=..[NomePred,Res,Alvo],
	clause(Pred,_),
	Pred.

ser(comp_nominal(NomePred,Alvo),Res):-
	nonvar(NomePred),
	Pred=..[NomePred,Res,Alvo],
	clause(Pred,_),
	Pred.

ser(Alvo,Res):-
	nonvar(Res),
	descreve(Res,Alvo).

ser(Alvo,Res):-
	nonvar(Alvo),
	descreve(Res,Alvo).

ser(player, Nome):-
    jogador(Nome),
	ignore(introduz_player).

ser(Nome, player):-
    jogador(Nome),
	ignore(introduz_player).

ser(L,L):-
    nonvar(L), \+ compound(L),
	ignore(introduz_pessoa(L)).

ser(L,L):-
	nonvar(L),
	L=sn(_).

ser(pred(Quem),comp_nominal(seu,nome)):-
	var(Quem),
	falando_com(player,Quem),
	ser(Quem,Quem).

/* diferenca entre pessoas e objetos */
/* entidade(player, _):- !, fail. */

entidade(_,qual).

entidade(A, quem):-
	A\=player,
    racional(A).

entidade(A, oque):-
    \+ racional(A).

entidade(A,onde):-
	local(A);
    racional(A).

entidade(OQue,(quanto,dinheiro)):-
	nonvar(OQue),
	OQue=sn(id:prata).

entidade(OQue,quanto):-
	nonvar(OQue),
	OQue=sn(numero:_).

custar(sn(id:prata ..numero:Preco),OQue):-
	\+compound(OQue),
	quanto_custa(OQue,Preco).

valor(sn(id:prata..numero:Saldo),saldo):-
	saldo_conta(player,Saldo).

preco(Valor,OQue):-
	custar(Valor,OQue).

dono(player, X):-
    nonvar(X),
    estar(X, player).

suficiente(comp_nominal(player,dinheiro), Objeto):-
	suficiente(comp_nominal(meu,dinheiro), Objeto).

suficiente(comp_nominal(meu,dinheiro), Objeto):-
	quanto_custa(Objeto,Preco),
	dinheiro_do_jogador(player,Saldo),
	Preco < Saldo.

quebrado(OQue):-
    defeito(OQue, _).

/* indica que X esta unido a Y */
unido(X, Y):-
        estar_em(Z, X),
        estar_em(Z, Y).

/* ACOES: define acoes que podem ser realizadas SOBRE os objetos */

/* acoes de deslocamento */
poder_especifico(ir(player, barco)):-
	!,
    nao(quebrado(barco)),
    estar(player, CenaAtual),
    perto(CenaAtual, barco).

poder_especifico(ir(player, lago)):-
	!,
    estar(player, barco),
    ter(player, remo).

poder_especifico(ir(player,Onde)):-
	!,
	\+member(Onde,[barco,lago]).
poder_especifico(ir(player,Onde)):-
	var(Onde).

ir(player, Onde):-
    estar(player, Aqui),
    perto(Onde,Aqui),
    local(Onde),
    poder_especifico(ir(player,Onde)),
    retract(estar(player, _)),
    asserta(estar(player, Onde)).

local_fechado(carpintaria).

perto(Onde):-
    estar(player, Aqui),
    perto(Aqui, Onde).


/* entrar */
poder_especifico(entrar(player,barco)).
poder_especifico(entrar(player,Onde)):-
	!,
	Onde\=barco,
	local_fechado(Onde).

entrar(player, Onde):-
	estar(player, Aqui),
    perto(Onde,Aqui),
    local(Onde),
    poder_especifico(entrar(player,Onde)),
    poder_especifico(ir(player,Onde)),
    retract(estar(player, _)),
    asserta(estar(player, Onde)).

/* cortar */
cortar_com(tabuas, serrote):-
        % coleta de informacoes do mundo
        comprimento(tabuas, Comp),
        Comp > 10,
        % atualizacao do tamanho da tabua
        retract(comprimento(tabuas, Comp)),
        NovoComp is Comp-10,
        assertz(comprimento(tabuas, NovoComp)),
        % criacao da nova tabua
        ultima_tabua(Ultima),
        retract(ultima_tabua(Ultima)),
        NovaUltima is Ultima+1,
        assertz(ultima_tabua(NovaUltima)),
        assertz(comprimento((tabua, NovaUltima), 10)),
        % posicionamento da tabua no mundo
        estar(player, CenaAtual),
        assertz(estar((tabua, NovaUltima), CenaAtual)).

poder_especifico(cortar(player,corda,tesoura)).
poder_especifico(cortar(player,mao,serrote)).
poder_especifico(cortar(player,tabua,serrote)).
poder_especifico(cortar(player,barco,serrote)).

cortar(player, (tema1:ObjACortar ..tema2:ObjParaCortar)):-
	poder_especifico(player,ObjACortar,ObjParaCortar),
	estar(player, Aqui),
    estar(ObjACortar, Aqui),
    ter(player, ObjParaCortar),
	assertz(cortado(ObjParaCortar)),
	assert_especifico(cortar(ObjACortar,ObjParaCortar)).

assert_especifico(cortar(corda, tesoura)):-
	retract(estar(corda, _)).

assert_especifico(cortar(mao, serrote)):-
	assertz(injuriado(player)),
	retract(estar(sua_mao,player)).

assert_especifico(cortar(barco,serrote)):-
	retract(consertado(barco)),
	asserta(defeito(barco, buraco)).

amarrar(player, (tema1:OQue.. tema2:[NoQue,ENoQue])):-
    ter(player, OQue),
	amarravel(OQue),
	estar(player,Aqui),
	estar(NoQue,Aqui),
	estar(ENoQue,Aqui),
	nao(racional(NoQue)),
	nao(racional(ENoQue)),
	poder_especifico(amarrar(OQue,NoQue)),
	poder_especifico(amarrar(OQue,ENoQue)),
	assertz(amarrado(OQue,NoQue)),
	assertz(amarrado(OQue,ENoQue)).

desamarrar(player, OQue):-
	amarrado(OQue,NoQue),
	amarrado(OQue,ENoQue),
	NoQue\=ENoQue,
	retractall(amarrado(OQue,_)).

/* execucao da acao de consertar: somente para buraco/barco */
consertar(player, barco):-
    estar(player, Aqui),
    estar(barco, Aqui),
    dono(player, barco),
    ter(player,ferramentas),
    retract(defeito(barco, buraco)),
    retract(estar(buraco, barco)),
	asserta(consertado(barco)).

pregar(player, (tema1:OQue ..tema2:NoQue ..tema3:martelo)):-
    ter(player, prego), 
    ter(player, martelo), 
	ter(player, OQue),
    estar(player,Aqui),
    estar(NoQue,Aqui),!,
	retract(estar(OQue,player)),
	assertz(pregado(OQue,NoQue)).

despregar(player, OQue):-
	ter(player, pe_de_cabra),
	retract(pregado(OQue,_)).

poder_especifico(colocar(minhocas,vara_pescar)):-
	!,
	ter(player, vara_pescar).

poder_especifico(colocar(_,estande)):-
	!,
	estar(player,Aqui),
	estar(estande,Aqui).

poder_especifico(colocar(peixe,sambura)):-
	!,
	ter(player, sambura).


poder_especifico(colocar(_,Onde)):-
	local(Onde),!,
	estar(player,Onde).

colocar(player, (tema1:OQue ..tema2:Onde)):-
    ter(player, OQue),
	poder_especifico(colocar(OQue,Onde)),
    retract(estar(OQue, player)),
    assertz(estar(OQue, Onde)),
	colateral_evento_colocar(OQue,Onde).

colateral_evento_colocar(cartao_credito,caixa_eletronico):-
	evento(agente:caixa_eletronico ..acao:estar ..tema:(acao:pedir ..tema_real:comp_nominal(player,senha))).

colateral_evento_colocar(_,_).

retirar(player,Tema):-
	sinonimo(tirar(player,Tema)).

tirar(player, (tema1:OQue ..tema2:DoQue)):-
    ter(player, DoQue),
	estar(OQue, DoQue),
    retract(estar(OQue, DoQue)),
    assertz(estar(OQue, player)).

tirar(player, (tema1:OQue ..tema2:DoQue)):-
	estar(player, DoQue),
    retract(estar(OQue, DoQue)),
    assertz(estar(OQue, player)).

/* larga o objeto e o coloca na cena atual */
soltar(player, OQue):-
	ter(player,OQue),
    estar(player, Aqui),
    colocar(player, (tema1:OQue ..tema2:Aqui)).

/* pegar */
poder_especifico(pegar(player,corda)):-
	!,
	nao(amarrado(corda,_)).

pegar(Quem, OQue):-
    estar(Quem,Aqui),
    estar(OQue,Aqui),
	nao(grande(OQue)),
	nao(pregado(OQue,_)),
    pegavel(OQue),
    (dono(Quem, OQue);nao(dono(_,OQue))),
	poder_especifico(pegar(Quem,OQue)),
    retractall(estar(OQue, _)),
    assertz(estar(OQue, Quem)).

pegar(player,OQue):-
	nonvar(OQue),
	OQue=dinheiro,
	estar(player,Aqui),
	estar(sn(id:prata ..numero:Valor),Aqui),
	colateral_pegar_dinheiro(Valor).

pegar(player,OQue):-
	nonvar(OQue),
	OQue=sn(id:prata ..numero:Valor),
	colateral_pegar_dinheiro(Valor).

colateral_pegar_dinheiro(Valor):-
	estar(player,Aqui),
	SnReal=sn(id:prata ..numero:ValorReal),
	estar(SnReal,Aqui),
	Valor =< ValorReal,
	ValorSub is ValorReal-Valor,
	retract(estar(SnReal,Aqui)),
	ignore((ValorSub>0, assertz(estar(sn(id:prata ..numero:ValorSub),Aqui)))),
	colateral_adicionar_dinheiro(Valor).

colateral_adicionar_dinheiro(Valor):-
	dinheiro_do_jogador(player,Anterior),
	retract(dinheiro_do_jogador(player,_)),
	NovoValor is Valor+Anterior,
	assertz(dinheiro_do_jogador(player,NovoValor)).


/* vedar -- para vedar buracos */
vedar(buraco, X):-
     (X = vela ; X = chiclete),
     ter(player,X),!,
     unido(barco, tabuas),!,
     consertar(barco),
     retract(estar(X, player)).

vedar(barco, X):-
     (X = vela ; X = chiclete),
     estar(X, player),!,
     pregado(barco, tabuas),!,
     consertar(barco),
     retract(estar(X, player)).

/* fazer remo */
fazer(player, remo):-
    ter(player, tabuas),
    ter(player, serrote),
    comprimento(tabuas, Comp),
    Comp > 50,
    retract(estar(tabuas, player)),
    asserta(estar(remo, player)).

/* Examinar */
examinar(OQue, [obj(Objetos), def(Defeitos)]):-
        \+ invisivel(OQue),
        estar(player, CenaAtual),
        (estar(OQue, CenaAtual); OQue = CenaAtual),
        (defeito(OQue, Defeitos); Defeitos=[]),
        findall(X, (estar(X, OQue), 
                    \+ member(X, [player, sua_mao]),
                    \+ member(X, Defeitos)),
                Objetos),
        findall(X, (invisivel(X), 
                    member(X, Objetos), 
                    retract(invisivel(X))), _),
        findall(X, (invisivel(X), 
                    member(X, Defeitos), 
                    retract(invisivel(X))), _).

/* conversar -- inicia dialogo com Pessoa */
conversar(player, Pessoa):-
	estar(player,Aqui),
	estar(Pessoa,Aqui),
    racional(Pessoa),
    retract(falando_com(player,_)),
    assertz(falando_com(player, Pessoa)).

/* --- acoes de conversa com personagens --- */
poder_especifico(comprar(_)).

/* comprar objeto da pessoa */
comprar(player, Objeto):-
    falando_com(player, Pessoa), 
    dono(Pessoa,Objeto),
	querer(Pessoa,vender(Objeto)),
    poder_especifico(comprar(Objeto)),
	suficiente(comp_nominal(player,dinheiro),Objeto),
	colateral_novo_saldo_subtraindo_valor_de(Objeto),
    retract(dono(_,Objeto)),
    asserta(estar(Objeto,player)).

colateral_novo_saldo_subtraindo_valor_de(Objeto):-
	quanto_custa(Objeto,Preco),
	dinheiro_do_jogador(player,Saldo),
	NovoSaldo is Saldo-Preco,
	NovoSaldo >= 0,
	retract(dinheiro_do_jogador(player,_)),
	asserta(dinheiro_do_jogador(player,NovoSaldo)).

vender(Quem, (tema1:OQue ..tema2:ParaQuem)):-
	dono(Quem,OQue),
	querer(ParaQuem, comprar(OQue)),
	querer(Quem,vender(OQue)),
    poder_especifico(vender(Quem,OQue)),
    retract(dono(_,OQue)),
    asserta(estar(OQue,ParaQuem)).


digitar(player, (tema1:senha ..tema2:teclado)):-
	estar(player,caixa_eletronico),
	estar(cartao_credito,caixa_eletronico),
    assert_digitado(digitado(senha, teclado)),
	assertz(estar(comp_nominal(menu,caixa_eletronico),tela)),
	evento(acao:aparecer ..tempo:preterito ..agente:comp_nominal(menu,caixa_eletronico) ..tema:tela).

digitar(player, (tema1:Valor ..tema2:teclado)):-
	integer(Valor),
	estar(player,caixa_eletronico),
	estar(cartao_credito,caixa_eletronico),
	selecionado(comp_nominal(opcao,saque),caixa_eletronico),
	retract(selecionado(comp_nominal(opcao,saque),caixa_eletronico)),
    assert_digitado(digitado(Valor, teclado)),
	evento(acao:aparecer ..tempo:preterito ..agente:comp_nominal(opcao,confirmacao) ..tema:tela).

selecionar(player,comp_nominal(opcao,saque)):-
	estar(player,caixa_eletronico),
	digitado(senha,teclado),
	assertz(selecionado(comp_nominal(opcao,saque),caixa_eletronico)),
	evento(agente:caixa_eletronico ..acao:estar ..tema:(acao:pedir ..tema_real:valor)).

selecionar(player,comp_nominal(opcao,saldo)):-
	estar(player,caixa_eletronico),
	digitado(senha,teclado),
	saldo_conta(player,Num),
	evento(acao:ser ..agente:comp_nominal(valor,saldo) ..tema:sn(id:prata ..numero:Num)).

selecionar(player,comp_nominal(opcao,confirmacao)):-
	estar(player,caixa_eletronico),
	digitado(Valor,teclado),
	assertz(estar(sn(id:prata ..numero:Valor),caixa_eletronico)),
	retractall(digitado(_,teclado)),
	retractall(selecionado(_,teclado)),
	evento(agente:sn(id:prata ..numero:Valor) ..tema:caixa_eletronico ..acao:aparecer ..tempo:preterito).

assert_digitado(NovoDigitado):-
	NovoDigitado=..[digitado,_,NoQue],
	retractall(digitado(_,NoQue)),
	assertz(NovoDigitado).

pescar(player,Onde):-
    Onde = lago,
    estar(player,Aqui),
    perto(Aqui,lago),
    ter(player, vara_pescar),
    estar(minhocas, vara_pescar),
    asserta(estar(peixe,player)).

% nao coloque nenhum poder especifico depois desse
poder_especifico(_).

introduz_pessoa(Quem):-
	falando_com(player,Quem),
	\+conhecer(player,Quem),
	assertz(conhecer(player,Quem)).

introduz_player:-
	falando_com(player,Quem),
	Quem\=narrador,
	\+conhecer(Quem,player),
	assertz(conhecer(Quem,player)).


nome_de_quem_estah_falando(Nome):-
	falando_com(player,Quem),
	\+conhecer(player,Quem),
	descreve(Quem, Nome).

nome_de_quem_estah_falando(Nome):-
	falando_com(player,Nome).

sinonimo(Pred):-
	Pred.

narrador(Pred):-
	Pred.

zulu(ser(A,B)):-
	(A=zulu;B=zulu;B=comp_nominal(seu,nome)),
	ser(A,B).

zulu(ser(A,B)):-
	conhecer(zulu,A),
	ser(A,B).

zulu(ser(A,B)):-
	conhecer(zulu,B),
	ser(A,B).

zulu(Pred):-
	Pred=..[NomePred|_],
	NomePred\=ser,
	Pred.

%mateo(conversar(player,mateo)):-
%	conversar(player,mateo),
%	evento(agente:player ..acao:querer ..tema:(acao:comprar ..tema_real:sn(id:coisa ..quant:algum))).

querer(_).

evento(Resposta):-
	Resposta=(ato_fala:interro_agente_incognito..agente:incog(_)),
	limpa_eventos,
	asserta(resposta_evento(Resposta)).

evento(Resposta):-
	Resposta=(ato_fala:interro_tema_incognito..tema:incog(_)),
	limpa_eventos,
	asserta(resposta_evento(Resposta)).

evento(Resposta):-
	Resposta=ato_fala:informar,
	limpa_eventos,
	asserta(resposta_evento(Resposta)).

limpa_eventos:-
	retractall(resposta_evento(_)).
	
