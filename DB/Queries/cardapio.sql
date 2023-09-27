/**
* @desc: Função de adição de um novo registro.
**/
CREATE DEFINER=`u863995488_producao`@`%` FUNCTION `fc_cardapio_adicionar`(estabelecimentoId INT, cardapioNome VARCHAR(30), cardapioDescricao VARCHAR(40), cardapioExibir BOOL) RETURNS int(11)
BEGIN
	
    -- Adiciona um novo registro.
    INSERT INTO	u863995488_producao.cardapio (nome, descricao) VALUES (cardapioNome, cardapioDescricao);
    
     -- Variável de armazenamento da próxima ID da tabela.
    SET @nextID = 0;
    
	-- Carrega a últma ID Válida.
    SELECT LAST_INSERT_ID() AS id_cardapio INTO @nextID FROM u863995488_producao.cardapio;
    
    -- Realiza a associação do cardápio ao estabelecimento.
    INSERT INTO u863995488_producao.estabelecimento_cardapio (id_estabelecimento, id_cardapio, exibir) VALUES (estabelecimentoId, @nextID, cardapioExibir);
    
    RETURN 201;
END

-- Chamada
SELECT  u863995488_producao.fc_cardapio_adicionar({idEstabelecimento}, {nome}, {descricao}, {exibir});

/*------------------*/

-- Consulta os registros passando os id's dos estabelecimentos.
SELECT 		c.id_cardapio, c.nome, c.descricao, (CASE WHEN c.exclusao IS NULL THEN 'true' ELSE 'false' END) AS ativo,
			ec.id_estabelecimento, ec.inclusao, ec.exclusao
FROM		u863995488_producao.cardapio c
JOIN		u863995488_producao.estabelecimento_cardapio ec ON ec.id_cardapio = c.id_cardapio AND ec.id_estabelecimento IN ({idEstabelecimento})
ORDER BY 	c.nome;

-- Pesquisa um registro pelo seu id e do estabelecimento.
SELECT      c.id_cardapio, c.nome, c.descricao, (CASE WHEN c.exclusao IS NULL THEN 'true' ELSE 'false' END) AS ativo,
		    ec.id_estabelecimento, ec.inclusao, ec.exclusao
FROM	    u863995488_producao.cardapio c
JOIN	    u863995488_producao.estabelecimento_cardapio ec ON ec.id_cardapio = c.id_cardapio
WHERE	    c.id_cardapio = {idCardapio}
AND 	    ec.id_estabelecimento = {idEstabelecimento}
ORDER BY    c.nome;

-- Pesquisa um registro por texto e id do estabelecimento.
SELECT 	c.id_cardapio, c.nome, c.descricao,
		(CASE WHEN c.exclusao IS NULL THEN 'true' ELSE 'false' END) AS ativo,
        ec.id_estabelecimento, ec.inclusao, ec.exclusao
FROM 	u863995488_producao.cardapio c
JOIN	u863995488_producao.estabelecimento_cardapio ec ON ec.id_cardapio = c.idCardapio AND ec.id_estabelecimento = {idEstabelecimento}
WHERE   LOWER(c.nome) LIKE(LOWER('%pro%'));

-- Seleciona os estabelecimentos associados ao cardápio
SELECT 		e.id_estabelecimento, e.nome_fantasia, e.nome, e.exclusao, e.inclusao,
			ec.exibir, (CASE WHEN ec.exclusao IS NULL THEN 'true' ELSE 'false' END) AS ativo
FROM 		u863995488_producao.estabelecimento e
JOIN		u863995488_producao.estabelecimento_cardapio ec ON ec.id_estabelecimento = e.id_estabelecimento
JOIN		u863995488_producao.cardapio c ON c.id_cardapio = ec.id_cardapio
WHERE		c.id_cardapio = {idCardapio}
ORDER BY 	e.nome_fantasia;

/**
* Edita as informações do cardápio
**/
CREATE DEFINER=`u863995488_producao`@`%` FUNCTION `fc_cardapio_editar`() RETURNS int(11)
BEGIN

	-- Armazenará a quantidade de registros encontrados.
	SET @qtd = 0;
    
     -- Consulta os registros.
    SELECT 		COUNT(*) AS qtd	INTO @qtd
	FROM		u863995488_producao.cardapio c
	JOIN		u863995488_producao.estabelecimento_cardapio ec ON ec.id_cardapio = cardapioId AND ec.id_estabelecimento = estabelecimentoId
	WHERE       c.exclusao IS NULL
	ORDER BY 	c.nome;
    
    -- Consulta os cardápios
    IF (@qtd > 0) THEN
		
        -- Atualiza o registro de cardápio.
		UPDATE	u863995488_producao.cardapio
		SET		nome = cardapioNome, descricao = cardapioDescricao
		WHERE	id_cardapio = cardapioId;
        
        -- Atualiza o vínculo com o cardápio.
        UPDATE	u863995488_producao.estabelecimento_cardapio
        SET		exibir = cardapioExibir
        WHERE 	id_cardapio = cardapioId AND id_estabelecimento = estabelecimentoId;        
        
        RETURN 200;
	ELSE
		RETURN 400;
    END IF;
END

-- Chamada
SELECT  u863995488_producao.fc_cardapio_editar({idEstabelecimento}, {idCardapio}, {nome}, {descricao}, {exibir});

/* -------- */

-- Remoção do registro
UPDATE  u863995488_producao.cardapio
SET     inclusao = CURRENT_TIMESTAMP()
WHERE   id_cardapio = {idCardapio};