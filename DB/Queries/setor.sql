-- Consulta dos setores cadastrados
SELECT	id_setor, descricao, exclusao, inclusao, nome FROM u863995488_producao.setor ORDER BY nome;

-- Consulta de um setor em específico
SELECT	id_setor, descricao, exclusao, inclusao, nome FROM u863995488_producao.setor WHERE id_setor = {idSetor};

-- Insere um novo registro na tabela
INSERT INTO u863995488_producao.setor (descricao, nome) VALUES (
    {descricao}, -- Varchar
    {nome} -- Varchar
);

-- Edita um registro na tabela
UPDATE u863995488_producao.setor SET descricao = {descricao}, nome = {nome} WHERE id_setor = {id_setor};

-- Realiza a exclusão lógica do registro
UPDATE u863995488_producao.setor SET exclusao = CURRENT_TIMESTAMP WHERE id_setor = {idSetor};