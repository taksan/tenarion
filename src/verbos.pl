%%%% VERBOS
% INTRANSITIVO        : subcat:[]
% TRANSITIVO DIRETO   : subcat:[sn]
% TRANSITIVO INDIRETO : subcat[sp(prep:P)] P = preposição exigida
% BITRANSITIVO        : subcat[sn, sp(prep:P)] P = preposição exigida para o 2o objeto

% VERBO: ESTAR
v(acao:estar ..num:sing ..pessoa: terc ..subcat:[advb] ..poss:nao) --> [estah].
v(acao:estar ..num:sing ..pessoa: terc ..subcat:[sp(prep:em)] ..poss:nao) --> [estah].
v(acao:estar ..num:plur ..pessoa: terc ..subcat:[advb]..poss:nao) --> [estao].
v(acao:estar ..num:plur ..pessoa: terc ..subcat:[sp(prep:em)]..poss:nao) --> [estao].
v(acao:estar ..num:sing ..pessoa: prim ..subcat:[advb] ..poss:nao) --> [estou].
v(acao:estar ..num:sing ..pessoa: prim ..subcat:[sp(prep:em)] ..poss:nao) --> [estou].
v(acao:estar ..num:plur ..pessoa: prim ..subcat:[sp(prep:em)] ..poss:nao) --> [estamos].
v(acao:estar ..num:plur ..pessoa: prim ..subcat:[advb] ..poss:nao) --> [estamos].
v(acao:estar ..num:sing ..pessoa: indic ..subcat:[sp(prep:em)]) --> [estar].

v(acao:estar ..num:sing ..pessoa: indic ..subcat:[sa]) --> [estar].
v(acao:estar ..num:sing ..pessoa: terc ..subcat:[sa]) --> [estah].
v(acao:estar ..num:plur ..pessoa: terc ..subcat:[sa]) --> [estao].

% VERBO: SER
v(acao:ser .. num:sing ..pessoa: terc ..subcat:[sn]) --> ['eh'].
v(acao:ser .. num:sing ..pessoa: indic ..subcat:[sn]) --> [ser].
v(acao:ser .. num:plur ..pessoa: terc ..subcat:[sn]) --> ['sao'].
v(acao:ser .. num:sing ..pessoa: prim ..subcat:[sn]) --> [sou].
% exige adjetivo
v(acao:ser .. num:sing ..pessoa: prim ..subcat:[sa]) --> [sou].
v(acao:ser .. num:sing ..pessoa: terc ..subcat:[sa]) --> ['eh'].
v(acao:ser .. num:plur ..pessoa: prim ..subcat:[sa]) --> [sao].

v(acao:pertencer .. num:sing ..pessoa: terc ..subcat:[sp(prep:de)]) --> ['eh'].
v(acao:pertencer .. num:plur ..pessoa: prim ..subcat:[sp(prep:de)]) --> ['sao'].

% VERBO: CONHECER
v(acao:conhecer ..num:sing  ..pessoa: prim ..subcat:[sn]) --> [conheco].
v(acao:conhecer ..num:sing  ..pessoa: terc ..subcat:[sn]) --> [conhece].
v(acao:conhecer ..num:sing  ..pessoa: indic ..subcat:[sn]) --> [conhecer].

% VERBO: CONSERTAR
v(acao:consertar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [consertar].
v(acao:consertar ..num:sing ..pessoa: prim  ..subcat:[sn]) --> [conserto].
v(acao:consertar ..num:sing ..pessoa: terc  ..subcat:[sn]) --> [conserta].

% VERBO: PEGAR
v(acao:pegar .. num:sing .. pessoa:prim ..subcat:[sn]) --> [pego].
v(acao:pegar .. num:sing .. pessoa:terc ..subcat:[sn]) --> [pega].
v(acao:pegar .. num:sing .. pessoa:indic ..subcat:[sn]) --> [pegar].

% VERBO: IR
v(acao:ir .. num:sing .. pessoa: prim ..subcat:[sp(prep:para)]) --> [vou].
v(acao:ir .. num:sing .. pessoa: terc ..subcat:[sp(prep:para)]) --> [vai].
v(acao:ir ..num:sing ..pessoa: indic ..subcat:[sp(prep:para)]) --> [ir].

% VERBO: VEDAR
v(acao:vedar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vedo].
v(acao:vedar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [veda].
v(acao:vedar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [vedar].

% VERBO: PREGAR - BITRANSITIVO
v(acao:pregar ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:em)]) --> [prego].
v(acao:pregar ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [prega].
v(acao:pregar ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:em)]) --> [pregar].

