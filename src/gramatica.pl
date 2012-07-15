/*********************** Gramatica *********************/
:-[gulp].
:- dynamic(np_indefinido/2).

/*
 * premissas:
 * 	o verbo deve concordar com o agente, e nao com o tema!
 *  
 */

/*** Mensagens simples ****/
s([]) --> [].
s(ato_fala:responder .. mensagem: positivo)--> [sim].
s(ato_fala:responder .. mensagem: negativo)--> [nao].
s(ato_fala:responder .. mensagem: quem) --> [quem],[ou],[o],[que],['?'].
s(ato_fala:responder .. mensagem: ok) --> [ok].
s(ato_fala:responder .. mensagem: oi) --> [oi], pontuacao_opcional('.').
s(ato_fala:terminar .. mensagem: tchau) --> [tchau].
s(ato_fala:terminar .. mensagem: tchau) --> [tchau],[_].
s(ato_fala:responder .. mensagem: oi ..tema:T) --> 
	[oi],
	sn(id:T),
	pontuacao_opcional('.').

/*** Gramatica Real ****/
/* perguntas */

% ex: quem esta aqui? ("quem" eh o agente do verbo estar)
s(ato_fala:interro_agente_desconhecido ..agente:incog(Id) .. acao:X .. tema:T ..indefinido:IsIndefinido) -->
	sn(tipo: pron_qu .. coord:nao ..id:Id ..pessoa:P), 
	sv(puxa_pron:sim ..omite:_ ..acao:X ..tema:T ..pessoa:P ..indefinido:IsIndefinido),
        pontuacao_opcional(_).
	%,{ determina_indefinido(T, IsIndefinido, EI) }.

% 
s(ato_fala:interro_tema_desconhecido .. agente:Ag .. acao:X ..tema:incog(PronRelativo) ..indefinido:IsIndefinido ) -->
        spro(id:PronRelativo),
        sv(puxa_pron:sim ..omite:sim ..acao:X ..tema:A ..indefinido:IsIndefinido),
        pontuacao_opcional(_),
	{ 
	  determina_indefinido(A, IsIndefinido, Ag)
	}.
	
% perguntas cujas respostas serao sim ou nao no estilo "eu posso pegar", "eu posso ir", etc
s(ato_fala:int_sim_nao .. agente:A .. acao:X .. tema:T ..indefinido:nao) -->
	sn(id:A ..num:N),
	sv(puxa_pron:nao ..omite:nao ..acao:X .. tema:T ..num:N),
        ['?'].
%	{ 
%		determina_indefinido(T, IsIndefinido, EI);
%	  	determina_indefinido(A, IsIndefinido, EI) 
%	}.

/* informar / mandar */
% sentenca para agente singular
s(ato_fala:informar ..agente:A .. acao:X .. tema:T ..pessoa:Pes ..indefinido:nao) -->
        {\+ is_list(A)}, 
	sn(id:A .. num: N ..pessoa:Pes), 
	sv(puxa_pron:nao ..omite:nao ..acao:X .. tema:T .. num: N ..pessoa:Pes),
    	pontuacao_opcional('.').
	%,{ determina_indefinido(A, IsIndefinido, EI) }.

s(ato_fala:informar .. agente:A .. acao:X .. tema:T ..indefinido:nao) -->
        {\+ is_list(A)},
	sn(id:A .. num: N),
	sv(puxa_pron:nao ..omite:nao ..(acao:X .. tema:T .. num:N)),
    	pontuacao_opcional('.').
	%<{ determina_indefinido(T, IsIndefinido, EI) }.

% sentenca onde o agente eh "ninguem" ou "nada". (ex: nada estah aqui)
s(ato_fala:informar .. agente:[] .. acao:X .. tema:T ..entidade:E ..indefinido:nao) -->
	sn(tipo: pron_ninguem(E) .. coord:nao),
	sv(puxa_pron:nao ..omite:nao ..acao:X ..tema:T .. num: sing ..pessoa:terc),
        pontuacao_opcional('.').
	%{ determina_indefinido(T, IsIndefinido, EI) }.

