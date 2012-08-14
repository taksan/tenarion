:-discontiguous(subcat/2).
:-discontiguous(v/3).

%%%% VERBOS
% INTRANSITIVO        : subcat:[]
% TRANSITIVO DIRETO   : subcat:[sn]
% TRANSITIVO INDIRETO : subcat[sp(prep:P)] P = preposição exigida
% BITRANSITIVO        : subcat[sn, sp(prep:P)] P = preposição exigida para o 2o objeto

% VERBO: ESTAR
subcat(estar,SUBCAT):-
	member(SUBCAT,[advb,sp(prep:em),sp(prep:com),sa,loc(verbo:estar),gerundio]).
v(acao:estar ..tempo:presente ..num:sing ..pessoa: terc  ..subcat:[SUBCAT] ..poss:nao) --> {subcat(estar,SUBCAT)}, [estah].
v(acao:estar ..tempo:presente ..num:plur ..pessoa: terc  ..subcat:[SUBCAT] ..poss:nao) --> {subcat(estar,SUBCAT)}, [estao].
v(acao:estar ..tempo:presente ..num:sing ..pessoa: prim  ..subcat:[SUBCAT] ..poss:nao) --> {subcat(estar,SUBCAT)}, [estou].
v(acao:estar ..tempo:presente ..num:plur ..pessoa: prim  ..subcat:[SUBCAT] ..poss:nao) --> {subcat(estar,SUBCAT)}, [estamos].
v(acao:estar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[SUBCAT]) --> {subcat(estar,SUBCAT)}, [estar].

% VERBO: SER
subcat(ser,SUBCAT):-
	member(SUBCAT,[sn,sa,pred]).
v(acao:ser ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[SUBCAT]) --> {subcat(ser,SUBCAT)}, [ser].
v(acao:ser ..tempo:presente ..num:sing ..pessoa: terc  ..subcat:[SUBCAT]) --> {subcat(ser,SUBCAT)}, [eh].
v(acao:ser ..tempo:presente ..num:plur ..pessoa: terc  ..subcat:[SUBCAT]) --> {subcat(ser,SUBCAT)}, [sao].
v(acao:ser ..tempo:presente ..num:sing ..pessoa: prim  ..subcat:[SUBCAT]) --> {subcat(ser,SUBCAT)}, [sou].

% VERBO: PERTENCER
v(acao:pertencer ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sp(prep:de)]) --> ['eh'].
v(acao:pertencer ..tempo:presente ..num:plur ..pessoa: prim ..subcat:[sp(prep:de)]) --> ['sao'].

% VERBO: CONHECER
v(acao:conhecer ..tempo:presente ..num:sing  ..pessoa: indic ..subcat:[sn]) --> [conhecer].
v(acao:conhecer ..tempo:presente ..num:sing  ..pessoa: prim ..subcat:[sn]) --> [conheco].
v(acao:conhecer ..tempo:presente ..num:sing  ..pessoa: terc ..subcat:[sn]) --> [conhece].

% VERBO: CONSERTAR
v(acao:consertar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [consertar].
v(acao:consertar ..tempo:presente ..num:sing ..pessoa: prim  ..subcat:[sn]) --> [conserto].
v(acao:consertar ..tempo:presente ..num:sing ..pessoa: terc  ..subcat:[sn]) --> [conserta].
v(acao:consertar ..gen:masc ..num:sing ..pessoa: participio  ..subcat:[sn]) --> [consertado].
v(acao:consertar ..gen:fem  ..num:sing ..pessoa: participio  ..subcat:[sn]) --> [consertada].

% VERBO: PEGAR
v(acao:pegar ..tempo:presente ..num:sing .. pessoa:indic ..subcat:[sn]) --> [pegar].
v(acao:pegar ..tempo:presente ..num:sing .. pessoa:prim ..subcat:[sn]) --> [pego].
v(acao:pegar ..tempo:presente ..num:sing .. pessoa:terc ..subcat:[sn]) --> [pega].

% VERBO: IR
v(acao:ir ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sp(prep:para)]) --> [ir].
v(acao:ir ..tempo:presente ..num:sing .. pessoa: prim ..subcat:[sp(prep:para)]) --> [vou].
v(acao:ir ..tempo:presente ..num:sing .. pessoa: terc ..subcat:[sp(prep:para)]) --> [vai].

