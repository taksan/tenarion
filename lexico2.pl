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
a(adj:_ ..gen:_ ..num:_) --> [].
a(adj:_ ..gen:_ ..num:_) --> [].
a(adj:_ ..gen:_ ..num:_) --> [].
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
np(id:zulu) --> [zulu].
np(id:mateo) --> [mateo].

np(id:ancoradouro .. tipo:nc ..num:sing ..gen:masc) --> [ancoradouro].
np(id:carpintaria .. tipo:nc ..num:sing ..gen:fem) --> [carpintaria].
np(id:lago .. tipo:nc ..num:sing ..gen:masc) --> [lago].
np(id:ilha .. tipo:nc ..num:sing ..gen:fem) --> [ilha].
np(id:identidade .. tipo:nc ..num:sing ..gen:fem) --> [identidade].
np(id:cartao_credito .. tipo:nc ..num:sing ..gen:masc) --> [cartao], [de],[credito].
np(id:mao .. tipo:nc ..num:sing ..gen:fem) --> [mao].
np(id:tabua .. tipo:nc ..num:sing ..gen:fem) --> [tabua].
np(id:(tabua, _) .. tipo:nc ..num:plur ..gen:fem) --> [tabuas].
np(id:vara_pescar .. tipo:nc ..num:sing ..gen:fem) --> [vara], [de], [pescar].
np(id:minhocas .. tipo:nc ..num:plur ..gen:fem) --> [minhocas].
np(id:barco .. tipo:nc ..num:sing ..gen:masc) --> [barco].
np(id:corda .. tipo:nc ..num:sing ..gen:fem) --> [corda].
np(id:buraco .. tipo:nc ..num:sing ..gen:masc) --> [buraco].
np(id:pregos .. tipo:nc ..num:plur ..gen:masc) --> [pregos].
np(id:caixa_eletronico .. tipo:nc ..num:sing ..gen:masc) --> [caixa],[eletronico].
np(id:placa_nome_loja .. tipo:nc ..num:sing ..gen:fem) --> [placa].
np(id:balcao .. tipo:nc ..num:sing ..gen:masc) --> [balcao].
np(id:estande .. tipo:nc ..num:sing ..gen:masc) --> [estande].
np(id:carteira .. tipo:nc ..num:sing ..gen:fem) --> [carteira].
np(id:poster .. tipo:nc ..num:sing ..gen:masc) --> [poster].
np(id:martelo .. tipo:nc ..num:sing ..gen:masc) --> [martelo].
np(id:serrote .. tipo:nc ..num:sing ..gen:masc) --> [serrote].
np(id:tesoura .. tipo:nc ..num:sing ..gen:fem) --> [tesoura].
np(id:caixa_registradora .. tipo:nc ..num:sing ..gen:fem) --> [caixa],[registradora].
np(id:vaso_ming .. tipo:nc ..num:sing ..gen:masc) --> [vaso],[ming].
np(id:circulo_de_velas .. tipo:nc ..num:sing ..gen:masc) --> [circulo],[de],[velas].
np(id:santo_do_pau_oco .. tipo:nc ..num:sing ..gen:masc) --> [santo],[do],[pau],[oco].
np(id:vela .. tipo:nc ..num:sing ..gen:fem) --> [vela].
np(id:(vela, _) .. tipo:nc ..num:plur ..gen:fem) --> [velas].
np(id:chiclete .. tipo:nc ..num:sing ..gen:masc) --> [chiclete].
np(id:feiticeira .. tipo:nc ..num:sing ..gen:fem) --> [feiticeira].
np(id:dinheiro .. tipo:nc ..num:sing ..gen:masc) --> [dinheiro].
np(id:botoes .. tipo:nc ..num:plur ..gen:masc) --> [botoes].
np(id:tela .. tipo:nc ..num:sing ..gen:fem) --> [tela].
np(id:agua_do_lago .. tipo:nc ..num:sing ..gen:fem) --> [agua].
np(id:peixe .. tipo:nc ..num:sing ..gen:masc) --> [peixe].
np(id:peixe_voador .. tipo:nc ..num:sing ..gen:masc) --> [peixe],[voador].
np(id:peixes .. tipo:nc ..num:plur ..gen:masc) --> [peixes].
np(id:vitoria_regia .. tipo:nc ..num:sing ..gen:fem) --> [vitoria-regia].

