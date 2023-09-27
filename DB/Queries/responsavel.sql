-- Listar os registros
SELECT	id_estabelecimento, id_responsavel, exclusao, inclusao
FROM 	u863995488_producao.responsavel;

-- Listar os registros válidos
SELECT	id_estabelecimento, id_responsavel, exclusao, inclusao
FROM 	u863995488_producao.responsavel
WHERE   exclusao IS NULL;

-- Carrega os responsáveis pelo estabelecimento
SELECT	u.nome, (CASE WHEN u.exclusao IS NULL THEN 'true' ELSE 'false' END) AS ativo,
		r.exclusao
FROM	u863995488_producao.responsavel r
JOIN	u863995488_producao.usuario u ON u.id_usuario = r.id_responsavel
WHERE	r.id_estabelecimento = {idEstabelecimento};

-- Carrega os estalebecimentos associados ao respnsável
SELECT	e.nome, (CASE WHEN e.exclusao IS NULL THEN 'true' ELSE 'false' END) AS ativo,
		r.exclusao
FROM	u863995488_producao.responsavel r
JOIN	u863995488_producao.estabelecimento e ON e.id_estabelecimento = r.id_estabelecimento
WHERE	r.id_responsavel = {idResponsavel};

-- Remover responsável do estabelecimento
UPDATE  u863995488_producao.responsavel
SET     exclusao = CURRENT_TIMESTAMP()
WHERE   id_responsavel = {idEstabelecimento}
AND     id_estabelecimento = {idResponsavel}