---------------------------------------------------------------------------------------------
-- 1.

SELECT 
	paciente.nome AS nome_paciente,
	paciente.cpf AS cpf_paciente,
	paciente.data_nascimento AS data_nascimento_paciente,
	paciente.sexo AS sexo_paciente,
	paciente.idade AS idade_paciente,
	consulta.data_consulta,
	consulta.hora_consulta,
	consulta.tem_retorno,
	consulta.data_retorno,
	consulta.hora_retorno,
	medico.nome AS nome_medico,
	medico.cpf AS cpf_medico,
	medico.data_nascimento AS data_nascimento_medico,
	medico.sexo AS sexo_medico,
	medico.email AS email_medico,
	medico.numero_crm AS numero_crm_medico,
	medico.estado_crm AS estado_crm_medico,
	especialidade.nome AS especialidade_medico
FROM paciente
LEFT JOIN consulta ON (consulta.id_paciente = paciente.id)
INNER JOIN medico ON (medico.id = consulta.id_medico)
INNER JOIN especialidade ON (especialidade.id = medico.id_especialidade)
ORDER BY data_consulta

---------------------------------------------------------------------------------------------
-- 2.

SELECT
	medico.id AS id_medico,
	medico.nome AS nome_medico,
	medico.cpf AS cpf_medico,
	medico.data_nascimento AS data_nascimento_medico,
	medico.sexo AS sexo_medico,
	medico.email AS email_medico,
	medico.numero_crm AS numero_crm_medico,
	medico.estado_crm AS estado_crm_medico,
	especialidade.id AS id_especialidade,
	especialidade.nome AS especialidade_medico
FROM medico
INNER JOIN especialidade ON (medico.id_especialidade = especialidade.id)
WHERE (medico.sexo LIKE 'M')
AND (medico.data_nascimento > '1985-01-01')
AND (especialidade.nome LIKE 'Nefrologia')
ORDER BY medico.id
	
---------------------------------------------------------------------------------------------
-- 3.

SELECT
	medico.id AS id_medico,
	medico.nome AS nome_medico,
	medico.cpf AS cpf_medico,
	medico.data_nascimento AS data_nascimento_medico,
	medico.sexo AS sexo_medico,
	medico.email AS email_medico,
	medico.numero_crm AS numero_crm_medico,
	medico.estado_crm AS estado_crm_medico,
	especialidade.id AS id_especialidade,
	especialidade.nome AS especialidade_medico
FROM medico
INNER JOIN especialidade ON (medico.id_especialidade = especialidade.id)
WHERE (medico.data_nascimento BETWEEN '1985-01-01' AND '1987-12-31')
AND (medico.email ILIKE '%@gmail.com')
ORDER BY medico.id

---------------------------------------------------------------------------------------------
-- 4.

SELECT
	medico.id AS id_medico,
	medico.nome AS nome_medico,
	medico.cpf AS cpf_medico,
	medico.data_nascimento AS data_nascimento_medico,
	medico.sexo AS sexo_medico,
	medico.email AS email_medico,
	medico.numero_crm AS numero_crm_medico,
	medico.estado_crm AS estado_crm_medico
FROM medico
WHERE (medico.cpf ILIKE '4%')
AND (medico.nome ILIKE 'v%')
ORDER BY medico.id

---------------------------------------------------------------------------------------------
-- 5.

SELECT
	medico.id AS id_medico,
	medico.nome AS nome_medico,
	medico.cpf AS cpf_medico,
	medico.data_nascimento AS data_nascimento_medico,
	medico.sexo AS sexo_medico,
	medico.email AS email_medico,
	medico.numero_crm AS numero_crm_medico,
	medico.estado_crm AS estado_crm_medico
FROM medico
WHERE (medico.numero_crm BETWEEN 60000 AND 70000)
AND (medico.data_nascimento < '1979-12-31')
AND (medico.estado_crm LIKE 'GO')
ORDER BY medico.id

---------------------------------------------------------------------------------------------
-- 6.

SELECT
	medico.id AS id_medico,
	medico.nome AS nome_medico,
	medico.cpf AS cpf_medico,
	medico.data_nascimento AS data_nascimento_medico,
	medico.sexo AS sexo_medico,
	medico.email AS email_medico,
	medico.numero_crm AS numero_crm_medico,
	medico.estado_crm AS estado_crm_medico
FROM medico
WHERE (medico.id = 5 OR medico.id = 11 OR medico.id = 18 OR medico.id = 28 OR medico.id = 31)
ORDER BY medico.id

---------------------------------------------------------------------------------------------
-- 7.

