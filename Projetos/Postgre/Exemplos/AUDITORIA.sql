/* EXEMPLO DE AUDITORIA EM TODAS AS TABELAS UTILIZANDO JSON */

-- DROP NOS OBJETOS
DROP TABLE IF EXISTS auditoria;

-- CREATE SEQUENCE
CREATE SEQUENCE IF NOT EXISTS auditoria_id_seq;

-- CREATE DA TABELA auditoria
CREATE TABLE IF NOT EXISTS auditoria
(
  id INTEGER NOT NULL DEFAULT nextval('auditoria_id_seq'),
  usuario character varying(50) NOT NULL,
  tabela character varying(50) NOT NULL,
  operacao character varying(50) NOT NULL,
  registro jsonb NOT NULL,
  data_auditoria timestamp DEFAULT now(),
  CONSTRAINT auditoria_pk PRIMARY KEY (id)
);

-- CREATE DA FUNCTION trigger de audirotia geral
CREATE OR REPLACE FUNCTION auditoria_geral_function() RETURNS trigger AS
$BODY$
BEGIN
	INSERT INTO auditoria(usuario, tabela, operacao, registro) VALUES (SESSION_USER, TG_RELNAME, TG_OP, ROW_TO_JSON(OLD));
	RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;


-- BLOCO para criar de forma dinâmica tigger de auditoria em todas as tabelas do banco (Avançado)
DO $$ DECLARE
    tabela RECORD;
BEGIN
    FOR tabela IN (SELECT tablename AS nome FROM pg_tables WHERE schemaname = CURRENT_SCHEMA AND tablename <> 'auditoria') LOOP
	EXECUTE 'DROP TRIGGER IF EXISTS auditoria_' || LOWER(tabela.nome) || '_trigger ON ' || tabela.nome || ';';
	EXECUTE 'CREATE TRIGGER auditoria_' || LOWER(tabela.nome) || '_trigger  AFTER UPDATE OR DELETE ON ' || tabela.nome || ' FOR EACH ROW EXECUTE PROCEDURE auditoria_geral_function();';
    RAISE INFO 'Criado trigger de auditoria para a tabela: %', tabela.nome;
    END LOOP;
END $$;