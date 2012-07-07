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
   readWord(Char,Chars,State),
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
   readWord(Char,Rest,State).

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

writeLine([]).
writeLine([First|Rest]):-
        (falando_com(voce, Nome); Nome = narrador),            
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


capitalize(W,W2):-
	atom_chars(W,W1),
	cap(W1,W1cap),
	atom_chars(W2,W1cap).

cap([],[]).
cap([F|Rest],[F2|Rest]):-
	char_code(F,C),
	C2 is C -32,
	char_code(F2,C2).

%%%%%%%% Utilizado para contracoes/quebra

equivale(na, [em, a]).
equivale(no, [em, o]).
equivale(da, [de, a]).
equivale(das, [de, as]).
equivale(do, [de, o]).
equivale(dos, [de, os]).
equivale(comigo, [em, eu]).
equivale(contigo, [em, voce]).
equivale(nele, [em, ele]).

char_code(X,X).