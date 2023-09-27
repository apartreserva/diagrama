-- Consulta dos estabelecimentos
SELECT      id_estabelecimento, id_matriz, cnpj, inclusao, exclusao, nome, nome_fantasia,
		    (CASE
			    WHEN id_matriz IS NULL THEN 'true'
                ELSE 'false'
            END) AS matriz
FROM 	    u863995488_producao.estabelecimento
ORDER BY    nome;

-- Consulta de um estabelecimento por ID
SELECT  id_estabelecimento, id_matriz, cnpj, inclusao, exclusao, nome, nome_fantasia,
		(CASE
			WHEN id_matriz IS NULL THEN 'true'
            ELSE 'false'
        END) AS matriz
FROM 	u863995488_producao.estabelecimento
WHERE   id_estabelecimento = {idEstabelecimento};

-- Consultar por digitar um termo chave
SELECT  id_estabelecimento, id_matriz, cnpj, inclusao, exclusao, nome, nome_fantasia
FROM 	u863995488_producao.estabelecimento
WHERE	LOWER(nome) LIKE(LOWER('%%')) OR LOWER(nome_fantasia) LIKE(LOWER('%%'))

-- Consulta das filiais
SELECT  id_estabelecimento, id_matriz, cnpj, inclusao, exclusao, nome, nome_fantasia
FROM 	u863995488_producao.estabelecimento
WHERE	id_matriz = {IdMatriz};

-- Editar dados do estabelecimento
UPDATE 	u863995488_producao.estabelecimento
SET		id_matriz = {idMatriz}, cnpj = {cnpj}, nome = {nome}, nome_fantasia = {nomeFantasia}
WHERE	id_estabelecimento = {idMatriz};

-- Remover estabelecimento
UPDATE 	u863995488_producao.estabelecimento
SET		exclusao = CURRENT_TIMESTAMP()
WHERE	id_estabelecimento = {idEstabelecimento};