% VERBO: ENTRAR
v(acao:entrar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sp(prep:em)]) --> [entrar].
v(acao:entrar ..tempo:presente ..num:sing .. pessoa: prim ..subcat:[sp(prep:em)]) --> [entro].
v(acao:entrar ..tempo:presente ..num:sing .. pessoa: terc ..subcat:[sp(prep:em)]) --> [entra].


% VERBO: VEDAR
v(acao:vedar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vedo].
v(acao:vedar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [veda].
v(acao:vedar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [vedar].

% VERBO: PREGAR - BITRANSITIVO
v(acao:pregar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:em)]) --> [prego].
v(acao:pregar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [prega].
v(acao:pregar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:em)]) --> [pregar].

% VERBO: SERRAR
v(acao:serrar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [serro].
v(acao:serrar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [serra].
v(acao:serrar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [serrar].

% VERBO: PESCAR
v(acao:pescar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[]) --> [pesco].
v(acao:pescar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[]) --> [pesca].
v(acao:pescar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[]) --> [pescar].

% VERBO: NAVEGAR
v(acao:navegar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[]) --> [navego].
v(acao:navegar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[]) --> [navega].
v(acao:navegar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[]) --> [navegar].

% VERBO: REMAR
v(acao:navegar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[]) --> [remo].
v(acao:navegar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[]) --> [rema].
v(acao:navegar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[]) --> [remar].

% VERBO: CONVERSAR
v(acao:conversar ..tempo:presente ..num:sing ..pessoa:prim ..subcat:[sp(prep:com)]) --> [converso].
v(acao:conversar ..tempo:presente ..num:sing ..pessoa:terc ..subcat:[sp(prep:com)]) --> [conversa].
v(acao:conversar ..tempo:presente ..num:sing ..pessoa:indic ..subcat:[sp(prep:com)]) --> [conversar].

% VERBO: FALAR
v(acao:conversar ..tempo:presente ..num:sing ..pessoa:prim ..subcat:[sp(prep:com)]) --> [falo].
v(acao:conversar ..tempo:presente ..num:sing ..pessoa:terc ..subcat:[sp(prep:com)]) --> [fala].
v(acao:conversar ..tempo:presente ..num:sing ..pessoa:indic ..subcat:[sp(prep:com)]) --> [falar].

% VERBO: SOLTAR
v(acao:soltar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [solto].
v(acao:soltar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [solta].
v(acao:soltar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [soltar].

% VERBO: LARGAR
v(acao:soltar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [largo].

v(acao:soltar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [larga].

v(acao:soltar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [largar].

% VERBO: COLOCAR
v(acao:colocar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:em)]) --> [coloco].
v(acao:colocar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [coloca].
v(acao:colocar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:em)]) --> [colocar].

% VERBO: INSERIR
v(acao:inserir ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:em)]) --> [insiro].
v(acao:inserir ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [insere].
v(acao:inserir ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:em)]) --> [inserir].

% VERBO: tirar
v(acao:tirar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:de)]) --> [tiro].
v(acao:tirar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:de)]) --> [tira].
v(acao:tirar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:de)]) --> [tirar].

v(acao:retirar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn, sp(prep:de)]) --> [retiro].
v(acao:retirar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:de)]) --> [retira].
v(acao:retirar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn, sp(prep:de)]) --> [retirar].

