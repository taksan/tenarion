:-[rpg].
:-[mecanismo_teste].
is_verbose:-true.

% os testes sao deterministicamente executador na ordem alfabetica.
% a ordem dos testes nao eh facultativa!
teste01:-
    dado_pergunta_espero_resposta('o que tem aqui?', 'aqui tem o barco, uma corda, algumas minhocas, algumas tabuas e uma vara de pescar.').
teste02:- 
    dado_pergunta_espero_resposta('quem estah aqui?', 'o pescador estah aqui.').
teste03:- 
    dado_pergunta_espero_resposta('onde eu estou?', 'voce estah no embarcadouro.').
teste04:-
    dado_pergunta_espero_resposta('onde eu posso ir?', 'voce pode ir para a carpintaria.').
teste05:-
    dado_pergunta_espero_resposta('o que eu posso pegar?', 'voce pode pegar algumas minhocas e uma vara de pescar.').
teste06:-
    dado_pergunta_espero_resposta('onde estah a corda?', 'ela estah no barco e no embarcadouro.').
teste07a:-
    dado_pergunta_espero_resposta('eu posso pegar a corda?', 'nao').
teste07b:-
    dado_pergunta_espero_resposta('eu posso pegar as minhocas?', 'sim').
teste08:-
    dado_pergunta_espero_resposta('eu pego ela.', 'voce nao pode pega-la, porque ela estah amarrada.').
teste09:-
    dado_pergunta_espero_resposta('o que eu tenho?', 'voce tem um cartao de credito, a identidade, a sua mao e 5 pratas.').
teste10_a:-
	dado_pergunta_espero_resposta('o martelo estah aqui?', 'nao').
teste10_b:-
    dado_pergunta_espero_resposta('as minhocas estao aqui?', 'sim').
teste11:-
    dado_pergunta_espero_resposta('o que elas sao?', 'elas sao algumas minhocas.').
teste12:-
    dado_pergunta_espero_resposta('eu pego elas.', 'ok').
teste13:-
    dado_pergunta_espero_resposta('o que eu tenho?', 'voce tem um cartao de credito, a identidade, algumas minhocas, a sua mao e 5 pratas.').
teste14:-
    dado_pergunta_espero_resposta('o barco estah aqui?', 'sim').
teste15:-
    dado_pergunta_espero_resposta('o que eh ele?', 'ele eh o barco.').
teste16a:-
    dado_pergunta_espero_resposta('onde estah o zulu?', 'quem eh o zulu?').
teste16b:-
    dado_pergunta_espero_resposta('onde estah o pescador?', 'ele estah no embarcadouro.').
teste16c:-
	dado_pergunta_espero_resposta('o que o pescador tem?', 'ele tem um sambura.').
teste17:-
    dado_pergunta_espero_resposta('o que eh ele?', 'ele eh um pescador.').
teste18:-
    dado_pergunta_espero_resposta('quem eh ele?', 'ele eh um pescador.').
teste19:-
	dado_pergunta_espero_resposta('quem estah no caixa eletronico?', 'ninguem estah no caixa eletronico.').
teste20_a:-
	dado_pergunta_espero_resposta('o que o peixe voador tem?', 'quem eh o peixe voador?').
teste20_b:-
	dado_pergunta_espero_resposta('o que o pescador tem?', 'ele tem um sambura.').
teste20_c:-
	dado_pergunta_espero_resposta('o que voce tem?', 'eu nao tenho nada.').
teste20_d:-
	dado_pergunta_espero_resposta('quem eh voce?', 'eu sou o narrador.').
teste21:-
	dado_pergunta_espero_resposta('eu falo com o pescador.', 'ok').
teste22:-
	dado_pergunta_espero_resposta('oi.', 'oi.').
teste22a:-
	dado_pergunta_espero_resposta('quem sou eu?', 'eu nao sei.').
teste23:-
	dado_pergunta_espero_resposta('quem eh voce?', 'eu sou o zulu. quem eh voce?').
teste23a:-
	dado_pergunta_espero_resposta('eu sou o foo.', 'oi foo.').
teste23b:-
	dado_pergunta_espero_resposta('qual eh o seu nome?', 'o meu nome eh zulu.').
teste23c:-
	dado_pergunta_espero_resposta('qual o seu nome?', 'o meu nome eh zulu.').
teste24:-
	dado_pergunta_espero_resposta('quem sou eu?', 'voce eh o foo.').
teste24a:-
	dado_pergunta_espero_resposta('eu compro o sambura.', 'voce nao pode compra-lo, porque eu nao quero vende-lo.').
teste25:-
	dado_pergunta_espero_resposta('onde estah a faca?', 'eu nao sei o que eh uma faca.').
teste26:-
	dado_pergunta_espero_resposta('eu pego a vara de pescar.', 'ok').
teste27:-
	dado_pergunta_espero_resposta('eu pego as minhocas.', 'voce nao pode pega-las, porque elas ja estao contigo.').
