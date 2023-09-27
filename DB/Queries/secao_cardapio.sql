-- Carrega todas as seções passando o IdCardápio como parâmetro.
SELECT		id_secao_cardapio, id_cardapio, descricao, exclusao, inclusao, nome, ordem
FROM 		u863995488_producao.secao_cardapio
WHERE		id_cardapio = {idSecaoCardapio}
ORDER BY	ordem;

-- Busca uma seção pasando o id como parâmetro.
SELECT		id_secao_cardapio, id_cardapio, descricao, exclusao, inclusao, nome, ordem
FROM 		u863995488_producao.secao_cardapio
WHERE		id_secao_cardapio = {idSecaoCardapio}

-- Busca uma seção passando o idCardapio ou nome ou descrição.
SELECT		id_secao_cardapio, id_cardapio, descricao, exclusao, inclusao, nome, ordem
FROM 		u863995488_producao.secao_cardapio
WHERE		LOWER(nome) LIKE(LOWER('%%')) OR LOWER(descricao) LIKE(LOWER('%%'))
AND			id_cardapio = {idCardapio};

-- Atualização do registro.
UPDATE	u863995488_producao.secao_cardapio
SET		descricao = {descricao}, nome = {nome}, ordem = {ordem}
WHERE	id_secao_cardapio = {idSecaoCardapio} AND id_cardapio = {idCardapio};

-- Exclusão lógica do registro.
UPDATE	u863995488_producao.secao_cardapio
SET		exclusao = CURRENT_TIMESTAMP()
WHERE	id_secao_cardapio = {idSecaoCardapio} AND id_cardapio = {idCardapio};

-- Adiciona um novo registro.
INSERT INTO u863995488_producao.secao_cardapio(id_cardapio, descricao, nome, ordem)
VALUES      ({idCardapio}, {descricao}, {nome}, {ordem});