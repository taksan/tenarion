:-[gulp].
:-[io].
:-[resolucao_pronomes].
:-[interpretador].
/*
 Programa principal que controla o jogo
 Para executar, é só escrever a consulta "jogar".
*/

cleanup_player:-
        jogador(_),
        retract(jogador(_)).

cleanup_player.

jogar:-
        once(cleanup_player),
        write('Bem Vindo ao mundo de Tenarion!'),
        nl,
        write('Qual o seu sexo (F/M/I)? '),
        readText([Sex|_]),
		(
	        (Sex = 'm', 
				T='aventureiro', assert(sexo_jogador(masc)))
			;
				(T='aventureira', assert(sexo_jogador(fem)))
		),
        write('Digite seu nome, nobre '),
        write(T), write(': '),
        readText([Nome|_]),
        assert(jogador(Nome)),!,
        dialogo.

dialogo:-
    once(readLine(P)),
	processar_pergunta(P,R,Sem),!,
    writeLine(R),
    continuar(Sem).

processar_pergunta(P,R,Sem):-
	(s(Sem,P,[]), processa_sentenca(Sem,R));
	(R=['desculpe, mas nao entendi.']).


processa_sentenca(Sem,R):-
    substitui_pronomes_na_sentenca_start(Sem),!,
    ((processar(Sem,Resposta),
		(
			gera_resposta(Resposta,R);
			R=['nao sei te responder.']
		)
	);R=['eu nao entendo essa logica']).

gera_resposta(Resposta,R):-
	institui_pronomes_na_sentenca_start(Resposta),!,
    s(Resposta,R,[]).

continuar(Sem):-
	nonvar(Sem),
	Sem=ato_fala:terminar,
    \+ falando_com(player, _),
	nl.

continuar(_):-
    dialogo.

nadadica:-
	1=1.
