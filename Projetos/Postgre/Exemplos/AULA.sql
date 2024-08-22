-- UPDATE
-- DELETE
-- CHECK
-- INDEX
-- TRIGGER
-- CASE WHEN
-- SUB SELECT
--VIEWS NORMAL E MAT

--SUBSELECT
--Coluna
    SELECT
        cid.*,
        (SELECT COUNT(*)
         FROM aluno
         WHERE aluno.id_cidade = cid.id)::INT AS alunos_vinculados
    FROM cidade cid;

--Filtro
    SELECT
        *
    FROM aluno
    WHERE id_signo IN (SELECT signo.id
                       FROM signo
                       WHERE signo.nome IN ('Virgem', 'Gêmeos'));

    SELECT
        *
    FROM aluno
    WHERE EXISTS (SELECT signo.id
                       FROM signo
                       WHERE signo.id = aluno.id_signo);

--Fonte de dados
SELECT *
FROM (
    SELECT aluno.id AS id_aluno,
           aluno.nome,
           aluno.cpf,
           aluno.id_cidade,
           COALESCE(cidade.cidade, 'SEM CIDADE') AS nome_cidade,
           COALESCE(cidade.estado, 'SEM ESTADO') AS sigla_estado
    FROM aluno
    LEFT JOIN cidade ON (cidade.id = aluno.id_cidade)
    LEFT JOIN signo ON (signo.id = aluno.id_signo)
) AS tabela_temporaria
WHERE tabela_temporaria.nome_cidade ILIKE '%SEM%';


--CASE WHEN
    SELECT
        id,
        nome,
        CASE WHEN tipo_sanguineo = 'O-' THEN 'TIPO DE SANGUE O-'
             WHEN tipo_sanguineo = 'A-' THEN 'TIPO DE SANGUE A-'
             WHEN tipo_sanguineo = 'AB+' THEN 'TIPO DE SANGUE AB+'
             WHEN tipo_sanguineo = 'O+' THEN 'TIPO DE SANGUE O+'
             WHEN tipo_sanguineo = 'B-' THEN 'TIPO DE SANGUE B-'
             WHEN tipo_sanguineo = 'A+' THEN 'TIPO DE SANGUE A+'
             WHEN tipo_sanguineo = 'AB-' THEN 'TIPO DE SANGUE AB-'
             WHEN tipo_sanguineo = 'B+' THEN 'TIPO DE SANGUE B+'
        ELSE 'DESCONHECIDO' END AS tipo_sanguineo_alterado
    FROM aluno;

--UPDATE
SELECT nome, data_nascimento, tipo_sanguineo FROM aluno WHERE id = 177;
--+-----------------------+---------------+--------------+
--|nome                   |data_nascimento|tipo_sanguineo|
--+-----------------------+---------------+--------------+
--|Pedro Henrique Oliveira|1992-03-14     |O+            |
--+-----------------------+---------------+--------------+

UPDATE aluno SET
                 nome = 'Pedro Henrique de Oliveira',
                 data_nascimento = '1992-03-16',
                 tipo_sanguineo = 'O-'
WHERE id = 177;

--DELETE
SELECT cpf, COUNT(*) AS contador
FROM aluno
GROUP BY cpf
HAVING count(*) > 1;

DELETE FROM aluno WHERE id IN (108, 110, 105, 107, 106, 112, 101, 104, 103, 109);

--CHECK
CREATE TABLE IF NOT EXISTS teste (
    id INTEGER NOT NULL,
    nome CHARACTER VARYING(100),
    tipo INTEGER NOT NULL,
    CONSTRAINT teste_pk PRIMARY KEY (id),
    CONSTRAINT teste_tipo_check CHECK (tipo IN (1,2,3,4,5))
);
SELECT * FROM teste;
INSERT INTO teste (id, nome, tipo) VALUES (1, 'TESTE 1', 1);
INSERT INTO teste (id, nome, tipo) VALUES (2, 'TESTE 2', 2);
INSERT INTO teste (id, nome, tipo) VALUES (3, 'TESTE 3', 3);
INSERT INTO teste (id, nome, tipo) VALUES (4, 'TESTE 4', 4);
INSERT INTO teste (id, nome, tipo) VALUES (5, 'TESTE 5', 5);

INSERT INTO teste (id, nome, tipo) VALUES (6, 'TESTE 6', 1);

--ERROS DE CHECK
INSERT INTO teste (id, nome, tipo) VALUES (7, 'TESTE 7', 7);
UPDATE teste SET tipo = 7 WHERE id = 5;

