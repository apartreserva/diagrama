-- Consulta de todos os registros.
SELECT      id_equipe, id_setor, id_responsavel, descricao, nome, exclusao, inclusao
FROM        u863995488_producao.equipe
ORDER BY    nome;

-- Consulta dos registros de equipes com exclusão nula.
SELECT      id_equipe, id_setor, id_responsavel, descricao, nome, exclusao, inclusao
FROM        u863995488_producao.equipe
WHERE       exclusao IS NULL
ORDER BY    nome;

-- Consulta dos registros de equipes excluídos.
SELECT      id_equipe, id_setor, id_responsavel, descricao, nome, exclusao, inclusao
FROM        u863995488_producao.equipe
WHERE       exclusao IS NOT NULL
ORDER BY    nome;

-- Consulta de uma equipe passando o id como parâmetro.
SELECT  id_equipe, id_setor, id_responsavel, descricao, nome, exclusao, inclusao
FROM    u863995488_producao.equipe
WHERE   id_equipe = {idEquipe}
ORDER BY nome;

-- Consulta de uma equipe passando o setor como parâmetro.
SELECT  id_equipe, id_setor, id_responsavel, descricao, nome, exclusao, inclusao
FROM    u863995488_producao.equipe
WHERE   id_setor = {idSetor}
ORDER BY nome;

-- Consulta as equipes associadas à um responsável.
SELECT  id_equipe, id_setor, id_responsavel, descricao, nome, exclusao, inclusao
FROM    u863995488_producao.equipe
WHERE   id_responsavel = {idResponsavel}
ORDER BY nome;

-- Carregar membros da equipe.
SELECT  u.nome, u.exclusao,
		(CASE
			WHEN	eu.exclusao IS NOT NULL THEN 'false'
            ELSE	'true'
        END) AS 	membro_ativo,
        (CASE
			WHEN	eq.id_responsavel = u.id_usuario THEN 'true'
            ELSE	'false'
        END) AS responsavel
FROM    u863995488_producao.equipe eq
JOIN    u863995488_producao.equipe_usuario eu ON eu.id_equipe = eq.id_equipe
JOIN    u863995488_producao.usuario u ON u.id_usuario = eu.id_usuario
WHERE   eq.id_equipe = {idEquipe};

-- Editar os dados de uma equipe
UPDATE  u863995488_producao.equipe SET id_setor = {idSetor}, id_responsavel = {idResponsavel}, descricao = {descricao}, nome = {nome}
WHERE   id_equipe = {idEquipe};

-- Exclusão lógica do registro.
UPDATE  u863995488_producao.equipe SET exclusao = current_time() WHERE id_equipe = {id_equipe};

-- Recuperação do registro
UPDATE  u863995488_producao.equipe SET exclusao = null WHERE id_equipe = {id_equipe};

-- Incluir uma nova equipe.
INSERT INTO u863995488_producao.equipe (id_setor, id_responsavel, descricao, nome) VALUES (
    {idSetor}, -- integer
    {idResponsavel}, -- integer
    {descricao}, -- varchar
    {nome} -- varchar
);

-- Inserir membro na equipe.
INSERT INTO u863995488_producao.equipe_usuario (id_equipe, id_usuario)
VALUES      ({idEquipe}, {id_usuario});

-- Remover membro da equipe
UPDATE  u863995488_producao.equipe_usuario SET exclusao = CURRENT_TIMESTAMP() WHERE id_equipe = {idEquipe} AND id_usuario = {idUsuario};