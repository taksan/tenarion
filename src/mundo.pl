/************************************************
*          MODULO DE DESCRICAO DO MUNDO         *
************************************************/
:- dynamic(estar/2), dynamic(ultima_tabua/1),
   dynamic(falando_com/2), dynamic(defeito/2),
   dynamic(comprimento/2), dynamic(invisivel/1),
   dynamic(jogador/1),dynamic(estado).

/**** Predicados auxiliares para informacao ****/

nao(Predicado):-
    \+ Predicado.

inventario(Obj):-
        examinar(player, Obj).

falando_com(player, narrador).

/**** objetos especiais */
conj_velas([1,2,3,4,5,6,7,8,9,10,11,12,13]).

ultima_tabua(1).

/**** Localizacao dos objetos no mundo */

/* DETERMINA O QUE O OBJETO X TEM */
ter(Quem, Oque):-
    ( var(Oque); \+ racional(Oque) ),
    estar(Oque, Quem).

ter(player, ferramentas):-
    ter(player,pregos),
    ter(player,tabuas),
    ter(player,martelo).
    
pertencer(Oque,A_Quem):-
    ter(A_Quem, Oque).

/* DETERMINA CONEXAO ENTRE LOCAIS */

adjacente(ancoradouro, carpintaria).
adjacente(barco, lago).
adjacente(lago, ilha).

perto(X, Y):-
        adjacente(X,Y).

perto(X, Y):-
        adjacente(Y,X).

perto(X, Y):-
        estar(Y, X).

perto(X, Y):-
        estar(X, Y).


/* LOCAL: JOGO  -- todos os cenarios do jogo */
estar(ancoradouro, jogo).
estar(carpintaria, jogo).
estar(lago, jogo).
estar(ilha, jogo).


/* LOCAL ONDE VOCE SE ENCONTRA */
estar(player, ancoradouro).

/* LOCAL: Inventario */

estar(identidade, player).
estar(cartao_credito, player).
estar(sua(mao), player).

/* LOCAL: ANCORADOURO */

estar((tabua, 1), ancoradouro).
estar(vara_pescar, ancoradouro).
estar(minhocas, ancoradouro).
estar(barco, ancoradouro).
estar(zulu, ancoradouro).
estar(corda, ancoradouro).

/* BARCO */
estar(buraco, barco).
estar(pregos, barco).
estar(corda, barco).
estar(agua_do_lago, barco).

/* LOCAL: CARPINTARIA */
estar(mateo, carpintaria).
estar(caixa_eletronico, carpintaria).
estar(placa_nome_loja, carpintaria).
estar(balcao, carpintaria).
estar(estande, carpintaria).
estar(carteira, carpintaria).
estar(poster, carpintaria).

/* ESTANDE */
estar(martelo, estande).

estar(serrote, estande).

estar(tesoura, estande).

/* BALCAO */
estar(caixa_registradora, balcao).
estar(vaso_ming, balcao).
estar(circulo_de_velas, balcao).

/* CIRCULO DE VELAS */
estar((vela, X), circulo_de_velas):-
        conj_velas(Velas),
        member(X, Velas).

estar(santo_do_pau_oco, circulo_de_velas).

/* CARTEIRA */
estar(embaixo_carteira, carteira).

/* EMBAIXO DA CARTEIRA */
estar(chiclete, embaixo_carteira).

/* POSTER */
estar(feiticeira, poster).

/* caixa eletronico */
estar(dinheiro, caixa_eletronico).
estar(botoes, caixa_eletronico).
estar(tela, caixa_eletronico).

/* LOCAL: LAGO */
estar(agua_do_lago, lago).
estar(peixe_voador, lago).

/* AGUA DO LAGO */
estar(peixe, agua_do_lago).
estar(vitoria_regia, agua_do_lago).

%estar(Objeto,aqui):-
%    estar(player, Aqui),!,
%    estar(Objeto,Aqui).

/* Verificacao sobre um conjunto de objetos */
estar(QueCoisas, Lug):-
        nonvar(QueCoisas),
        is_list(QueCoisas),
        estar_conj(QueCoisas, Lug).

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
        estado(X, bom).

estado(X, bom):-
        \+ defeito(X, _).

estado(barco, quebrado).

/* indica se objeto e invisivel */

invisivel(chiclete).
invisivel(pregos).
invisivel(buraco).
invisivel(dinheiro).
invisivel(peixe).

/* pegavel */

pegavel((vela, _)).
pegavel(martelo).
pegavel(identidade).
pegavel(carta_credito).
pegavel(sua(mao)).
pegavel((tabua, _)).
pegavel(vara_pescar).
pegavel(minhocas).
pegavel(pregos).
pegavel(poster).
pegavel(serrote).
pegavel(tesoura).
pegavel(vaso_ming).
pegavel(santo_do_pau_oco).
pegavel(chiclete).
pegavel(dinheiro).
pegavel(corda):-
	nao(amarrada(corda)).

amarrada(corda).

/* indica que e um local e que o personagem pode "ir para" ele */
local(ancoradouro).
local(carpintaria).
local(ilha).
local(lago).
local(barco).
local(caixa_eletronico).