--INDEX
--DOCS em https://www.postgresql.org/docs/current/sql-createindex.html
-- CREATE [ UNIQUE ] INDEX [ CONCURRENTLY ] [ [ IF NOT EXISTS ] name ] ON [ ONLY ] table_name [ USING method ]
--     ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass [ ( opclass_parameter = value [, ... ] ) ] ] [ ASC | DESC ] [ NULLS { FIRST | LAST } ] [, ...] )
--     [ INCLUDE ( column_name [, ...] ) ]
--     [ NULLS [ NOT ] DISTINCT ]
--     [ WITH ( storage_parameter [= value] [, ... ] ) ]
--     [ TABLESPACE tablespace_name ]
--     [ WHERE predicate ]

CREATE INDEX CONCURRENTLY IF NOT EXISTS aluno_id_cidade_idx ON aluno(id_cidade);
CREATE INDEX IF NOT EXISTS aluno_id_signo_idx ON aluno(id_signo);
CREATE INDEX IF NOT EXISTS aluno_nome_idx ON aluno(nome);

--CUSTO AO SGBD para atualizar
--CRIAR NA FK?

--VIEW
--DOCS em https://www.postgresql.org/docs/current/sql-createview.html
--CREATE [ OR REPLACE ] [ TEMP | TEMPORARY ] [ RECURSIVE ] VIEW name [ ( column_name [, ...] ) ]
--    [ WITH ( view_option_name [= view_option_value] [, ... ] ) ]
--    AS query
--    [ WITH [ CASCADED | LOCAL ] CHECK OPTION ]

DROP VIEW IF EXISTS ficha_aluno_view;

CREATE OR REPLACE VIEW ficha_aluno_view AS
    SELECT aluno.id AS id_aluno,
           aluno.nome,
           aluno.cpf,
           aluno.rg,
           aluno.data_nascimento,
           aluno.sexo,
           aluno.mae,
           aluno.celular,
           aluno.tipo_sanguineo,
           aluno.altura,
           aluno.peso,
           aluno.id_cidade,
           COALESCE(cidade.cidade, 'SEM CIDADE') AS nome_cidade,
           COALESCE(cidade.estado, 'SEM ESTADO') AS sigla_estado,
           aluno.id_signo,
           COALESCE(signo.nome, 'SEM SIGNO') AS signo
    FROM aluno
    LEFT JOIN cidade ON (cidade.id = aluno.id_cidade)
    LEFT JOIN signo ON (signo.id = aluno.id_signo);

SELECT * FROM ficha_aluno_view;
SELECT * FROM ficha_aluno_view WHERE nome ILIKE '%felipe%';

--MATERIALIZED VIEW
--DOCS em https://www.postgresql.org/docs/current/sql-creatematerializedview.html
--CREATE MATERIALIZED VIEW [ IF NOT EXISTS ] table_name
--    [ (column_name [, ...] ) ]
--    [ USING method ]
--    [ WITH ( storage_parameter [= value] [, ... ] ) ]
--    [ TABLESPACE tablespace_name ]
--    AS query
--    [ WITH [ NO ] DATA ]

DROP MATERIALIZED VIEW IF EXISTS ficha_aluno_materialized_view;

CREATE MATERIALIZED VIEW IF NOT EXISTS ficha_aluno_materialized_view AS
    SELECT aluno.id AS id_aluno,
           aluno.nome,
           aluno.cpf,
           aluno.rg,
           aluno.data_nascimento,
           aluno.sexo,
           aluno.mae,
           aluno.celular,
           aluno.tipo_sanguineo,
           aluno.altura,
           aluno.peso,
           aluno.id_cidade,
           COALESCE(cidade.cidade, 'SEM CIDADE') AS nome_cidade,
           COALESCE(cidade.estado, 'SEM ESTADO') AS sigla_estado,
           aluno.id_signo,
           COALESCE(signo.nome, 'SEM SIGNO') AS signo
    FROM aluno
    LEFT JOIN cidade ON (cidade.id = aluno.id_cidade)
    LEFT JOIN signo ON (signo.id = aluno.id_signo)
    WITH NO DATA;

    REFRESH MATERIALIZED VIEW ficha_aluno_materialized_view;

    SELECT * FROM ficha_aluno_materialized_view;
    SELECT * FROM ficha_aluno_materialized_view WHERE nome ILIKE '%felipe%';

--PROCEDURES

--TRIGGERS
    CREATE OR REPLACE FUNCTION aluno_celular_trigger_function() RETURNS trigger AS
    $BODY$
    BEGIN
        /* LÓGICA DE PROGRAMAÇÃO AQUI */
        RETURN NEW;
    END;
    $BODY$
    LANGUAGE plpgsql;

    CREATE TRIGGER aluno_celular_trigger
    BEFORE INSERT OR UPDATE ON aluno
    FOR EACH ROW
    EXECUTE PROCEDURE aluno_celular_trigger_function();

--TRANSACAO
BEGIN; --INICIAR TRANSACAO
COMMIT; --COMITAR/CONFIRMAR
ROLLBACK; --PARAR/CANCELAR
END; --MESMA FUNCAO DO COMMIT