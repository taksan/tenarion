/*********************** Gramatica *********************/
%:-[gulp].
:-[apoio_gramatical].
:- dynamic(np_desconhecido/2),dynamic(forca_pontuacao/1).


/*
* premissas:
* 	o verbo deve concordar com o agente, e nao com o tema!
*/


/*** Sentencas compostas****/
s(ato_fala:composto ..composicao:[])-->[].

s(ato_fala:composto ..composicao:[S1|Outros])-->
	{
		nonvar(S1),
		S1=(ligacao:L),
		ignore((nonvar(L),asserta(forca_pontuacao(L))))
	},
	s(S1),
	{ 	ignore((nonvar(L),retract(forca_pontuacao(_)))) },
	s(ato_fala:composto ..composicao:Outros).


s(Tracos)-->
	{
		Tracos=(porque:Porque ..porque_processado:nao),
		nonvar(Porque),
		Porque=(porque_processado:PorqueProcessado ..ato_fala:informar),
		var(PorqueProcessado),
		once(marcar_porque_processado(Porque)),
		asserta(forca_pontuacao(','))
	},
	s(Tracos),
	[porque],
	{ 	retract(forca_pontuacao(_)) },
	s(Porque).



/*** Mensagens simples ****/
s([]) --> [].

s(ato_fala:responder .. mensagem: positivo)--> [sim].
s(ato_fala:responder .. mensagem: negativo)--> advb(tipo_adv:afirmacao ..adv:nao).
s(ato_fala:responder .. mensagem: quem) --> [quem],[ou],[o],[que],['?'].
s(ato_fala:responder .. mensagem: ok) --> [ok].
s(ato_fala:responder .. mensagem: oi) --> [oi], pontuacao_opcional('.').
s(ato_fala:terminar .. mensagem: tchau) --> [tchau], pontuacao_opcional('.').
s(ato_fala:responder .. mensagem: oi ..tema:T) --> 
	[oi],
	sn(id:T),
	pontuacao_opcional('.').


/* perguntas */

% ex.: o que EU tenho (EU é agente)
% ex: quem esta aqui? ("quem" é o agente do verbo estar)
s(ato_fala:interro_agente_incognito ..agente:incog(Id) ..acao:X.. pessoa:P.. gen:G ..num:N ..tema:Paciente ..desconhecido:nao) -->
	sn(tipo: relativo .. coord:nao ..id:Id), 
	sv(tema_eh_agente_ou_complemento:complemento ..acao:X ..tema:Paciente ..pessoa:P ..num:N ..gen:G ..desconhecido:nao),
    pontuacao_opcional('?').

s(ato_fala:interro_tema_incognito ..agente:Agente ..tema:incog(Id) .. acao:X ..desconhecido:nao) -->
	sn(tipo: relativo .. coord:nao ..id:Id ..pessoa:P), 
	sv(tema_eh_agente_ou_complemento:agente ..acao:X ..tema:Agente ..pessoa:P ..desconhecido:nao),
    pontuacao_opcional(_).


s(ato_fala:interro_tema_incognito .. agente:Ag .. acao:X ..tema:(tema:incog(PronRelativo) ..subtema:Paciente) ..desconhecido:IsDesconhecido ) -->
	sn(tipo:relativo .. coord:nao ..id:PronRelativo),% casa com ONDE
	sn(id:Ag),%casa com o sujeito
    sv(tema_eh_agente_ou_complemento:complemento ..acao:X ..tema:Paciente ..desconhecido:IsDesconhecido),
    pontuacao_opcional(_).

s(ato_fala:interro_tema_incognito ..agente:Agente ..tema:incog(Id) .. acao:X ..desconhecido:IsDesconhecido) -->
	sn(tipo: relativo .. coord:nao ..id:Id ..pessoa:P), 
	sv(tema_eh_agente_ou_complemento:agente ..acao:X ..tema:Agente ..pessoa:P ..desconhecido:IsDesconhecido),
    pontuacao_opcional(_).
	
% perguntas cujas respostas serao sim ou nao no estilo "eu posso pegar", "eu posso ir", etc
s(ato_fala:int_sim_nao .. agente:A .. acao:X .. tema:Paciente ..desconhecido:nao) -->
	sn(id:A ..num:N ..pessoa:Pes ..gen:G),
	sv(tema_eh_agente_ou_complemento:complemento ..acao:X .. tema:Paciente ..num:N ..pessoa:Pes ..gen:G),
    ['?'].