% sentenca com agente composto (ex: as minhocas e a vara de pescar estao no ancoradouro).
s(ato_fala:informar .. agente:[A1|A2] .. acao:X .. tema:T ..pessoa:P ..indefinido:nao) -->
	sn(coord:sim .. id:[A1|A2] ..pessoa:P),
	sv(puxa_pron:nao ..omite:nao ..acao:X .. tema:T .. num:plur ..pessoa:P),
        pontuacao_opcional('.').
	%{ determina_indefinido(T, IsIndefinido, EI) }.

% sentenca na qual o agente tem que ser determinado pelo contexto (ex: pegar a lata - agente: quem falou)
s(ato_fala:informar ..agente:(pessoa:P ..num:N) .. acao:X .. tema:T ..indefinido:nao) -->
	sv(puxa_pron:nao ..omite:nao ..acao:X .. tema:T .. num:N .. pessoa:P),
	pontuacao_opcional('.').
%,{ determina_indefinido(T, IsIndefinido, EI) }.

% perguntas cujas respostas serao sim ou nao, do tipo "a faca estah aqui?" - acho que a regra de cima cobre essa regra
%s(ato_fala:int_sim_nao .. agente:A .. acao:X .. tema:T ..indefinido:IsIndefinido) -->
%        { \+compound(T), (member(Tipo, [np,nc]))},
%	sv(puxa_pron:nao ..agente:A ..tipo:Tipo ..omite:nao ..acao:X .. tema:T),
%        ['?'],
%	{ determina_indefinido(T, IsIndefinido, EI) }.

/* atos de fala diversos */
% funciona para produzir resposta do tipo "voce nao pode pegar X."
s(ato_fala:recusar ..agente:A ..acao:X .. tema:T ..indefinido:nao ..pessoa:Pessoa) -->
	sn(coord:nao ..id:A ..pessoa:Pessoa),
        [nao], [pode],
	sv(puxa_pron:nao ..omite:_ ..acao:X .. tema:T ..pessoa: indic),
        pontuacao_opcional('.').

% funciona para resposta do tipo tipo "eu nao sei o que eh faca"
s(ato_fala:recusar ..agente:A ..acao:X.. tema:Tema ..indefinido:sim ..pessoa:Pessoa) -->
	sn(coord:nao ..id:A ..pessoa:Pessoa ..tipo:_ ..produzindo:sim),
        [nao], 
	sv(puxa_pron:nao ..omite:_ ..acao:X .. tema:Tema ..pessoa: Pessoa ..indefinido:sim),
        pontuacao_opcional('.').

% SINTAGMA NOMINAL
sn_indef(coord:nao .. id:indefinido(texto: Texto ..tipo:Tipo ..gen:G ..num:N)) -->
    ident(gen:G .. num:N ..tipo:Tipo),
	np(id:Texto .. tipo:Tipo ..gen:G ..num:N ..indefinido:sim).

% casa com pronomes: eu, ele, voce
sn(coord:nao ..tipo:T ..id:Ag ..gen:G .. num:N .. pessoa:P ..indefinido:nao ..prep:PreposicaoPrecedente) -->
        { \+ is_list(Ag) },
        { ( 
        	(nonvar(Ag); nonvar(T)), 
           	denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Ag)
           );
           var(Ag)},
        pro(tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron ..prep:PreposicaoPrecedente), 
        { (var(Ag),
           denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Ag));
          \+ var(Ag)}.

% essa regra eh para produzir texto sobre substantivos indefinidos
sn(coord:nao .. id:Texto ..indefinido:sim ..pessoa:terc) -->
	{ nonvar(Texto) },
	sn_indef(coord:nao ..id:Texto ..pessoa:terc).

sn(coord:nao ..id:I ..tipo:T ..gen:G ..num:N ..num:N ..pessoa:terc ..indefinido:nao) -->
        { (\+ var(I); \+ is_list(I)) },
    ident(gen:G .. num:N ..tipo:T),
	np(id:I .. tipo:T ..gen:G ..num:N ..indefinido:nao).

