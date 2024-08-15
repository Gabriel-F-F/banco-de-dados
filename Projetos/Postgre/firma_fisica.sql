-- DROP MODO DEV
DROP TABLE IF EXISTS produto_pedido;
DROP SEQUENCE IF EXISTS produto_pedido_id_seq;

DROP TABLE IF EXISTS pessoa_fisica;
DROP SEQUENCE IF EXISTS pessoa_fisica_id_seq;
DROP TABLE IF EXISTS pessoa_juridica;
DROP SEQUENCE IF EXISTS pessoa_juridica_id_seq;
DROP TABLE IF EXISTS endereco;
DROP TABLE IF EXISTS pessoa;
DROP SEQUENCE IF EXISTS pessoa_id_seq;

DROP TABLE IF EXISTS pedido;
DROP SEQUENCE IF EXISTS pedido_id_seq;
DROP TABLE IF EXISTS produto;
DROP SEQUENCE IF EXISTS produto_id_seq;
DROP TABLE IF EXISTS categoria;
DROP SEQUENCE IF EXISTS categoria_id_seq;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TABELA CLIENTE
CREATE SEQUENCE IF NOT EXISTS pessoa_id_seq;

CREATE TABLE IF NOT EXISTS pessoa (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('pessoa_id_seq'),
	nome CHARACTER VARYING(100) NOT NULL,
	tipo_pessoa_1_Fisica_2_Juridica INTEGER NOT NULL,
	telefone CHARACTER VARYING(100) NOT NULL,
	status CHARACTER VARYING(100) NOT NULL,
	limite_credito NUMERIC NOT NULL,
	CONSTRAINT pessoa_pk PRIMARY KEY (codigo)
);

-- TABELA ENDEREÇO
CREATE TABLE IF NOT EXISTS endereco (

	tipo CHARACTER VARYING(100) NOT NULL,
	nome_endereco CHARACTER VARYING(100) NOT NULL,
	codigo_pessoa INTEGER NOT NULL,
	CONSTRAINT endereco_pessoa_codigo_pessoa_fk FOREIGN KEY (codigo_pessoa) REFERENCES pessoa (codigo)
);

-- TABELA PESSOA FÍSICA
CREATE SEQUENCE IF NOT EXISTS pessoa_fisica_id_seq;

CREATE TABLE IF NOT EXISTS pessoa_fisica (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('pessoa_fisica_id_seq'),
	codigo_pessoa INTEGER NOT NULL,
	cpf CHARACTER VARYING(100) NOT NULL,
	sexo CHARACTER VARYING(100) NOT NULL,
	CONSTRAINT pessoa_fisica_pk PRIMARY KEY (codigo),
	CONSTRAINT pessoa_fisica_pessoa_codigo_pessoa_fk FOREIGN KEY (codigo_pessoa) REFERENCES pessoa (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA PESSOA JURÍDICA
CREATE SEQUENCE IF NOT EXISTS pessoa_juridica_id_seq;

CREATE TABLE IF NOT EXISTS pessoa_juridica (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('pessoa_juridica_id_seq'),
	codigo_pessoa INTEGER NOT NULL,
	cnpj CHARACTER VARYING(100) NOT NULL,
	razao_social CHARACTER VARYING(100) NOT NULL,
	CONSTRAINT pessoa_juridica_pk PRIMARY KEY (codigo),
	CONSTRAINT pessoa_juridica_pessoa_codigo_pessoa_fk FOREIGN KEY (codigo_pessoa) REFERENCES pessoa (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TABELA CATEGORIA
CREATE SEQUENCE IF NOT EXISTS categoria_id_seq;

CREATE TABLE IF NOT EXISTS categoria (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('categoria_id_seq'),
	nome_categoria CHARACTER VARYING(100) NOT NULL,
	CONSTRAINT categoria_pk PRIMARY KEY (codigo)
);

-- TABELA PRODUTO
CREATE SEQUENCE IF NOT EXISTS produto_id_seq;

CREATE TABLE IF NOT EXISTS produto (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('produto_id_seq'),
	codigo_categoria INTEGER NOT NULL,
	nome_produto CHARACTER VARYING(100) NOT NULL,
	preco NUMERIC NOT NULL,
	CONSTRAINT produto_pk PRIMARY KEY (codigo),
	CONSTRAINT produto_categoria_codigo_categoria_fk FOREIGN KEY (codigo_categoria) REFERENCES categoria (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA PEDIDO
CREATE SEQUENCE IF NOT EXISTS pedido_id_seq;

CREATE TABLE IF NOT EXISTS pedido (

	numero_pedido INTEGER NOT NULL DEFAULT NEXTVAL('pedido_id_seq'),
	data_pedido DATE NOT NULL,
	CONSTRAINT pedido_pk PRIMARY KEY (numero_pedido)
);

-- TABELA PRODUTO_PEDIDO
CREATE SEQUENCE IF NOT EXISTS produto_pedido_id_seq;

CREATE TABLE IF NOT EXISTS produto_pedido (

	codigo_pedido INTEGER NOT NULL,
	codigo_produto INTEGER NOT NULL,
	compra_feita INTEGER NOT NULL DEFAULT NEXTVAL('produto_pedido_id_seq'),
	CONSTRAINT produto_pedido_pk PRIMARY KEY (compra_feita)
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- INSERTS NAS TABELAS

INSERT INTO pessoa (nome, tipo_pessoa_1_Fisica_2_Juridica, telefone, status, limite_credito)
VALUES
('Ana Silva', 1, '1234-5678', 'Bom', 5000.00),
('Empresa X Ltda', 2, '8765-4321', 'Ruim', 10000.00),
('Concessionária Alto-Rodas Ltda', 2, '53467-4631', 'Bom', 7500.00),
('Ana Silva', 1, '1234-5678', 'Médio', 3000.00);

INSERT INTO endereco (tipo, nome_endereco, codigo_pessoa)
VALUES
('Residencial', 'Rua das Flores', 1),
('Comercial', 'Av. Central', 2),
('Comercial', 'Av. Coral', 3),
('Residencial', 'Rua Almeida', 4);

INSERT INTO pessoa_fisica (codigo_pessoa, cpf, sexo)
VALUES
(1, '12345678901', 'F'),
(4, '98759435632', 'F');

INSERT INTO pessoa_juridica (codigo_pessoa, cnpj, razao_social)
VALUES
(2, '12345678000195', 'Empresa X Ltda'),
(3, '54361234363462', 'Concessionária Alto-Rodas Ltda');

INSERT INTO categoria (nome_categoria)
VALUES
('Eletrônicos'),
('Roupas'),
('Móveis');

INSERT INTO produto (codigo_categoria, nome_produto, preco)
VALUES
(1, 'Smartphone', 1500.00),
(2, 'Sofá', 2000.00),
(3, 'Casaco', 300.00);

INSERT INTO pedido (data_pedido)
VALUES
('2024-08-15'),
('2024-08-16');

INSERT INTO produto_pedido (codigo_pedido, codigo_produto)
VALUES
(1, 1), 
(1, 2); 

INSERT INTO produto_pedido (codigo_pedido, codigo_produto)
VALUES
(2, 2),
(2, 1);

INSERT INTO produto_pedido (codigo_pedido, codigo_produto)
VALUES
(2, 1);

INSERT INTO produto_pedido (codigo_pedido, codigo_produto)
VALUES
(3, 1),
(3, 2),
(3, 3),
(3, 3);

INSERT INTO produto_pedido (codigo_pedido, codigo_produto)
VALUES
(4, 1);