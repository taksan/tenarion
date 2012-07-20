/*********************** Gramatica *********************/
:-[gulp].
:- dynamic(np_desconhecido/2).

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

% ex.: o que EU tenho (EU eh agente)
s(ato_fala:interro_tema_desconhecido ..agente:Agente ..tema:incog(Id) .. acao:X ..desconhecido:_) -->
	sn(tipo: pron_qu .. coord:nao ..id:Id ..pessoa:P), 
	sv(tema_eh_agente_ou_complemento:agente ..acao:X ..tema:Agente ..pessoa:P ..desconhecido:nao),
    pontuacao_opcional(_).


% ex: quem esta aqui? ("quem" eh o agente do verbo estar)
s(ato_fala:interro_agente_desconhecido ..agente:incog(Id) .. acao:X .. tema:T ..desconhecido:IsDesconhecido) -->
	sn(tipo: pron_qu .. coord:nao ..id:Id ..pessoa:P), 
	sv(acao:X ..tema:T ..pessoa:P ..desconhecido:nao),
    pontuacao_opcional(_).
	%,{ determina_desconhecido(T, IsDesconhecido, EI) }.

s(ato_fala:interro_tema_desconhecido .. agente:Ag .. acao:X ..tema:incog(PronRelativo) ..desconhecido:IsDesconhecido ) -->
        spro(id:PronRelativo),
        sv(tema_eh_agente_ou_complemento:agente ..acao:X ..tema:A ..desconhecido:IsDesconhecido),
        pontuacao_opcional(_),
	{ 
	  determina_desconhecido(A, IsDesconhecido, Ag)
	}.
	
% perguntas cujas respostas serao sim ou nao no estilo "eu posso pegar", "eu posso ir", etc
s(ato_fala:int_sim_nao .. agente:A .. acao:X .. tema:T ..desconhecido:nao) -->
	sn(id:A ..num:N),
	sv(tema_eh_agente_ou_complemento:complemento ..omite:nao ..acao:X .. tema:T ..num:N),
        ['?'].
%	{ 
%		determina_desconhecido(T, IsDesconhecido, EI);
%	  	determina_desconhecido(A, IsDesconhecido, EI) 
%	}.

/* informar / mandar */
% sentenca para agente singular
s(ato_fala:informar ..agente:A .. acao:X .. tema:T ..pessoa:Pes ..desconhecido:nao) -->
        {\+ is_list(A)}, 
	sn(id:A .. num: N ..pessoa:Pes), 
	sv(tema_eh_agente_ou_complemento:complemento ..omite:nao ..acao:X .. tema:T .. num: N ..pessoa:Pes),
    	pontuacao_opcional('.').
	%,{ determina_desconhecido(A, IsDesconhecido, EI) }.

s(ato_fala:informar .. agente:A .. acao:X .. tema:T ..desconhecido:nao) -->
        {\+ is_list(A)},
	sn(id:A .. num: N),
	sv(tema_eh_agente_ou_complemento:complemento ..omite:nao ..(acao:X .. tema:T .. num:N)),
    	pontuacao_opcional('.').
	%<{ determina_desconhecido(T, IsDesconhecido, EI) }.

% sentenca onde o agente eh "ninguem" ou "nada". (ex: nada estah aqui)
s(ato_fala:informar .. agente:[] .. acao:X .. tema:T ..entidade:E ..desconhecido:nao) -->
	sn(tipo: pron_ninguem(E) .. coord:nao),
	sv(tema_eh_agente_ou_complemento:complemento ..omite:nao ..acao:X ..tema:T .. num: sing ..pessoa:terc),
        pontuacao_opcional('.').
	%{ determina_desconhecido(T, IsDesconhecido, EI) }.

% sentenca com agente composto (ex: as minhocas e a vara de pescar estao no ancoradouro).
s(ato_fala:informar .. agente:[A1|A2] .. acao:X .. tema:T ..pessoa:P ..desconhecido:nao) -->
	sn(coord:sim .. id:[A1|A2] ..pessoa:P),
	sv(tema_eh_agente_ou_complemento:complemento ..omite:nao ..acao:X .. tema:T .. num:plur ..pessoa:P),
        pontuacao_opcional('.').
	%{ determina_desconhecido(T, IsDesconhecido, EI) }.

% sentenca na qual o agente tem que ser determinado pelo contexto (ex: pegar a lata - agente: quem falou)
s(ato_fala:informar ..agente:(pessoa:P ..num:N) .. acao:X .. tema:T ..desconhecido:nao) -->
	sv(tema_eh_agente_ou_complemento:complemento ..omite:nao ..acao:X .. tema:T .. num:N .. pessoa:P),
	pontuacao_opcional('.').
