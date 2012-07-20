:-[gulp].

%%%% ADJETIVOS

a(adj:sem_fio ..gen:_ ..num:_) --> [sem], [fio].
a(adj:grande ..gen:_ ..num:sing) --> [grande].
a(adj:grande ..gen:_ ..num:plur) --> [grandes].
a(adj:voador ..gen:masc ..num:sing) --> [voador].
a(adj:voador ..gen:masc ..num:plur) --> [voadores].
a(adj:pequeno ..gen:fem ..num:sing) --> [pequena].
a(adj:pequeno ..gen:masc ..num:sing) --> [pequeno].
a(adj:pequeno ..gen:fem ..num:plur) --> [pequenas].
a(adj:pequeno ..gen:masc ..num:plur) --> [pequenos].
a(adj:defeito ..gen:masc ..num:sing) --> [estragado].
a(adj:defeito ..gen:fem ..num:sing) --> [estragada].
a(adj:acesa ..gen:fem ..num:sing) --> [acesa].
a(adj:acesa ..gen:fem ..num:plur) --> [acesas].

a(adj:_ ..gen:_ ..num:_) --> [].


%%%% QUANT
quant((gen:masc.. num:sing)) --> [todo].
quant((gen:fem.. num:sing)) --> [toda].
quant((gen:masc.. num:plur)) --> [todos].
quant((gen:fem.. num:plur)) --> [todas].
quant((gen:masc.. num:sing)) --> [algum].
quant((gen:fem.. num:sing)) --> [alguma].
quant((gen:masc.. num:plur)) --> [alguns].
quant((gen:fem.. num:plur)) --> [algumas].
quant((gen:masc.. num:sing)) --> [nenhum].
quant((gen:fem.. num:sing)) --> [nenhuma].
quant(_) --> [].

%%%% NUMERO
num(gen:fem.. num:sing) --> [uma].
num(gen:fem.. num:plur) --> [duas].
num(num:plur) -->   [tres].
num(num:plur) -->   [quatro].
num(num:plur) -->   [cinco].
num(num:plur) -->   [seis].
num(num:plur) -->   [sete].
num(num:plur) -->   [oito].
num(num:plur) -->   [nove].
num(num:plur) -->   [dez].
num(num:plur) -->   [onze].
num(num:plur) -->   [doze].
num(num:plur) -->   [treze].
num(_) -->   [].

%%%% ADV* (que raio � isso??)
adv -->  [bem].
adv -->  [mais].

%%%% IDENT
% tipo:nc -> nome comum
% tipo:np -> nome proprio
% vai preferir usar nc para respostas, a nao ser que o objeto seja NP mesmo
ident(gen:masc.. num:sing ..tipo:np) --> [o].
ident(gen:fem.. num:sing ..tipo:np) --> [a].
ident(gen:masc.. num:plur ..tipo:np) --> [os].
ident(gen:fem.. num:plur ..tipo:np) --> [as].
ident(gen:masc.. num:sing..tipo:nc) --> [um].
ident(gen:fem.. num:sing..tipo:nc) --> [uma]. 
ident(gen:masc.. num:plur..tipo:nc) --> [alguns].
ident(gen:masc.. num:plur..tipo:nc) --> [uns].
ident(gen:fem.. num:plur..tipo:nc) --> [algumas].
ident(gen:fem.. num:plur..tipo:nc) --> [umas].

% em dialogos, o a os as podem ser usados com nomes comuns
ident(gen:masc.. num:sing ..tipo:nc) --> [o].
ident(gen:fem.. num:sing ..tipo:nc) --> [a].
ident(gen:masc.. num:plur ..tipo:nc) --> [os].
ident(gen:fem.. num:plur ..tipo:nc) --> [as].

ident(tipo:np) --> [].

%%%% POSSESSIVOS
poss((poss:meu.. gen:masc.. num:sing)) -->  [meu].
poss((poss:meu.. gen:fem.. num:sing)) -->  [minha].
poss((poss:meu.. gen:masc.. num:plur)) -->  [meus].
poss((poss:meu.. gen:fem.. num:plur)) -->  [minhas].
poss((poss:seu.. gen:masc.. num:sing)) -->  [seu].
poss((poss:seu.. gen:fem.. num:sing)) -->  [sua].
poss((poss:seu.. gen:masc.. num:plur)) -->  [seus].
poss((poss:seu.. gen:fem.. num:plur)) -->  [suas].
poss((poss:nosso.. gen:masc.. num:sing)) -->  [nosso].
poss((poss:nosso.. gen:fem.. num:sing)) -->  [nossa].
poss(_) -->  [].