%%%% PRONOMES
pro(tipo:reto .. num:sing .. pessoa:prim) --> [eu].
pro(tipo:reto .. num:sing .. pessoa:terc ..gen:fem) --> [ela].
pro(tipo:reto .. num:sing .. pessoa:terc ..gen:masc) --> [ele].
pro(tipo:voce .. num:sing .. pessoa:terc) --> [voce].
pro(tipo:reto .. num:plur .. pessoa:prim) --> [nos].
pro(tipo:obliquo ..num:sing ..pessoa:prim ..subcat:[]) --> [mim].
pro(tipo:obliquo ..num:sing ..pessoa:prim ..subcat:[sv]) --> [me].
pro(tipo:obliquo ..num:sing ..pessoa:seg) -->  [te].
pro(tipo:pron_qu ..pron:quem) --> [quem].
pro(tipo:pron_qu ..pron:que) --> [que].
pro(tipo:pron_qu ..pron:oque) --> [o],[que].
pro(tipo:pron_qu ..pron:qual ..num:sing ) --> [qual].
pro(tipo:pron_qu ..pron:qual ..num:plur ) --> [quais].
pro(tipo:pron_ninguem) --> [ninguem].

%%%% ADVERBIOS
advb(tipo:lugar ..adv:onde) --> [onde].
advb(tipo:lugar ..adv:aqui) --> [aqui].

%%%% VERBOS

% VERBO: ESTAR
v(omite:sim ..acao:estar ..num:sing ..pessoa: terc ..subcat:[sp(prep:em)]) --> [estah].
v(omite:sim ..acao:estar ..num:plur ..pessoa: terc ..subcat:[sp(prep:em)]) --> [estao].

v(omite:sim ..acao:estar ..num:sing ..pessoa: prim ..subcat:[sp(prep:em)] ..poss:nao) --> 
        [estou].
v(omite:sim ..acao:estar ..num:sing ..pessoa: prim ..subcat:[sp(prep:com)] ..poss:sim) --> 
        [estou].
v(omite:sim ..acao:estar ..num:sing ..pessoa: prim ..subcat:[]) --> [estou].

v(omite:sim ..acao:estar ..num:plur ..pessoa: prim ..subcat:[sp(prep:em)] ..poss:nao) --> [estamos].
v(omite:sim ..acao:estar ..num:plur ..pessoa: prim ..subcat:[]) --> [estamos].
v(omite:sim ..acao:estar ..num:sing ..pessoa: indic ..subcat:[sp(prep:em)]) --> [estar].

% VERBO: SER
v(omite:nao ..acao:ser .. num:sing ..pessoa: prim ..subcat:[sa]) --> [sou].
v(omite:nao ..acao:ser .. num:sing ..pessoa: prim ..subcat:[sp(prep:de)]) --> [sou].

v(omite:nao ..acao:ser .. num:sing ..pessoa: terc ..subcat:[sa]) --> ['eh'].
v(omite:nao ..acao:ser .. num:sing ..pessoa: terc ..subcat:[sp(prep:de)]) --> ['eh'].

v(omite:nao ..acao:ser .. num:plur ..pessoa: prim ..subcat:[sa]) --> [sao].
v(omite:nao ..acao:ser .. num:plur ..pessoa: prim ..subcat:[sp(prep:de)]) --> [sao].

% VERBO: CONHECER
v(omite:nao ..acao:conhecer ..num:sing  ..pessoa: prim ..subcat:[sn]) --> [conheco].
v(omite:nao ..acao:conhecer ..num:sing  ..pessoa: terc ..subcat:[sn]) --> [conhece].

