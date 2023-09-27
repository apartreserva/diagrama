-- Consulta dos logs de usuário
SELECT id_log, id_usuario, inclusao FROM u863995488_producao.log_acesso ORDER BY inclusao DESC;

-- Consulta o log de acesso de um usuário específico
SELECT id_log, id_usuario, inclusao FROM u863995488_producao.log_acesso WHERE id_usuario = {idUsuario} ORDER BY inclusao DESC;

-- Inclusão de um registro
INSERT INTO u863995488_producao.log_acesso (id_usuario) VALUES ({idUsuario});