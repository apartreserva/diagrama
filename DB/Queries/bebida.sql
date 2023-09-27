-- Seleciona as bebidas.
SELECT		id_bebida, id_estabelecimento, alcoolica, nome, descricao, exclusao, inclusao, litros
FROM 		u863995488_producao.bebida
WHERE       id_Estabelecimento IS NULL
ORDER BY 	nome;

-- Seleciona as bebidas do estabelecimento
SELECT		id_bebida, id_estabelecimento, alcoolica, nome, descricao, exclusao, inclusao, litros
FROM 		u863995488_producao.bebida
WHERE       id_Estabelecimento = {idEstabelecimento}
ORDER BY 	nome;

-- Atualiza uma bebida
UPDATE  u863995488_producao.bebida
SET     alcoolica = {alcoolica}, nome = {nome}, descricao = {descricao}, litros = {litros}
WHERE   id_bebida = {IdBebida}

-- Atualiza uma bebida do estabelecimento
UPDATE  u863995488_producao.bebida
SET     alcoolica = {alcoolica}, nome = {nome}, descricao = {descricao}, litros = {litros}
WHERE   id_bebida = {IdBebida} AND id_estabelecimento = {idEstabelecimento};
        
-- Realiza a exclusão lógica do registro
UPDATE  u863995488_producao.bebida
SET     exclusao = CURRENT_TIMESTAMP()
WHERE   id_bebida = {IdBebida};

-- Realiza a exclusão lógica do registro associado à um estabelecimento.
UPDATE  u863995488_producao.bebida
SET     exclusao = CURRENT_TIMESTAMP()
WHERE   id_bebida = {IdBebida}
AND     id_estabelecimento {idEstabelecimento};

-- Insere um novo registro em bebidas
INSERT INTO u863995488_producao.bebida ()