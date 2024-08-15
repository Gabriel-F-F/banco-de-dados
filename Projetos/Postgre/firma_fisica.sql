-- DROP MODO DEV

-- TABELA CLIENTE
CREATE SEQUENCE IF NOT EXISTS cliente_id_seq;

CREATE TABLE IF NOT EXISTS pessoa (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('pessoa_id_seq'),
	nome CHARACTER VARYING(100) NOT NULL,
	tipo_pessoa (1- Fisica, 2- Juridica) INTEGER NOT NULL,
	telefone CHARACTER VARYING(100) NOT NULL,
	status CHARACTER VARYING(5) NOT NULL,
	limite_credito NUMERIC NOT NULL,
	CONSTRAINT pessoa_pk PRIMARY KEY (codigo)
);

-- TABELA ENDEREÇO
CREATE TABLE IF NOT EXISTS endereco (

	tipo CHARACTER VARYING(100) NOT NULL,
	nome_endereco CHARACTER VARYING(100) NOT NULL,
	codigo_cliente INTEGER NOT NULL,
	CONSTRAINT endereco_cliente_codigo_cliente_fk FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo)
);

-- TABELA PESSOA FÍSICA
CREATE SEQUENCE IF NOT EXISTS pessoa_fisica_id_seq;

CREATE TABLE IF NOT EXISTS pessoa_fisica (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('pessoa_fisica_id_seq'),
	codigo_pessoa INTEGER NOT NULL,
	cpf INTEGER NOT NULL,
	sexo CHARACTER VARYING(100) NOT NULL,
	CONSTRAINT pessoa_fisica_pk PRIMARY KEY (codigo),
	CONSTRAINT pessoa_fisica_pessoa_codigo_pessoa_fk FOREIGN KEY (codigo_pessoa) REFERENCES pessoa (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA PESSOA JURÍDICA
CREATE SEQUENCE IF NOT EXISTS pessoa_juridica_id_seq;

CREATE TABLE IF NOT EXISTS pessoa_juridica (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('pessoa_juridica_id_seq'),
	codigo_pessoa INTEGER NOT NULL,
	cnpj INTEGER NOT NULL,
	razao_social CHARACTER VARYING(100) NOT NULL,
	CONSTRAINT pessoa_juridica_pk PRIMARY KEY (codigo),
	CONSTRAINT pessoa_juridica_pessoa_codigo_pessoa_fk FOREIGN KEY (codigo_pessoa) REFERENCES pessoa (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
);







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
	CONSTRAINT produto_pk PRIMARY KEY (numero_pedido)
);

-- TABELA PRODUTO_PEDIDO
CREATE SEQUENCE IF NOT EXISTS produto_pedido_id_seq;

CREATE TABLE IF NOT EXISTS produto_pedido (

	codigo_pedido INTEGER NOT NULL,
	codigo_produto INTEGER NOT NULL,
	compra_feita INTEGER NOT NULL DEFAULT NEXTVAL('produto_pedido_id_seq'),
	CONSTRAINT produto_pedido_pk PRIMARY KEY (compra_feita)
);