/* informar / mandar */
% sentenca para agente singular


s(ato_fala:informar ..positivo:IsPositivo ..agente:A .. acao:X .. tema:Paciente ..pessoa:Pes ..desconhecido:_) -->
        {\+ is_list(A)}, 
	sn(id:A .. num: N ..pessoa:Pes ..gen:G), 
	sv(tema_eh_agente_ou_complemento:complemento ..positivo:IsPositivo ..acao:X .. tema:Paciente .. num: N ..pessoa:Pes ..gen:G),
   	pontuacao_opcional('.').

% sentenca com agente composto (ex: as minhocas e a vara de pescar estao no ancoradouro).
s(ato_fala:informar .. agente:[A1|ATail] .. acao:X .. tema:Paciente ..pessoa:P) -->
	sn(coord:sim .. id:[A1|ATail] ..pessoa:P),
	sv(tema_eh_agente_ou_complemento:complemento ..acao:X .. tema:Paciente .. num:plur ..pessoa:P),
    pontuacao_opcional('.').

% sentenca na qual o agente tem que ser determinado pelo contexto (ex: pegar a lata - agente: quem falou)
s(ato_fala:informar ..agente:(pessoa:P ..num:N) .. acao:X .. tema:Paciente ..desconhecido:_) -->
	sv(tema_eh_agente_ou_complemento:complemento ..acao:X .. tema:Paciente .. num:N .. pessoa:P),
	pontuacao_opcional('.').

/* atos de fala diversos */

% funciona para resposta do tipo tipo "eu nao sei o que é faca"
s(ato_fala:recusar ..agente:A ..acao:X.. tema:Paciente ..desconhecido:sim ..pessoa:Pessoa) -->
	sn(coord:nao ..id:A ..pessoa:Pessoa ..tipo:_ ..produzindo:sim ..gen:G),
	sv(positivo:nao ..tema_eh_agente_ou_complemento:complemento ..acao:X .. tema:Paciente ..pessoa: Pessoa ..gen:G ..desconhecido:sim),
        pontuacao_opcional('.').

% SINTAGMA NOMINAL
% casa com pronomes: eu, ele, voce
sn(coord:nao ..tipo:T ..id:Ag ..gen:G .. num:N .. pessoa:P ..desconhecido:nao) -->
	{ \+compound(Ag)},
	pro(tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Ag).

sn(coord:nao ..positivo:nao ..id:np([],onde) ..desconhecido:nao)-->
	[lugar],
	pro(tipo_pro:pron_ninguem(onde)).

sn(coord:nao ..positivo:nao ..id:np([],TipoQuem) ..desconhecido:nao)-->
	pro(tipo_pro:pron_ninguem(TipoQuem)).

sn(coord:nao ..id:Substantivo ..tipo:T ..gen:G ..num:N ..num:N ..pessoa:terc ..desconhecido:nao ..prefere_det:TipoDet) -->
    { id_para_np(Substantivo, I), (var(I); \+ is_list(I)), \+compound(I) },
	{  nonvar(TipoDet),T\=np,TipoIdent=TipoDet; (var(TipoDet), TipoDet=np);TipoIdent=T },
   	ident(gen:G .. num:N ..tipo:TipoIdent),
	np(id:I .. tipo:T ..gen:G ..num:N ..desconhecido:nao).

% usada para reconhecer usos de substantivos, casando com artigo, adjetivo, adv, quantidade(todos,alguns,etc)
% nao aceita produzir texto
sn(coord:nao ..id:Substantivo ..tipo:T ..gen:G ..num:N ..pessoa:terc ..desconhecido:IsDesconhecido) -->
    { var(Substantivo), var(I), var(T), var(IsDesconhecido) },
	det(gen:G .. num:N ..tipo:T ..det:det(numero:Numero.. quant:Quant.. poss:Poss)),
	mod(gen:G .. num:N), 
	np(id:I .. tipo:T ..gen:G ..num:N ..desconhecido:IsDesconhecido),
	mod(gen:G .. num:N),
	{ id_para_np(Substantivo,sn(id:I..numero:Numero.. quant:Quant.. poss:Poss))}.

% reconhece frases com conjuntos de substantivos (X e Y)
sn(coord:sim ..id:[A1,A2] .. num:plur ..prep:P) -->
	{ var(P) },
	sn(id:A1 .. coord:nao ..prefere_det:nc),
	[e],
	sn(id:A2 .. coord:nao ..prefere_det:nc).

