-- DROPS MODO DEV
DROP TABLE IF EXISTS turma_professor;
DROP TABLE IF EXISTS professor;
DROP SEQUENCE IF EXISTS professor_id_seq;
DROP TABLE IF EXISTS aula;
DROP SEQUENCE IF EXISTS aula_id_seq;
DROP TABLE IF EXISTS turma;
DROP SEQUENCE IF EXISTS turma_id_seq;
DROP TABLE IF EXISTS sala;
DROP SEQUENCE IF EXISTS sala_id_seq;

-- TABELA SALA
CREATE SEQUENCE IF NOT EXISTS sala_id_seq;

CREATE TABLE IF NOT EXISTS sala (

	id INTEGER NOT NULL DEFAULT NEXTVAL('sala_id_seq'),
	nome CHARACTER VARYING(100) NOT NULL,
	corredor INTEGER NOT NULL,
	excluido BOOLEAN DEFAULT false,
	CONSTRAINT sala_pk PRIMARY KEY (id)
);

-- TABELA TURMA
CREATE SEQUENCE IF NOT EXISTS turma_id_seq;

CREATE TABLE IF NOT EXISTS turma (

	id INTEGER NOT NULL DEFAULT NEXTVAL('turma_id_seq'),
	id_sala INTEGER NOT NULL,
	quantidade_alunos INTEGER NOT NULL,
	excluido BOOLEAN DEFAULT false,
	CONSTRAINT turma_pk PRIMARY KEY (id),

	CONSTRAINT turma_sala_id_sala_fk FOREIGN KEY (id_sala) REFERENCES sala (id)
);

-- TABELA PROFESSOR
CREATE SEQUENCE IF NOT EXISTS professor_id_seq;

CREATE TABLE IF NOT EXISTS professor (

	id INTEGER NOT NULL DEFAULT NEXTVAL('professor_id_seq'),
	nome CHARACTER VARYING(100) NOT NULL,
	excluido BOOLEAN DEFAULT false,
	CONSTRAINT professor_pk PRIMARY KEY (id)
);

-- TABELA TURMA_PROFESSOR
CREATE TABLE IF NOT EXISTS turma_professor (

	id_turma INTEGER NOT NULL,
	id_professor INTEGER NOT NULL,
	CONSTRAINT turma_professor_pk PRIMARY KEY (id_turma, id_professor),

	CONSTRAINT turma_professor_turma_id_turma_fk FOREIGN KEY (id_turma) REFERENCES turma (id) ON DELETE NO ACTION ON UPDATE NO ACTION,

	CONSTRAINT turma_professor_professor_id_professor_fk FOREIGN KEY (id_professor) REFERENCES professor (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA AULA
CREATE SEQUENCE IF NOT EXISTS aula_id_seq;

CREATE TABLE IF NOT EXISTS aula (

	id INTEGER NOT NULL DEFAULT NEXTVAL('aula_id_seq'),
	id_turma INTEGER NOT NULL,
	CONSTRAINT aula_pk PRIMARY KEY (id),

	CONSTRAINT aula_turma_id_turma_fk FOREIGN KEY (id_turma) REFERENCES turma (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO professor (nome) VALUES ('JOÃO');
INSERT INTO professor (nome) VALUES ('MARIA');
INSERT INTO professor (nome) VALUES ('CARLOS');

INSERT INTO sala (nome, corredor) VALUES ('Sala 01', 1);
INSERT INTO sala (nome, corredor) VALUES ('Sala 15', 4);
INSERT INTO sala (nome, corredor) VALUES ('Sala 23', 7);

INSERT INTO turma (id_sala, quantidade_alunos) VALUES (1, 20);
INSERT INTO turma (id_sala, quantidade_alunos) VALUES (3, 12);
INSERT INTO turma (id_sala, quantidade_alunos) VALUES (2, 34);

INSERT INTO aula (id_turma) VALUES (1);
INSERT INTO aula (id_turma) VALUES (2);
INSERT INTO aula (id_turma) VALUES (3);

INSERT INTO turma_professor (id_turma, id_professor) VALUES (1, 1);
INSERT INTO turma_professor (id_turma, id_professor) VALUES (1, 2);
INSERT INTO turma_professor (id_turma, id_professor) VALUES (2, 1);
INSERT INTO turma_professor (id_turma, id_professor) VALUES (3, 1);
INSERT INTO turma_professor (id_turma, id_professor) VALUES (3, 2);

SELECT * FROM professor;
SELECT * FROM sala;
SELECT * FROM aula;
SELECT * FROM turma;
SELECT * FROM turma_professor;