%%%% PREPOSICOES
prep(prep:com) --> [com].
prep(prep:em) --> [em].
prep(prep:para) --> [para].
prep(prep:de) --> [de].
prep(prep:a) --> [a].

%%%% NOMES 

% personagens (pessoas)
np(id:zulu ..gen:masc ..num:sing ..desconhecido:nao ..tipo:np) --> [zulu].
np(id:mateo ..gen:masc ..num:sing ..desconhecido:nao ..tipo:np) --> [mateo].

np(id:sua(mao) ..gen:fem ..num:sing ..desconhecido:nao) --> [sua],[mao].

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
np(id:(tabua,_) ..tipo:nc ..num:plur ..gen:fem ..desconhecido:nao) --> [tabuas].
np(id:tela .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [tela].
np(id:tesoura .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [tesoura].
np(id:vara_pescar .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [vara], [de], [pescar].
np(id:vaso_ming .. tipo:nc ..num:sing ..gen:masc ..desconhecido:nao) --> [vaso],[ming].
np(id:vela .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [vela].
np(id:(vela, _) .. tipo:nc ..num:plur ..gen:fem ..desconhecido:nao) --> [velas].
np(id:vitoria_regia .. tipo:nc ..num:sing ..gen:fem ..desconhecido:nao) --> [vitoria-regia].

% casa com nomes desconhecidos, ou seja, objetos ou pessoas desconhecidas.
np(id:T ..desconhecido:sim) --> [T].

%%%% PRONOMES
pro(tipo_pro:reto .. num:sing .. pessoa:prim ..pron:eu) --> [eu].
pro(tipo_pro:reto .. num:sing .. pessoa:terc ..gen:fem ..pron:ela) --> [ela].
pro(tipo_pro:reto .. num:sing .. pessoa:terc ..gen:masc ..pron:ele) --> [ele].
pro(tipo_pro:reto .. num:plur .. pessoa:terc ..gen:fem ..pron:ela) --> [elas].
pro(tipo_pro:reto .. num:plur .. pessoa:terc ..gen:masc ..pron:ele) --> [eles].
pro(tipo_pro:voce .. num:sing .. pessoa:terc ..pron:voce) --> [voce].
pro(tipo_pro:voce .. num:sing .. pessoa:terc ..pron:voce_resp) --> [voce].
pro(tipo_pro:reto .. num:plur .. pessoa:prim ..pron:nos) --> [nos].
pro(tipo_pro:obliquo ..num:sing ..pessoa:prim ..subcat:[] ..pron:mim) --> [mim].
pro(tipo_pro:obliquo ..num:sing ..pessoa:prim ..subcat:[sv] ..pron:me) --> [me].
pro(tipo_pro:obliquo ..num:sing ..pessoa:seg ..pron:te) -->  [te].
pro(tipo_pro:pron_qu ..pron:quem) --> [quem].
pro(tipo_pro:pron_qu ..pron:que) --> [que].
pro(tipo_pro:pron_qu ..pron:oque) --> [o],[que].
pro(tipo_pro:pron_qu ..pron:qual ..num:sing ) --> [qual].
pro(tipo_pro:pron_qu ..pron:qual ..num:plur ) --> [quais].
pro(tipo_pro:pron_ninguem(quem) ..pron:ninguem) --> [ninguem].
pro(tipo_pro:pron_ninguem(oque) ..pron:nada)--> [nada].
pro(tipo_pro:pron_ninguem(onde) ..pron:nenhum)--> [nenhum].

pro(tipo_pro:demonstrativo ..pron:esse ..gen:masc.. num:sing) --> [esse].
pro(tipo_pro:demonstrativo ..pron:essa ..gen:fem.. num:sing) --> [essa].
pro(tipo_pro:demonstrativo ..pron:esses ..gen:masc.. num:plur) --> [esses].
pro(tipo_pro:demonstrativo ..pron:essas ..gen:fem.. num:plur) --> [essas].
pro(tipo_pro:demonstrativo ..pron:este ..gen:masc.. num:sing) --> [este].
pro(tipo_pro:demonstrativo ..pron:esta ..gen:fem.. num:sing) --> [esta].
pro(tipo_pro:demonstrativo ..pron:estes ..gen:masc.. num:plur) --> [estes].
pro(tipo_pro:demonstrativo ..pron:estas ..gen:fem.. num:plur) --> [estas].
pro(tipo_pro:demonstrativo ..pron:aquele ..gen:masc.. num:sing) --> [aquele].
pro(tipo_pro:demonstrativo ..pron:aquela ..gen:fem.. num:sing) --> [aquela].
pro(tipo_pro:demonstrativo ..pron:aqueles ..gen:masc.. num:plur) --> [aqueles].
pro(tipo_pro:demonstrativo ..pron:aquelas ..gen:fem.. num:plur) --> [aquelas].
pro(tipo_pro:demonstrativo ..pron:aquilo ..gen:masc.. num:sing) --> [aquilo].
pro(tipo_pro:relativo ..pron:onde) --> [onde].

%%%% ADVERBIOS
advb(tipo_adv:lugar ..adv:aqui) --> [aqui].
advb(tipo_adv:lugar ..adv:la) --> [la].
advb(tipo_adv:afirmacao ..adv:nao) --> [nao].
advb(tipo_adv:afirmacao ..adv:sim) --> [].

%%%% VERBOS
% INTRANSITIVO        : subcat:[]
% TRANSITIVO DIRETO   : subcat:[sn]
% TRANSITIVO INDIRETO : subcat[sp(prep:P)] P = preposição exigida
% BITRANSITIVO        : subcat[sn, sp(prep:P)] P = preposição exigida para o 2o objeto

% VERBO: ESTAR
v(omite:nao ..acao:estar ..num:sing ..pessoa: terc ..subcat:[advb] ..poss:nao) --> 
        [estah].
v(omite:nao ..acao:estar ..num:sing ..pessoa: terc ..subcat:[sp(prep:em)] ..poss:nao) --> 
        [estah].
v(omite:nao ..acao:estar ..num:plur ..pessoa: terc ..subcat:[advb]..poss:nao) --> 
        [estao].
v(omite:nao ..acao:estar ..num:plur ..pessoa: terc ..subcat:[sp(prep:em)]..poss:nao) --> 
        [estao].
v(omite:nao ..acao:estar ..num:sing ..pessoa: prim ..subcat:[advb] ..poss:nao) --> 
        [estou].
v(omite:nao ..acao:estar ..num:sing ..pessoa: prim ..subcat:[sp(prep:em)] ..poss:nao) --> 
        [estou].
v(omite:_ ..acao:estar ..num:plur ..pessoa: prim ..subcat:[sp(prep:em)] ..poss:nao) --> 
        [estamos].
v(omite:_ ..acao:estar ..num:plur ..pessoa: prim ..subcat:[advb] ..poss:nao) --> 
        [estamos].
v(omite:_ ..acao:estar ..num:sing ..pessoa: indic ..subcat:[sp(prep:em)]) --> [estar].

% VERBO: SER
v(omite:_   ..acao:ser .. num:sing ..pessoa: terc ..subcat:[sn]) --> ['eh'].
v(omite:nao ..acao:ser .. num:sing ..pessoa: indic ..subcat:[sn]) --> [ser].
v(omite:nao ..acao:ser .. num:sing ..pessoa: prim ..subcat:[sn]) --> [sou].
v(omite:nao ..acao:ser .. num:sing ..pessoa: prim ..subcat:[sa]) --> [sou].
v(omite:nao ..acao:ser .. num:sing ..pessoa: terc ..subcat:[sa]) --> ['eh'].
v(omite:nao ..acao:ser .. num:plur ..pessoa: prim ..subcat:[sa]) --> [sao].

v(omite:nao ..acao:pertencer .. num:sing ..pessoa: terc ..subcat:[sp(prep:de)]) --> ['eh'].
v(omite:nao ..acao:pertencer .. num:plur ..pessoa: prim ..subcat:[sp(prep:de)]) --> [sao].

% VERBO: CONHECER
v(omite:nao ..acao:conhecer ..num:sing  ..pessoa: prim ..subcat:[sn]) --> [conheco].
v(omite:nao ..acao:conhecer ..num:sing  ..pessoa: terc ..subcat:[sn]) --> [conhece].
v(omite:nao ..acao:conhecer ..num:sing  ..pessoa: indic ..subcat:[sn]) --> [conhecer].

% VERBO: CONSERTAR
v(omite:nao ..acao:consertar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [conserto].
v(omite:nao ..acao:consertar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [conserta].
v(omite:nao..acao:consertar..num:sing ..pessoa: indic ..subcat:[sn]) --> [consertar].

% VERBO: PEGAR
v(omite:nao ..acao:pegar .. num:sing .. pessoa:prim ..subcat:[sn]) --> [pego].
v(omite:nao ..acao:pegar .. num:sing .. pessoa:terc ..subcat:[sn]) --> [pega].
v(omite:nao ..acao:pegar .. num:sing .. pessoa:indic ..subcat:[sn]) --> [pegar].

% VERBO: IR
v(omite:nao ..acao:ir .. num:sing .. pessoa: prim ..subcat:[sp(prep:para)]) --> [vou].
v(omite:nao ..acao:ir .. num:sing .. pessoa: terc ..subcat:[sp(prep:para)]) --> [vai].
v(omite:nao ..acao:ir ..num:sing ..pessoa: indic ..subcat:[sp(prep:para)]) --> [ir].

% VERBO: VEDAR
v(omite:nao ..acao:vedar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vedo].
v(omite:nao ..acao:vedar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [veda].
v(omite:nao ..acao:vedar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [vedar].

% VERBO: PREGAR - BITRANSITIVO
v(omite:nao ..acao:pregar ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:em)]) --> [prego].
v(omite:nao ..acao:pregar ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [prega].

v(omite:nao ..acao:pregar ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:em)]) --> [pregar].

% VERBO: SERRAR
v(omite:nao ..acao:serrar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [serro].

v(omite:nao ..acao:serrar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [serra].

v(omite:nao ..acao:serrar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [serrar].

% VERBO: PESCAR
v(omite:nao ..acao:pescar ..num:sing ..pessoa: prim ..subcat:[]) --> [pesco].

v(omite:nao ..acao:pescar ..num:sing ..pessoa: terc ..subcat:[]) --> [pesca].

v(omite:nao ..acao:serrar ..num:sing ..pessoa: indic ..subcat:[]) --> [pescar].

% VERBO: NAVEGAR
v(omite:nao ..acao:navegar ..num:sing ..pessoa: prim ..subcat:[]) --> [navego].

v(omite:nao ..acao:navegar ..num:sing ..pessoa: terc ..subcat:[]) --> [navega].

v(omite:nao ..acao:navegar ..num:sing ..pessoa: indic ..subcat:[]) --> [navegar].

% VERBO: REMAR
v(omite:nao ..acao:navegar ..num:sing ..pessoa: prim ..subcat:[]) --> [remo].

v(omite:nao ..acao:navegar ..num:sing ..pessoa: terc ..subcat:[]) --> [rema].

v(omite:nao ..acao:navegar ..num:sing ..pessoa: indic ..subcat:[]) --> [remar].

% VERBO: CONVERSAR
v(omite:nao ..acao:conversar ..num:sing ..pessoa:prim ..subcat:[sp(prep:com)]) --> [converso].

v(omite:nao ..acao:conversar ..num:sing ..pessoa:terc ..subcat:[sp(prep:com)]) --> [conversa].

v(omite:nao ..acao:conversar ..num:sing ..pessoa:indic ..subcat:[sp(prep:com)]) --> [conversar].

% VERBO: FALAR
v(omite:nao ..acao:conversar ..num:sing ..pessoa:prim ..subcat:[sp(prep:com)]) --> [falo].

v(omite:nao ..acao:conversar ..num:sing ..pessoa:terc ..subcat:[sp(prep:com)]) --> [fala].

v(omite:nao ..acao:conversar ..num:sing ..pessoa:indic ..subcat:[sp(prep:com)]) --> [falar].

% VERBO: SOLTAR
v(omite:nao ..acao:soltar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [solto].

v(omite:nao ..acao:soltar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [solta].

v(omite:nao ..acao:soltar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [soltar].

% VERBO: LARGAR
v(omite:nao ..acao:soltar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [largo].

v(omite:nao ..acao:soltar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [larga].

v(omite:nao ..acao:soltar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [largar].

% VERBO: COLOCAR
v(omite:nao ..acao:colocar ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:em)]) --> [coloco].

v(omite:nao ..acao:colocar ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [coloca].

v(omite:nao ..acao:colocar ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:em)]) --> [colocar].

% VERBO: COMPRAR
v(omite:nao ..acao:comprar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [compro].

v(omite:nao ..acao:comprar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [compra].

v(omite:nao ..acao:comprar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [comprar].

% VERBO: EMPRESTAR
v(omite:nao ..acao:emprestar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [empresto].

v(omite:nao ..acao:emprestar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [empresta].

v(omite:nao ..acao:emprestar ..num:sing..pessoa:indic ..subcat:[sn]) --> [emprestar].

% VERBO: VENDER
v(omite:nao ..acao:vender ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vendo].

v(omite:nao ..acao:vender ..num:sing ..pessoa: terc ..subcat:[sn]) --> [vende].

v(omite:nao ..acao:vender ..num:sing ..pessoa: indic ..subcat:[sn]) --> [vender].

% VERBO: CORTAR
v(omite:nao ..acao:cortar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [corto].

v(omite:nao ..acao:cortar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [corta].

v(omite:nao ..acao:cortar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [cortar].

% VERBO: FAZER
v(omite:nao ..acao:fazer ..num:sing ..pessoa: prim ..subcat:[sn]) --> [faco].

v(omite:nao ..acao:fazer ..num:sing ..pessoa: terc ..subcat:[sn]) --> [faz].

v(omite:nao ..acao:fazer ..num:sing ..pessoa: indic ..subcat:[sn]) --> [fazer].

% VERBO: EXAMINAR
v(omite:nao ..acao:examinar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [examino].

v(omite:nao ..acao:examinar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [examina].

v(omite:nao ..acao:examinar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [examinar].

% VERBO: OLHAR
v(omite:nao ..acao:examinar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [olho].

v(omite:nao ..acao:examinar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [olha].

v(omite:nao ..acao:examinar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [olhar].

% VERBO: TER 
v(omite:sim ..acao:ter ..num:sing ..pessoa: prim ..subcat:[]) --> [tenho].
v(omite:nao ..acao:ter ..num:sing ..pessoa: prim ..subcat:[sn]) --> [tenho].
v(omite:_ ..acao:ter ..num:sing ..pessoa: terc ..subcat:[sn]) --> [tem].

% onde ter tem sentido de estar
v(omite:nao ..acao:estar ..num:sing ..pessoa: terc ..subcat:[advb]) --> [tem].
v(omite:nao ..acao:estar ..num:sing ..pessoa: terc ..subcat:[sp(prep:em)]) --> [tem].
v(omite:sim ..acao:estar ..num:sing ..pessoa: terc ..subcat:[]) --> [tem].

v(omite:nao ..acao:ter ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [tem].
v(omite:nao ..acao:ter ..num:sing ..pessoa: indic ..subcat:[sp(prep:em)]) --> [ter].

% VERBO: POSSUIR
v(omite:sim ..acao:ter ..num:sing ..pessoa: prim ..subcat:[sn]) --> [possuo].
v(omite:nao ..acao:ter ..num:sing ..pessoa: prim ..subcat:[sn]) --> [possuo].
v(omite:nao ..acao:ter ..num:sing ..pessoa: terc ..subcat:[sn]) --> [possui].
v(omite:nao ..acao:ter ..num:sing ..pessoa: indic ..subcat:[sn]) --> [possuir].

% VERBO: DIGITAR
v(omite:nao ..acao:digitar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [digito].
v(omite:nao ..acao:digitar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [digito].
v(omite:nao ..acao:digitar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [digitar].

% VERBO: PODER
v(omite:nao ..acao:poder ..num:sing ..pessoa: prim ..subcat:[sv]) --> [posso].
v(omite:nao ..acao:poder ..num:sing ..pessoa: terc ..subcat:[sv]) --> [pode].
v(omite:nao ..acao:poder ..num:sing ..pessoa: indic ..subcat:[sv]) --> [poder].

% VERBO: VER
v(omite:nao ..acao:ver ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vejo].
v(omite:nao ..acao:ver ..num:sing ..pessoa: terc ..subcat:[sn]) --> [ve].
v(omite:nao ..acao:ver ..num:sing ..pessoa: indic ..subcat:[sn]) --> [ver].

% "VERBO": "SER DONO DE"
v(acao:dono ..num:sing ..pessoa:terc ..subcat:[sp(prep:de)]) --> [eh],[dono].
v(acao:dono ..num:sing ..pessoa:prim ..subcat:[sp(prep:de)]) --> [sou],[dono].

% VERBO: entender
v(acao:saber ..num:sing ..pessoa:indic..subcat:[pro(pron:oque),sn]) --> [saber].
v(acao:saber ..num:sing ..pessoa:prim ..subcat:[pro(pron:oque),sn]) --> [sei].
v(acao:saber ..num:sing ..pessoa:terc ..subcat:[pro(pron:oque),sn]) --> [sabe].