% gera frases com conjuntos de substantivos, levando em consideracao a preposicao correta
sn(coord:sim ..id:[A1,A2] .. num:plur ..prep:P) -->
	{ nonvar(P) },
	sn(id:A1 .. coord:nao ..prefere_det:nc),
	[e],
	sp(id:A2 .. prep:P ..prefere_det:nc).

% reconhece/gera listas de substantivos
sn(coord:sim ..id:[A1|Resto] .. num:plur ..prep:P) -->
	sn(id:A1 .. coord:nao ..prefere_det:nc),
	[,],
	sn(coord:sim .. id:Resto ..prep:P ..prefere_det:nc).

sn(coord:nao ..id:Substantivo ..tipo:T ..gen:G ..num:N ..pessoa:terc ..desconhecido:nao ..prefere_det:TipoDet) -->
	{ id_para_np(Substantivo, SnComposto) },
	{ SnComposto = comp_nominal(I,CompNominal) },
    { (var(I); \+ is_list(I)), \+compound(I) },
	{  nonvar(TipoDet),T\=np,TipoIdent=TipoDet; (var(TipoDet), TipoDet=np);TipoIdent=T },
   	ident(gen:G .. num:N ..tipo:TipoIdent),
	np(id:I .. tipo:T ..gen:G ..num:N ..desconhecido:nao),
	sp(prep:de ..id:CompNominal ..prefere_det:TipoDet).

sn(coord:nao ..id:Substantivo  ..tipo:T ..gen:G ..num:N ..desconhecido:nao)-->
	{ nonvar(Substantivo), Substantivo=pred(Pred) },
	np(id:Pred.. tipo:T ..gen:G ..num:N ..desconhecido:nao).
	

sn(coord:nao ..id:Substantivo ..tipo:T ..gen:G ..num:N ..pessoa:terc ..desconhecido:nao ..prefere_det:TipoDet) -->
	{ id_para_np(Substantivo, SnComposto) },
	{ SnComposto = comp_nominal(I,CompNominal) },
    { (var(I); \+ is_list(I)), \+compound(I) },
	{  nonvar(TipoDet),T\=np,TipoIdent=TipoDet; (var(TipoDet), TipoDet=np);TipoIdent=T },
   	ident(gen:G .. num:N ..tipo:TipoIdent),
	poss(poss:I..pessoa:terc..gen:G),
	np(id:CompNominal .. tipo:T ..gen:G ..num:N ..desconhecido:nao).


% essa regra eh para produzir texto sobre substantivos desconhecidos
sn(coord:nao .. id:Id ..desconhecido:sim) -->
	{ nonvar(Id), Id=desconhecido(tipo:Tipo ..gen:G ..num:N)  },
    ident(gen:G .. num:N ..tipo:nc),
	np(id:Id .. tipo:Tipo ..gen:G ..num:N ..desconhecido:sim).

% SINTAGMAS VERBAIS
% tipos de verbos a serem tratados:
% verbo transitivo direto (ex: verbos que não exigem preposição antes do objeto, pegar '' a faca)
% verbo bitransitivo direto e indireto (ex.:preferir)

%% VERBO TRANSITIVO DIRETO CUJO COMPLEMENTO É OUTRO VERBO
sv(tema_eh_agente_ou_complemento:complemento.. positivo:IsPositivo ..acao:A ..num:_ ..pessoa:P ..desconhecido:IsDesconhecido 
		..tema:(tema_eh_agente_ou_complemento:TAC ..acao:AX ..pessoa:PX ..num:NX ..tema:AgenteOuPaciente ..subcat:SUBCAT) ) -->
	{ ignore((var(IsPositivo),is_positivo(AgenteOuPaciente, IsPositivo))) },
	adv_afirmacao(positivo:IsPositivo),
	v(acao:A ..subcat:[sv] ..pessoa:P),
	sv(tema_eh_agente_ou_complemento:TAC ..positivo:sim ..acao:AX ..tema:AgenteOuPaciente .. num:NX ..pessoa:PX ..desconhecido:IsDesconhecido ..subcat:SUBCAT).


% VERBO INTRANSITIVO
% verbos intransitivos: verbo ou forma do verbo que nao exige nenhum complemento (ex.: pescar em, "eu pesco.")
sv(acao:A .. tema:TemaNaoInstanciado ..num:N ..pessoa:P ..desconhecido:nao) -->
	{ var(TemaNaoInstanciado) },
	v(acao:A ..subcat:[] .. num:N ..pessoa:P).