% usada para reconhecer usos de substantivos, casando com artigo, adjetivo, adv, quantidade(todos,alguns,etc)
% nao aceita produzir texto
sn(coord:nao ..id:I ..tipo:T ..gen:G ..num:N ..pessoa:terc ..indefinido:IsIndefinido) -->
        { var(I), var(T), var(IsIndefinido) },
    det(gen:G .. num:N ..tipo:T ),
    mod(gen:G .. num:N), 
	np(id:I .. tipo:T ..gen:G ..num:N ..indefinido:IsIndefinido),
    mod(gen:G .. num:N),
	{ cria_np_indefinido(IsIndefinido, I, T, G, N) }.

% reconhece frases com conjuntos de substantivos (X e Y)
sn(coord:sim ..id:[A1,A2] .. num:plur ..prep:P) -->
	{ var(P) },
	sn(id:A1 .. coord:nao),
	[e],
	sn(id:A2 .. coord:nao).

% gera frases com conjuntos de substantivos, levando em consideracao a preposicao correta
sn(coord:sim ..id:[A1,A2] .. num:plur ..prep:P) -->
	{ \+ var(P) },
	sn(id:A1 .. coord:nao),
	[e],
	sp(id:A2 .. prep:P).

% reconhece/gera listas de substantivos
sn(coord:sim ..id:[A1|Resto] .. num:plur ..prep:P) -->
	sn(id:A1 .. coord:nao),
	[,],
	sn(coord:sim .. id:Resto ..prep:P).

% usado tao somente para imprimir "eu" sempre que o narrador for o agente da resposta
% so deve ser usado para produzir texto
sn(coord:nao ..id:Ag ..pessoa:prim ..indefinido:nao ..produzindo:ProduzindoTexto) -->
	{ nonvar(Ag), nonvar(ProduzindoTexto) },
	[eu].

% SINTAGMAS VERBAIS
% tipos de verbos a serem tratados:
% verbo transitivo direto (ex: verbos que não exigem preposição antes do objeto, pegar '' a faca)
% verbo transitivo indireto (ex.: verbo que exige preposição, ex: estar EM , assistir A)
% verbo bitransitivo direto e indireto (ex.:preferir)

% verbos intransitivos: verbo ou forma do verbo que nao exige nenhum complemento (ex.: pescar em, "eu pesco.")
sv(omite:O ..acao:A .. tema:T ..num:N ..pessoa:P ..indefinido:nao) -->
	{ var(T) },
	v(omite:O ..acao:A ..subcat:[] .. num:N ..pessoa:P).

% verbo que exige preposicao e substantivo (ex.: estar em, "o barco esta _no_ ...")
% casa com verbo transitivo indireto que exige preposição
sv(omite:O ..acao:A .. tema:T .. num:N ..pessoa:Pess ..indefinido:IsIndefinido) -->
	{ \+ compound(T); is_list(T) },
	v(omite: O ..acao:A ..num:N ..pessoa:Pess ..subcat:[sp(prep:P)]),
	sp(id:T ..prep:P ..indefinido:IsIndefinido).

% verbo que exige substantivo depois (ex.: pegar, "pegar o ...")
sv(omite:O ..acao:A .. tema:T ..gen:G ..num:N ..pessoa:P ..indefinido:IsIndefinido) -->
	{ \+ compound(T); is_list(T) },
	v(omite:O ..acao:A ..subcat:[sn] ..num:N ..pessoa:P),
	sn(id:T ..gen:G ..num:_ ..indefinido:IsIndefinido).
	% nao forca o substantivo que tem depois a concordar com o anterior, pois o anterior eh o verbo do agente
	% e o sn represta o tema 

% verbo transitivo para o caso de perguntas, onde o complemento não está presente
% exemplo onde a faca está?
% O puxa_pron deveria ser um flag indicando que o complemento do verbo ja foi definido,
% por exemplo, no caso do onde. 
sv(puxa_pron:sim ..omite:O ..acao:A .. tema:T ..num:N ..pessoa:P ..indefinido:IsIndefinido) -->
	{ \+ compound(T); is_list(T) },
	sn(id:T ..pessoa:P ..num:N ..indefinido:IsIndefinido),
	v(omite:O ..acao:A ..subcat:[sn] ..num:N ..pessoa:P).


