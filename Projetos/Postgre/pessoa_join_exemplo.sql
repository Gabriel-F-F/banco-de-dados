CREATE TABLE IF NOT EXISTS pessoa (
    id SERIAL NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT un_pessoa_cpf UNIQUE (cpf)
);

CREATE TABLE IF NOT EXISTS estado (
	id SERIAL NOT NULL,
    sigla CHAR(2) NOT NULL UNIQUE,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS cidade (
	id SERIAL NOT NULL,
    id_estado INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_cidade_estado FOREIGN KEY (id_estado) REFERENCES estado (id)  ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS pessoa_completo (
	id INT NOT NULL,
    id_cidade INT NOT NULL,
    sexo CHAR(1) NULL,
    data_nascimento DATE NULL,
    email VARCHAR(100) NULL,
    celular VARCHAR(15) NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_pessoa_completo_cidade FOREIGN KEY (id_cidade) REFERENCES cidade (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT fk_pessoa_completo_pessoa FOREIGN KEY (id) REFERENCES pessoa (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION    
);

INSERT INTO estado (sigla, nome) VALUES ('SC', 'Santa Catarina');
INSERT INTO estado (sigla, nome) VALUES ('RS', 'Rio Grande do Sul');

INSERT INTO cidade (id_estado, nome) VALUES (1, 'Tubarão');
INSERT INTO cidade (id_estado, nome) VALUES (1, 'Gravatal');
INSERT INTO cidade (id_estado, nome) VALUES (1, 'Laguna');
INSERT INTO cidade (id_estado, nome) VALUES (2, 'Porto Alegre');
INSERT INTO cidade (id_estado, nome) VALUES (2, 'Caxias do Sul');

INSERT INTO pessoa (nome, cpf) VALUES ('FERNANDO MARTINS', '989.286.140-07');
INSERT INTO pessoa (nome, cpf) VALUES ('FELIPE CORREA', '539.720.720-90');
INSERT INTO pessoa (nome, cpf) VALUES ('JOAO PAULO SILVA', '514.792.580-59');
INSERT INTO pessoa (nome, cpf) VALUES ('MARCOS SILVEIRA', '617.038.430-10');
INSERT INTO pessoa (nome, cpf) VALUES ('CARLOS ROSA', '534.194.820-35');
INSERT INTO pessoa (nome, cpf) VALUES ('ADALTO MAY', '573.546.530-98');
INSERT INTO pessoa (nome, cpf) VALUES ('MARIA MARTA SANTOS', '228.711.850-00');
INSERT INTO pessoa (nome, cpf) VALUES ('MARLENE MATOS', '118.214.990-18');
INSERT INTO pessoa (nome, cpf) VALUES ('ISRAEL DONABELA', '930.114.250-35');
INSERT INTO pessoa (nome, cpf) VALUES ('DONALD NETO', '080.561.850-38');


INSERT INTO pessoa_completo (id, id_cidade, sexo, data_nascimento, email, celular) VALUES (1, 1, 'M', '1983-09-01', 'fernando.medeiros@edu.sc.senai.br', '(48) 99545-5478');
INSERT INTO pessoa_completo (id, id_cidade, sexo, data_nascimento, email, celular) VALUES (2, 2, 'M', '1983-08-25', 'felipe.correa@edu.sc.senai.br', '(48) 99545-5425');
INSERT INTO pessoa_completo (id, id_cidade, sexo, data_nascimento, email, celular) VALUES (3, 3, 'M', '1982-05-02', 'joao.paulo@edu.sc.senai.br', '(48) 99545-1237');
INSERT INTO pessoa_completo (id, id_cidade, sexo, data_nascimento, email, celular) VALUES (7, 4, 'F', '1988-03-20', 'maria.marta@edu.sc.senai.br', '(48) 99545-9874');
INSERT INTO pessoa_completo (id, id_cidade, sexo, data_nascimento, email, celular) VALUES (8, 5, 'F', '1990-01-18', 'marlene.matos@edu.sc.senai.br', '(48) 98545-5474');

----------------------------------------------------------------
SELECT * FROM pessoa
INNER JOIN pessoa_completo ON (pessoa.id = pessoa_completo.id)
----------------------------------------------------------------
SELECT * FROM pessoa
INNER JOIN pessoa_completo pc ON (pessoa.id = pc.id)
-- RENOMEAR TABELAS --------------------------------------------
SELECT
	pessoa.id AS id_pessoa,
	pc.id AS id_pessoa_completo
FROM pessoa
INNER JOIN pessoa_completo pc ON (pessoa.id = pc.id)
----------------------------------------------------------------
SELECT
	pessoa.id,
	pessoa.nome AS pessoa_nome,
	pessoa.cpf,
	pc.sexo,
	pc.data_nascimento,
	pc.email,
	pc.celular,
	cidade.nome AS cidade_nome,
	estado.nome AS estado_nome
FROM pessoa
INNER JOIN pessoa_completo pc ON (pessoa.id = pc.id)
-- LEFT JOIN pessoa_completo pc ON (pessoa.id = pc.id)
LEFT JOIN cidade ON (cidade.id = pc.id_cidade)
LEFT JOIN estado ON (estado.id = cidade.id_estado)
----------------------------------------------------------------