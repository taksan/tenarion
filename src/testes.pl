:-[rpg].
:-[mecanismo_teste].

% Siga a sequencia e nomenclatura, o mecanismo de testes depende delas para funcionar.
teste1:-
    dado_pergunta_espero_resposta('o que tem aqui?', 'o barco, uma corda, algumas minhocas, uma vara de pescar e algumas tabuas estao aqui.').
teste2:- 
    dado_pergunta_espero_resposta('quem estah aqui?', 'voce e o zulu estao aqui.').
teste3:- 
    dado_pergunta_espero_resposta('onde eu estou?', 'voce estah no ancoradouro.').
teste4:-
    dado_pergunta_espero_resposta('onde eu posso ir?', 'voce pode ir para a carpintaria.').
teste5:-
    dado_pergunta_espero_resposta('o que eu posso pegar?', 'voce pode pegar algumas minhocas, uma vara de pescar e algumas tabuas.').
teste6:-
    dado_pergunta_espero_resposta('onde estah a corda?', 'ela estah no ancoradouro e no barco.').
teste7:-
    dado_pergunta_espero_resposta('eu posso pegar a corda?', 'nao').
teste8:-
    dado_pergunta_espero_resposta('eu pego ela.', 'voce nao pode pegar ela.').
teste9:-
    dado_pergunta_espero_resposta('o que eu tenho?', 'voce tem um cartao de credito, a identidade e a sua mao.').
teste10:-
    dado_pergunta_espero_resposta('as minhocas estao aqui?', 'sim').
teste11:-
    dado_pergunta_espero_resposta('o que sao elas?', 'elas sao algumas minhocas.').
teste12:-
    dado_pergunta_espero_resposta('eu pego elas.', 'ok').
teste13:-
    dado_pergunta_espero_resposta('o que eu tenho?', 'voce tem um cartao de credito, a identidade, algumas minhocas e a sua mao.').
teste14:-
    dado_pergunta_espero_resposta('o barco estah aqui?', 'sim').
teste15:-
    dado_pergunta_espero_resposta('o que eh ele?', 'ele eh o barco.').
teste16:-
    dado_pergunta_espero_resposta('onde estah o zulu?', 'ele estah no ancoradouro.').
teste17:-
    dado_pergunta_espero_resposta('o que eh ele?', 'ele eh o zulu.').
teste18:-
    dado_pergunta_espero_resposta('quem eh ele?', 'ele eh o zulu.').
teste19:-
	dado_pergunta_espero_resposta('quem estah no caixa eletronico?', 'ninguem estah nele.').
teste20:-
	dado_pergunta_espero_resposta('o que o zulu tem?', 'ele nao tem nada.').
teste21:-
	dado_pergunta_espero_resposta('eu falo com o zulu.', 'ok').
teste22:-
	dado_pergunta_espero_resposta('oi zulu.', 'oi.').
teste23:-
	dado_pergunta_espero_resposta('quem eh voce?', 'eu sou o zulu.').
teste24:-
	dado_pergunta_espero_resposta('quem sou eu?', 'voce eh o foo.').
teste25:-
	dado_pergunta_espero_resposta('onde estah a faca?', 'eu nao sei o que eh uma faca.').
teste26:-
	dado_pergunta_espero_resposta('eu pego as minhocas.', 'voce nao pode pegar elas porque voce jah tem as minhocas.').
teste27:-
	dado_pergunta_espero_resposta('o que eu posso consertar', 'voce nao pode consertar nada.').
teste28:-
	dado_pergunta_espero_resposta('eu pego a vara de pescar.', 'ok').
teste29:-
	dado_pergunta_espero_resposta('eu coloco as minhocas na vara de pescar.', 'ok').
teste30:-
	dado_pergunta_espero_resposta('o que tem na vara de pescar?', 'algumas minhocas estao nela.').

:-roda_testes.
:-halt.
