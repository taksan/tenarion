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

%%%% ADV* (que raio é isso??)
adv -->  [bem].
adv -->  [mais].

%%%% IDENT
ident(gen:masc.. num:sing ..tipo:nc) --> [o].
ident(gen:fem.. num:sing ..tipo:nc) --> [a].
ident(gen:masc.. num:plur ..tipo:nc) --> [os].
ident(gen:fem.. num:plur ..tipo:nc) --> [as].
ident(gen:masc.. num:sing..tipo:nc) --> [um].
ident(gen:fem.. num:sing..tipo:nc) --> [uma]. 
ident(gen:masc.. num:plur..tipo:nc) --> [uns].
ident(gen:fem.. num:plur..tipo:nc) --> [umas].
ident(gen:masc.. num:sing..tipo:nc) --> [esse].
ident(gen:fem.. num:sing..tipo:nc) --> [essa].
ident(gen:masc.. num:plur..tipo:nc) --> [esses].
ident(gen:fem.. num:plur..tipo:nc) --> [essas].
ident(gen:masc.. num:sing..tipo:nc) --> [este].
ident(gen:fem.. num:sing..tipo:nc) --> [esta].
ident(gen:masc.. num:plur..tipo:nc) --> [estes].
ident(gen:fem.. num:plur..tipo:nc) --> [estas].
ident(gen:masc.. num:sing..tipo:nc) --> [aquele].
ident(gen:fem.. num:sing..tipo:nc) --> [aquela].
ident(gen:masc.. num:plur..tipo:nc) --> [aqueles].
ident(gen:fem.. num:plur..tipo:nc) --> [aquelas].
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
np(id:zulu ..gen:masc ..num:sing) --> [zulu].
np(id:mateo ..gen:masc ..num:sing) --> [mateo].

np(id:sua(mao) ..gen:fem ..num:sing) --> [sua],[mao].

np(id:agua_do_lago .. tipo:nc ..num:sing ..gen:fem) --> [agua].
np(id:ancoradouro .. tipo:nc ..num:sing ..gen:masc) --> [ancoradouro].
np(id:balcao .. tipo:nc ..num:sing ..gen:masc) --> [balcao].
np(id:barco .. tipo:nc ..num:sing ..gen:masc) --> [barco].
np(id:botoes .. tipo:nc ..num:plur ..gen:masc) --> [botoes].
np(id:buraco .. tipo:nc ..num:sing ..gen:masc) --> [buraco].
np(id:carteira .. tipo:nc ..num:sing ..gen:fem) --> [carteira].
np(id:carpintaria .. tipo:nc ..num:sing ..gen:fem) --> [carpintaria].
np(id:caixa_eletronico .. tipo:nc ..num:sing ..gen:masc) --> [caixa],[eletronico].
np(id:caixa_registradora .. tipo:nc ..num:sing ..gen:fem) --> [caixa],[registradora].
np(id:cartao_credito .. tipo:nc ..num:sing ..gen:masc) --> [cartao], [de],[credito].
np(id:chiclete .. tipo:nc ..num:sing ..gen:masc) --> [chiclete].
np(id:circulo_de_velas .. tipo:nc ..num:sing ..gen:masc) --> [circulo],[de],[velas].
np(id:corda .. tipo:nc ..num:sing ..gen:fem) --> [corda].
np(id:dinheiro .. tipo:nc ..num:sing ..gen:masc) --> [dinheiro].
np(id:estande .. tipo:nc ..num:sing ..gen:masc) --> [estande].
np(id:feiticeira .. tipo:nc ..num:sing ..gen:fem) --> [feiticeira].
np(id:identidade .. tipo:nc ..num:sing ..gen:fem) --> [identidade].
np(id:ilha .. tipo:nc ..num:sing ..gen:fem) --> [ilha].
np(id:jogo .. tipo:nc ..num:sing ..gen:masc) --> [jogo].
np(id:lago .. tipo:nc ..num:sing ..gen:masc) --> [lago].
np(id:mao .. tipo:nc ..num:sing ..gen:fem) --> [mao].
np(id:martelo .. tipo:nc ..num:sing ..gen:masc) --> [martelo].
np(id:minhocas .. tipo:nc ..num:plur ..gen:fem) --> [minhocas].
np(id:peixe .. tipo:nc ..num:sing ..gen:masc) --> [peixe].
np(id:peixe_voador .. tipo:nc ..num:sing ..gen:masc) --> [peixe],[voador].
np(id:peixes .. tipo:nc ..num:plur ..gen:masc) --> [peixes].
np(id:placa_nome_loja .. tipo:nc ..num:sing ..gen:fem) --> [placa].
np(id:poster .. tipo:nc ..num:sing ..gen:masc) --> [poster].
np(id:pregos .. tipo:nc ..num:plur ..gen:masc) --> [pregos].
np(id:santo_do_pau_oco .. tipo:nc ..num:sing ..gen:masc) --> [santo],[do],[pau],[oco].
np(id:serrote .. tipo:nc ..num:sing ..gen:masc) --> [serrote].
np(id:tabua ..tipo:nc ..num:sing ..gen:fem) --> [tabua].
np(id:(tabua,_) ..tipo:nc ..num:plur ..gen:fem) --> [tabuas].
np(id:tela .. tipo:nc ..num:sing ..gen:fem) --> [tela].
np(id:tesoura .. tipo:nc ..num:sing ..gen:fem) --> [tesoura].
np(id:vara_pescar .. tipo:nc ..num:sing ..gen:fem) --> [vara], [de], [pescar].
np(id:vaso_ming .. tipo:nc ..num:sing ..gen:masc) --> [vaso],[ming].
np(id:vela .. tipo:nc ..num:sing ..gen:fem) --> [vela].
np(id:(vela, _) .. tipo:nc ..num:plur ..gen:fem) --> [velas].
np(id:vitoria_regia .. tipo:nc ..num:sing ..gen:fem) --> [vitoria-regia].

