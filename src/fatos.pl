dinheiro(player,5).
saldo_conta(player,20).

/* DETERMINA CONEXAO ENTRE LOCAIS */

adjacente(embarcadouro, carpintaria).
adjacente(embarcadouro, lago).
adjacente(barco, lago).
adjacente(lago, ilha).


/* LOCAL: JOGO  -- todos os cenarios do jogo */
estar(embarcadouro, jogo).
estar(carpintaria, jogo).
estar(lago, jogo).
estar(ilha, jogo).

/* LOCAL: ANCORADOURO */

estar(tabuas, embarcadouro).
estar(vara_pescar, embarcadouro).
estar(minhocas, embarcadouro).
estar(barco, embarcadouro).
estar(zulu, embarcadouro).
estar(corda, embarcadouro).

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
estar(teclado, caixa_eletronico).
estar(tela, caixa_eletronico).

/* LOCAL: LAGO */
estar(agua_do_lago, lago).
estar(peixe_voador, lago).

/* AGUA DO LAGO */
estar(peixe, agua_do_lago).
estar(vitoria_regia, agua_do_lago).

/* PERSONAGENS */
estar(sambura, zulu).

/* Inventario */
estar(identidade, player).
estar(cartao_credito, player).
estar(sua_mao, player).

estar(comp_nominal(opcao,saque),comp_nominal(menu,caixa_eletronico)).
estar(comp_nominal(opcao,saldo),comp_nominal(menu,caixa_eletronico)).

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
pegavel(barco).
pegavel(dinheiro).

amarrado(corda,barco).
amarrado(corda,embarcadouro).

/* indica que e um local e que o personagem pode "ir para" ele */
local(embarcadouro).
local(carpintaria).
local(ilha).
local(lago).
local(barco).
local(caixa_eletronico).

/* racionalidade */

racional(player).
racional(zulu).
racional(mateo).
racional(peixe_voador).
racional(narrador).
racional(Quem):-
	jogador(Quem).

quanto_custa(martelo,10).
quanto_custa(serrote,15).
quanto_custa(tesoura,2).
quanto_custa(vaso_ming,40).

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

/* quem conhece quem*/
conhecer(zulu, mateo).
conhecer(mateo, zulu).
conhecer(peixe_voador, zulu).
conhecer(peixe_voador, mateo).
conhecer(player,narrador).

/* defeito */
defeito(barco, buraco).
defeito(tesoura, semfio).

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
grande(barco).

/* determina tamanho dos elementos do jogo */

comprimento(tabuas, 100).
comprimento(buraco, 8).
comprimento(remo, 60).

amarravel(corda).

/**** objetos especiais */
conj_velas([1,2,3,4,5,6,7,8,9,10,11,12,13]).

ultima_tabua(1).

querer(zulu,vender(sambura)):-fail.
querer(player,_).
querer(mateo,comprar(peixe)).
querer(mateo,vender(OQue)):-
	\+ member(OQue,[balcao,carteira,estande]),
	nao(local(OQue)).

descreve(zulu,pescador).
descreve(mateo,comp_nominal(vendedor,carpintaria)).

