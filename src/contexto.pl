%:-[gulp].
:-dynamic contexto/3, contexto_atual/1.

/* Resolucao e manutencao de contexto */
contexto_atual(jogador).

%% mantem mapeamento para ultimas referencias por genero
% aqui eh igual para o computador e para o jogador
    
% qdo o jogador usa pronome "eu"
contexto(jogador, (tipo_pro:reto ..pessoa:prim ..num:sing), player).% 

contexto(jogador, (tipo_pro:advb ..tipo_adv:lugar ..adv:aqui), Lugar):-
    estar(player, Lugar).

% contexto do computador
contexto(computador,(tipo_pro:voce ..num:sing ..pessoa:terc ..pron:voce),player).

contexto(computador, (tipo_pro:advb ..tipo_adv:lugar ..adv:aqui), Lugar):-
    estar(player, Lugar).

%% atualiza o contexto de acordo com a pergunta e com a resposta
atualiza_advb_aqui:-
    (
        contexto_atual(Ctx),
        estar(player, Lugar),
        \+contexto(Ctx, (tipo_adv:lugar ..adv:aqui), Lugar),
        asserta(contexto(Ctx, (tipo_pro:advb ..tipo_adv:lugar ..adv:aqui), Lugar))
    ).
atualiza_advb_aqui:-
    true.
    
atualiza_contexto((agente_real:AgResp ..tema_real:TemaResp)):-
    atualiza_advb_aqui,
    atualiza_contexto_denotado_por(TemaResp),
    atualiza_contexto_denotado_por(AgResp).
    % o agente eh usado por segundo para preferir usar o pronome para designar o agente

atualiza_contexto_denotado_por([]).

% se o jogador perguntou onde estah,remove _aqui_ do contexto
atualiza_contexto_denotado_por(incog(onde)):-
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:advb ..tipo_adv:lugar ..adv:aqui),Local),
    retractall(contexto(Ctx,_,Local)).

atualiza_contexto_denotado_por(TemaOuAgente):-
    \+ is_list(TemaOuAgente),
    quem_denota(Tracos , TemaOuAgente),  
    atualiza_pessoa(Tracos , TemaOuAgente).

atualiza_contexto_denotado_por([jogador|Resto]):-
    atualiza_contexto_denotado_por(Resto).

atualiza_contexto_denotado_por([TemaOuAgente|Resto]):-
    atualiza_contexto_denotado_por(TemaOuAgente),
    atualiza_contexto_denotado_por(Resto).

atualiza_contexto_denotado_por(_).

atualiza_pessoa((tipo_pro:voce),_).
atualiza_pessoa(_,player).

atualiza_pessoa(Pessoa, NovoValor):-
    nonvar(NovoValor),
    nonvar(Pessoa),
    \+ estar(player, NovoValor),
    contexto_atual(Ctx),
    retractall(contexto(Ctx, Pessoa, _)),
    asserta(contexto(Ctx, Pessoa, NovoValor)).

atualiza_pessoa(_ , _).


% DENOTA EH SEMPRE USADO PARA DETERMINAR O USO DE PRONOME
%% determinacao do agente baseado no contexto
valida_locutor(Ag):-
    falando_com(player, Interlocutor),
    member(Ag, [player,Interlocutor]).

denota((tipo_pro:pron_ninguem(quem)), ninguem).
denota((tipo_pro:pron_ninguem(oque)), nada).
denota((tipo_pro:relativo ..pron:onde), onde).

denota((tipo_pro:voce ..num:sing ..pessoa:terc ..pron:voce), Quem):-
	contexto_atual(jogador),
	falando_com(player,Quem).

denota((tipo_pro:reto .. num:sing .. pessoa:prim ..pron:eu), Quem):-
	contexto_atual(computador),
	falando_com(player,Quem).
    
% vai determinar se o Ag vai usar o pronome "eu" para se designar.
denota((tipo_pro:reto ..num:sing ..pessoa:prim ..gen:G), Ag):-
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:reto.. num:sing ..pessoa:prim ..gen:G), Ag),
    valida_locutor(Ag).
        
% vai determinar quem o pronome designa OU qual pronome designa Quem
denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem):-
    nonvar(Quem),
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem),
    % se acabou de determinar o pronome para Quem, evita que seja usado de novo
    % consecutivamente na mesma sentenca, solucionado o problema de responder "o que ela eh?"
    retract(contexto(Ctx,(tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem)).

denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem):-
    var(Quem),
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem).

   
denota((tipo_pro:relativo ..pron:Pron), P):-
    nonvar(Pron),
    P=Pron.

% para aceitar o pronome prp.dito
denota((tipo_pro:T ..gen:G .. num:N .. pessoa:P ..pron:Pron), Quem):-
    pro((tipo_pro:T ..gen:G ..num:N ..pessoa:P ..pron:Pron),[Quem],[]).

quem_denota((tipo_pro:reto ..num:N ..gen:G ..pessoa:terc), X):-
    \+ compound(X), 
    nonvar(X),
    np((id:X ..num:N ..gen:G ..desconhecido:nao), Texto, []),
    nonvar(Texto).

quem_denota((tipo_pro:reto ..num:N ..gen:G ..pessoa:terc ..desconhecido:sim), X):-
    \+ compound(X), 
    nonvar(X),
    np((num:N ..gen:G ..desconhecido:sim), [X], []).

%% determinacao do lugar baseado no contexto
denota_lugar(aqui, L):-
    contexto_atual(Ctx),
    contexto(Ctx,(tipo_pro:advb ..tipo_adv:lugar ..adv:aqui), L).

denota_lugar(nenhum, []).

%adiciona_termo_a_definir(Termo, Definicao).
adiciona_termo_a_definir(_, _).

determina_agente((pessoa:indic ..num:sing), player).
determina_agente(A,A).