% VERBO: COMPRAR
v(acao:comprar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [compro].
v(acao:comprar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [compra].
v(acao:comprar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [comprar].

% VERBO: EMPRESTAR
v(acao:emprestar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [empresto].
v(acao:emprestar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [empresta].
v(acao:emprestar ..tempo:presente ..num:sing..pessoa:indic ..subcat:[sn]) --> [emprestar].

% VERBO: VENDER
v(acao:vender ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vendo].
v(acao:vender ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [vende].
v(acao:vender ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [vender].

% VERBO: CUSTAR
v(acao:custar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [custo].
v(acao:custar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [custa].
v(acao:custar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [custar].

v(acao:vender ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn,sp(prep:para)]) --> [vendo].
v(acao:vender ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn,sp(prep:para)]) --> [vende].
v(acao:vender ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn,sp(prep:para)]) --> [vender].

% VERBO: CORTAR
v(acao:cortar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [corto].
v(acao:cortar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [corta].
v(acao:cortar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [cortar].

% VERBO: FAZER
v(acao:fazer ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [faco].
v(acao:fazer ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [faz].
v(acao:fazer ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [fazer].

% APARECER
v(acao:aparecer ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sp(prep:em)]) --> [aparecer].
v(acao:aparecer ..tempo:preterito..num:sing ..pessoa: terc  ..subcat:[sp(prep:em)]) --> [apareceu].

% APARECER
v(acao:pedir ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [pedir].
v(acao:pedir ..tempo:_        ..num:_    ..pessoa: gerundio ..subcat:[sn]) --> [pedindo].

% VERBO: EXAMINAR
v(acao:examinar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [examino].
v(acao:examinar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [examina].
v(acao:examinar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [examinar].

% VERBO: OLHAR
v(acao:examinar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [olho].
v(acao:examinar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [olha].
v(acao:examinar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [olhar].

% VERBO: TER 
v(acao:ter ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[]) --> [tenho].
v(acao:ter ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [tenho].
v(acao:ter ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [tem].

% onde ter tem sentido de estar
v(acao:estar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[advb]) --> [tem].
v(acao:estar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sp(prep:em)]) --> [tem].

v(acao:ter ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn, sp(prep:em)]) --> [tem].
v(acao:ter ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sp(prep:em)]) --> [ter].

% VERBO: POSSUIR
v(acao:ter ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [possuo].
v(acao:ter ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [possuo].
v(acao:ter ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [possui].
v(acao:ter ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [possuir].

% VERBO: DIGITAR
v(acao:digitar ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn,sp(prep:em)]) --> [digito].
v(acao:digitar ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn,sp(prep:em)]) --> [digito].
v(acao:digitar ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn,sp(prep:em)]) --> [digitar].

% VERBO: PODER
v(acao:poder ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sv]) --> [posso].
v(acao:poder ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sv]) --> [pode].
v(acao:poder ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sv]) --> [poder].

% VERBO: QUERER
v(acao:querer ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sv]) --> [quero].
v(acao:querer ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sv]) --> [quer].
v(acao:querer ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sv]) --> [querer].


% VERBO: VER
v(acao:ver ..tempo:presente ..num:sing ..pessoa: prim ..subcat:[sn]) --> [vejo].
v(acao:ver ..tempo:presente ..num:sing ..pessoa: terc ..subcat:[sn]) --> [ve].
v(acao:ver ..tempo:presente ..num:sing ..pessoa: indic ..subcat:[sn]) --> [ver].

% VERBO: entender
v(acao:saber ..tempo:presente ..num:sing ..pessoa:indic..subcat:[pro(pron:oque),sn]) --> [saber].
v(acao:saber ..tempo:presente ..num:sing ..pessoa:prim ..subcat:[pro(pron:oque),sn]) --> [sei].
v(acao:saber ..tempo:presente ..num:sing ..pessoa:terc ..subcat:[pro(pron:oque),sn]) --> [sabe].

v(acao:saber ..tempo:presente ..num:sing ..pessoa:indic..subcat:[]) --> [saber].
v(acao:saber ..tempo:presente ..num:sing ..pessoa:prim ..subcat:[]) --> [sei].
v(acao:saber ..tempo:presente ..num:sing ..pessoa:terc ..subcat:[]) --> [sabe].

v(acao:amarrar ..tempo:presente ..num:sing ..pessoa:indic ..subcat:[sn,sp(prep:em)]) --> [amarrar].
v(acao:amarrar ..tempo:presente ..num:sing ..pessoa:prim  ..subcat:[sn,sp(prep:em)]) --> [amarro].
v(acao:amarrar ..tempo:presente ..num:sing ..pessoa:terc  ..subcat:[sn,sp(prep:em)]) --> [amarra].
v(acao:amarrar ..tempo:_        ..num:sing ..pessoa:participio  ..subcat:[sn,sp(prep:em)]) --> [amarrado].

v(acao:desamarrar ..tempo:presente ..num:sing ..pessoa:indic ..subcat:[sn]) --> [desamarrar].
v(acao:desamarrar ..tempo:presente ..num:sing ..pessoa:prim  ..subcat:[sn]) --> [desamarro].
v(acao:desamarrar ..tempo:presente ..num:sing ..pessoa:terc  ..subcat:[sn]) --> [desamarra].

%v(acao:desconhecido(texto:Texto ..tempo:presente ..num:N ..pessoa:P ..subcat:[SUBCAT]) ..tempo:presente ..num:N ..pessoa:P ..subcat:[SUBCAT]) --> [Texto].