% VERBO: SERRAR
v(acao:serrar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [serro].
v(acao:serrar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [serra].
v(acao:serrar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [serrar].

% VERBO: PESCAR
v(acao:pescar ..num:sing ..pessoa: prim ..subcat:[]) --> [pesco].
v(acao:pescar ..num:sing ..pessoa: terc ..subcat:[]) --> [pesca].
v(acao:pescar ..num:sing ..pessoa: indic ..subcat:[]) --> [pescar].

% VERBO: NAVEGAR
v(acao:navegar ..num:sing ..pessoa: prim ..subcat:[]) --> [navego].
v(acao:navegar ..num:sing ..pessoa: terc ..subcat:[]) --> [navega].
v(acao:navegar ..num:sing ..pessoa: indic ..subcat:[]) --> [navegar].

% VERBO: REMAR
v(acao:navegar ..num:sing ..pessoa: prim ..subcat:[]) --> [remo].
v(acao:navegar ..num:sing ..pessoa: terc ..subcat:[]) --> [rema].
v(acao:navegar ..num:sing ..pessoa: indic ..subcat:[]) --> [remar].

% VERBO: CONVERSAR
v(acao:conversar ..num:sing ..pessoa:prim ..subcat:[sp(prep:com)]) --> [converso].
v(acao:conversar ..num:sing ..pessoa:terc ..subcat:[sp(prep:com)]) --> [conversa].
v(acao:conversar ..num:sing ..pessoa:indic ..subcat:[sp(prep:com)]) --> [conversar].

% VERBO: FALAR
v(acao:conversar ..num:sing ..pessoa:prim ..subcat:[sp(prep:com)]) --> [falo].
v(acao:conversar ..num:sing ..pessoa:terc ..subcat:[sp(prep:com)]) --> [fala].
v(acao:conversar ..num:sing ..pessoa:indic ..subcat:[sp(prep:com)]) --> [falar].

% VERBO: SOLTAR
v(acao:soltar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [solto].
v(acao:soltar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [solta].
v(acao:soltar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [soltar].

% VERBO: LARGAR
v(acao:soltar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [largo].

v(acao:soltar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [larga].

v(acao:soltar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [largar].

% VERBO: COLOCAR
v(acao:colocar ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:em)]) --> [coloco].
v(acao:colocar ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [coloca].
v(acao:colocar ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:em)]) --> [colocar].

% VERBO: tirar
v(acao:tirar ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:de)]) --> [tiro].
v(acao:tirar ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:de)]) --> [tira].
v(acao:tirar ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:de)]) --> [tirar].