%,{ determina_desconhecido(T, IsDesconhecido, EI) }.

% perguntas cujas respostas serao sim ou nao, do tipo "a faca estah aqui?" - acho que a regra de cima cobre essa regra
%s(ato_fala:int_sim_nao .. agente:A .. acao:X .. tema:T ..desconhecido:IsDesconhecido) -->
%        { \+compound(T), (member(Tipo, [np,nc]))},
%	sv(tema_eh_agente_ou_complemento:complemento ..agente:A ..tipo:Tipo ..omite:nao ..acao:X .. tema:T),
%        ['?'],
%	{ determina_desconhecido(T, IsDesconhecido, EI) }.

/* atos de fala diversos */
% funciona para produzir resposta do tipo "voce nao pode pegar X."
s(ato_fala:recusar ..agente:A ..acao:X .. tema:T ..desconhecido:nao ..pessoa:Pessoa) -->
	sn(coord:nao ..id:A ..pessoa:Pessoa),
        [nao], [pode],
	sv(tema_eh_agente_ou_complemento:complemento ..omite:_ ..acao:X .. tema:T ..pessoa: indic),
        pontuacao_opcional('.').

% funciona para resposta do tipo tipo "eu nao sei o que eh faca"
s(ato_fala:recusar ..agente:A ..acao:X.. tema:Tema ..desconhecido:sim ..pessoa:Pessoa) -->
	sn(coord:nao ..id:A ..pessoa:Pessoa ..tipo:_ ..produzindo:sim),
%        [nao], 
	sv(positivo:nao ..tema_eh_agente_ou_complemento:complemento ..omite:_ ..acao:X .. tema:Tema ..pessoa: Pessoa ..desconhecido:sim),
        pontuacao_opcional('.').

% SINTAGMA NOMINAL
sn_indef(coord:nao .. id:desconhecido(texto: Texto ..tipo:Tipo ..gen:G ..num:N)) -->
    ident(gen:G .. num:N ..tipo:Tipo),
	np(id:Texto .. tipo:Tipo ..gen:G ..num:N ..desconhecido:sim).

% casa com pronomes: eu, ele, voce
sn(coord:nao ..tipo:T ..id:Ag ..gen:G .. num:N .. pessoa:P ..desconhecido:nao) -->
        { \+ is_list(Ag) },
        { (
        	var(Ag); 
        	(nonvar(Ag); nonvar(T)), 
           	denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Ag)
           )},
        pro(tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), 
        { nonvar(Ag);
          (
          	var(Ag),
           	denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Ag) 
           )}.

sn(coord:nao ..positivo:nao ..id:np([],TipoQuem) ..desconhecido:nao)-->
	pro(tipo_pro:pron_ninguem(TipoQuem)).

sn(coord:nao ..id:I ..tipo:T ..gen:G ..num:N ..num:N ..pessoa:terc ..desconhecido:nao) -->
        { (var(I); \+ is_list(I)) },
    	ident(gen:G .. num:N ..tipo:T),
	np(id:I .. tipo:T ..gen:G ..num:N ..desconhecido:nao).

% usada para reconhecer usos de substantivos, casando com artigo, adjetivo, adv, quantidade(todos,alguns,etc)
% nao aceita produzir texto
sn(coord:nao ..id:I ..tipo:T ..gen:G ..num:N ..pessoa:terc ..desconhecido:IsDesconhecido) -->
        { var(I), var(T), var(IsDesconhecido) },
	det(gen:G .. num:N ..tipo:T ),
	mod(gen:G .. num:N), 
	np(id:I .. tipo:T ..gen:G ..num:N ..desconhecido:IsDesconhecido),
	mod(gen:G .. num:N),
	{ cria_np_desconhecido(IsDesconhecido, I, T, G, N) }.

% reconhece frases com conjuntos de substantivos (X e Y)
sn(coord:sim ..id:[A1,A2] .. num:plur ..prep:P) -->
	{ var(P) },
	sn(id:A1 .. coord:nao),
	[e],
	sn(id:A2 .. coord:nao).

% gera frases com conjuntos de substantivos, levando em consideracao a preposicao correta
sn(coord:sim ..id:[A1,A2] .. num:plur ..prep:P) -->
	{ nonvar(P) },
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
sn(coord:nao ..id:Ag ..pessoa:prim ..desconhecido:nao ..produzindo:ProduzindoTexto) -->
	{ nonvar(Ag), nonvar(ProduzindoTexto) },
	[eu].

