:-[gulp].

substitui_pronomes_na_sentenca(tema:TemaComposto ..tema_real:TemaComposto ..agente:AgenteComposto ..agente_real:AgenteComposto):-
	is_composto(TemaComposto), is_composto(AgenteComposto),
	substitui_pronomes_na_sentenca(TemaComposto),
	substitui_pronomes_na_sentenca(AgenteComposto).

substitui_pronomes_na_sentenca(tema:TemaComposto ..tema_real:TemaComposto ..agente:AgenteTalvezPronome ..agente_real:AgenteTraduzido):-
	is_composto(TemaComposto), \+is_composto(AgenteTalvezPronome),
	substitui_pronomes_na_sentenca(TemaComposto),
	substitui_pronome(AgenteTalvezPronome,AgenteTraduzido).

substitui_pronomes_na_sentenca(tema:TemaTalvezPronome ..tema_real:TemaTraduzido ..agente:AgenteComposto ..agente_real:AgenteComposto):-
	\+ is_composto(TemaTalvezPronome), is_composto(AgenteComposto),
	substitui_pronome(TemaTalvezPronome,TemaTraduzido),
	substitui_pronomes_na_sentenca(AgenteComposto).

substitui_pronomes_na_sentenca(tema:TemaTalvezPronome ..tema_real:TemaTraduzido ..agente:AgenteTalvezPronome ..agente_real:AgenteTraduzido):-
	\+ is_composto(TemaTalvezPronome), \+ is_composto(AgenteTalvezPronome),
	substitui_pronome(TemaTalvezPronome,TemaTraduzido),
	substitui_pronome(AgenteTalvezPronome,AgenteTraduzido).

substitui_pronome(TalvezPronome, Traduzido):-
	\+ is_composto(TalvezPronome),
	nonvar(TalvezPronome),
	pro((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TalvezPronome),_,[]),
	denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TalvezPronome), Traduzido).

substitui_pronome(NaoPronome, NaoPronome).

institui_pronomes_na_sentenca(tema_real:TemaReal ..tema:TemaReferenciado ..agente_real:AgenteReal ..agente:AgenteReferenciado):-
	institui_pronome(TemaReal, TemaReferenciado),
	institui_pronome(AgenteReal, AgenteReferenciado).

institui_pronome(TemaReal, TemaReferenciado):-
	\+ compound(TemaReal),
	quem_denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P),TemaReal),
	denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P), TemaReal),
	pro((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:TemaReferenciado),_,[]).

institui_pronome(TemaReal, TemaReal).

institui_pronomes_na_sentenca(tema_real:TemaReal ..tema:TemaReal ..agente_real:AgenteReal ..agente:AgenteReal).

is_composto(G):-
	nonvar(G),
	G=tema:_.