%%%% PRONOMES
pro(tipo_pro:reto .. num:sing .. pessoa:prim) --> [eu].
pro(tipo_pro:reto .. num:sing .. pessoa:terc ..gen:fem) --> [ela].
pro(tipo_pro:reto .. num:sing .. pessoa:terc ..gen:masc) --> [ele].
pro(tipo_pro:voce .. num:sing .. pessoa:terc) --> [voce].
pro(tipo_pro:reto .. num:plur .. pessoa:prim) --> [nos].
pro(tipo_pro:obliquo ..num:sing ..pessoa:prim ..subcat:[]) --> [mim].
pro(tipo_pro:obliquo ..num:sing ..pessoa:prim ..subcat:[sv]) --> [me].
pro(tipo_pro:obliquo ..num:sing ..pessoa:seg) -->  [te].
pro(tipo_pro:pron_qu ..pron:quem) --> [quem].
pro(tipo_pro:pron_qu ..pron:que) --> [que].
pro(tipo_pro:pron_qu ..pron:oque) --> [o],[que].
pro(tipo_pro:pron_qu ..pron:qual ..num:sing ) --> [qual].
pro(tipo_pro:pron_qu ..pron:qual ..num:plur ) --> [quais].
pro(tipo_pro:pron_ninguem(quem)) --> [ninguem].
pro(tipo_pro:pron_ninguem(oque))--> [nada].

%%%% ADVERBIOS
advb(tipo_adv:lugar ..adv:onde) --> [onde].
advb(tipo_adv:lugar ..adv:aqui) --> [aqui].

%%%% VERBOS

% VERBO: ESTAR
v(omite:nao ..acao:estar ..num:sing ..pessoa: terc ..subcat:[sp(prep:em)] ..poss:nao ..aux:nao)> 
        [estah].
v(omite:nao ..acao:estar ..num:sing ..pessoa: prim ..subcat:[sp(prep:com)]..poss:sim ..aux:nao)> 
        [estah].
