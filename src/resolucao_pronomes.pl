%:-[gulp].
:-dynamic estah_na_mesma_sentenca/0.
substitui_pronomes_na_sentenca_start(Pergunta):-
    seta_contexto(jogador),
	substitui_pronomes_na_sentenca(Pergunta),
	once(atualiza_contexto(Pergunta)),

    seta_contexto(computador),
    once(atualiza_contexto(Pergunta)).

substitui_pronomes_na_sentenca(tema:TemaTalvezPronome ..tema_real:TemaTraduzido ..agente:AgenteTalvezPronome ..agente_real:AgenteTraduzido):-
%    seta_contexto(jogador),
	substitui_pronome(AgenteTalvezPronome,AgenteTraduzido),
	substitui_pronome(TemaTalvezPronome,TemaTraduzido).
	
%	ignore((TemaTraduzido=corda,gspy(atualiza_contexto))),
%	once(atualiza_contexto(agente_real:AgenteTraduzido..tema_real:TemaTraduzido)),
 %   seta_contexto(computador),
%	once(atualiza_contexto(agente_real:AgenteTraduzido..tema_real:TemaTraduzido)).

substitui_pronome(TalvezPronome, Traduzido):-
	nonvar(TalvezPronome),
	TalvezPronome=aqui,
	estar(player, Traduzido).

substitui_pronome(TalvezPronome, Traduzido):-
	nonvar(TalvezPronome),
	\+ has_features(TalvezPronome),
	pro((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TalvezPronome),_,[]),
	denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TalvezPronome), Traduzido).

substitui_pronome(TalvezPronome, TalvezPronome):-
	has_features(TalvezPronome),
	substitui_pronomes_na_sentenca(TalvezPronome).

substitui_pronome(NaoPronome, NaoPronome).

institui_pronomes_na_sentenca_start(Resposta):-
	institui_pronomes_na_sentenca(Resposta),
	seta_contexto(jogador), 
	once(atualiza_contexto(Resposta)).

%%
institui_pronomes_na_sentenca(tema_real:TemaReal ..tema:TemaReferenciado ..agente_real:AgenteReal ..agente:AgenteReferenciado ..porque:Porque):-
	institui_pronome(AgenteReal, AgenteReferenciado),
	institui_pronomes_no_complemento_somente_se_nao_usou_pronome_no_agente(TemaReal,TemaReferenciado,AgenteReferenciado),
	ignore((nonvar(Porque),institui_pronomes_na_sentenca(Porque))).

institui_pronomes_na_sentenca(tema_real:TemaReal ..tema:TemaReal ..agente_real:AgenteReal ..agente:AgenteReal).

institui_pronomes_no_complemento_somente_se_nao_usou_pronome_no_agente(TemaReal,TemaReferenciado,AgenteReferenciado):-
	( 	once(institui_pronome(TemaReal, TemaReferenciado)),
		\+ AgenteReferenciado = TemaReferenciado 
	)
	; TemaReal = TemaReferenciado.

institui_pronome_agente(Agente,_,AgenteReferenciado):-
	institui_pronome(Agente,AgenteReferenciado).


institui_pronome(comp_nominal(seu,ComplementoNom), comp_nominal(meu,ComplementoNom)):-
	nonvar(ComplementoNom).

institui_pronome(comp_nominal(Tema,ComplementoNom), comp_nominal(TemaReferenciado,ComplReferenciado)):-
	nonvar(Tema),nonvar(ComplementoNom),
	institui_pronome(Tema,TemaReferenciado),
	(	
		local(ComplementoNom),ComplReferenciado=ComplementoNom;
		institui_pronome(ComplementoNom,ComplReferenciado)
	).


institui_pronome(TemaBiTransitivo, (tema1:Tema1Referenciado ..tema2:Tema2Referenciado)):-
	nonvar(TemaBiTransitivo),
	has_features(TemaBiTransitivo),
	TemaBiTransitivo=(tema1:Tema1 ..tema2:Tema2),
	nonvar(Tema1),nonvar(Tema2),
	institui_pronome(Tema1,Tema1Referenciado),
	institui_pronome(Tema2,Tema2Referenciado).

institui_pronome(TemaReal, TemaReferenciado):-
	denota_lugar(TemaReferenciado, TemaReal).

institui_pronome(TemaReal, TemaReferenciado):-
	\+ has_features(TemaReal),
	denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P), TemaReal),
	pro((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TemaReferenciado),_,[]).

institui_pronome(TemaComposto, TemaComposto):-
	has_features(TemaComposto),
	institui_pronomes_na_sentenca(TemaComposto).

institui_pronome(TemaReal, TemaReal).

has_features(G):-
	nonvar(G),
	(G=tema:_;G=agente:_;G=tema1:_).

suprime_se_era_incog(Original):-
	nonvar(Original),
	Original=incog(_).

seta_contexto(Ctx):-
    retractall(contexto_atual(_)),
    assertz(contexto_atual(Ctx)).


