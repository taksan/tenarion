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
        examinar(voce, Obj).

falando_com(voce, narrador).

/**** objetos especiais */
conj_velas([1,2,3,4,5,6,7,8,9,10,11,12,13]).

ultima_tabua(1).

/**** Localizacao dos objetos no mundo */

/* DETERMINA O QUE O OBJETO X TEM */
ter(Quem, Oque):-
    ( var(Oque); \+ racional(Oque) ),
    estar(Oque, Quem).

ter(voce, ferramentas):-
    ter(voce,pregos),
    ter(voce,tabuas),
    ter(voce,martelo).
    
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
estar(voce, ancoradouro).

/* LOCAL: Inventario */

estar(identidade, voce).
estar(cartao_credito, voce).
estar(sua(mao), voce).

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
%    estar(voce, Aqui),!,
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

/* indica que e um local e que o personagem pode "ir para" ele */
local(ancoradouro).
local(carpintaria).
local(ilha).
local(lago).
local(barco).
local(caixa_eletronico).

/* identidade */
ser(voce, narrador):-
        \+ falando_com(voce, _).

ser(voce, X):-
        falando_com(voce, X).
ser(L,L).        

/* diferenca entre pessoas e objetos */

/* entidade(voce, _):- !, fail. */

entidade(A, quem):-
        racional(A).

entidade(A, oque):-
        \+ racional(A).

/* racionalidade */

racional(voce).
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
% voce
dono(voce, X):-
    nonvar(X),
    estar(X, voce).

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
poder_ir(voce, barco):-
    dono(voce, barco),
    estar(voce, CenaAtual),
    perto(CenaAtual, barco).

poder_ir(voce, lago):-
    estar(voce, barco),
    nao(quebrado(barco)),
    ter(voce, remo).

poder_ir(voce, X):-
        estar(voce, Aqui),
        perto(Aqui, X),
        nao(estar(voce, X)),
        local(X),
        \+ member(X,[barco,lago]).

ir(voce, X):-
        poder_ir(voce, X),!,
        retract(estar(voce, _)),
        assert(estar(voce, X)).

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
        estar_em(voce, CenaAtual),
        assertz(estar((tabua, NovaUltima), CenaAtual)).

objeto_A_corta_B(faca,corda).
objeto_A_corta_B(serrote,tabua).
objeto_A_corta_B(serrote,barco).

poder_cortar(voce, ObjACortar, ObjParaCortar):-
    estar(ObjACortar, aqui),
    ter(voce, ObjParaCortar),
    objeto_A_corta_B(ObjParaCortar,ObjParaCortar).

poder_cortar(voce, Oque, ComOQue):-
    var(Oque), Oque=oque,
    var(ComOQue), ComOQue=oque.

cortar(voce, Oque, ComOQue):-
    var(Oque), Oque=oque,
    var(ComOQue), ComOQue=oque.

cortar(voce, corda, tesoura):-
        poder_cortar(voce, corda, tesoura),
        retract(estar(corda, _)).

cortar(voce, mao, serrote):-
        assertz(injuriado(voce)).

amarrar(voce, Oque, [NoQue,ENoQue]):-
    poder_amarrar(voce, Oque, [NoQue,ENoQue]),
    assertz(estar(Oque, NoQue)),
    assertz(estar(Oque, ENoQue)).

/* execucao da acao de consertar: somente para buraco/barco */
poder_consertar(voce, barco):-
	estar(voce, Aqui),
	estar(barco, Aqui),
    dono(voce, barco),
    ter(voce,ferramentas).

consertar(voce, barco):-
        poder_consertar(barco),
        retract(defeito(barco, [buraco])),
        retract(estar(buraco, barco)).


/* pregar: aplicavel a qualquer objeto */
pregar_em_com(prego, X, martelo):-
        ter(voce, martelo), !, 
        ter(voce, prego),!,
		estar(voce,Aqui),
        estar(X,Aqui),!,
        assertz(estar_em(pregos, X)).

pregar_em_com(prego, X, Y, martelo):-
    ter(voce, martelo),
    ter(voce, pregos),
	estar(voce,Aqui),
    estar(X, Aqui),
    estar(Y, Aqui),
    assertz(estar(prego, X)),
    assertz(estar(prego, Y)).

