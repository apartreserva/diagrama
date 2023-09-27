-- Seleção das assinaturas
SELECT	id_assinatura, descricao, nome, exclusao, inclusao, valor
FROM 	u863995488_producao.assinatura
WHERE	exclusao IS NULL;

-- Seleção das assinaturas por id
SELECT	id_assinatura, descricao, nome, exclusao, inclusao, valor
FROM 	u863995488_producao.assinatura
WHERE	id_assinatura = {idAssinatura}
AND     exclusao IS NULL;

-- Seleção das assinaturas por nome
SELECT	id_assinatura, descricao, nome, exclusao, inclusao, valor
FROM 	u863995488_producao.assinatura
WHERE	LOWER(nome) LIKE(LOWER('%%'))
AND     exclusao IS NULL;

-- Consulta os usuários que possuem a asinatura selecionada.
SELECT	u.nome, (CASE WHEN u.exclusao IS NULL THEN 'Ativo' ELSE 'Inativo' END) AS status_usuario,
		au.inclusao, au.exclusao 
FROM	u863995488_producao.assinatura a
JOIN	u863995488_producao.assinatura_usuario au ON au.id_assinatura = a.id_assinatura
JOIN	u863995488_producao.usuario u ON u.id_usuario = au.id_usuario
WHERE	a.id_assinatura = {idAssinatura}

-- Atualização dos dado do registro
UPDATE  u863995488_producao.assinatura
SET     descricao = {descricao}, nome = {nome}, valor = {valor}
WHERE   id_assinatura = {idAssinatura};

-- Associação da assinatura e usuário
INSERT INTO u863995488_producao.assinatura_usuario (id_assinatura, id_usuario) VALUES ({idAssinatura}, {idUsuario});

-- Desassociação da assinatura e usuário
UPDATE  u863995488_producao.assinatura_usuario
SET     exclusao = CURRENT_TIMESTAMP()
WHERE   id_assinatura = {idAssinatura} AND id_usuario = {idUsuario};

-- Remoção do registro.
UPDATE  u863995488_producao.assinatura
SET     exclusao = CURRENT_TIMESTAMP()
WHERE   id_assinatura = {idAssinatura};