% VERBO: COMPRAR
v(acao:comprar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [compro].
v(acao:comprar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [compra].
v(acao:comprar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [comprar].

% VERBO: EMPRESTAR
v(acao:emprestar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [empresto].
v(acao:emprestar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [empresta].
v(acao:emprestar ..num:sing..pessoa:indic ..subcat:[sn]) --> [emprestar].

% VERBO: VENDER
v(acao:vender ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vendo].
v(acao:vender ..num:sing ..pessoa: terc ..subcat:[sn]) --> [vende].
v(acao:vender ..num:sing ..pessoa: indic ..subcat:[sn]) --> [vender].

% VERBO: CORTAR
v(acao:cortar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [corto].
v(acao:cortar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [corta].
v(acao:cortar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [cortar].

% VERBO: FAZER
v(acao:fazer ..num:sing ..pessoa: prim ..subcat:[sn]) --> [faco].
v(acao:fazer ..num:sing ..pessoa: terc ..subcat:[sn]) --> [faz].
v(acao:fazer ..num:sing ..pessoa: indic ..subcat:[sn]) --> [fazer].

% VERBO: EXAMINAR
v(acao:examinar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [examino].
v(acao:examinar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [examina].
v(acao:examinar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [examinar].

% VERBO: OLHAR
v(acao:examinar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [olho].
v(acao:examinar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [olha].
v(acao:examinar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [olhar].

% VERBO: TER 
v(acao:ter ..num:sing ..pessoa: prim ..subcat:[]) --> [tenho].
v(acao:ter ..num:sing ..pessoa: prim ..subcat:[sn]) --> [tenho].
v(acao:ter ..num:sing ..pessoa: terc ..subcat:[sn]) --> [tem].

% onde ter tem sentido de estar
v(acao:estar ..num:sing ..pessoa: terc ..subcat:[advb]) --> [tem].
v(acao:estar ..num:sing ..pessoa: terc ..subcat:[sp(prep:em)]) --> [tem].
v(acao:estar ..num:sing ..pessoa: terc ..subcat:[]) --> [tem].

v(acao:ter ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [tem].
v(acao:ter ..num:sing ..pessoa: indic ..subcat:[sp(prep:em)]) --> [ter].

% VERBO: POSSUIR
v(acao:ter ..num:sing ..pessoa: prim ..subcat:[sn]) --> [possuo].
v(acao:ter ..num:sing ..pessoa: prim ..subcat:[sn]) --> [possuo].
v(acao:ter ..num:sing ..pessoa: terc ..subcat:[sn]) --> [possui].
v(acao:ter ..num:sing ..pessoa: indic ..subcat:[sn]) --> [possuir].

% VERBO: DIGITAR
v(acao:digitar ..num:sing ..pessoa: prim ..subcat:[sn]) --> [digito].
v(acao:digitar ..num:sing ..pessoa: terc ..subcat:[sn]) --> [digito].
v(acao:digitar ..num:sing ..pessoa: indic ..subcat:[sn]) --> [digitar].

% VERBO: PODER
v(acao:poder ..num:sing ..pessoa: prim ..subcat:[sv]) --> [posso].
v(acao:poder ..num:sing ..pessoa: terc ..subcat:[sv]) --> [pode].
v(acao:poder ..num:sing ..pessoa: indic ..subcat:[sv]) --> [poder].

% VERBO: VER
v(acao:ver ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vejo].
v(acao:ver ..num:sing ..pessoa: terc ..subcat:[sn]) --> [ve].
v(acao:ver ..num:sing ..pessoa: indic ..subcat:[sn]) --> [ver].

% "VERBO": "SER DONO DE"
v(acao:dono ..num:sing ..pessoa:terc ..subcat:[sp(prep:de)]) --> ['eh'],[dono].
v(acao:dono ..num:sing ..pessoa:prim ..subcat:[sp(prep:de)]) --> [sou],[dono].

% VERBO: entender
v(acao:saber ..num:sing ..pessoa:indic..subcat:[pro(pron:oque),sn]) --> [saber].
v(acao:saber ..num:sing ..pessoa:prim ..subcat:[pro(pron:oque),sn]) --> [sei].
v(acao:saber ..num:sing ..pessoa:terc ..subcat:[pro(pron:oque),sn]) --> [sabe].

v(acao:amarrar ..num:sing ..pessoa:indic ..subcat:[sn,sp(prep:em)]) --> [amarrar].
v(acao:amarrar ..num:sing ..pessoa:prim  ..subcat:[sn,sp(prep:em)]) --> [amarro].
v(acao:amarrar ..num:sing ..pessoa:terc  ..subcat:[sn,sp(prep:em)]) --> [amarra].

v(acao:desamarrar ..num:sing ..pessoa:indic ..subcat:[sn]) --> [desamarrar].
v(acao:desamarrar ..num:sing ..pessoa:prim  ..subcat:[sn]) --> [desamarro].
v(acao:desamarrar ..num:sing ..pessoa:terc  ..subcat:[sn]) --> [desamarra].

%v(acao:desconhecido(texto:Texto ..num:N ..pessoa:P ..subcat:[SUBCAT]) ..num:N ..pessoa:P ..subcat:[SUBCAT]) --> [Texto].