%% IMPORTANTE:
%%% o verbo transitivo direto TEM que ser testado antes do indireto, pois no caso de verbos
%%% que possuem as duas formas com conotações diferentes(ex: ser no sentido de ser ou de pertencer)
%%% ele deve preferir tentar o que nao tem a preposição

% VERBO TRANSITIVO DIRETO onde o OBJETO foi determinado antes
% exemplo onde a faca está? (nesse caso o complemento é ONDE)
% Nesses casos, o tema do sintagma verbal será o AGENTE  
sv(tema_eh_agente_ou_complemento:agente ..acao:A .. tema:Agente ..desconhecido:IsDesconhecido) -->
	sn(id:Agente ..pessoa:P ..num:N ..desconhecido:IsDesconhecido),
	v(acao:A ..subcat:[sn] ..num:N ..pessoa:P).

% igual ao caso anterior, apenas invertendo verbo com agente
sv(tema_eh_agente_ou_complemento:agente ..acao:A .. tema:Agente ..desconhecido:IsDesconhecido) -->
	v(acao:A ..subcat:[sn] ..num:N ..pessoa:P),
	sn(id:Agente ..pessoa:P ..num:N ..desconhecido:IsDesconhecido).


% VERBO TRANSITIVO DIRETO
% verbo que exige substantivo depois (ex.: pegar, "pegar o ...")
% AGENTE: externo (num:N ..pessoa:Pess)
sv(tema_eh_agente_ou_complemento:complemento ..acao:A .. tema:Paciente ..num:N ..pessoa:P ..positivo:IsPositivo ..desconhecido:IsDesconhecido) -->
	{ ignore((var(IsPositivo), is_positivo(Paciente, IsPositivo))) },
	adv_afirmacao(positivo:IsPositivo),
	v(acao:A ..subcat:[sn] ..num:N ..pessoa:P),
	sn(id:Paciente ..desconhecido:IsDesconhecido ..prefere_det:nc).
	% nao forca o substantivo que tem depois a concordar com o anterior, pois o anterior eh o verbo do agente
	% e o sn representata o complemento 

sv(tema_eh_agente_ou_complemento:complemento ..acao:A ..tema:Paciente .. num:N ..pessoa:Pess ..positivo:IsPositivo) -->
	{ ignore((var(IsPositivo), is_positivo(Paciente, IsPositivo))) },
	adv_afirmacao(positivo:IsPositivo),
	v(acao:A ..num:N ..pessoa:Pess ..subcat:[advb]),
	sadvb(id:Paciente).

% VERBO TRANSITIVO INDIRETO
% verbo que exige preposicao e substantivo - tb chamdo de objeto indireto (ex.: estar em, "o barco esta _no_ ...")
% AGENTE: externo (num:N ..pessoa:Pess)
sv(tema_eh_agente_ou_complemento:complemento ..positivo:IsPositivo ..acao:Acao ..tema:Paciente .. num:N ..pessoa:Pess ..desconhecido:IsDesconhecido) -->
	{ ignore((var(IsPositivo), is_positivo(Paciente, IsPositivo))), preposicao_exigida(Acao,P), id_para_acao(Acao,A) },
	adv_afirmacao(positivo:IsPositivo),
	v(acao:A ..num:N ..pessoa:Pess ..subcat:[sp(prep:P)]),
	sp(id:Paciente ..prep:P ..desconhecido:IsDesconhecido).

sv(tema_eh_agente_ou_complemento:complemento ..positivo:IsPositivo ..acao:locucao(A,LocP) ..tema:Paciente .. num:N ..pessoa:Pess ..desconhecido:IsDesconhecido) -->
	{ ignore((var(IsPositivo), is_positivo(Paciente, IsPositivo))) },
	adv_afirmacao(positivo:IsPositivo),
	v(acao:A ..num:N ..pessoa:Pess ..subcat:[loc(tipo:prep..verbo:A)]),
	loc(tipo:prep.. id:LocP ..prep:P),
	sp(id:Paciente ..prep:P ..desconhecido:IsDesconhecido).

% VERBO TRANSITIVO INDIRETO onde o OBJETO foi determinado antes 
% nesse caso, o substantivo determina o AGENTE
% ex: *onde* estah a identidade? (*onde* eh o complemento, *a identidade* é o agente)
sv(tema_eh_agente_ou_complemento:agente ..acao:A .. tema:Agente ..desconhecido:IsDesconhecido) -->
	v(acao:A ..num:N ..pessoa:Pess ..subcat:[sp(prep:_)]),
	sn(id:Agente ..num:N ..pessoa:Pess ..desconhecido:IsDesconhecido).
	
