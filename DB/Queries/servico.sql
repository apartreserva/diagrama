-- Consulta os serviços da APART
SELECT 	    id_servico, nome, descricao, exclusao, inclusao, sigla
FROM	    u863995488_producao.servico
ORDER BY    nome;

-- Busca um serviços da APART por seu id
SELECT 	id_servico, nome, descricao, exclusao, inclusao, sigla
FROM	u863995488_producao.servico
WHERE   id_servico = {idServico};

-- Adição de um novo registro
INSERT INTO u863995488_producao.servico (nome, descricao, sigla)
VALUES      ({nome}, {descricao}, {sigla});

-- Edição do registro
UPDATE  u863995488_producao.servico
SET     nome = {nome}, descricao = {descricao}, sigla = {sigla}
WHERE   id_servico = {idServico};

-- Exclusão lógica
UPDATE  u863995488_producao.servico
SET     exclusao = CURRENT_TIMESTAMP()
WHERE   id_servico = {idServico};