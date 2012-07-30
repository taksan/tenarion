%:-[gulp].

substitui_pronomes_na_sentenca(tema:TemaComposto ..tema_real:TemaComposto ..agente:AgenteComposto ..agente_real:AgenteComposto):-
	has_features(TemaComposto), has_features(AgenteComposto),
	substitui_pronomes_na_sentenca(AgenteComposto),
	substitui_pronomes_na_sentenca(TemaComposto).

substitui_pronomes_na_sentenca(tema:TemaComposto ..tema_real:TemaComposto ..agente:AgenteTalvezPronome ..agente_real:AgenteTraduzido):-
	has_features(TemaComposto), \+has_features(AgenteTalvezPronome),
	substitui_pronome(AgenteTalvezPronome,AgenteTraduzido),
	substitui_pronomes_na_sentenca(TemaComposto).

substitui_pronomes_na_sentenca(tema:TemaTalvezPronome ..tema_real:TemaTraduzido ..agente:AgenteComposto ..agente_real:AgenteComposto):-
	\+ has_features(TemaTalvezPronome), has_features(AgenteComposto),
	substitui_pronomes_na_sentenca(AgenteComposto),
	substitui_pronome(TemaTalvezPronome,TemaTraduzido).

substitui_pronomes_na_sentenca(tema:TemaTalvezPronome ..tema_real:TemaTraduzido ..agente:AgenteTalvezPronome ..agente_real:AgenteTraduzido):-
	\+ has_features(TemaTalvezPronome), \+ has_features(AgenteTalvezPronome),
	substitui_pronome(AgenteTalvezPronome,AgenteTraduzido),
	substitui_pronome(TemaTalvezPronome,TemaTraduzido).

substitui_pronome(TalvezPronome, Traduzido):-
	nonvar(TalvezPronome),
	denota_lugar(TalvezPronome, Traduzido).

substitui_pronome(TalvezPronome, Traduzido):-
	\+ has_features(TalvezPronome),
	nonvar(TalvezPronome),
	pro((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TalvezPronome),_,[]),
	denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TalvezPronome), Traduzido).

substitui_pronome(NaoPronome, NaoPronome).

institui_pronomes_na_sentenca(tema_real:TemaReal ..tema:TemaReferenciado ..agente_real:AgenteReal ..agente:AgenteReferenciado ..porque:Porque):-
	institui_pronome(AgenteReal, AgenteReferenciado),
	(
		( once(institui_pronome(TemaReal, TemaReferenciado)),\+ AgenteReferenciado = TemaReferenciado )
		; TemaReal = TemaReferenciado
	),
	ignore((nonvar(Porque),institui_pronomes_na_sentenca(Porque))).

institui_pronomes_na_sentenca(tema_real:TemaReal ..tema:TemaReal ..agente_real:AgenteReal ..agente:AgenteReal).

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
	G=tema:_.