combina(minhocas,vara_pescar).

/* identidade */
ser(player, Nome):-
	jogador(Nome).

ser(L,L):-
	nonvar(L),
	nao(L=player).

/* diferenca entre pessoas e objetos */

/* entidade(player, _):- !, fail. */

entidade(A, quem):-
	racional(A).

entidade(A, oque):-
    \+ racional(A).

/* racionalidade */

racional(player).
racional(zulu).
racional(mateo).
racional(peixe_voador).


/* pertinencia */
% zulu
dono(zulu, barco).
dono(zulu, vara_de_pescar).

% mateo
dono(mateo, martelo).
dono(mateo, serrote).
dono(mateo, tesoura).
dono(mateo, (velas, _)).
dono(mateo, vaso_ming).
dono(mateo, poster).
dono(mateo, balcao).
dono(mateo, estande).
dono(mateo, carpintaria).
dono(mateo, santo_do_pau_oco).
dono(mateo, carteira).
% player
dono(player, X):-
    nonvar(X),
    estar(X, player).

/* quem conhece quem*/
conhecer(zulu, mateo).
conhecer(mateo, zulu).
conhecer(peixe_voador, zulu).
conhecer(peixe_voador, mateo).

/* defeito */
defeito(barco, [buraco]).
defeito(tesoura, [semfio]).

quebrado(OQue):-
    defeito(OQue, _).

/* capacidade de flutuar */
flutua(zulu).
flutua(mateo).
flutua(barco).
flutua(tabua).
flutua(vitoria_regia).
flutua(placa_nome_loja).
flutua(vaso_ming).
flutua(vara_pescar).

tamanho(barco, grande).

/* indica que X esta unido a Y */
unido(X, Y):-
        estar_em(Z, X),
        estar_em(Z, Y).

/* determina tamanho dos elementos do jogo */

comprimento((tabua, 1), 100).
comprimento(buraco, 8).
comprimento(remo, 60).

/* ACOES: define acoes que podem ser realizadas SOBRE os objetos */

/* acoes de deslocamento */
poder_ir(player, barco):-
    dono(player, barco),
    estar(player, CenaAtual),
    perto(CenaAtual, barco).

poder_ir(player, lago):-
    estar(player, barco),
    nao(quebrado(barco)),
    ter(player, remo).

poder_ir(player, X):-
        estar(player, Aqui),
        perto(Aqui, X),
        nao(estar(player, X)),
        local(X),
        \+ member(X,[barco,lago]).

ir(player, X):-
        poder_ir(player, X),!,
        retract(estar(player, _)),
        assert(estar(player, X)).

/* cortar */
cortar_com((tabua, X), serrote):-
        % coleta de informacoes do mundo
        comprimento((tabua, X), Comp),
        Comp > 10,
        % atualizacao do tamanho da tabua
        retract(comprimento((tabua, X), Comp)),
        NovoComp is Comp-10,
        assertz(comprimento((tabua, X), NovoComp)),
        % criacao da nova tabua
        ultima_tabua(Ultima),
        retract(ultima_tabua(Ultima)),
        NovaUltima is Ultima+1,
        assertz(ultima_tabua(NovaUltima)),
        assertz(comprimento((tabua, NovaUltima), 10)),
        % posicionamento da tabua no mundo
        estar_em(player, CenaAtual),
        assertz(estar((tabua, NovaUltima), CenaAtual)).

objeto_A_corta_B(faca,corda).
objeto_A_corta_B(serrote,tabua).
objeto_A_corta_B(serrote,barco).

poder_cortar(player, ObjACortar, ObjParaCortar):-
    estar(ObjACortar, aqui),
    ter(player, ObjParaCortar),
    objeto_A_corta_B(ObjParaCortar,ObjParaCortar).

poder_cortar(player, Oque, ComOQue):-
    var(Oque), Oque=oque,
    var(ComOQue), ComOQue=oque.

cortar(player, Oque, ComOQue):-
    var(Oque), Oque=oque,
    var(ComOQue), ComOQue=oque.

cortar(player, corda, tesoura):-
        poder_cortar(player, corda, tesoura),
        retract(estar(corda, _)).

cortar(player, mao, serrote):-
        assertz(injuriado(player)).

amarrar(player, Oque, [NoQue,ENoQue]):-
    poder_amarrar(player, Oque, [NoQue,ENoQue]),
    assertz(estar(Oque, NoQue)),
    assertz(estar(Oque, ENoQue)).

/* execucao da acao de consertar: somente para buraco/barco */
poder_consertar(player, barco):-
	estar(player, Aqui),
	estar(barco, Aqui),
    dono(player, barco),
    ter(player,ferramentas).

consertar(player, barco):-
        poder_consertar(barco),
        retract(defeito(barco, [buraco])),
        retract(estar(buraco, barco)).


/* pregar: aplicavel a qualquer objeto */
pregar_em_com(prego, X, martelo):-
        ter(player, martelo), !, 
        ter(player, prego),!,
		estar(player,Aqui),
        estar(X,Aqui),!,
        assertz(estar_em(pregos, X)).

