/**
* @descrição: Função para inclusão do registro.
* @return {int} id do registro recém inserido.
**/

-- Função de inclusão de endereço.
CREATE DEFINER=`u863995488_producao`@`%` FUNCTION `fc_endereco_adicionar`(enderecoIdUf INT, enderecoCEP VARCHAR(255), enderecoCidade VARCHAR(255), enderecoBairro VARCHAR(255), enderecoComplemento VARCHAR(255), enderecoDescricao VARCHAR(255), enderecoRUA VARCHAR(255), enderecoNumero VARCHAR(255)) RETURNS int(11)
BEGIN

	-- Insere um novo registro.
	INSERT INTO u863995488_producao.endereco (enderecoIdUf, cep, cidade, bairro, complemento, descricao, rua, numero)
	VALUES      (enderecoIdUf, enderecoCEP, enderecoCidade, enderecoBairro, enderecoComplemento, enderecoDescricao, enderecoRUA, enderecoNumero);
    
    -- Variável de armazenamento da próxima ID da tabela
    SET @nextID = 0;
    
    -- Carrega a últma ID Válida
	SELECT LAST_INSERT_ID() AS id_endereco INTO @nextID FROM u863995488_producao.endereco;
    
RETURN @nextID;
END

-- Chamada
SELECT  u863995488_producao.fc_endereco_adicionar({enderecoIdUf}, {cep}, {cidade}, {bairro}, {complemento}, {descricao}, {rua}, {numero}) AS id_endereco;

/**
* @descrição: Função para associação do registo.
* @return {int} 1062 - Caso o registro já exista | 201 - cadastro realizado.
**/
CREATE DEFINER=`u863995488_producao`@`%` FUNCTION `fc_endereco_usuario_associar`(idEndereco INT, idUsuario INT, enderecoPrincipal bool) RETURNS int(11)
BEGIN
	
    -- Armazena a quantidade de registros encontrados.
    SET	@qtdReg = 0;

	-- Consulta se o registro já está incluso.
    SELECT	COUNT(*) INTO @qtdReg FROM u863995488_producao.endereco_usuario WHERE id_usuario = idUsuario AND id_endereco = idEndereco;
    
	-- Verifica se existem registro.
    IF (@qtdReg > 0 ) THEN
    
		-- Código de chave duplicada, devolve para o sistema perguntar de deseja reativar o endereço.
		RETURN 1062;
        
    ELSE
		
        -- Insere o novo registro
		INSERT INTO u863995488_producao.endereco_usuario (id_endereco, id_usuario, principal) VALUES (idEndereco, idUsuario, enderecoPrincipal);
		RETURN 201;
    END IF;
END

-- Chamada
SELECT  u863995488_producao.fc_endereco_usuario_associar({idEndereco}, {idUsuario}, {principal}) AS codigo;

/**
* @descrição: Função para associação do registo.
* @return {int} 200 sucesso
**/
CREATE DEFINER=`u863995488_producao`@`%` FUNCTION `fc_endereco_usuario_remover`(idEndereco INT, idUsuario INT) RETURNS int(11)
BEGIN

	-- Apaga a associação.
	UPDATE  u863995488_producao.endereco_usuario SET exclusao = CURRENT_TIMESTAMP() WHERE id_endereco = idEndereco AND id_usuario = idUsuario;
    
    -- Apaga o endereço.
	UPDATE  u863995488_producao.endereco SET exclusao = CURRENT_TIMESTAMP() WHERE id_endereco = idEndereco;

RETURN 200;
END

-- Chamada
SELECT  u863995488_producao.fc_endereco_usuario_remover({idEndereco}, {idUsuario});

/**
* @descrição: Função para recuperação do registo.
* @return {int} 200 sucesso
**/
CREATE DEFINER=`u863995488_producao`@`%` FUNCTION `fc_endereco_usuario_recuperar`(idEndereco INT, idUsuario INT) RETURNS int(11)
BEGIN
	
    -- Atualiza a associação.
    UPDATE u863995488_producao.endereco_usuario SET exclusao = NULL;
    
    -- Atualiza o endereço.
    UPDATE u863995488_producao.endereco SET exclusao = NULL;
    
RETURN 200;
END

-- Chamada
SELECT  u863995488_producao.fc_endereco_usuario_recuperar({idEndereco}, {idUsuario});

/**
* @descrição: Função para atualizar o registo.
* @return {int} 200 sucesso
**/
CREATE DEFINER=`u863995488_producao`@`%` FUNCTION `fc_endereco_usuario_editar`(enderecoID INT, enderecoIdUf INT, enderecoCEP VARCHAR(255), enderecoCidade VARCHAR(255), enderecoBairro VARCHAR(255), enderecoComplemento VARCHAR(255), enderecoDescricao VARCHAR(255), enderecoRUA VARCHAR(255), enderecoNumero VARCHAR(255)) RETURNS int(11)
BEGIN
		
        UPDATE 	u863995488_producao.endereco
		SET		cep = {enderecoCEP}, cidade = {enderecoCidade}, bairro = {enderecoBairro}, complemento = {enderecoComplemento},
				descricao = {enderecoDescricao}, rua = {enderecoRUA}, numero = {enderecoNumero}, id_uf = {enderecoIdUf}
        WHERE 	id_endereco = {enderecoID};
    
RETURN 200;
END

-- Chamada
SELECT u863995488_producao.fc_endereco_usuario_editar({idEndereco}, {cep}, {cidade}, {bairro}, {complemento}, {descricao}, {rua}, {numero});

-- Seleciona os endereços do usuário
SELECT		e.*,
			(CASE
				WHEN eu.principal = 0 THEN 'false'
				ELSE
					'true'
			END) AS principal
FROM 		u863995488_producao.usuario u
JOIN		u863995488_producao.endereco_usuario eu ON eu.id_usuario = u.id_usuario
JOIN		u863995488_producao.endereco e ON e.id_endereco = eu.id_endereco
WHERE   	u.id_usuario = {idUsuario}
ORDER BY 	e.descricao;

-- Lista as unidades federativas do Brasil
SELECT	id_uf, nome, sigla FROM u863995488_producao.uf ORDER BY sigla;