SELECT
	medico.id AS id_medico,
	medico.nome AS nome_medico,
	medico.cpf AS cpf_medico,
	medico.data_nascimento AS data_nascimento_medico,
	medico.sexo AS sexo_medico,
	medico.email AS email_medico,
	medico.numero_crm AS numero_crm_medico,
	medico.estado_crm AS estado_crm_medico
FROM medico
WHERE (medico.nome ILIKE '%mendes%')
ORDER BY medico.id

---------------------------------------------------------------------------------------------
-- 8.

SELECT 
	paciente.id AS id_paciente,
	paciente.nome AS nome_paciente,
	COUNT(sequencial_consulta) AS total_consultas
FROM paciente
INNER JOIN consulta ON (consulta.id_paciente = paciente.id)
GROUP BY paciente.id
HAVING COUNT(sequencial_consulta) > 1 
ORDER BY paciente.id

---------------------------------------------------------------------------------------------
-- 9.

SELECT
	medico.id AS id_medico,
	medico.nome AS nome_medico,
	COUNT(sequencial_consulta) AS total_consultas
FROM medico
INNER JOIN consulta ON (consulta.id_medico = medico.id)
GROUP BY medico.id
ORDER BY total_consultas DESC

---------------------------------------------------------------------------------------------
-- 10.

SELECT
	medico.id AS id_medico,
	medico.nome AS nome_medico,
	medico.cpf AS cpf_medico,
	medico.data_nascimento AS data_nascimento_medico,
	medico.sexo AS sexo_medico, 
	medico.email AS email_medico,
	medico.numero_crm AS numero_crm_medico, 
	medico.estado_crm AS estado_crm_medico
FROM medico
LEFT JOIN consulta ON (consulta.id_medico = medico.id)
WHERE medico.id > 6
ORDER BY medico.id

---------------------------------------------------------------------------------------------
-- 11.

SELECT	
	consulta.data_consulta,
	COUNT(*) AS total_consultas
FROM consulta
GROUP BY consulta.data_consulta
ORDER BY total_consultas DESC, consulta.data_consulta

---------------------------------------------------------------------------------------------
-- 12.

SELECT
	paciente.sexo AS sexo_paciente,
	COUNT(*) AS total_pacientes,
	ROUND(AVG(paciente.idade), 2) AS media_idade
FROM paciente
GROUP BY paciente.sexo

---------------------------------------------------------------------------------------------
-- 13.

SELECT
	especialidade.id AS id_especialidade,
	especialidade.nome AS nome_especialidade,
	(SELECT COUNT(*)
	FROM medico
	WHERE medico.id_especialidade = especialidade.id)::VARCHAR AS quantidade_medicos
FROM especialidade 

---------------------------------------------------------------------------------------------
-- 14.

CREATE OR REPLACE FUNCTION altera_consultas_sem_retorno_function() RETURNS void AS $$

	BEGIN

	IF consulta.tem_retorno = 'f' THEN
	UPDATE consulta SET tem_retorno = 't', 
			    data_retorno = date.now(), 
			    hora_retorno = time.now();
	END IF;
	END;

$$ LANGUAGE plpgsql;

SELECT altera_consultas_sem_retorno_function() FROM consulta;

SELECT
	*
FROM consulta

---------------------------------------------------------------------------------------------
-- 15.

ALTER TABLE medico ADD COLUMN data_atualizacao TIMESTAMP;

CREATE OR REPLACE FUNCTION data_atualizacao_function() RETURNS trigger AS $$

	BEGIN
		IF (NEW.nome <> OLD.nome 
		OR NEW.cpf <> OLD.cpf 
		OR NEW.data_nascimento <> NEW.data_nascimento 
		OR NEW.sexo <> OLD.sexo
		OR NEW.email <> OLD.email
		OR NEW.numero_crm <> OLD.numero_crm
		OR NEW.estado_crm <> OLD.estado_crm
		OR NEW.id_especialidade <> OLD.id_especialidade
		OR NEW.ativo <> OLD.ativo)  THEN
		UPDATE medico SET data_atualizacao = (now());
		END IF;
		RETURN NEW;
	END;

$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS data_atualizacao_trigger ON medico;
CREATE TRIGGER data_atualizacao_trigger 
AFTER UPDATE OR DELETE ON medico
FOR EACH ROW
EXECUTE PROCEDURE data_atualizacao_function();

INSERT INTO medico(nome, cpf, data_nascimento, sexo, email, numero_crm, estado_crm, id_especialidade, ativo) VALUES
('Gabriel Felix Faustina', '123.456.789-01', '2004-09-23', 'M', 'gabriel@gmail.com', 123123, 'SC', 1, 't');

UPDATE medico SET nome = 'Gabriel Felix Faustina'
WHERE id = 55;

SELECT
	*
FROM medico
WHERE id = 55