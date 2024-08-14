-- DROP MODO DEV
DROP TABLE IF EXISTS bebe;
DROP SEQUENCE IF EXISTS bebe_id_seq;
DROP TABLE IF EXISTS mae;
DROP SEQUENCE IF EXISTS mae_id_seq;
DROP TABLE IF EXISTS medico;
DROP SEQUENCE IF EXISTS medico_id_seq;

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
INSERT INTO medico (crm, nome, telefone_celular, especialidade) VALUES (51347, 'Clavisson José', '(48) 44444-4444', 'Anetesista');

INSERT INTO mae (nome, endereco, telefone, dataNascimento) VALUES ('Maria Joaquina', 'Avenida Pedroso', '(48) 11111-1111', '1989-09-28');
INSERT INTO mae (nome, endereco, telefone, dataNascimento) VALUES ('Valmira Duarte', 'Rua das Gaivotas', '(48) 22222-2222', '1992-04-12');
INSERT INTO mae (nome, endereco, telefone, dataNascimento) VALUES ('Ana Paula', 'BR-101', '(48) 33333-33333', '1995-02-10');

INSERT INTO bebe (id_mae, id_medico, nome, dataNascimento, pesoNascimento) VALUES (1, 1, 'Pedrinho', '2023-09-23', 1.65);
INSERT INTO bebe (id_mae, id_medico, nome, dataNascimento, pesoNascimento) VALUES (2, 1, 'Zézinho', '2022-03-01', 1.78);
INSERT INTO bebe (id_mae, id_medico, nome, dataNascimento, pesoNascimento) VALUES (3, 3, 'Franjinha', '2020-05-12', 1.54);
INSERT INTO bebe (id_mae, id_medico, nome, dataNascimento, pesoNascimento) VALUES (3, 2, 'Franjinha', '2020-05-12', 1.54);