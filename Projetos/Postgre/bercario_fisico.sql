-- DROP MODO DEV
DROP TABLE IF EXISTS mae;
DROP SEQUENCE IF EXISTS mae_id_seq;
DROP TABLE IF EXISTS medico;
DROP SEQUENCE IF EXISTS medico_id_seq;
DROP TABLE IF EXISTS bebe;
DROP SEQUENCE IF EXISTS bebe_id_seq;

-- TABELA MÃE
CREATE SEQUENCE IF NOT EXISTS mae_id_seq;

CREATE TABLE IF NOT EXISTS mae (

	id INTEGER NOT NULL DEFAULT NEXTVAL('mae_id_seq'),
	nome CHARACTER VARYING(100) NOT NULL,
	endereco CHARACTER VARYING(100) NOT NULL,
	telefone CHARACTER VARYING(100) NOT NULL,
	dataNascimento DATE NOT NULL,
	excluido BOOLEAN DEFAULT false,

	CONSTRAINT mae_pk PRIMARY KEY (id)
);

-- TABELA MÉDICO
CREATE SEQUENCE IF NOT EXISTS medico_id_seq;

CREATE TABLE IF NOT EXISTS medico (

	id INTEGER NOT NULL DEFAULT NEXTVAL('medico_id_seq'),
	crm INTEGER NOT NULL,
	nome CHARACTER VARYING(100) NOT NULL,
	telefone_celular CHARACTER VARYING(100) NOT NULL,
	especialidade CHARACTER VARYING(100) NOT NULL,
	excluido BOOLEAN DEFAULT false,

	CONSTRAINT medico_pk PRIMARY KEY (id)
);

-- TABELA BEBÊ
CREATE SEQUENCE IF NOT EXISTS bebe_id_seq;

CREATE TABLE IF NOT EXISTS bebe (

	id INTEGER NOT NULL DEFAULT NEXTVAL('bebe_id_seq'),
	id_mae INTEGER NOT NULL,
	id_medico INTEGER NOT NULL,
	nome CHARACTER VARYING(100) NOT NULL,
	dataNascimento DATE NOT NULL,
	pesoNascimento DECIMAL NOT NULL,
	CONSTRAINT bebe_pk PRIMARY KEY (id),

	CONSTRAINT bebe_mae_id_mae_fk FOREIGN KEY (id_mae) REFERENCES mae (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT bebe_medico_id_medico_fk FOREIGN KEY (id_medico) REFERENCES medico (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO medico (crm, nome, telefone_celular, especialidade) VALUES (12345, 'João da Silva', '(48) 11111-1111', 'Pediatra');
INSERT INTO medico (crm, nome, telefone_celular, especialidade) VALUES (6789, 'Maria da Silva', '(48) 22222-2222', 'Oftamologista');
INSERT INTO medico (crm, nome, telefone_celular, especialidade) VALUES (13579, 'Carlos Adrino', '(48) 33333-3333', 'Cirurgião');
INSERT INTO medico (crm, nome, telefone_celular, especialidade) VALUES (51347, 'Clavisson José', '(48) 44444-4444', 'Anetesista');