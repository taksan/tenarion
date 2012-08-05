:-[rpg].
:-[mecanismo_teste].
is_verbose:-true.

% Siga a sequencia e nomenclatura, o mecanismo de testes depende delas para funcionar.
teste01:-
    dado_pergunta_espero_resposta('o que tem aqui?', 'o barco, uma corda, algumas minhocas, algumas tabuas e uma vara de pescar estao aqui.').
teste02:- 
    dado_pergunta_espero_resposta('quem estah aqui?', 'o pescador estah aqui.').
teste03:- 
    dado_pergunta_espero_resposta('onde eu estou?', 'voce estah no ancoradouro.').
teste04:-
    dado_pergunta_espero_resposta('onde eu posso ir?', 'voce pode ir para a carpintaria.').
teste05:-
    dado_pergunta_espero_resposta('o que eu posso pegar?', 'voce pode pegar algumas minhocas e uma vara de pescar.').
teste06:-
    dado_pergunta_espero_resposta('onde estah a corda?', 'ela estah no ancoradouro e no barco.').
teste07a:-
    dado_pergunta_espero_resposta('eu posso pegar a corda?', 'nao').
teste07b:-
    dado_pergunta_espero_resposta('eu posso pegar as minhocas?', 'sim').
teste08:-
    dado_pergunta_espero_resposta('eu pego ela.', 'voce nao pode pega-la, porque ela estah amarrada.').
teste09:-
    dado_pergunta_espero_resposta('o que eu tenho?', 'voce tem um cartao de credito, a identidade e a sua mao.').
teste10_a:-
	dado_pergunta_espero_resposta('o martelo estah aqui?', 'nao').
teste10_b:-
    dado_pergunta_espero_resposta('as minhocas estao aqui?', 'sim').
teste11:-
    dado_pergunta_espero_resposta('o que elas sao?', 'elas sao algumas minhocas.').
teste12:-
    dado_pergunta_espero_resposta('eu pego elas.', 'ok').
teste13:-
    dado_pergunta_espero_resposta('o que eu tenho?', 'voce tem um cartao de credito, a identidade, algumas minhocas e a sua mao.').
teste14:-
    dado_pergunta_espero_resposta('o barco estah aqui?', 'sim').
teste15:-
    dado_pergunta_espero_resposta('o que eh ele?', 'ele eh o barco.').
teste16a:-
    dado_pergunta_espero_resposta('onde estah o zulu?', 'quem eh o zulu?').
teste16b:-
    dado_pergunta_espero_resposta('onde estah o pescador?', 'ele estah no ancoradouro.').
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
teste23:-
	dado_pergunta_espero_resposta('quem eh voce?', 'eu sou o zulu.').
teste23a:-
	dado_pergunta_espero_resposta('qual eh o seu nome?', 'o meu nome eh zulu.').
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
	dado_pergunta_espero_resposta('o que tem na vara de pescar?', 'as minhocas estao nela.').
teste30:-
	dado_pergunta_espero_resposta('o que eu posso consertar', 'voce nao pode consertar nada.').
teste31:-
	dado_pergunta_espero_resposta('eu pego as minhocas.', 'voce nao pode pega-las, porque elas nao estao aqui.').
teste32:-
	dado_pergunta_espero_resposta('eu desamarro a corda.', 'ok').
teste33:-
	dado_pergunta_espero_resposta('onde a corda estah?', 'ela estah no ancoradouro e no barco.').
teste34:-
	dado_pergunta_espero_resposta('eu pego a corda.', 'ok').
teste35:-
	dado_pergunta_espero_resposta('o que eu tenho?', 'voce tem um cartao de credito, uma corda, a identidade, a sua mao e uma vara de pescar.').
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
teste41:-
	dado_pergunta_espero_resposta('eu pego o barco.', 'voce nao pode pega-lo, porque ele nao eh pegavel.').
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
	dado_pergunta_espero_resposta('eu entro no ancoradouro.', 'voce nao pode entrar nele, porque ele nao eh um local fechado.').
teste51:-
	dado_pergunta_espero_resposta('onde eu estou?', 'voce estah na carpintaria.').
teste52:-
	dado_pergunta_espero_resposta('onde estao os pregos do barco?', 'os pregos do barco estao no barco.').
teste53:-
	dado_pergunta_espero_resposta('onde estah o dono do barco?', 'o dono do barco estah no ancoradouro.').
teste54:-
	dado_pergunta_espero_resposta('quem eh o dono do barco?', 'eu sou o dono do barco.').
teste55:-
	dado_pergunta_espero_resposta('tchau.', 'tchau.').
teste55a:-
	dado_pergunta_espero_resposta('o que estah com o zulu?','o sambura estah com ele.').
teste56:-
	dado_pergunta_espero_resposta('quem eh o dono do barco?', 'o zulu eh o dono do barco.').
teste57:-
	dado_pergunta_espero_resposta('onde estao as tabuas do zulu?', 'as tabuas do zulu estao no ancoradouro.').
teste58:-
	dado_pergunta_espero_resposta('onde estah o sambura do zulu?', 'o sambura do zulu estah com o zulu.').
teste59:-
	dado_pergunta_espero_resposta('quem estah aqui?', 'o vendedor da carpintaria estah aqui.').
teste60:-
	dado_pergunta_espero_resposta('eu falo com ele.', 'ok').
teste61:-
	dado_pergunta_espero_resposta('oi.','oi.').
teste62:-
	dado_pergunta_espero_resposta('quem eh voce.','eu sou o mateo.').
teste64:-
	dado_pergunta_espero_resposta('tchau.','tchau.').
teste65:-
	dado_pergunta_espero_resposta('quem estah aqui?','o mateo estah aqui.').
teste66:-
	dado_pergunta_espero_resposta('quem eh o vendedor?', 'o mateo eh o vendedor.').
teste67:-
	dado_pergunta_espero_resposta('eu falo com o vendedor.', 'ok').


:-roda_testes.
:-halt.