%sn(coord:nao ..id:Ag ..pessoa:P ..num:N ..gen:N) -->
%	sadvb(id:Ag),
%	{ ignore(np((id:Ag ..num:N ..pessoa:P ..gen:N),_,[]) }.

% essa regra eh para produzir texto sobre substantivos desconhecidos
sn(coord:nao .. id:Texto ..desconhecido:sim ..pessoa:terc) -->
	{ nonvar(Texto) },
	sn_indef(coord:nao ..id:Texto ..pessoa:terc).

% SINTAGMAS VERBAIS
% tipos de verbos a serem tratados:
% verbo transitivo direto (ex: verbos que não exigem preposição antes do objeto, pegar '' a faca)
% verbo bitransitivo direto e indireto (ex.:preferir)

% VERBO INTRANSITIVO
% verbos intransitivos: verbo ou forma do verbo que nao exige nenhum complemento (ex.: pescar em, "eu pesco.")
sv(omite:O ..acao:A .. tema:T ..num:N ..pessoa:P ..desconhecido:nao) -->
	{ var(T) },
	v(omite:O ..acao:A ..subcat:[] .. num:N ..pessoa:P).

%% IMPORTANTE:
%%% o verbo transitivo direto TEM que ser testado antes do indireto, pois no caso de verbos
%%% que possuem as duas formas com conotações diferentes(ex: ser no sentido de ser ou de pertencer)
%%% ele deve preferir tentar o que nao tem a preposição

% VERBO TRANSITIVO DIRETO onde o OBJETO foi determinado antes
% exemplo onde a faca está? (nesse caso o complemento é ONDE)
% Nesses casos, o tema do sintagma verbal será o AGENTE  
sv(tema_eh_agente_ou_complemento:agente ..omite:O ..acao:A .. tema:Agente ..desconhecido:IsDesconhecido) -->
%	{ \+ compound(T); is_list(T) },
	sn(id:Agente ..pessoa:P ..num:N ..desconhecido:IsDesconhecido),
	v(omite:O ..acao:A ..subcat:[sn] ..num:N ..pessoa:P).

% igual ao caso anterior, apenas invertendo verbo com agente
sv(tema_eh_agente_ou_complemento:agente ..omite:O ..acao:A .. tema:Agente ..desconhecido:IsDesconhecido) -->
%	{ \+ compound(T); is_list(T) },
	v(omite:O ..acao:A ..subcat:[sn] ..num:N ..pessoa:P),
	sn(id:Agente ..pessoa:P ..num:N ..desconhecido:IsDesconhecido).


% VERBO TRANSITIVO DIRETO
% verbo que exige substantivo depois (ex.: pegar, "pegar o ...")
% AGENTE: externo (num:N ..pessoa:Pess)
sv(tema_eh_agente_ou_complemento:complemento ..omite:O ..acao:A .. tema:Complemento ..num:N ..pessoa:P ..desconhecido:IsDesconhecido) -->
%	{ \+ compound(T); is_list(T) },
	{ is_positivo(Complemento, IsPositivo) },
	negacao(positivo:IsPositivo),
	v(omite:O ..acao:A ..subcat:[sn] ..num:N ..pessoa:P),
	sn(id:Complemento ..desconhecido:IsDesconhecido).
	% nao forca o substantivo que tem depois a concordar com o anterior, pois o anterior eh o verbo do agente
	% e o sn representata o complemento 

sv(tema_eh_agente_ou_complemento:complemento ..omite:O ..acao:A ..tema:Complemento .. num:N ..pessoa:Pess) -->
%	{ \+ compound(T); is_list(T) },
	v(omite: O ..acao:A ..num:N ..pessoa:Pess ..subcat:[advb]),
	sadvb(id:Complemento).

% VERBO TRANSITIVO INDIRETO
% verbo que exige preposicao e substantivo - tb chamdo de objeto indireto (ex.: estar em, "o barco esta _no_ ...")
% AGENTE: externo (num:N ..pessoa:Pess)
sv(tema_eh_agente_ou_complemento:complemento ..omite:O ..acao:A ..tema:Complemento .. num:N ..pessoa:Pess ..desconhecido:IsDesconhecido) -->
%	{ \+ compound(T); is_list(T) },
	v(omite: O ..acao:A ..num:N ..pessoa:Pess ..subcat:[sp(prep:P)]),
	sp(id:Complemento ..prep:P ..desconhecido:IsDesconhecido).

% VERBO TRANSITIVO INDIRETO onde o OBJETO foi determinado antes 
% nesse caso, o substantivo determina o AGENTE
% ex: *onde* estah a identidade? (*onde* eh o complemento, *a identidade* é o agente)
sv(tema_eh_agente_ou_complemento:agente ..omite:O ..acao:A .. tema:Agente ..desconhecido:IsDesconhecido) -->
%	{ \+ compound(T); is_list(T) },
	v(omite: O ..acao:A ..num:N ..pessoa:Pess ..subcat:[sp(prep:_)]),
	sn(id:Agente ..num:N ..pessoa:Pess ..desconhecido:IsDesconhecido).
	
% igual ao caso acima, mas o verbo fica no final.
sv(tema_eh_agente_ou_complemento:agente ..omite:O ..acao:A .. tema:Agente ..desconhecido:IsDesconhecido) -->
%	{ \+ compound(T); is_list(T) },
	sn(id:Agente ..num:N ..pessoa:Pess ..desconhecido:IsDesconhecido),
	v(omite: O ..acao:A ..num:N ..pessoa:Pess ..subcat:[sp(prep:_)]).
	

% VERBO BITRANSITIVO 
% seria o caso bitransitivo, exigindo um objeto direto e um indireto
sv(omite:O ..acao:A .. tema:T ..num:N ..pessoa:P ..desconhecido:IsDesconhecido) -->
%	{ \+ compound(T); is_list(T) },
	v(omite:O ..acao:A ..subcat:[sn, sp(prep:Prep)] ..num:N ..pessoa:P),
	sn(id:T ..desconhecido:IsDesconhecido),
   	sp(prep:Prep ..desconhecido:IsDesconhecido).

% ex.: sv onde o tema eh uma acao
sv(positivo:IsPositivo ..omite:O ..acao:A ..tema:(acao:AX ..pessoa:PX ..num:NX ..tema:T) ..num:N ..pessoa:P ..desconhecido:IsDesconhecido) -->
	negacao(positivo:IsPositivo),
	v(omite:O ..acao:A ..subcat:[pro(pron:Pronome),sn] ..num:N ..pessoa:P),
	pro(tipo_pro:pron_qu ..pron:Pronome),
	sv(tema_eh_agente_ou_complemento:complemento ..omite:nao ..acao:AX ..pessoa:PX ..num:NX ..tema:T ..desconhecido:IsDesconhecido).

sv(positivo:IsPositivo ..omite:O ..acao:A ..tema:(acao:AX ..pessoa:P ..num:N ..tema:T) ..num:N ..pessoa:P ..desconhecido:IsDesconhecido) -->
	negacao(positivo:IsPositivo),
	v(omite:O ..acao:AX ..subcat:[sv] ..pessoa:P),
	sv(omite: O ..acao:A ..tema:T .. num:N ..pessoa:indic ..desconhecido:IsDesconhecido).

% cobre o caso em que o objeto indireto eh substituido por um adverbio
sp(id:I .. prep:_ ..desconhecido:_)-->
	sadvb(id:I).
	
sp(id:I .. prep:P ..desconhecido:IsDesconhecido) -->
    prep(prep:P),
    sn(id:I ..desconhecido:IsDesconhecido ..prep:P).

sadvb(id:I) -->
    advb(tipo_adv:lugar ..adv:A),
    { denota_lugar(A, I) }.

negacao(positivo: IsPositivo) -->
	{ nonvar(IsPositivo) },
    advb(tipo_adv:afirmacao ..adv:IsPositivo).

negacao(positivo: IsPositivo) -->
	{ var(IsPositivo), IsPositivo=sim },
    advb(tipo_adv:afirmacao ..adv:IsPositivo).

spro(id:I) -->
    pro(tipo_pro: relativo ..pron:I).
    
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

% tratamento de casos desconhecidos
is_positivo(np([],_), nao).
is_positivo(_, sim).

cria_np_desconhecido(IsDesconhecido,_, _, _, _):-
	var(IsDesconhecido),
	IsDesconhecido = nao.

cria_np_desconhecido(sim, Texto, T, G, N):-
	nonvar(T), nonvar(G), nonvar(N), nonvar(Texto),
	asserta(np_desconhecido(Texto, desconhecido(texto: Texto ..tipo:T ..gen:G ..num:N))).

cria_np_desconhecido(IsDesconhecido,Texto, _, _, _):-
	( var(IsDesconhecido) ; IsDesconhecido = nao ),
	clause(np_desconhecido, _),
	np_desconhecido(Texto, _),
	retract(np_desconhecido(Texto, _)).
	
cria_np_desconhecido(_,_,_,_,_).

determina_desconhecido(IdentidadeDesconhecido, sim, Tracos):-
	np_desconhecido(IdentidadeDesconhecido, Tracos),!,
	retract(np_desconhecido(IdentidadeDesconhecido, _)).

determina_desconhecido(IdentidadeDesconhecido, nao, IdentidadeDesconhecido):-
	\+ np_desconhecido(IdentidadeDesconhecido, _).

determina_desconhecido(A, _,A):-
	\+ compound(A),
	retractall(np_desconhecido).

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
equivale(dele, [de, ele]).
equivale(dela, [de, ela]).
equivale(deles, [de, eles]).
equivale(delas, [de, elas]).