pregar_em_com(prego, X, Y, martelo):-
    ter(player, martelo),
    ter(player, pregos),
	estar(player,Aqui),
    estar(X, Aqui),
    estar(Y, Aqui),
    assertz(estar(prego, X)),
    assertz(estar(prego, Y)).


/* colocar objeto X em objeto Y */
poder_colocar(player, (tema1:OQue ..tema2:Onde)):-
    ter(player, OQue),
	(	(local(Onde),estar(player,Onde));
		(local(Onde),estar(player,Aqui),estar(Onde,Aqui));
		(ter(player,Onde),combina(OQue,Onde))
	).


colocar(player, (tema1:OQue ..tema2:Onde)):-
    poder_colocar(player, (tema1:OQue ..tema2:Onde)),
    colocar(OQue, Onde).

colocar(X, Y):-
    retract(estar(X, player)),
    assertz(estar(X, Y)).

/* larga o objeto e o coloca na cena atual */
soltar(player, X):-
        largar(X).

largar(X):-
        estar(player, CenaAtual), !,
        colocar(X, CenaAtual).

/* pegar */
poder_pegar(Quem,Oque):-
    %   \+ invisivel(X),
    pegavel(Oque),
    nao(ter(Quem,Oque)),
    estar(Oque,aqui),
    dono(Quem, Oque).

poder_pegar(Quem,Oque):-
    %   \+ invisivel(X),
    pegavel(Oque),
    nao(ter(Quem,Oque)),
    nao(dono(_, Oque)),
    estar(Quem,Aqui),
	estar(Oque,Aqui).

pegar(player, X):-
	poder_pegar(player, X),
    pegar(X).

pegar(X):-
     poder_pegar(player, X),!,
     retract(estar(X, _)),
     assertz(estar(X, player)).

/* vedar -- para vedar buracos */
vedar(buraco, X):-
        (X = vela ; X = chiclete),
        ter(player,X),!,
        unido(barco, (tabua, _)),!,
        consertar(barco),
        retract(estar(X, player)).

vedar(barco, X):-
        (X = vela ; X = chiclete),
        estar_em(X, player),!,
        pregado(barco, (tabua, _)),!,
        consertar(barco),
        retract(estar(X, player)).

/* fazer remo */
poder_fazer(player, remo):-
    ter(player, (tabua,_)),
    ter(player, serrote).

fazer(player, remo):-
    poder_fazer(player,remo),
    retract(estar((tabua, _), player)),
	comprimento((tabua, X), Comp),
	Comp > 50,
	retract(estar((tabua, X), player)),
	assert(estar(remo, player)).

/* Examinar */

examinar(Oque, [obj(Objetos), def(Defeitos)]):-
        \+ invisivel(Oque),
        estar(player, CenaAtual),
        (estar_em(Oque, CenaAtual); Oque = CenaAtual),
        (defeito(Oque, Defeitos); Defeitos=[]),
        findall(X, (estar(X, Oque), 
                    \+ member(X, [player, sua(mao)]),
                    \+ member(X, Defeitos)),
                Objetos),
        findall(X, (invisivel(X), 
                    member(X, Objetos), 
                    retract(invisivel(X))), _),
        findall(X, (invisivel(X), 
                    member(X, Defeitos), 
                    retract(invisivel(X))), _).

/* conversar -- inicia dialogo com Pessoa */
poder_conversar(player, X):-
    poder_conversar_com(X).

poder_conversar_com(Pessoa):-
        racional(Pessoa), !, 
        \+ falando_com(player, Pessoa).

conversar(player, X):-
        conversar_com(X).

conversar_com(Pessoa):-
        poder_conversar_com(Pessoa),
		retractall(falando_com(player,_)),
        assertz(falando_com(player, Pessoa)).

finaliza_conversa(Pessoa):-
        falando_com(_, Pessoa),
        retract(falando_com(_, Pessoa)),
		assertz(falando_com(player,narrador)).

finaliza_conversa(Pessoa):-
        falando_com(Pessoa, _),
        retract(falando_com(Pessoa, _)),
		assertz(falando_com(player,narrador)).

/* acoes provenientes do lexico */

/* --- acoes de conversa com personagens --- */

/* comprar objeto da pessoa */
poder_comprar(player,Objeto):-
        dono(Objeto, Pessoa),
        falando_com(player, Pessoa), 
        aceitar_vender(Pessoa, Objeto).
    
comprar(player, Objeto):-
        poder_comprar(player,Objeto),
        retractall(dono(_,Objeto)),
        assertz(dono(player,Objeto)),
        assertz(estar(Objeto,player)).

poder_digitar(player, senha, caixa_eletronico).

digitar(player, Oque, NoQue):-
    poder_digitar(player, Oque, NoQue),
    assertz(digitado(Oque, NoQue)).

poder_pescar(player, Onde):-
	Onde = lago,
	estar(player,Aqui),
	perto(Aqui,lago),
	ter(player, vara_pescar),
	estar(minhocas, vara_pescar).

pescar(player,Onde):-
	poder_pescar(player,Onde),
	assertz(estar(peixe,player)).