teste28:-
	dado_pergunta_espero_resposta('eu coloco as minhocas na vara de pescar.', 'ok').
teste29:-
	dado_pergunta_espero_resposta('o que tem na vara de pescar?', 'ela tem algumas minhocas.').
teste30:-
	dado_pergunta_espero_resposta('o que eu posso consertar', 'voce nao pode consertar nada.').
teste31:-
	dado_pergunta_espero_resposta('eu pego as minhocas.', 'voce nao pode pega-las, porque elas nao estao aqui.').
teste32:-
	dado_pergunta_espero_resposta('eu desamarro a corda.', 'ok').
teste33:-
	dado_pergunta_espero_resposta('onde a corda estah?', 'ela estah no barco e no embarcadouro.').
teste34:-
	dado_pergunta_espero_resposta('eu pego a corda.', 'ok').
teste35:-
	dado_pergunta_espero_resposta('o que eu tenho?', 'voce tem um cartao de credito, uma corda, a identidade, a sua mao, uma vara de pescar e 5 pratas.').
teste36:-
	dado_pergunta_espero_resposta('eu tiro as minhocas da vara de pescar.', 'ok').
teste37:-
	dado_pergunta_espero_resposta('onde as minhocas estao?', 'elas estao contigo.').
teste38:-
	dado_pergunta_espero_resposta('eu tiro as minhocas da vara de pescar.', 'voce nao pode tira-las da vara de pescar, porque elas ja estao contigo.').
teste39:-
	dado_pergunta_espero_resposta('eu largo as minhocas.', 'ok').
teste40:-
	dado_pergunta_espero_resposta('eu tiro as minhocas da vara de pescar.', 'voce nao pode tira-las da vara de pescar, porque elas nao estao na vara de pescar.').
teste40a:-
	dado_pergunta_espero_resposta('eu retiro as minhocas da vara de pescar.', 'voce nao pode retira-las da vara de pescar, porque elas nao estao na vara de pescar.').
teste41:-
	dado_pergunta_espero_resposta('eu pego o barco.', 'voce nao pode pega-lo, porque ele eh muito grande.').
teste42:-
	dado_pergunta_espero_resposta('eu pego as tabuas.', 'voce nao pode pega-las, porque voce nao eh o dono delas.').
teste43:-
	dado_pergunta_espero_resposta('o que eu vejo?', 'voce nao ve nada.').
teste44:-
	dado_pergunta_espero_resposta('o que voce tem?', 'eu tenho um sambura.').
teste45:-
	dado_pergunta_espero_resposta('quem estah no barco?', 'ninguem estah no barco.').
teste46:-
	dado_pergunta_espero_resposta('eu vou para o barco.', 'voce nao pode ir para ele, porque ele estah quebrado.').
teste47:-
	dado_pergunta_espero_resposta('eu entro no barco.', 'voce nao pode entrar nele, porque ele estah quebrado.').
teste48:-
	dado_pergunta_espero_resposta('eu vou para o caixa eletronico.', 'voce nao pode ir para ele, porque ele nao estah perto daqui.').
teste49:-
	dado_pergunta_espero_resposta('eu vou para a carpintaria.', 'ok').
teste50:-
	dado_pergunta_espero_resposta('eu entro no embarcadouro.', 'voce nao pode entrar nele, porque ele nao eh um local fechado.').
teste51:-
	dado_pergunta_espero_resposta('onde eu estou?', 'voce estah na carpintaria.').
teste52:-
	dado_pergunta_espero_resposta('onde estao os pregos do barco?', 'os pregos do barco estao no barco.').
teste53:-
	dado_pergunta_espero_resposta('onde estah o dono do barco?', 'o dono do barco estah no embarcadouro.').
teste54:-
	dado_pergunta_espero_resposta('quem eh o dono do barco?', 'eu sou o dono do barco.').
teste55:-
	dado_pergunta_espero_resposta('tchau.', 'tchau.').
teste55a:-
	dado_pergunta_espero_resposta('o que estah com o zulu?','o sambura estah com ele.').
teste56:-
	dado_pergunta_espero_resposta('quem eh o dono do barco?', 'o zulu eh o dono do barco.').
teste57:-
	dado_pergunta_espero_resposta('onde estao as tabuas do zulu?', 'as tabuas do zulu estao no embarcadouro.').
teste58:-
	dado_pergunta_espero_resposta('onde estah o sambura do zulu?', 'o sambura do zulu estah com o zulu.').
teste59:-
	dado_pergunta_espero_resposta('quem estah aqui?', 'o vendedor da carpintaria estah aqui.').
teste60:-
	dado_pergunta_espero_resposta('eu falo com ele.', 'ok').
teste61:-
	dado_pergunta_espero_resposta('oi.','oi.').
teste62:-
	dado_pergunta_espero_resposta('quem eh voce?','eu sou o mateo.').
