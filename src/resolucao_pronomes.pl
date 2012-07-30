%:-[gulp].

substitui_pronomes_na_sentenca(tema:TemaTalvezPronome ..tema_real:TemaTraduzido ..agente:AgenteTalvezPronome ..agente_real:AgenteTraduzido):-
	substitui_pronome(AgenteTalvezPronome,AgenteTraduzido),
	substitui_pronome(TemaTalvezPronome,TemaTraduzido).

substitui_pronome(TalvezPronome, Traduzido):-
	nonvar(TalvezPronome),
	\+ has_features(TalvezPronome),
	denota_lugar(TalvezPronome, Traduzido).

substitui_pronome(TalvezPronome, Traduzido):-
	nonvar(TalvezPronome),
	\+ has_features(TalvezPronome),
	pro((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TalvezPronome),_,[]),
	denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TalvezPronome), Traduzido).

substitui_pronome(TalvezPronome, TalvezPronome):-
	has_features(TalvezPronome),
	substitui_pronomes_na_sentenca(TalvezPronome).

substitui_pronome(NaoPronome, NaoPronome).

%%
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
	(G=tema:_;G=agente:_;G=tema1:_).
