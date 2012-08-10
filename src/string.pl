converte_pergunta_para_lista(PerguntaString,PerguntaArray):-
	adapt_punctuation(PerguntaString,PerguntaString1),
	atomic_list_concat(PerguntaC,' ',PerguntaString1),!,
	contraido(PerguntaC,PerguntaArray).

converte_resposta_para_string(RespostaLista,RespostaString):-
	contraido(RespostaC, RespostaLista),
	toString(RespostaC,RespostaString).

adapt_punctuation(SIn,SOut):-
	string_length(SIn,Len), 
	Len1 is Len-1, 
	sub_string(SIn, 0, Len1, _, Sub),
	sub_string(SIn, Len1, 1,_,Punct),
	concat_atom([Sub,' ',Punct], SOut).

contraido([],[]).

contraido([Contraido|Resto],[A,B|Restocontraidodo]):-
	equivale(Contraido,[A,B]),
	contraido(Resto,Restocontraidodo).

contraido([A|Resto],[A|Restocontraidodo]):-
	contraido(Resto,Restocontraidodo).

contraido([A,B],[A,B]).

toString([],'').

toString([H],H).

toString([H,,|Tail],String):-
	toString(Tail,StringResto),
	concat_atom([H, ', ', StringResto],String).

toString([H,Q],String):-
	member(Q,[.,?]),
	concat_atom([H, Q],String).

toString([H,.|Tail],String):-
	toString(Tail,StringResto),
	concat_atom([H, '. ', StringResto],String).


toString([H|Tail],String):-
	toString(Tail,StringResto),
	concat_atom([H, ' ', StringResto],String).

capitalize(W,W2):-
	atom_chars(W,W1),
	cap(W1,W1cap),
	atom_chars(W2,W1cap).

cap([],[]).
cap([F|Rest],[F2|Rest]):-
	char_code(F,C),
	C2 is C -32,
	char_code(F2,C2).

