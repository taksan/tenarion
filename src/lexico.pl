%:-[gulp].
:-[verbos].
:-[substantivos].

%%%% ADJETIVOS

a(adj:sem_fio  ..tipo:estar ..gen:_ ..num:_) --> [sem], [fio].
a(adj:grande   ..tipo:ser ..gen:_ ..num:sing) --> [grande].
a(adj:grande   ..tipo:ser ..gen:_ ..num:plur) --> [grandes].
a(adj:voador   ..tipo:ser ..gen:masc ..num:sing) --> [voador].
a(adj:voador   ..tipo:ser ..gen:masc ..num:plur) --> [voadores].
a(adj:pequeno  ..tipo:ser ..gen:fem ..num:sing) --> [pequena].
a(adj:pequeno  ..tipo:ser ..gen:masc ..num:sing) --> [pequeno].
a(adj:pequeno  ..tipo:ser ..gen:fem ..num:plur) --> [pequenas].
a(adj:pequeno  ..tipo:ser ..gen:masc ..num:plur) --> [pequenos].
a(adj:estragado ..tipo:estar ..gen:masc ..num:sing) --> [estragado].
a(adj:estragado..tipo:estar ..gen:fem ..num:sing) --> [estragada].
a(adj:acesa    ..tipo:estar ..gen:fem ..num:sing) --> [acesa].
a(adj:acesa    ..tipo:estar ..gen:fem ..num:plur) --> [acesas].
a(adj:racional ..tipo:ser ..num:sing)-->[racional].
a(adj:racional ..tipo:ser ..num:plur)-->[racionais].

a(adj:pegavel   ..tipo:ser ..num:sing)-->[pegavel].
a(adj:amarravel ..tipo:ser ..num:sing)-->[amarravel].

a(adj:consertado ..gen:masc ..tipo:estar  ..num:sing)-->[consertado].
a(adj:consertada ..gen:fem  ..tipo:estar  ..num:sing)-->[consertada].
a(adj:amarrado   ..gen:masc ..tipo:estar ..num:sing)-->[amarrado].
a(adj:amarrado   ..gen:fem  ..tipo:estar ..num:sing)-->[amarrada].
a(adj:pregado    ..gen:masc ..tipo:estar ..num:sing)-->[pregado].
a(adj:pregado    ..gen:fem ..tipo:estar ..num:sing)-->[pregada].


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

%%%% PRONOMES
pro(tipo_pro:reto .. num:sing .. pessoa:prim ..pron:eu) --> [eu].
pro(tipo_pro:reto .. num:sing .. pessoa:terc ..gen:fem ..pron:ela) --> [ela].
pro(tipo_pro:reto .. num:sing .. pessoa:terc ..gen:masc ..pron:ele) --> [ele].
pro(tipo_pro:reto .. num:plur .. pessoa:terc ..gen:fem ..pron:elas) --> [elas].
pro(tipo_pro:reto .. num:plur .. pessoa:terc ..gen:masc ..pron:eles) --> [eles].
pro(tipo_pro:voce .. num:sing .. pessoa:terc ..pron:voce) --> [voce].
pro(tipo_pro:voce .. num:sing .. pessoa:terc ..pron:player) --> [voce].
pro(tipo_pro:reto .. num:plur .. pessoa:prim ..pron:nos) --> [nos].
pro(tipo_pro:obliquo ..num:sing ..pessoa:prim ..subcat:[] ..pron:mim) --> [mim].
pro(tipo_pro:obliquo ..num:sing ..pessoa:prim ..subcat:[sv] ..pron:me) --> [me].
pro(tipo_pro:obliquo ..num:sing ..pessoa:seg ..pron:te) -->  [te].
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

pro(tipo_pro:relativo ..pron:quem) --> [quem].
pro(tipo_pro:relativo ..pron:que) --> [que].
pro(tipo_pro:relativo ..pron:oque) --> [o],[que].
pro(tipo_pro:relativo ..pron:qual ..num:sing ) --> [qual].
pro(tipo_pro:relativo ..pron:qual ..num:plur ) --> [quais].
pro(tipo_pro:relativo ..pron:onde) --> [onde].

%%%% ADVERBIOS
advb(tipo_adv:lugar ..adv:aqui) --> [aqui].
advb(tipo_adv:lugar ..adv:la) --> [la].
advb(tipo_adv:afirmacao ..adv:nao) --> [nao].
advb(tipo_adv:afirmacao ..adv:sim) --> [].
advb(tipo_adv:afirmacao ..adv:ja) -->[ja].
