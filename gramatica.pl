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
s(ato_fala:informar ..agente:A .. acao:X .. tema:T ..pessoa:Pes) -->
        {\+ is_list(A)}, 
	sn(id:A .. num: N ..pessoa:Pes),
	sv(puxa_pron:nao ..omite:nao ..acao:X .. tema:T .. num: N ..pessoa:Pes),
        ['.'].

s(ato_fala:informar .. agente:A .. acao:X .. tema:T) -->
        {\+ is_list(A)},
	sn(id:A .. num: N),     
	sv(puxa_pron:nao ..omite:nao ..(acao:X .. tema:T .. num:N)),
        ['.'].

s(ato_fala:informar .. agente:[] .. acao:X .. tema:T ..entidade:E) -->
	sn(tipo: pron_ninguem(E) .. coord:nao),
	sv(puxa_pron:nao ..omite:nao ..acao:X ..tema:T .. num: sing ..pessoa:terc),
        ['.'].

s(ato_fala:informar .. agente:[] .. acao:X .. tema:T ..entidade:E) -->
	sn(tipo: pron_ninguem(E) .. coord:nao),
	sv(puxa_pron:nao ..omite:nao ..acao:X ..tema:T .. num: sing ..pessoa:terc),
        ['.'].

s(ato_fala:informar .. agente:[A1|A2] .. acao:X .. tema:T ..pessoa:P) -->
	sn(coord:sim .. id:[A1|A2] ..pessoa:P),
	sv(puxa_pron:nao ..omite:nao ..acao:X .. tema:T .. num:plur ..pessoa:P),
        ['.'].

s(ato_fala:informar ..agente:[pessoa(P), num(N)] .. acao:X .. tema:T) -->
    sv(puxa_pron:nao ..omite:nao ..acao:X .. tema:T .. num:N .. pessoa:P),
        ['.'].


/* perguntas */
s(ato_fala:interro_qu ..agente:incog(Id) .. acao:X .. tema:T) -->
	sn(tipo: pron_qu .. coord:nao ..id:Id ..pessoa:P), 
	sv(puxa_pron:sim ..omite:_ ..acao:X ..tema:T ..pessoa:P),
        ['?'].

s(ato_fala:interro_adv .. agente:A .. acao:X) -->
        sp(_), 
        sv(puxa_pron:sim ..omite:sim ..acao:X ..tema:A),
        ['?'].

s(ato_fala:int_sim_nao .. agente:A .. acao:X .. tema:T) -->
		{ AX = '' },
	sn(id:A),
	sv(puxa_pron:nao ..omite:nao ..acao_aux:AX ..acao:X .. tema:T),
        ['?'].

s(ato_fala:int_sim_nao .. agente:A .. acao:X .. tema:T) -->
        { AX = '', (member(Tipo, [np,nc]))},
	sv(puxa_pron:nao ..agente:A ..tipo:Tipo ..omite:nao ..acao_aux: AX ..acao:X .. tema:T),
        ['?'].

s(ato_fala:int_sim_nao_aux .. agente:A .. acao_aux: AX ..acao:X .. tema:T) -->
	sn(id:A),
	sv(omite:nao ..acao_aux: AX ..acao:X ..tema:T),
        ['?'].

s(ato_fala:int_sim_nao_aux .. agente:A .. acao_aux: AX ..acao:X .. tema:T) -->
		{ A = prim },
	sv(omite:sim ..acao_aux: AX ..acao:X ..tema:T),
        ['?'].


/* atos de fala diversos */
s(ato_fala:recusar ..agente:A ..acao:X .. tema:T) -->
	sn(id:A),
        [nao], [pode],
	sv(puxa_pron:nao ..omite:_ ..acao:X .. tema:T ..pessoa: indic),
        ['.'].

% SINTAGMA NOMINAL
sn(coord:nao ..id:I ..tipo:T ..gen:G ..num:N ..num:N ..pessoa:terc) -->
        { var(I), var(T) },
    det(gen:G .. num:N ..tipo:T ),
    mod(gen:G .. num:N), 
	np(id:I .. tipo:T ..gen:G ..num:N),
    mod(gen:G .. num:N).

sn(coord:nao ..id:I ..tipo:T ..gen:G ..num:N ..num:N ..pessoa:terc) -->
        { (\+ var(I); \+ is_list(I)) },
    ident(gen:G .. num:N ..tipo:T),
	np(id:I .. tipo:T ..gen:G ..num:N).

sn(coord:nao ..tipo:T ..id:Ag ..gen:G .. num:N .. pessoa:P) -->
        { \+ is_list(Ag) },
        { ( (\+ var(Ag); \+ var(T)), 
           denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Ag));
           var(Ag)},
        pro(tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), 
        { (var(Ag),
           denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Ag));
          \+ var(Ag)}.

sn(coord:sim ..id:[A1,A2] .. num:plur) -->
	sn(id:A1 .. coord:nao),
	[e],
	sn(id:A2 .. coord:nao).

sn(coord:sim ..id:[A1|Resto] .. num:plur) -->
	sn(id:A1 .. coord:nao),
	[,],
	sn(coord:sim .. id:Resto).

sv(omite:O ..acao:A .. tema:T .. num:N ..pessoa:P) -->
	v(omite:O ..acao:A ..subcat:[] .. num:N ..pessoa:P ..tema:T).

sv(omite:O ..acao:A .. tema:T .. num:N ..pessoa:Pess) -->
	v(omite: O ..acao:A ..num:N ..pessoa:Pess ..subcat:[sp(prep:P)]),
	sp(id:T ..prep:P).

sv(omite:O ..acao:A .. tema:T ..num:N ..pessoa:P) -->
	v(omite:O ..acao:A ..subcat:[sn] ..num:N ..pessoa:P),
	sn(id:T).

sv(puxa_pron:sim ..omite:O ..acao:A .. tema:T ..num:N ..pessoa:P) -->
	sn(id:T ..pessoa:P),
	v(omite:O ..acao:A ..subcat:[] ..num:N ..pessoa:P).

sv(omite:O ..acao:A .. tema:T ..num:N ..pessoa:P) -->
	v(omite:O ..acao:A ..subcat:[sn, sp(prep:Prep)] ..num:N ..pessoa:P),
	sn(id:T),
    sp(prep:Prep).

sv(pessoa:P ..acao_aux: AX ..acao:A .. tema:T .. num:N) -->
	v(omite:O ..acao:AX ..subcat:[sv] ..pessoa:P),
	sv(omite: O ..acao:A ..tema:T .. num:N ..pessoa:indic).
	
sp(id:I .. prep:P) -->
    prep(prep:P),
    sn(id:I).

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