teste64:-
	dado_pergunta_espero_resposta('tchau.','tchau.').
teste65:-
	dado_pergunta_espero_resposta('quem estah aqui?','o mateo estah aqui.').
teste66:-
	dado_pergunta_espero_resposta('quem eh o vendedor?', 'o mateo eh o vendedor.').
teste67:-
	dado_pergunta_espero_resposta('eu falo com o vendedor.', 'ok').
teste68:-
	dado_pergunta_espero_resposta('o que voce tem para vender?', 'eu tenho o santo do pau oco, um poster, um vaso ming, algumas velas, uma tesoura, um serrote e um martelo para vender.').
teste69:-
	dado_pergunta_espero_resposta('eu quero comprar o martelo.','ok').
teste69a:-
	dado_pergunta_espero_resposta('eu compro o martelo.','voce nao pode compra-lo, porque o seu dinheiro nao eh suficiente.').
teste69b:-
	dado_pergunta_espero_resposta('quanto dinheiro eu tenho?','voce tem 5 pratas.').
teste69c:-
	dado_pergunta_espero_resposta('quanto custa o martelo?','ele custa 10 pratas.').
teste69d:-
	dado_pergunta_espero_resposta('qual o preco do martelo?','o preco dele eh 10 pratas.').
teste69e:-
	dado_pergunta_espero_resposta('qual o preco da tesoura?','o preco da tesoura eh 2 pratas.').
teste69f:-
	dado_pergunta_espero_resposta('eu compro ela.','ok').
teste69g:-
	dado_pergunta_espero_resposta('quanto dinheiro eu tenho?','voce tem 3 pratas.').
teste70:-
	dado_pergunta_espero_resposta('eu vou para o caixa eletronico.','ok').
teste70a:-
	dado_pergunta_espero_resposta('o que tem no caixa eletronico?','aqui tem um teclado e uma tela.').
teste70b:-
	dado_pergunta_espero_resposta('eu coloco o cartao de credito no caixa eletronico.', 'o caixa eletronico estah pedindo a sua senha.').
teste70c:-
	dado_pergunta_espero_resposta('eu digito a senha no teclado.','o menu do caixa eletronico apareceu na tela.').
teste70d:-
	dado_pergunta_espero_resposta('o que tem no caixa eletronico?','aqui tem um cartao de credito, um teclado e uma tela.').
teste70e:-
	dado_pergunta_espero_resposta('o que tem na tela?','ela tem um menu do caixa eletronico.').
teste70f:-
	dado_pergunta_espero_resposta('o que tem no menu do caixa eletronico?','o menu do caixa eletronico tem uma opcao do saldo e uma opcao de um saque.').
teste70g:-
	dado_pergunta_espero_resposta('qual o valor do saldo?','o valor do saldo eh 20 pratas.').
teste70h:-
	dado_pergunta_espero_resposta('eu seleciono a opcao de saldo.','o valor do saldo eh 20 pratas.').
teste71:-
	dado_pergunta_espero_resposta('eu pego.', 'o que voce pega?').
teste72:-
	dado_pergunta_espero_resposta('eu digito 20 no teclado.','voce nao pode digitar 20 no teclado, porque a opcao do saque nao estah selecionada.').
teste72a:-
	dado_pergunta_espero_resposta('eu seleciono a opcao de saque.','o caixa eletronico estah pedindo o valor.').
teste72b:-
	dado_pergunta_espero_resposta('eu digito 20 no teclado.','a opcao da confirmacao apareceu na tela.').
teste72c:-
	dado_pergunta_espero_resposta('eu seleciono a opcao de confirmacao.','20 pratas apareceram no caixa eletronico.').
teste73:-
	dado_pergunta_espero_resposta('eu pego 10 pratas.','ok').
teste73a:-
	dado_pergunta_espero_resposta('quanto dinheiro tem aqui?','aqui tem 10 pratas.').
teste74:-
	dado_pergunta_espero_resposta('quanto dinheiro eu tenho?','voce tem 13 pratas.').
teste74a:-
	dado_pergunta_espero_resposta('quanto eu tenho?','voce tem 13 pratas.').
teste74b:-
	dado_pergunta_espero_resposta('o que tem aqui?','aqui tem um cartao de credito, um teclado, uma tela e 10 pratas.').
teste75:-
	dado_pergunta_espero_resposta('eu pego o dinheiro.','ok').
teste76:-
	dado_pergunta_espero_resposta('quanto dinheiro eu tenho?','voce tem 23 pratas.').
teste77:-
	dado_pergunta_espero_resposta('o que tem aqui?','aqui tem um cartao de credito, um teclado e uma tela.').
teste78:-
	dado_pergunta_espero_resposta('eu tiro o cartao de credito do caixa eletronico.','ok').
teste79:-
	dado_pergunta_espero_resposta('eu insiro o cartao de credito no caixa eletronico.','o caixa eletronico estah pedindo a sua senha.').


:-roda_testes.
:-halt.