v(omite:_ ..acao:estar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> 
        [estah].

v(omite:nao ..acao:estar ..num:plur ..pessoa: terc ..subcat:[sp(prep:em)]..poss:nao ..aux:nao)> 
        [estao].

v(omite:nao ..acao:estar ..num:sing ..pessoa: prim ..subcat:[sp(prep:em)] ..poss:nao ..aux:nao)> 
        [estou].
v(omite:_ ..acao:estar ..num:sing ..pessoa: prim ..subcat:[sp(prep:com)] ..poss:sim ..aux:nao)> 
        [estou].
v(omite:_ ..acao:estar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> 
        [estou].

v(omite:_ ..acao:estar ..num:plur ..pessoa: prim ..subcat:[sp(prep:em)] ..poss:nao ..aux:nao)> 
        [estamos].

v(omite:_ ..acao:estar ..num:sing ..pessoa: indic ..subcat:[sp(prep:em)] ..aux:nao)> [estar].



% VERBO: SER
v(omite:nao ..acao:ser .. num:sing ..pessoa: prim ..subcat:[sa] ..aux:nao)> [sou].
v(omite:nao ..acao:ser .. num:sing ..pessoa: prim ..subcat:[sp(prep:de)] ..aux:nao)> [sou].

v(omite:nao ..acao:ser .. num:sing ..pessoa: terc ..subcat:[sa] ..aux:nao)> ['eh'].
v(omite:nao ..acao:ser .. num:sing ..pessoa: terc ..subcat:[sp(prep:de)] ..aux:nao)> ['eh'].
v(omite:sim ..acao:ser .. num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> ['eh'].

v(omite:nao ..acao:ser .. num:plur ..pessoa: prim ..subcat:[sa] ..aux:nao)> [sao].
v(omite:nao ..acao:ser .. num:plur ..pessoa: prim ..subcat:[sp(prep:de)] ..aux:nao)> [sao].

v(omite:nao ..acao:ser .. num:plur ..pessoa: indic ..subcat:[sn] ..aux:nao)> [ser].

% VERBO: CONHECER
v(omite:nao ..acao:conhecer ..num:sing  ..pessoa: prim ..subcat:[sn] ..aux:nao)> [conheco].

v(omite:nao ..acao:conhecer ..num:sing  ..pessoa: terc ..subcat:[sn] ..aux:nao)> [conhece].

v(omite:nao ..acao:conhecer ..num:sing  ..pessoa: indic ..subcat:[sn] ..aux:nao)> [conhecer].

% VERBO: CONSERTAR
v(omite:nao ..acao:consertar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [conserto].

v(omite:nao ..acao:consertar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [conserta].

v(omite:nao..acao:consertar..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [consertar].

% VERBO: PEGAR
v(omite:nao ..acao:pegar .. num:sing .. pessoa:prim ..subcat:[sn] ..aux:nao)> [pego].

v(omite:nao ..acao:pegar .. num:sing .. pessoa:terc ..subcat:[sn] ..aux:nao)> [pega].

v(omite:nao ..acao:pegar .. num:sing .. pessoa:indic ..subcat:[sn] ..aux:nao)> [pegar].

% VERBO: IR
v(omite:nao ..acao:ir .. num:sing .. pessoa: prim ..subcat:[sp(prep:para)] ..aux:nao)> [vou].

v(omite:nao ..acao:ir .. num:sing .. pessoa: terc ..subcat:[sp(prep:para)] ..aux:nao)> [vai].

v(omite:nao ..acao:ir ..num:sing ..pessoa: indic ..subcat:[sp(prep:para)] ..aux:nao)> [ir].

% VERBO: VEDAR
v(omite:nao ..acao:vedar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [vedo].

v(omite:nao ..acao:vedar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [veda].

v(omite:nao ..acao:vedar ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [vedar].

% VERBO: PREGAR
v(omite:nao ..acao:pregar ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:em)] ..aux:nao)> [prego].

v(omite:nao ..acao:pregar ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)] ..aux:nao)> [prega].

v(omite:nao ..acao:pregar ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:em)] ..aux:nao)> [pregar].

% VERBO: SERRAR
v(omite:nao ..acao:serrar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [serro].

v(omite:nao ..acao:serrar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [serra].

v(omite:nao ..acao:serrar ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [serrar].

% VERBO: PESCAR
v(omite:nao ..acao:pescar ..num:sing ..pessoa: prim ..subcat:[] ..aux:nao)> [pesco].

v(omite:nao ..acao:pescar ..num:sing ..pessoa: terc ..subcat:[] ..aux:nao)> [pesca].

v(omite:nao ..acao:serrar ..num:sing ..pessoa: indic ..subcat:[] ..aux:nao)> [pescar].

% VERBO: NAVEGAR
v(omite:nao ..acao:navegar ..num:sing ..pessoa: prim ..subcat:[] ..aux:nao)> [navego].

v(omite:nao ..acao:navegar ..num:sing ..pessoa: terc ..subcat:[] ..aux:nao)> [navega].

v(omite:nao ..acao:navegar ..num:sing ..pessoa: indic ..subcat:[] ..aux:nao)> [navegar].

% VERBO: REMAR
v(omite:nao ..acao:navegar ..num:sing ..pessoa: prim ..subcat:[] ..aux:nao)> [remo].

v(omite:nao ..acao:navegar ..num:sing ..pessoa: terc ..subcat:[] ..aux:nao)> [rema].

v(omite:nao ..acao:navegar ..num:sing ..pessoa: indic ..subcat:[] ..aux:nao)> [remar].

% VERBO: CONVERSAR
v(omite:nao ..acao:conversar ..num:sing ..pessoa:prim ..subcat:[sp(prep:com)] ..aux:nao)> [converso].

v(omite:nao ..acao:conversar ..num:sing ..pessoa:terc ..subcat:[sp(prep:com)] ..aux:nao)> [conversa].

v(omite:nao ..acao:conversar ..num:sing ..pessoa:indic ..subcat:[sp(prep:com)] ..aux:nao)> [conversar].

% VERBO: FALAR
v(omite:nao ..acao:conversar ..num:sing ..pessoa:prim ..subcat:[sp(prep:com)] ..aux:nao)> [falo].

v(omite:nao ..acao:conversar ..num:sing ..pessoa:terc ..subcat:[sp(prep:com)] ..aux:nao)> [fala].

v(omite:nao ..acao:conversar ..num:sing ..pessoa:indic ..subcat:[sp(prep:com)] ..aux:nao)> [falar].

% VERBO: SOLTAR
v(omite:nao ..acao:soltar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [solto].

v(omite:nao ..acao:soltar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [solta].

v(omite:nao ..acao:soltar ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [soltar].

% VERBO: LARGAR
v(omite:nao ..acao:soltar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [largo].

v(omite:nao ..acao:soltar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [larga].

v(omite:nao ..acao:soltar ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [largar].

% VERBO: COLOCAR
v(omite:nao ..acao:colocar ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:em)] ..aux:nao)> [coloco].

v(omite:nao ..acao:colocar ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)] ..aux:nao)> [coloca].

v(omite:nao ..acao:colocar ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:em)] ..aux:nao)> [colocar].

% VERBO: COMPRAR
v(omite:nao ..acao:comprar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [compro].

v(omite:nao ..acao:comprar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [compra].

v(omite:nao ..acao:comprar ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [comprar].

% VERBO: EMPRESTAR
v(omite:nao ..acao:emprestar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [empresto].

v(omite:nao ..acao:emprestar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [empresta].

v(omite:nao ..acao:emprestar ..num:sing..pessoa:indic ..subcat:[sn] ..aux:nao)> [emprestar].

% VERBO: VENDER
v(omite:nao ..acao:vender ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [vendo].

v(omite:nao ..acao:vender ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [vende].

v(omite:nao ..acao:vender ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [vender].

% VERBO: CORTAR
v(omite:nao ..acao:cortar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [corto].

v(omite:nao ..acao:cortar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [corta].

v(omite:nao ..acao:cortar ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [cortar].

% VERBO: FAZER
v(omite:nao ..acao:fazer ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [faco].

v(omite:nao ..acao:fazer ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [faz].

v(omite:nao ..acao:fazer ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [fazer].

% VERBO: EXAMINAR
v(omite:nao ..acao:examinar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [examino].

v(omite:nao ..acao:examinar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [examina].

v(omite:nao ..acao:examinar ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [examinar].

% VERBO: OLHAR
v(omite:nao ..acao:examinar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [olho].

v(omite:nao ..acao:examinar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [olha].

v(omite:nao ..acao:examinar ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [olhar].

% VERBO: TER
v(omite:sim ..acao:estar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [tenho].

v(omite:nao ..acao:ter ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [tenho].

v(omite:_ ..acao:ter ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [tem].

v(omite:nao ..acao:estar ..num:sing ..pessoa: terc ..subcat:[sp(prep:em)] ..aux:nao)> [tem].

v(omite:nao ..acao:ter ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)] ..aux:nao)> [tem].

v(omite:nao ..acao:ter ..num:sing ..pessoa: indic ..subcat:[sp(prep:em)] ..aux:nao)> [ter].

% VERBO: POSSUIR
v(omite:nao ..acao:ter ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [possuo].

v(omite:nao ..acao:ter ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [possui].

v(omite:nao ..acao:ter ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [possuir].

% VERBO: DIGITAR
v(omite:nao ..acao:digitar ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [digito].

v(omite:nao ..acao:digitar ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [digito].

v(omite:nao ..acao:digitar ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [digitar].

% VERBO: PODER
v(omite:nao ..acao:poder ..num:sing ..pessoa: prim ..subcat:[sv] ..aux:sim)> [posso].

v(omite:nao ..acao:poder ..num:sing ..pessoa: terc ..subcat:[sv] ..aux:sim)> [pode].

v(omite:nao ..acao:poder ..num:sing ..pessoa: indic ..subcat:[sv] ..aux:sim)> [poder].


% VERBO: VER
v(omite:nao ..acao:ver ..num:sing ..pessoa: prim ..subcat:[sn] ..aux:nao)> [vejo].

v(omite:nao ..acao:ver ..num:sing ..pessoa: terc ..subcat:[sn] ..aux:nao)> [ve].

v(omite:nao ..acao:ver ..num:sing ..pessoa: indic ..subcat:[sn] ..aux:nao)> [ver].

% "VERBO": "SER DONO DE"
v(acao:dono ..num:sing ..pessoa:terc ..subcat:[sp(prep:de)] ..aux:nao)> [eh],[dono].

v(acao:dono ..num:sing ..pessoa:prim ..subcat:[sp(prep:de)] ..aux:nao)> [sou],[dono].
