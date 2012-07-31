%:-[gulp].
:-dynamic contexto/3, contexto_atual/1.

/* Resolucao e manutencao de contexto */
contexto_atual(jogador).

contexto(_, (tipo_pro:advb ..tipo_adv:lugar ..adv:aqui), Lugar):-
    estar(player, Lugar).

% manutencao de contexto
%% atualiza o contexto de acordo com a pergunta e com a resposta
   
atualiza_contexto((agente_real:AgResp ..tema_real:TemaResp)):-
    atualiza_advb_aqui,
    atualiza_contexto_dado_np_real(TemaResp),
    atualiza_contexto_dado_np_real(AgResp).
    % o agente eh usado por segundo para preferir usar o pronome para designar o agente

atualiza_contexto_dado_np_real([]).

% se o jogador perguntou onde estah,remove _aqui_ do contexto
atualiza_contexto_dado_np_real(incog(onde)):-
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:advb ..tipo_adv:lugar ..adv:aqui),Local),
    retractall(contexto(Ctx,_,Local)).

atualiza_contexto_dado_np_real(TemaOuAgente):-
    \+ is_list(TemaOuAgente),
    quem_denota(Tracos , TemaOuAgente),  
    atualiza_pessoa(Tracos , TemaOuAgente).

atualiza_contexto_dado_np_real(_).

atualiza_pessoa(Pessoa, NovoValor):-
    nonvar(NovoValor),
    nonvar(Pessoa),
	NovoValor\=player,
    \+ estar(player, NovoValor),
    contexto_atual(Ctx),
	Pessoa=(tipa_pro:reto ..pessoa:terc ..gen:G),
    retractall(contexto(Ctx, (tipo_pro:reto ..pessoa:terc ..gen:G), _)),
    asserta(contexto(Ctx, Pessoa, NovoValor)).

%evita que o atualiza_pessoa falhe
atualiza_pessoa(_ , _).

atualiza_advb_aqui:-
	contexto_atual(Ctx),
	estar(player, Aqui),
	\+contexto(Ctx, (tipo_adv:lugar ..adv:aqui), Aqui),
	asserta(contexto(Ctx, (tipo_pro:advb ..tipo_adv:lugar ..adv:aqui), Aqui)).

%evita que o atualiza_advb_aqui falhe
atualiza_advb_aqui:-
    true.

% auxiliar para encontrar os tracos de um substantivo de terc pessoa para colocar no contexto
quem_denota((tipo_pro:reto ..num:N ..gen:G ..pessoa:terc), X):-
    \+ compound(X), 
    nonvar(X),
    np((id:X ..num:N ..gen:G ..desconhecido:nao), Texto, []),
    nonvar(Texto).

quem_denota((tipo_pro:reto ..num:N ..gen:G ..pessoa:terc ..desconhecido:sim), X):-
    \+ compound(X), 
    nonvar(X),
    np((num:N ..gen:G ..desconhecido:sim), [X], []).

% no caso de pronomes eu/voce, a resolucao nao depende do contexto dinamico
% a resolucao de primeira pessoa tem que ficar antes!
denota((tipo_pro:voce ..num:sing ..pessoa:terc ..pron:voce), Quem):-
	contexto_atual(jogador),
	falando_com(player,Quem).

denota((tipo_pro:reto ..num:sing ..pessoa:prim ..pron:eu), player):-
	contexto_atual(jogador).

denota((tipo_pro:reto .. num:sing .. pessoa:prim ..pron:eu), Quem):-
	contexto_atual(computador),
	falando_com(player,Quem).

denota((tipo_pro:voce ..num:sing ..pessoa:terc ..pron:voce), player):-
	contexto_atual(computador).
    
% a resolucao para terc pessoa ele/ela/eles/elas depende do contexto dinamico
denota((tipo_pro:reto ..gen:G .. num:N .. pessoa:terc ..pron:Pron), Quem):-
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:reto ..gen:G .. num:N .. pessoa:terc ..pron:Pron), Quem),
	\+estar(player,Quem).
   
%% determinacao do lugar baseado no contexto
denota_lugar(aqui, L):-
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:advb ..tipo_adv:lugar ..adv:aqui), _),
	estar(player,L).

%%TODO: serah usado no futuro como contexto para o usuario ensinar palavras novas
%adiciona_termo_a_definir(Termo, Definicao).
adiciona_termo_a_definir(_, _).
