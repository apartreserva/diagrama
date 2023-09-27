-- Consulta dos usuários do sistema.
SELECT		id_usuario, nome, exclusao, inclusao
FROM 		u863995488_producao.usuario
ORDER BY	nome;

-- Consulta os usuários do sistema que estão válidos
SELECT		id_usuario, nome, exclusao, inclusao
FROM 		u863995488_producao.usuario
WHERE		exclusao IS NULL
ORDER BY	nome;

-- Consulta as assinaturas do usuário
SELECT	a.nome, a.valor, au.inclusao, au.exclusao
FROM	u863995488_producao.assinatura a
JOIN	u863995488_producao.assinatura_usuario au ON au.id_assinatura = a.id_assinatura
JOIN	u863995488_producao.usuario u ON u.id_usuario = au.id_usuario
WHERE	au.id_usuario = {idUsuario};

-- Alterar o status do usuário
UPDATE  u863995488_producao.usuario SET id_status = {idStaus} WHERE id_status = {idUsuario};

-- Exclusão lógica do usuário
UPDATE  u863995488_producao.usuario SET exclusao = CURRENT_TIMESTAMP WHERE id_usuario = {idUsuario};