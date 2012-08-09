/************************************************
*          MODULO DE DESCRICAO DO MUNDO         *
************************************************/
:- dynamic(estar/2), dynamic(ultima_tabua/1),
   dynamic(falando_com/2), dynamic(defeito/2),
   dynamic(comprimento/2), dynamic(invisivel/1),
   dynamic(jogador/1),dynamic(estado),
   dynamic(consertado/1),dynamic(pregado/2),
   dynamic(amarrado/2),dynamic(digitado/2),
   dynamic(conhecer/2),dynamic(dono/2),
   discontiguous(poder_especifico/1).

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

quanto(Quem,ter,dinheiro,Incognita):-
	Incognita=sn(id:prata ..numero:Saldo),
	dinheiro(Quem,Saldo).

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

ter(player, ferramentas):-
    ter(player,pregos),
    ter(player,tabuas),
    ter(player,martelo),
	ter(player,chiclete).
    
pertencer(OQue,A_Quem):-
    ter(A_Quem, OQue).

/* DETERMINA CONEXAO ENTRE LOCAIS */

adjacente(ancoradouro, carpintaria).
adjacente(ancoradouro, lago).
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

/* LOCAL: ANCORADOURO */

estar(tabuas, ancoradouro).
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
%estar((vela, X), circulo_de_velas):-
%        conj_velas(Velas),
%        member(X, Velas).
estar(velas,circulo_de_velas).
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

/* PERSONAGENS */
estar(sambura, zulu).

/* Verificacao sobre um conjunto de objetos */
estar(QueCoisas, Lug):-
        nonvar(QueCoisas),
        is_list(QueCoisas),
        estar_conj(QueCoisas, Lug).

/* LOCAL ONDE O JOGADOR SE ENCONTRA */
estar(player, ancoradouro).

/* Inventario */
estar(identidade, player).
estar(cartao_credito, player).
estar(sua_mao, player).

dinheiro(player,5).

%estar(OQue, Onde):-
%        nonvar(OQue),nonvar(Onde),
%        estar(OQue,NoQue),
%        estar(NoQue,Onde).

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
pegavel(sua_mao).
pegavel(tabuas).
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
pegavel(corda).

amarrado(corda,barco).
amarrado(corda,ancoradouro).

/* indica que e um local e que o personagem pode "ir para" ele */
local(ancoradouro).
local(carpintaria).
local(ilha).
local(lago).
local(barco).
local(caixa_eletronico).

/* identidade */
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

entidade(_,(quanto,_)).

/* racionalidade */

racional(player).
racional(zulu).
racional(mateo).
racional(peixe_voador).
racional(narrador).
racional(Quem):-
	jogador(Quem).


descreve(zulu,pescador).
descreve(mateo,comp_nominal(vendedor,carpintaria)).

preco(martelo,10).
preco(serrote,15).
preco(tesoura,2).
preco(vaso_ming,40).

/* pertinencia */
% zulu
dono(zulu, barco).
dono(zulu, tabuas).
dono(zulu, chapeu).
dono(zulu, sambura).

% mateo
dono(mateo, martelo).
dono(mateo, serrote).
dono(mateo, tesoura).
dono(mateo, velas).
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
caro(Objeto):-
	preco(Objeto,Preco),
	dinheiro(player,Saldo),
	Preco > Saldo.

suficiente(comp_nominal(meu,dinheiro), Objeto):-
	preco(Objeto,Preco),
	dinheiro(player,Saldo),
	Preco < Saldo.

/* quem conhece quem*/
conhecer(zulu, mateo).
conhecer(mateo, zulu).
conhecer(peixe_voador, zulu).
conhecer(peixe_voador, mateo).
conhecer(player,narrador).

/* defeito */
defeito(barco, buraco).
defeito(tesoura, semfio).

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

comprimento(tabuas, 100).
comprimento(buraco, 8).
comprimento(remo, 60).

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
        estar_em(player, CenaAtual),
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

amarravel(corda).

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
    assertz(estar(OQue, Onde)).

retirar(player,Tema):-
	sinonimo(tirar(player,Tema)).

tirar(player, (tema1:OQue ..tema2:DoQue)):-
    ter(player, DoQue),
	estar(OQue, DoQue),
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
    pegavel(OQue),
	nao(pregado(OQue,_)),
    estar(Quem,Aqui),
    estar(OQue,Aqui),
    (dono(Quem, OQue);nao(dono(_,OQue))),
	poder_especifico(pegar(Quem,OQue)),
    retractall(estar(OQue, _)),
    assertz(estar(OQue, Quem)).

/* vedar -- para vedar buracos */
vedar(buraco, X):-
     (X = vela ; X = chiclete),
     ter(player,X),!,
     unido(barco, tabuas),!,
     consertar(barco),
     retract(estar(X, player)).

vedar(barco, X):-
     (X = vela ; X = chiclete),
     estar_em(X, player),!,
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
        (estar_em(OQue, CenaAtual); OQue = CenaAtual),
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

finaliza_conversa(Pessoa):-
    falando_com(_, Pessoa),
    retract(falando_com(_, Pessoa)),
    assertz(falando_com(player,narrador)).

finaliza_conversa(Pessoa):-
    falando_com(Pessoa, _),
    retract(falando_com(Pessoa, _)),
    asserta(falando_com(player,narrador)).

/* acoes provenientes do lexico */
querer(zulu,vender(sambura)):-fail.
querer(player,_).
querer(mateo,comprar(peixe)).
querer(mateo,vender(OQue)):-
	\+ member(OQue,[balcao,carteira,estande]),
	nao(local(OQue)).

/* --- acoes de conversa com personagens --- */
poder_especifico(comprar(_)).

/* comprar objeto da pessoa */
comprar(player, Objeto):-
    falando_com(player, Pessoa), 
    dono(Pessoa,Objeto),
	querer(Pessoa,vender(Objeto)),
    poder_especifico(comprar(Objeto)),
	suficiente(comp_nominal(player,dinheiro),Objeto),
    retract(dono(_,Objeto)),
    asserta(estar(Objeto,player)).

vender(Quem, (tema1:OQue ..tema2:ParaQuem)):-
	dono(Quem,OQue),
	querer(ParaQuem, comprar(OQue)),
	querer(Quem,vender(OQue)),
    poder_especifico(vender(Quem,OQue)),
    retract(dono(_,OQue)),
    asserta(estar(OQue,ParaQuem)).


digitar(player, (tema1:OQue ..tema2:NoQue)):-
    OQue=senha,
	NoQue=caixa_eletronico,
	estar(cartao_credito,NoQue),
	estar(player,NoQue),
    assertz(digitado(OQue, NoQue)).

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

querer(_).