sv(omite:O ..acao:A .. tema:T ..num:N ..pessoa:P ..indefinido:IsIndefinido) -->
	{ \+ compound(T); is_list(T) },
	v(omite:O ..acao:A ..subcat:[sn, sp(prep:Prep)] ..num:N ..pessoa:P),
	sn(id:T ..indefinido:IsIndefinido),
    sp(prep:Prep ..indefinido:IsIndefinido).

sv(omite:O ..acao:A .. tema:T .. num:N ..pessoa:Pess ..indefinido:IsIndefinido) -->
%	{ \+ compound(T) },
	v(omite: O ..acao:A ..num:N ..pessoa:Pess ..subcat:[sn]),
	sn(id:T ..indefinido:IsIndefinido).

% ex.: o que eh ...
sv(omite:O ..acao:A ..tema:(acao:AX ..pessoa:PX ..num:NX ..tema:T) ..num:N ..pessoa:P ..indefinido:IsIndefinido) -->
	v(omite:O ..acao:A ..subcat:[pro(pron:Pronome),sn] ..num:N ..pessoa:P),
	pro(tipo_pro:pron_qu ..pron:Pronome),
	sv(omite:nao ..acao:AX ..pessoa:PX ..num:NX ..tema:T ..indefinido:IsIndefinido).

sv(omite:O ..acao:A ..tema:(acao:AX ..pessoa:P ..num:N ..tema:T) ..num:N ..pessoa:P ..indefinido:IsIndefinido) -->
	v(omite:O ..acao:AX ..subcat:[sv] ..pessoa:P),
	sv(omite: O ..acao:A ..tema:T .. num:N ..pessoa:indic ..indefinido:IsIndefinido).
	
sp(id:I .. prep:P ..indefinido:IsIndefinido) -->
    prep(prep:P),
    sn(id:I ..indefinido:IsIndefinido ..prep:P).

sp(id:I .. prep:_ ..indefinido:IsIndefinido) -->
    sn(id:I ..indefinido:IsIndefinido ..prep:[]).

spro(id:I) -->
    pro(tipo_pro: relativo ..pron:A),
    { denota_lugar(A, I) }.
    
spro(id:[]) -->
    pro(tipo_pro: pron_ninguem(onde) ..pron:A),
    { denota_lugar(A, _) }.
    

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

pontuacao_opcional(P) --> [P];[].

% tratamento de casos indefinidos

cria_np_indefinido(IsIndefinido,_, _, _, _):-
	var(IsIndefinido),
	IsIndefinido = nao.

cria_np_indefinido(sim, Texto, T, G, N):-
	nonvar(T), nonvar(G), nonvar(N), nonvar(Texto),
	asserta(np_indefinido(Texto, indefinido(texto: Texto ..tipo:T ..gen:G ..num:N))).

cria_np_indefinido(IsIndefinido,Texto, _, _, _):-
	( var(IsIndefinido) ; IsIndefinido = nao ),
	clause(np_indefinido, _),
	np_indefinido(Texto, _),
	retract(np_indefinido(Texto, _)).
	
cria_np_indefinido(_,_,_,_,_).

determina_indefinido(IdentidadeIndefinido, sim, Tracos):-
	np_indefinido(IdentidadeIndefinido, Tracos),!,
	retract(np_indefinido(IdentidadeIndefinido, _)).

determina_indefinido(IdentidadeIndefinido, nao, IdentidadeIndefinido):-
	\+ np_indefinido(IdentidadeIndefinido, _).

determina_indefinido(A, _,A):-
	\+ compound(A),
	retractall(np_indefinido).

%%%%%%%% Utilizado para contracoes/quebra
%% eh usado no IO
equivale(na, [em, a]).
equivale(numa, [em, uma]).
equivale(no, [em, o]).
equivale(num, [em, um]).
equivale(da, [de, a]).
equivale(das, [de, as]).
equivale(do, [de, o]).
equivale(dos, [de, os]).
equivale(comigo, [em, eu]).
equivale(contigo, [em, voce]).
equivale(nele, [em, ele]).