% igual ao caso acima, mas o verbo fica no final.
sv(tema_eh_agente_ou_complemento:agente ..acao:A .. tema:Agente ..desconhecido:IsDesconhecido) -->
%	{ \+ compound(T); is_list(T) },
	sn(id:Agente ..num:N ..pessoa:Pess ..desconhecido:IsDesconhecido),
	v(acao:A ..num:N ..pessoa:Pess ..subcat:[sp(prep:_)]).
	

% VERBO BITRANSITIVO 
% seria o caso bitransitivo, exigindo um objeto direto e um indireto
sv( acao:Acao .. tema:Paciente ..num:N ..pessoa:P ..positivo:IsPositivo ..desconhecido:IsDesconhecido) -->
	{ Paciente=(tema1:T1 ..prep:Prep ..tema2:T2) },
	{ ignore((var(IsPositivo), is_positivo(T1, IsPositivo))), preposicao_exigida(Acao,Prep), id_para_acao(Acao,A) },
	adv_afirmacao(positivo:IsPositivo),
	v(acao:A ..subcat:[sn, sp(prep:Prep)] ..num:N ..pessoa:P),
	sn(id:T1 ..desconhecido:IsDesconhecido),
   	sp(id:T2 ..prep:Prep ..desconhecido:IsDesconhecido).

% ex.: sv onde o tema eh uma acao .. nesse caso, vai ser usado para "eu NAO SEI O QUE <verbo>"
sv(tema_eh_agente_ou_complemento:complemento ..positivo:IsPositivo ..acao:A ..num:N ..pessoa:P ..desconhecido:IsDesconhecido
		..tema:(acao:AX ..pessoa:PX ..num:NX ..tema:T)) -->
	adv_afirmacao(positivo:IsPositivo),
	v(acao:A ..subcat:[pro(pron:Pronome),sn] ..num:N ..pessoa:P),
	pro(tipo_pro:relativo ..pron:Pronome),
	sv(tema_eh_agente_ou_complemento:complemento ..acao:AX ..pessoa:PX ..num:NX ..tema:T ..desconhecido:IsDesconhecido).


sv(tema_eh_agente_ou_complemento:a_definir ..acao:A ..num:N ..pessoa:Pess ..subcat:SUBCAT) -->
	v(acao:A ..num:N ..pessoa:Pess ..subcat:[SUBCAT]).

sv(tema_eh_agente_ou_complemento:complemento ..gen:G ..num:N ..pessoa:P ..acao:A .. tema:Adjetivo ..positivo:IsPositivo ..desconhecido:_) -->
	{ ignore((var(IsPositivo), is_positivo(Adjetivo, IsPositivo))) },
	adv_afirmacao(positivo:IsPositivo),
	v(acao:A ..subcat:[sa] ..num:N ..pessoa:P),
	sa(adj:Adjetivo ..tipo:A ..num:N ..gen:G).


% cobre o caso em que o objeto indireto eh substituido por um adverbio
sp(id:I .. prep:P ..desconhecido:_)-->
    prep(prep:P),
	sadvb(id:I ..aceita_prep:P).

sp(id:I .. prep:_ ..desconhecido:_)-->
	sadvb(id:I).
	
sp(id:I .. prep:P ..desconhecido:IsDesconhecido ..prefere_det:PrefDet) -->
    prep(prep:P),
    sn(id:I ..desconhecido:IsDesconhecido ..prep:P ..prefere_det:PrefDet).

sadvb(id:I) -->
    advb(tipo_adv:lugar ..adv:I).

adv_afirmacao(positivo: IsPositivo) -->
	{ nonvar(IsPositivo) },
    advb(tipo_adv:afirmacao ..adv:IsPositivo).

adv_afirmacao(positivo: IsPositivo) -->
	{ var(IsPositivo), IsPositivo=sim },
    advb(tipo_adv:afirmacao ..adv:IsPositivo).

det(gen:G .. num:N ..tipo:T ..det:det(numero:Numero.. quant:Quant)) --> 
       quant(id:Quant.. gen:G .. num:N),
       ident(gen:G .. num:N ..tipo:T),
       num(id:Numero ..gen:G .. num:N).

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

pontuacao_opcional(_) --> 
	{ forca_pontuacao(P) },
	[P].

pontuacao_opcional(P) --> 
	[P];
	[].

marcar_porque_processado(porque_processado:sim).

