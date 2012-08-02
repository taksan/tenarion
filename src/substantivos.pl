%%%% NOMES 

% personagens (pessoas)
np(id:zulu ..gen:masc ..num:sing ..desconhecido:nao ..tipo:np) --> [zulu].
np(id:mateo ..gen:masc ..num:sing ..desconhecido:nao ..tipo:np) --> [mateo].
np(id:narrador ..gen:masc ..num:sing ..desconhecido:nao ..tipo:np) --> [narrador].

np(id:sua_mao ..gen:fem ..num:sing ..desconhecido:nao) --> [sua],[mao].

% objetos com nomes proprios (np), serao designados com o os a as
np(id:ancoradouro .. tipo:np ..num:sing ..gen:masc ..desconhecido:nao) --> [ancoradouro].
np(id:balcao .. tipo:np ..num:sing ..gen:masc ..desconhecido:nao) --> [balcao].
np(id:carpintaria .. tipo:np ..num:sing ..gen:fem ..desconhecido:nao) --> [carpintaria].
np(id:caixa_eletronico .. tipo:np ..num:sing ..gen:masc ..desconhecido:nao) --> [caixa],[eletronico].
np(id:estande .. tipo:np ..num:sing ..gen:masc ..desconhecido:nao) --> [estande].
np(id:feiticeira .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [feiticeira].
np(id:ilha .. tipo:np ..num:sing ..gen:fem ..desconhecido:nao) --> [ilha].
np(id:jogo .. tipo:np ..num:sing ..gen:masc ..desconhecido:nao) --> [jogo].
np(id:lago .. tipo:np ..num:sing ..gen:masc ..desconhecido:nao) --> [lago].
np(id:santo_do_pau_oco .. tipo:np ..num:sing ..gen:masc ..desconhecido:nao) --> [santo],[do],[pau],[oco].
np(id:identidade .. tipo:np ..num:sing ..gen:fem ..desconhecido:nao) --> [identidade].
np(id:barco .. tipo:np ..num:sing ..gen:masc ..desconhecido:nao) --> [barco].

np(id:agua_do_lago .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [agua].
np(id:botoes .. tipo:nc ..num:plur ..gen:masc ..desconhecido:nao) --> [botoes].
np(id:buraco .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [buraco].
np(id:carteira .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [carteira].
np(id:caixa_registradora .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [caixa],[registradora].
np(id:cartao_credito .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [cartao],[de],[credito].
np(id:cartao_credito .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [cartao].
np(id:chiclete .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [chiclete].
np(id:circulo_de_velas .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [circulo],[de],[velas].
np(id:corda .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [corda].
np(id:dinheiro .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [dinheiro].
np(id:mao .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [mao].
np(id:martelo .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [martelo].
np(id:minhocas .. tipo:nc ..num:plur ..gen:fem ..desconhecido:nao) --> [minhocas].
np(id:peixe .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [peixe].
np(id:peixe_voador .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [peixe],[voador].
np(id:peixes .. tipo:nc ..num:plur ..gen:masc ..desconhecido:nao) --> [peixes].
np(id:placa_nome_loja .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [placa].
np(id:poster .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [poster].
np(id:pregos .. tipo:nc ..num:plur ..gen:masc ..desconhecido:nao) --> [pregos].
np(id:serrote .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [serrote].
np(id:tabua ..tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [tabua].
np(id:tabuas ..tipo:nc ..num:plur ..gen:fem ..desconhecido:nao) --> [tabuas].
np(id:tela .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [tela].
np(id:tesoura .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [tesoura].
np(id:vara_pescar .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [vara], [de], [pescar].
np(id:vaso_ming .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [vaso],[ming].
np(id:vela .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [vela].
np(id:(vela, _) .. tipo:nc ..num:plur ..gen:fem ..desconhecido:nao) --> [velas].
np(id:vitoria_regia .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [vitoria-regia].
np(id:sambura ..tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [sambura].
np(id:chapeu ..tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [chapeu].
np(id:dono ..tipo:np ..num:sing ..gen:masc ..desconhecido:nao) --> [dono].
np(id:homem ..tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [homem].
np(id:mulher ..tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [mulher].
np(id:pescador ..tipo:np ..num:sing ..gen:masc ..desconhecido:nao) --> [pescador].
np(id:vendedor ..tipo:np ..num:sing ..gen:masc ..desconhecido:nao) --> [vendedor].

np(id:local_fechado ..tipo:nc ..gen:masc ..num:sing ..desconhecido:nao)-->[local],[fechado].
np(id:Jogador ..tipo:np ..num:sing ..gen:GeneroJogador ..desconhecido:nao)-->
	{ jogador(Jogador), sexo_jogador(GeneroJogador) },
	[ Jogador ].

% casa com nomes desconhecidos, ou seja, objetos ou pessoas desconhecidas.
np(id:desconhecido(texto: Texto ..tipo:Tipo ..gen:G ..num:N) ..tipo:Tipo ..gen:G ..num:N ..desconhecido:sim) --> [Texto].