/* colocar objeto X em objeto Y */
poder_colocar(voce, (tema1:OQue ..tema2:Onde)):-
    ter(voce, OQue),
	(	estar(voce,Onde);
		(estar(voce,Aqui),estar(Onde,Aqui));
		ter(voce,Onde)
	).

colocar(voce, (tema1:OQue ..tema2:Onde)):-
    poder_colocar(voce, (tema1:OQue ..tema2:Onde)),
    colocar(OQue, Onde).

colocar(X, Y):-
    retract(estar(X, voce)),
    assertz(estar(X, Y)).

/* larga o objeto e o coloca na cena atual */
soltar(voce, X):-
        largar(X).

largar(X):-
        estar(voce, CenaAtual), !,
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

pegar(voce, X):-
	poder_pegar(voce, X),
    pegar(X).

pegar(X):-
     poder_pegar(voce, X),!,
     retract(estar(X, _)),
     assertz(estar(X, voce)).

/* vedar -- para vedar buracos */
vedar(buraco, X):-
        (X = vela ; X = chiclete),
        ter(voce,X),!,
        unido(barco, (tabua, _)),!,
        consertar(barco),
        retract(estar(X, voce)).

vedar(barco, X):-
        (X = vela ; X = chiclete),
        estar_em(X, voce),!,
        pregado(barco, (tabua, _)),!,
        consertar(barco),
        retract(estar(X, voce)).

/* fazer remo */
poder_fazer(voce, remo):-
    ter(voce, (tabua,_)),
    ter(voce, serrote).

fazer(voce, remo):-
    poder_fazer(voce,remo),
    retract(estar((tabua, _), voce)),
	comprimento((tabua, X), Comp),
	Comp > 50,
	retract(estar((tabua, X), voce)),
	assert(estar(remo, voce)).

/* Examinar */

examinar(Oque, [obj(Objetos), def(Defeitos)]):-
        \+ invisivel(Oque),
        estar(voce, CenaAtual),
        (estar_em(Oque, CenaAtual); Oque = CenaAtual),
        (defeito(Oque, Defeitos); Defeitos=[]),
        findall(X, (estar(X, Oque), 
                    \+ member(X, [voce, sua(mao)]),
                    \+ member(X, Defeitos)),
                Objetos),
        findall(X, (invisivel(X), 
                    member(X, Objetos), 
                    retract(invisivel(X))), _),
        findall(X, (invisivel(X), 
                    member(X, Defeitos), 
                    retract(invisivel(X))), _).

/* conversar -- inicia dialogo com Pessoa */
poder_conversar(voce, X):-
    poder_conversar_com(X).

poder_conversar_com(Pessoa):-
        racional(Pessoa), !, 
        \+ falando_com(voce, Pessoa).

conversar(voce, X):-
        conversar_com(X).

conversar_com(Pessoa):-
        poder_conversar_com(Pessoa),
        assertz(falando_com(voce, Pessoa)).

finaliza_conversa(Pessoa):-
        falando_com(_, Pessoa),
        retract(falando_com(_, Pessoa)).

finaliza_conversa(Pessoa):-
        falando_com(Pessoa, _),
        retract(falando_com(Pessoa, _)).

/* acoes provenientes do lexico */

/* --- acoes de conversa com personagens --- */

/* comprar objeto da pessoa */
poder_comprar(voce,Objeto):-
        dono(Objeto, Pessoa),
        falando_com(voce, Pessoa), 
        aceitar_vender(Pessoa, Objeto).
    
comprar(voce, Objeto):-
        poder_comprar(voce,Objeto),
        retractall(dono(_,Objeto)),
        assertz(dono(voce,Objeto)),
        assertz(estar(Objeto,voce)).

poder_digitar(voce, senha, caixa_eletronico).

digitar(voce, Oque, NoQue):-
    poder_digitar(voce, Oque, NoQue),
    assertz(digitado(Oque, NoQue)).

poder_pescar(voce, Onde):-
	Onde = lago,
	estar(voce,Aqui),
	perto(Aqui,lago),
	ter(voce, vara_pescar),
	estar(minhocas, vara_pescar).

pescar(voce,Onde):-
	poder_pescar(voce,Onde),
	assertz(estar(peixe,voce)).
