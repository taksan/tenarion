/*********************** Gramatica *********************/

/*** Mensagens simples ****/
s([]) --> [].
s(ato_fala:responder .. mensagem: positivo)--> [sim].
s(ato_fala:responder .. mensagem: negativo)--> [nao].
s(ato_fala:responder .. mensagem: quem) --> [quem],[ou],[o],[que],['?'].
s(ato_fala:responder .. mensagem: ok) --> [ok].
s(ato_fala:responder .. mensagem: oi) --> [oi].
s(ato_fala:terminar .. mensagem: tchau) --> [tchau].
s(ato_fala:terminar .. mensagem: tchau) --> [tchau],[_].

/*** Gramatica Real ****/

/* informar / mandar */
s(ato_fala:informar ..agente:A .. acao:X .. tema:T ..pessoa:Pes ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
        {\+ is_list(A)}, 
	sn(id:A .. num: N ..pessoa:Pes),
	sv(puxa_pron:nao ..omite:nao ..acao:X .. tema:T .. num: N ..pessoa:Pes),
        ['.'],
	{ determina_indefinido(A, IsIndefinido, EI) }.

s(ato_fala:informar .. agente:A .. acao:X .. tema:T ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
        {\+ is_list(A)},
	sn(id:A .. num: N),     
	sv(puxa_pron:nao ..omite:nao ..(acao:X .. tema:T .. num:N)),
        ['.'],
	{ determina_indefinido(T, IsIndefinido, EI) }.

s(ato_fala:informar .. agente:[] .. acao:X .. tema:T ..entidade:E  ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
	sn(tipo: pron_ninguem(E) .. coord:nao),
	sv(puxa_pron:nao ..omite:nao ..acao:X ..tema:T .. num: sing ..pessoa:terc),
        ['.'],
	{ determina_indefinido(T, IsIndefinido, EI) }.

s(ato_fala:informar .. agente:[] .. acao:X .. tema:T ..entidade:E ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
	sn(tipo: pron_ninguem(E) .. coord:nao),
	sv(puxa_pron:nao ..omite:nao ..acao:X ..tema:T .. num: sing ..pessoa:terc),
        ['.'],
	{ determina_indefinido(T, IsIndefinido, EI) }.

s(ato_fala:informar .. agente:[A1|A2] .. acao:X .. tema:T ..pessoa:P ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
	sn(coord:sim .. id:[A1|A2] ..pessoa:P),
	sv(puxa_pron:nao ..omite:nao ..acao:X .. tema:T .. num:plur ..pessoa:P),
        ['.'],
	{ determina_indefinido(T, IsIndefinido, EI) }.

s(ato_fala:informar ..agente:[pessoa(P), num(N)] .. acao:X .. tema:T ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
    sv(puxa_pron:nao ..omite:nao ..acao:X .. tema:T .. num:N .. pessoa:P),
        ['.'],
	{ determina_indefinido(T, IsIndefinido, EI) }.


/* perguntas */
s(ato_fala:interro_qu ..agente:incog(Id) .. acao:X .. tema:T ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
	sn(tipo: pron_qu .. coord:nao ..id:Id ..pessoa:P), 
	sv(puxa_pron:sim ..omite:_ ..acao:X ..tema:T ..pessoa:P),
        ['?'],
	{ determina_indefinido(T, IsIndefinido, EI) }.

s(ato_fala:interro_adv .. agente:A .. acao:X ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
        sp(_), 
        sv(puxa_pron:sim ..omite:sim ..acao:X ..tema:A),
        ['?'],
	{ determina_indefinido(A, IsIndefinido, EI) }.

s(ato_fala:int_sim_nao .. agente:A .. acao:X .. tema:T ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
		{ AX = '' },
	sn(id:A),
	sv(puxa_pron:nao ..omite:nao ..acao_aux:AX ..acao:X .. tema:T),
        ['?'],
	{ 
		determina_indefinido(T, IsIndefinido, EI);
	  	determina_indefinido(A, IsIndefinido, EI) 
	}.

s(ato_fala:int_sim_nao .. agente:A .. acao:X .. tema:T ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
        { AX = '', (member(Tipo, [np,nc]))},
	sv(puxa_pron:nao ..agente:A ..tipo:Tipo ..omite:nao ..acao_aux: AX ..acao:X .. tema:T),
        ['?'],
	{ determina_indefinido(T, IsIndefinido, EI) }.

s(ato_fala:int_sim_nao_aux .. agente:A .. acao_aux: AX ..acao:X .. tema:T ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
	sn(id:A),
	sv(omite:nao ..acao_aux: AX ..acao:X ..tema:T),
        ['?'],
	{ determina_indefinido(T, IsIndefinido, EI) }.

s(ato_fala:int_sim_nao_aux .. agente:A .. acao_aux: AX ..acao:X .. tema:T ..indefinido:IsIndefinido ..elemento_indefinido:EI) -->
		{ A = prim },
	sv(omite:sim ..acao_aux: AX ..acao:X ..tema:T),
        ['?'],
	{ determina_indefinido(T, IsIndefinido, EI) }.


/* atos de fala diversos */
s(ato_fala:recusar ..agente:A ..acao:X .. tema:T ..indefinido:nao) -->
	sn(coord:nao ..id:A),
        [nao], [pode],
	sv(puxa_pron:nao ..omite:_ ..acao:X .. tema:T ..pessoa: indic),
        ['.'].

s(ato_fala:recusar ..agente:A ..acao:X.. acao_aux:AX ..tema:Tema ..indefinido:sim) -->
	sn(coord:nao ..id:A ..pessoa:Pessoa),
        [nao], 
	sv(puxa_pron:nao ..omite:_ ..acao:X .. acao_aux:AX ..tema:Tema ..pessoa: Pessoa ..indefinido:sim),
        ['.'].

% SINTAGMA NOMINAL
% essa regra eh para produzir texto
%sn(coord:nao ..id:indefinido(texto: Texto ..tipo:Tipo ..gen:G ..num:N) ..indefinido:sim) -->
%    det(gen:G .. num:N ..tipo:Tipo ),
%    mod(gen:G .. num:N), 
%	np(id:Texto .. tipo:Tipo ..gen:G ..num:N ..indefinido:sim).

sn(coord:nao ..id:I ..tipo:T ..gen:G ..num:N ..num:N ..pessoa:terc ..indefinido:nao) -->
        { (\+ var(I); \+ is_list(I)) },
    ident(gen:G .. num:N ..tipo:T),
	np(id:I .. tipo:T ..gen:G ..num:N ..indefinido:nao).

% a regra abaixo faz match do texto, nao deve ser usada para produzir texto
sn(coord:nao ..id:I ..tipo:T ..gen:G ..num:N ..num:N ..pessoa:terc ..indefinido:IsIndefinido) -->
        { var(I), var(T), var(IsIndefinido) },
    det(gen:G .. num:N ..tipo:T ),
    mod(gen:G .. num:N), 
	np(id:I .. tipo:T ..gen:G ..num:N ..indefinido:IsIndefinido),
    mod(gen:G .. num:N),
	{ cria_np_indefinido(IsIndefinido, I, T, G, N) }.

sn(coord:nao ..tipo:T ..id:Ag ..gen:G .. num:N .. pessoa:P ..indefinido:nao) -->
        { \+ is_list(Ag) },
        { ( (\+ var(Ag); \+ var(T)), 
           denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Ag));
           var(Ag)},
        pro(tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), 
        { (var(Ag),
           denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Ag));
          \+ var(Ag)}.

sn(coord:sim ..id:[A1,A2] .. num:plur ..prep:P) -->
	{ var(P) },
	sn(id:A1 .. coord:nao),
	[e],
	sn(id:A2 .. coord:nao).

sn(coord:sim ..id:[A1,A2] .. num:plur ..prep:P) -->
	{ \+ var(P) },
	sn(id:A1 .. coord:nao),
	[e],
	sp(id:A2 .. prep:P).

sn(coord:sim ..id:[A1|Resto] .. num:plur ..prep:P) -->
	sn(id:A1 .. coord:nao),
	[,],
	sn(coord:sim .. id:Resto ..prep:P).

sv(omite:O ..acao:A ..acao_aux:(acao:AX ..pessoa:PX ..num:NX ) ..tema:T ..num:N ..pessoa:P ..indefinido:IsIndefinido) -->
%	{ write([A,T,N,P,G,IndefN]), nl },
	v(omite:O ..acao:A ..subcat:[pro(pron:Pronome),sn] ..num:N ..pessoa:P),
	pro(tipo_pro:pron_qu ..pron:Pronome),
	sv(omite:nao ..acao:AX ..pessoa:PX ..num:NX ..tema:T ..indefinido:IsIndefinido).

sv(omite:O ..acao:A .. num:N ..pessoa:P ..indefinido:nao) -->
	v(omite:O ..acao:A ..subcat:[] .. num:N ..pessoa:P).

sv(omite:O ..acao:A .. tema:T .. num:N ..pessoa:Pess ..indefinido:IsIndefinido) -->
	v(omite: O ..acao:A ..num:N ..pessoa:Pess ..subcat:[sp(prep:P)]),
	sp(id:T ..prep:P ..indefinido:IsIndefinido).

sv(omite:O ..acao:A .. tema:T ..gen:G ..num:N ..pessoa:P ..indefinido:IsIndefinido) -->
	v(omite:O ..acao:A ..subcat:[sn] ..num:N ..pessoa:P),
	sn(id:T ..gen:G ..num:N ..indefinido:IsIndefinido).

sv(puxa_pron:sim ..omite:O ..acao:A .. tema:T ..num:N ..pessoa:P ..indefinido:IsIndefinido) -->
	sn(id:T ..pessoa:P ..num:N ..indefinido:IsIndefinido),
	v(omite:O ..acao:A ..subcat:[sn] ..num:N ..pessoa:P).

sv(omite:O ..acao:A .. tema:T ..num:N ..pessoa:P ..indefinido:IsIndefinido) -->
	v(omite:O ..acao:A ..subcat:[sn, sp(prep:Prep)] ..num:N ..pessoa:P),
	sn(id:T ..indefinido:IsIndefinido),
    sp(prep:Prep ..indefinido:IsIndefinido).

sv(pessoa:P ..acao_aux: AX ..acao:A .. tema:T .. num:N ..indefinido:IsIndefinido) -->
	v(omite:O ..acao:AX ..subcat:[sv] ..pessoa:P),
	sv(omite: O ..acao:A ..tema:T .. num:N ..pessoa:indic ..indefinido:IsIndefinido).
	
sp(id:I .. prep:P ..indefinido:IsIndefinido) -->
    prep(prep:P),
    sn(id:I ..indefinido:IsIndefinido ..prep:P).

sp(id:I .. prep:_) -->
    advb(adv:A),
    { denota_lugar(A, I) }.

det(gen:G .. num:N ..tipo:T) --> 
       quant(gen:G .. num:N),
       ident(gen:G .. num:N ..tipo:T),
       poss(gen:G .. num:N),
       num(gen:G .. num:N).

sa(adj:A ..gen:G .. num:N) --> 
       a(adj:A ..gen:G .. num:N).

sa(adj:A ..gen:G .. num:N) --> 
       adv, 
       a(adj:A ..gen:G .. num:N).

sa(adj:A ..gen:G .. num:N) --> 
       a(adj:A ..gen:G .. num:N), 
       sp(_).

mod(adj:A ..gen:G .. num:N) --> sa(adj:A ..gen:G .. num:N).

mod(_) --> sp(_).

mod(_) --> [].


np_indefinido($,$).

cria_np_indefinido(IsIndefinido,_, _, _, _):-
	var(IsIndefinido),
	IsIndefinido = nao.

cria_np_indefinido(sim, Texto, T, G, N):-
	nonvar(T), nonvar(G), nonvar(N),
	retract(np_indefinido($,$)),
	assertz(np_indefinido(Texto, indefinido(texto: Texto ..tipo:T ..gen:G ..num:N))).

cria_np_indefinido(IsIndefinido,Texto, _, _, _):-
	( var(IsIndefinido) ; IsIndefinido = nao ),
	np_indefinido(Texto, _),
	retract(np_indefinido(Texto, _)).

determina_indefinido(IdentidadeIndefinido, sim, Tracos):-
	np_indefinido(IdentidadeIndefinido, Tracos),!,
	retract(np_indefinido(IdentidadeIndefinido, _)).

determina_indefinido(IdentidadeIndefinido, nao, []):-
	\+ np_indefinido(IdentidadeIndefinido, _).