% VERBO: CONSERTAR
v(omite:nao ..acao:consertar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [conserto].

v(omite:nao ..acao:consertar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [conserta].

% VERBO: PEGAR
v(omite:nao ..acao:pegar .. num:sing .. pessoa:prim ..subcat:[sn]) --> [pego].

v(omite:nao ..acao:pegar .. num:sing .. pessoa:terc ..subcat:[sn]) --> [pega].

v(omite:nao ..acao:pegar .. num:sing .. pessoa:indic ..subcat:[sn]) --> [pego].

% VERBO: IR
v(omite:nao ..acao:ir .. num:sing .. pessoa: prim ..subcat:[sp(prep:para)]) --> [vou].

v(omite:nao ..acao:ir .. num:sing .. pessoa: terc ..subcat:[sp(prep:para)]) --> [vai].

% VERBO: VEDAR
v(omite:nao ..acao:vedar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vedo].

v(omite:nao ..acao:vedar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [veda].

% VERBO: PREGAR
v(omite:nao ..acao:pregar ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:em)]) --> [prego].

v(omite:nao ..acao:pregar ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [prega].

% VERBO: SERRAR
v(omite:nao ..acao:serrar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [serro].

v(omite:nao ..acao:serrar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [serra].

% VERBO: PESCAR
v(omite:nao ..acao:pescar ..num:sing ..pessoa: prim ..subcat:[]) --> [pesco].

v(omite:nao ..acao:pescar ..num:sing ..pessoa: terc ..subcat:[]) --> [pesca].

% VERBO: NAVEGAR
v(omite:nao ..acao:navegar ..num:sing ..pessoa: prim ..subcat:[]) --> [navego].

v(omite:nao ..acao:navegar ..num:sing ..pessoa: terc ..subcat:[]) --> [navega].

% VERBO: REMAR
v(omite:nao ..acao:navegar ..num:sing ..pessoa: prim ..subcat:[]) --> [remo].

v(omite:nao ..acao:navegar ..num:sing ..pessoa: terc ..subcat:[]) --> [rema].

% VERBO: CONVERSAR
v(omite:nao ..acao:conversar ..num:sing ..pessoa: prim ..subcat:[sp(prep:com)]) --> [converso].

v(omite:nao ..acao:conversar ..num:sing ..pessoa: terc ..subcat:[sp(prep:com)]) --> [conversa].

% VERBO: FALAR
v(omite:nao ..acao:conversar ..num:sing ..pessoa: prim ..subcat:[sp(prep:com)]) --> [falo].

v(omite:nao ..acao:conversar ..num:sing ..pessoa: terc ..subcat:[sp(prep:com)]) --> [fala].

% VERBO: SOLTAR
v(omite:nao ..acao:soltar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [solto].

v(omite:nao ..acao:soltar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [solta].

% VERBO: LARGAR
v(omite:nao ..acao:soltar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [largo].

v(omite:nao ..acao:soltar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [larga].

% VERBO: COLOCAR
v(omite:nao ..acao:colocar ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:em)]) --> [coloco].

v(omite:nao ..acao:colocar ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [coloca].

% VERBO: COMPRAR
v(omite:nao ..acao:comprar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [compro].

v(omite:nao ..acao:comprar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [compra].

% VERBO: EMPRESTAR
v(omite:nao ..acao:emprestar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [empresto].

v(omite:nao ..acao:emprestar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [empresta].

% VERBO: VENDER
v(omite:nao ..acao:vender ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vendo].

v(omite:nao ..acao:vender ..num:sing ..pessoa: terc ..subcat:[sn]) --> [vende].

% VERBO: CORTAR
v(omite:nao ..acao:cortar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [corto].

v(omite:nao ..acao:cortar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [corta].

% VERBO: FAZER
v(omite:nao ..acao:fazer ..num:sing ..pessoa: prim ..subcat:[sn]) --> [faco].

v(omite:nao ..acao:fazer ..num:sing ..pessoa: terc ..subcat:[sn]) --> [faz].

% VERBO: EXAMINAR
v(omite:nao ..acao:examinar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [examino].

v(omite:nao ..acao:examinar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [examina].

% VERBO: OLHAR
v(omite:nao ..acao:examinar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [olho].

v(omite:nao ..acao:examinar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [olha].

% VERBO: TER
v(omite:sim ..acao:ter ..num:sing ..pessoa: prim ..subcat:[sn]) --> [tenho].

v(omite:sim ..acao:ter ..num:sing ..pessoa: terc ..subcat:[sn]) --> [tem].

v(omite:nao ..acao:ter ..num:sing ..pessoa: terc ..subcat:[sp(prep:em)]) --> [tem].

% VERBO: POSSUIR
v(omite:nao ..acao:ter ..num:sing ..pessoa: prim ..subcat:[sn]) --> [possuo].

v(omite:nao ..acao:ter ..num:sing ..pessoa: terc ..subcat:[sn]) --> [possui].

% VERBO: DIGITAR
v(omite:nao ..acao:digitar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [digito].

v(omite:nao ..acao:digitar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [digito].

% VERBO: VER
v(omite:nao ..acao:ver ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vejo].

v(omite:nao ..acao:ver ..num:sing ..pessoa: terc ..subcat:[sn]) --> [ve].


% VERBO: "SER DONO DE"
v(acao:dono ..num:sing ..pessoa:terc ..subcat:[sp(prep:de)]) --> [eh],[dono].

v(acao:dono ..num:sing ..pessoa:prim ..subcat:[sp(prep:de)]) --> [sou],[dono].
