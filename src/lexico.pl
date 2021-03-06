%:-[gulp].
:-[verbos].
:-[substantivos].

%%%% ADJETIVOS

a(adj:sem_fio  ..tipo:estar ..gen:_ ..num:_) --> [sem], [fio].
a(adj:grande   ..tipo:ser ..num:sing ..prefere_adv:muito)-->[grande].
a(adj:grande   ..tipo:ser ..num:plur ..prefere_adv:muito) --> [grandes].
a(adj:voador   ..tipo:ser ..gen:masc ..num:sing) --> [voador].
a(adj:voador   ..tipo:ser ..gen:masc ..num:plur) --> [voadores].
a(adj:pequeno  ..tipo:ser ..gen:fem ..num:sing) --> [pequena].
a(adj:pequeno  ..tipo:ser ..gen:masc ..num:sing) --> [pequeno].
a(adj:pequeno  ..tipo:ser ..gen:fem ..num:plur) --> [pequenas].
a(adj:pequeno  ..tipo:ser ..gen:masc ..num:plur) --> [pequenos].
a(adj:acesa    ..tipo:estar ..gen:fem ..num:sing) --> [acesa].
a(adj:acesa    ..tipo:estar ..gen:fem ..num:plur) --> [acesas].
a(adj:racional ..tipo:ser ..num:sing)-->[racional].
a(adj:racional ..tipo:ser ..num:plur)-->[racionais].
a(adj:caro     ..tipo:ser ..num:sing)-->[caro].
a(adj:suficiente ..tipo:ser ..num:sing)-->[suficiente].

%a(adj:pegavel   ..tipo:ser ..num:sing)-->[pegavel].
a(adj:amarravel ..tipo:ser ..num:sing)-->[amarravel].
a(adj:possivel  ..tipo:ser ..num:sing)-->[possivel].

% "adjetivos" que sao na realidade participio de verbos
a(adj:estragado  ..gen:masc ..tipo:estar ..num:sing)--> [estragado].
a(adj:estragado  ..gen:fem  ..tipo:estar ..num:sing)--> [estragada].
a(adj:consertado ..gen:masc ..tipo:estar ..num:sing)-->[consertado].
a(adj:consertada ..gen:fem  ..tipo:estar ..num:sing)-->[consertada].
a(adj:amarrado   ..gen:masc ..tipo:estar ..num:sing)-->[amarrado].
a(adj:amarrado   ..gen:fem  ..tipo:estar ..num:sing)-->[amarrada].
a(adj:pregado    ..gen:masc ..tipo:estar ..num:sing)-->[pregado].
a(adj:pregado    ..gen:fem  ..tipo:estar ..num:sing)-->[pregada].
a(adj:quebrado   ..gen:masc ..tipo:estar ..num:sing)-->[quebrado].
a(adj:quebrado   ..gen:fem  ..tipo:estar ..num:sing)-->[quebrada].
a(adj:digitado   ..gen:masc ..tipo:estar ..num:sing)-->[digitado].
a(adj:digitado   ..gen:fem  ..tipo:estar ..num:sing)-->[digitada].
a(adj:selecionado   ..gen:masc ..tipo:estar ..num:sing)-->[selecionado].
a(adj:selecionado   ..gen:fem  ..tipo:estar ..num:sing)-->[selecionada].


%%%% QUANT
quant(id:todo.. gen:masc.. num:sing)   --> [todo].
quant(id:todo.. gen:fem.. num:sing)   --> [toda].
quant(id:todo.. gen:masc.. num:plur)  --> [todos].
quant(id:todo.. gen:fem.. num:plur)   --> [todas].
quant(id:algum.. gen:masc.. num:sing) --> [algum].
quant(id:algum.. gen:fem.. num:sing)   --> [alguma].
quant(id:algum.. gen:masc.. num:plur)  --> [alguns].
quant(id:algum.. gen:fem.. num:plur)   --> [algumas].
quant(id:nenhum..gen:masc.. num:sing) --> [nenhum].
quant(id:nenhum..gen:fem.. num:sing) --> [nenhuma].
quant(_) --> [].

%%%% NUMERO
num(id:1 ..num:sing) --> [1].
num(id:NUM ..num:plur) --> {integer(NUM),NUM>1}, [NUM].
num(id:NInt ..num:plur) --> [NUM],{is_number(NUM), atom_number(NUM,NInt),NInt>1} .

is_number(Atom):-
	nonvar(Atom),
	atom_chars(Atom,Chars),
	is_number_a(Chars).

is_digit(A):-
	char_code(A,D),
	D > 47,
	D < 58.

is_number_a([D]):-
	is_digit(D).

is_number_a([D|Tail]):-
	is_digit(D),
	is_number_a(Tail).

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
poss(poss:meu.. gen:masc.. num:sing) -->  [meu].
poss(poss:meu.. gen:fem.. num:sing) -->  [minha].
poss(poss:meu.. gen:masc.. num:plur) -->  [meus].
poss(poss:meu.. gen:fem.. num:plur) -->  [minhas].
poss(poss:seu.. gen:masc.. num:sing) -->  [seu].
poss(poss:seu.. gen:fem.. num:sing) -->  [sua].
poss(poss:seu.. gen:masc.. num:plur) -->  [seus].
poss(poss:seu.. gen:fem.. num:plur) -->  [suas].
poss(poss:nosso.. gen:masc.. num:sing) -->  [nosso].
poss(poss:nosso.. gen:fem.. num:sing) -->  [nossa].


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
pro(tipo_pro:pron_ninguem(qual) ..pron:nada)--> [nada].
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
pro(tipo_pro:relativo ..pron:quanto) --> [quanto].

%%%% ADVERBIOS
advb(tipo_adv:lugar ..aceita_prep:de ..adv:aqui) --> [aqui].
advb(tipo_adv:lugar ..adv:la) --> [la].
advb(tipo_adv:afirmacao ..adv:nao) --> [nao].
advb(tipo_adv:afirmacao ..adv:sim) --> [].
advb(tipo_adv:afirmacao ..adv:ja) -->[ja].

advb(tipo_adv:intensidade ..adv:bem) -->[bem].
advb(tipo_adv:intensidade ..adv:mais) --> [mais].
advb(tipo_adv:intensidade ..adv:muito) -->[muito].


%%% LOCUCAO PREPOSITIVA
loc(tipo:prep.. id:perto ..prep:de ..verbo:estar)-->[perto].
loc(tipo:prep.. id:preco ..prep:de ..verbo:ser)-->[preco].

