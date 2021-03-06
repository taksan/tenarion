% Utilitario para input/output

/*************************************************************************

         name: readLine.pl
      version: March 31, 1998
  description: Converting input line to list of atoms, suitable for
               DCG input.
      authors: Patrick Blackburn & Johan Bos

*************************************************************************/


/*========================================================================

   Read Predicates
   ---------------

readLine(-WordList)
   Outputs a prompt, reads a sequence of characters from the standard
   input and converts this to WordList, a list of strings. Punctuation 
   is stripped.

readWords(-WordList)
   Reads in a sequence of characters, until a return is registered, 
   and converts this to WordList a list of strings. 

readWord(+Char,-Chars,?State)
   Read a word coded as Chars (a list of ascii values), starting 
   with with ascii value Char, and determine the State of input
   (`ended' = end of line, `notended' = not end of line).
   Blanks and full stops split words, a return ends a line.

checkWords(+OldWordList,-NewWordList)
   Check if all words are unquoted atoms, if not convert them 
   into atoms.

convertWord(+OldWord,-NewWord)
   OldWord and NewWord are words represented as lists of ascii values.
   Converts upper into lower case characters, and eliminates
   non-alphabetic characters.

========================================================================*/

:-[string].

readText(WordList):-
   readWords(Words),
   checkWords(Words,WordList).

readLine(WordList):-
   jogador(Nome),
   nl, write(Nome), write(' > '),
   readWords(Words),
   checkWords(Words,WordList).

readWords([Word|Rest]):-
   get0(Char),
   decap(Char,DecapChar),
   readWord(DecapChar,Chars,State),
   atom_chars(Word,Chars),
   readRest(Rest,State).

readRest([],return).

readRest(['.'|Rest],dot):-
   readWords(Rest).

readRest([','|Rest],coma):-
   readWords(Rest).

readRest(['?'|Rest],interro):-
   readWords(Rest).

readRest(['!'|Rest],exclam):-
   readWords(Rest).

readRest(Rest,blank):-
   readWords(Rest).

readWord(32,[],blank):-!.
readWord(33,[],exclam):-!.
readWord(46,[],dot):-!.
readWord(44,[],coma):-!.
readWord(63,[],interro):-!.
readWord(10,[],return):-!.
readWord(Code,[Code|Rest],State):-
   get0(Char),
   decap(Char,DecapChar),
   readWord(DecapChar,Rest,State).

checkWords([],[]):- !.

checkWords([''|Rest1],Rest2):-
   checkWords(Rest1,Rest2).

checkWords([Atom|Rest1], R):-
   atom_chars(Atom,Word1),
   convertWord(Word1,Word2),
   atom_chars(Atom2,Word2),
   % se necessario, realiza descontracao
   equivale(Atom2, List),!,
   checkWords(Rest1, Rest2),!,
   append(List, Rest2, R).

checkWords([Atom|Rest1],[Atom2|Rest2]):-
   atom_chars(Atom,Word1),
   convertWord(Word1,Word2),
   atom_chars(Atom2,Word2),
   checkWords(Rest1,Rest2).

convertWord([],[]):- !.
convertWord([Capital|Rest1],[Small|Rest2]):-
   char_code(Capital, Code),                  
   Code > 64, Code < 91, !,
   Small is Code + 32,
   convertWord(Rest1,Rest2).
convertWord([Weird|Rest1],Rest2):-
   char_code(Weird, Code),              
   ((Code < 97, Code \== 33, Code \== 44, Code \== 46, Code \== 63); Code > 122), !,
   convertWord(Rest1,Rest2).
convertWord([Char|Rest1],[Char|Rest2]):-
   convertWord(Rest1,Rest2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% writeLine

% Escrito por Michel Gagnon

%%%%%%%%%%%%%%%%%%%%%%%%%%%5
texto_nome_quem_fala(Nome):-
	nome_de_quem_estah_falando(Desc),
	sn(id:Desc,NomeCalc,[]),
	converte_resposta_para_string(NomeCalc,NomeX),
	capitalize(NomeX,Nome).

writeLine([]).
writeLine([First|Rest]):-
    texto_nome_quem_fala(Nome),
    write(Nome),
    write(' > '),
	capitalize(First,FirstCap),
	write(FirstCap),
	writeWords(Rest).

writeWords([]).
writeWords(['.'|Rest]):-
	write('.'),
	writeWords(Rest).
writeWords([','|Rest]):-
	write(','),
	writeWords(Rest).
writeWords(['?'|Rest]):-
	write('?'),
	writeWords(Rest).
writeWords(['!'|Rest]):-
	write('!'),
	writeWords(Rest).
writeWords([U,W|Rest]):-
    equivale(Z, [U,W]),
    write(' '),
	write(Z),
	writeWords(Rest).
writeWords([W|Rest]):-
    write(' '),
	write(W),
	writeWords(Rest).

decap(Cap,Decap):-
	Cap>64, Cap<92,!,
	Decap is Cap+32.

decap(Decap,Decap).

%char_code(X,X).
