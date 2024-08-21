--REMOVE OBJETOS (SOMENTE EM MODO DEV)
DROP TABLE IF EXISTS item_pedido;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS forma_pagamento;
DROP TABLE IF EXISTS endereco;
DROP TABLE IF EXISTS cliente_pf;
DROP TABLE IF EXISTS cliente_pj;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS categoria;
DROP SEQUENCE IF EXISTS item_pedido_id_seq;
DROP SEQUENCE IF EXISTS forma_pagamento_id_seq;
DROP SEQUENCE IF EXISTS cliente_id_seq;
DROP SEQUENCE IF EXISTS categoria_id_seq;

--DDL's

-- TABELA CATEGORIA
CREATE SEQUENCE categoria_id_seq;

CREATE TABLE categoria
(
  id INTEGER NOT NULL DEFAULT nextval('categoria_id_seq'),
  nome CHARACTER VARYING(100) NOT NULL,
  CONSTRAINT categoria_pk PRIMARY KEY (id)
);


-- TABELA PRODUTO
CREATE TABLE produto
(
  codigo_barra BIGINT NOT NULL,
  nome CHARACTER VARYING(100) NOT NULL,
  id_categoria INTEGER NOT NULL,
  valor_venda NUMERIC(10,2) NOT NULL,
  ativo BOOLEAN NOT NULL DEFAULT true,
  estoque INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT produto_pk PRIMARY KEY (codigo_barra),
  CONSTRAINT produto_categoria_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES categoria (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA CLIENTE
CREATE SEQUENCE cliente_id_seq;

CREATE TABLE cliente (
    id INTEGER NOT NULL DEFAULT nextval('cliente_id_seq'),
    whatsapp CHARACTER VARYING(15),
    email CHARACTER VARYING(50),
    CONSTRAINT cliente_pk PRIMARY KEY (id)
);

-- CLIENTE PF
CREATE TABLE cliente_pf (
    id INTEGER NOT NULL,
    nome CHARACTER VARYING(150) NOT NULL,
    cpf CHARACTER VARYING(14) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo CHAR(1),
    ativo BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT cliente_pf_pk PRIMARY KEY (id),
    CONSTRAINT cliente_pf_cliente_id_fkey FOREIGN KEY (id) REFERENCES cliente (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);


-- CLIENTE PJ
CREATE TABLE cliente_pj (
    id INTEGER NOT NULL,
    nome_fantasia CHARACTER VARYING(150) NOT NULL,
    razao_social CHARACTER VARYING(150) NOT NULL,
    cnpj CHARACTER VARYING(18) NOT NULL,
    incricao_estadual CHARACTER VARYING(18) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT cliente_pj_pk PRIMARY KEY (id),
    CONSTRAINT cliente_pj_cliente_id_fkey FOREIGN KEY (id) REFERENCES cliente (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA ENDERECO
CREATE TABLE endereco (
    id_pessoa INTEGER NOT NULL,
    tipo INTEGER NOT NULL,  --1 - RESIDENCIAL, 2 - COMERCIAL
    endereco CHARACTER VARYING(80) NOT NULL,
    numero INTEGER,
    complemento CHARACTER VARYING(40),
    bairro CHARACTER VARYING(40) NOT NULL,
    cidade CHARACTER VARYING(40) NOT NULL,
    estado CHAR(2),
    cep CHARACTER VARYING(10),
    CONSTRAINT endereco_pk PRIMARY KEY (id_pessoa, tipo),
    CONSTRAINT endereco_cliente_id_pessoa_fkey FOREIGN KEY (id_pessoa) REFERENCES cliente (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA FORMA DE PAGAMENTO
CREATE SEQUENCE forma_pagamento_id_seq;

CREATE TABLE forma_pagamento
(
  id INTEGER NOT NULL DEFAULT nextval('forma_pagamento_id_seq'),
  nome CHARACTER VARYING(100) NOT NULL,
  CONSTRAINT forma_pagamento_pk PRIMARY KEY (id)
);

-- TABELA PEDIDO
CREATE TABLE pedido (
    id integer NOT NULL,
    data_pedido TIMESTAMP NOT NULL,
    id_cliente INTEGER,
    id_forma_pagamento INTEGER,
    CONSTRAINT pedido_pk PRIMARY KEY (id),
    CONSTRAINT pedido_cliente_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES cliente (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT pedido_forma_pagamento_id_forma_pagamento_fkey FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA ITEM DO PEDIDO

CREATE TABLE item_pedido (
    id_pedido INTEGER NOT NULL,
    sequencial INTEGER NOT NULL,
    codigo_barra BIGINT NOT NULL,
    quantidade INTEGER NOT NULL,
    valor_unitario NUMERIC(14,2) NOT NULL,
    CONSTRAINT item_pedido_pk PRIMARY KEY (id_pedido, sequencial),
    CONSTRAINT item_pedido_pedido_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES pedido (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT item_pedido_produto_codigo_barra_fkey FOREIGN KEY (codigo_barra) REFERENCES produto (codigo_barra) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- DML's
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 99999-9991', 'email_pf_1@email.com');
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 99999-9992', 'email_pf_2@email.com');
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 99999-9993', 'email_pf_3@email.com');
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 99999-9994', 'email_pf_4@email.com');
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 99999-9995', 'email_pf_5@email.com');
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 99999-9996', 'email_pf_6@email.com');
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 99999-9997', 'email_pf_7@email.com');
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 99999-9998', 'email_pf_8@email.com');
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 99999-9999', 'email_pf_9@email.com');
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 99999-9910', 'email_pf_10@email.com');

INSERT INTO cliente (whatsapp, email) VALUES ('(48) 98888-9911', 'email_pj_11@email.com');
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 98888-9912', 'email_pj_12@email.com');
INSERT INTO cliente (whatsapp, email) VALUES ('(48) 98888-9913', 'email_pj_13@email.com');

INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (1,  2, 'RUA PESSOA FISICA 1',  1,'', 'BAIRRO PESSOA FISICA 1', 'CIDADE PESSOA FISICA 1', 'SC', '88888-881');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (2,  1, 'RUA PESSOA FISICA 2',  2,'', 'BAIRRO PESSOA FISICA 2', 'CIDADE PESSOA FISICA 2', 'SC', '88888-882');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (3,  1, 'RUA PESSOA FISICA 3',  3,'', 'BAIRRO PESSOA FISICA 3', 'CIDADE PESSOA FISICA 3', 'SC', '88888-883');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (4,  1, 'RUA PESSOA FISICA 4',  4,'', 'BAIRRO PESSOA FISICA 4', 'CIDADE PESSOA FISICA 4', 'SC', '88888-884');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (5,  1, 'RUA PESSOA FISICA 5',  5,'', 'BAIRRO PESSOA FISICA 5', 'CIDADE PESSOA FISICA 5', 'SC', '88888-885');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (6,  1, 'RUA PESSOA FISICA 6',  6,'', 'BAIRRO PESSOA FISICA 6', 'CIDADE PESSOA FISICA 6', 'SC', '88888-886');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (7,  1, 'RUA PESSOA FISICA 7',  7,'', 'BAIRRO PESSOA FISICA 7', 'CIDADE PESSOA FISICA 7', 'SC', '88888-887');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (8,  1, 'RUA PESSOA FISICA 8',  8,'', 'BAIRRO PESSOA FISICA 8', 'CIDADE PESSOA FISICA 8', 'SC', '88888-888');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (9,  1, 'RUA PESSOA FISICA 9',  9,'', 'BAIRRO PESSOA FISICA 9', 'CIDADE PESSOA FISICA 9', 'SC', '88888-889');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (10, 1, 'RUA PESSOA FISICA 10', 10, '', 'BAIRRO PESSOA FISICA 10', 'CIDADE PESSOA FISICA 10', 'SC', '88888-810');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (11, 1, 'RUA PESSOA FISICA 11', 11, '', 'BAIRRO PESSOA FISICA 11', 'CIDADE PESSOA FISICA 11', 'SC', '88888-811');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (12, 1, 'RUA PESSOA FISICA 12', 12, '', 'BAIRRO PESSOA FISICA 12', 'CIDADE PESSOA FISICA 12', 'SC', '88888-812');
INSERT INTO endereco (id_pessoa, tipo, endereco, numero, complemento, bairro, cidade, estado, cep) VALUES (13, 1, 'RUA PESSOA FISICA 13', 13, '', 'BAIRRO PESSOA FISICA 13', 'CIDADE PESSOA FISICA 13', 'SC', '88888-813');

INSERT INTO cliente_pf (id, nome, cpf, data_nascimento, sexo) VALUES (1, 'Jaqueline Luana Tereza Ramos', '028.979.039-53', '1947-03-14', 'F');
INSERT INTO cliente_pf (id, nome, cpf, data_nascimento, sexo) VALUES (2, 'Giovana Ester Antonella Rodrigues', '518.397.679-10', '1953-07-26', 'F');
INSERT INTO cliente_pf (id, nome, cpf, data_nascimento, sexo) VALUES (3, 'Stefany Jennifer Assis', '417.760.779-70', '1969-10-08', 'F');
INSERT INTO cliente_pf (id, nome, cpf, data_nascimento, sexo) VALUES (4, 'Guilherme Lucca Hugo Cardoso', '405.243.389-06', '1978-06-23', 'M');
INSERT INTO cliente_pf (id, nome, cpf, data_nascimento, sexo) VALUES (5, 'Isadora Patrícia de Paula', '367.206.539-03', '2003-11-24', 'F');
INSERT INTO cliente_pf (id, nome, cpf, data_nascimento, sexo) VALUES (6, 'Bruno Henry Benedito Silveira', '629.267.199-22', '1999-08-02', 'M');
INSERT INTO cliente_pf (id, nome, cpf, data_nascimento, sexo) VALUES (7, 'Cristiane Isabella Rita Sales', '591.064.669-90', '1988-04-10', 'F');
INSERT INTO cliente_pf (id, nome, cpf, data_nascimento, sexo) VALUES (8, 'Natália Alícia Antônia Rodrigues', '677.976.579-12', '1985-10-12', 'F');
INSERT INTO cliente_pf (id, nome, cpf, data_nascimento, sexo) VALUES (9, 'Ricardo Henrique Edson da Mota', '786.125.779-77', '1957-05-11', 'M');
INSERT INTO cliente_pf (id, nome, cpf, data_nascimento, sexo) VALUES (10, 'Diego Rafael Giovanni Rodrigues', '919.630.769-23', '1989-06-20', 'M');

INSERT INTO cliente_pj (id, nome_fantasia, razao_social, cnpj, incricao_estadual) VALUES (11, 'Empresa 11', 'Empresa 11 LTDA.', '30.652.225/0001-93', '123456');
INSERT INTO cliente_pj (id, nome_fantasia, razao_social, cnpj, incricao_estadual) VALUES (12, 'Empresa 12', 'Empresa 12 LTDA.', '27.544.084/0001-80', '654321');
INSERT INTO cliente_pj (id, nome_fantasia, razao_social, cnpj, incricao_estadual) VALUES (13, 'Empresa 13', 'Empresa 13 LTDA.', '64.640.870/0001-08', '987654');

INSERT INTO categoria (nome) VALUES ('HORTIFRÚTI');
INSERT INTO categoria (nome) VALUES ('PADARIA');
INSERT INTO categoria (nome) VALUES ('AÇOUGUE');
INSERT INTO categoria (nome) VALUES ('LATICÍNIOS');
INSERT INTO categoria (nome) VALUES ('MERCERIA');
INSERT INTO categoria (nome) VALUES ('LIMPEZA');
INSERT INTO categoria (nome) VALUES ('HIGIENE PESSOAL');
INSERT INTO categoria (nome) VALUES ('PRODUTOS CONGELADOS');
INSERT INTO categoria (nome) VALUES ('BEDIDAS');
INSERT INTO categoria (nome) VALUES ('ADEGA');

INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000001, 8.90, 'MAÇA', 1, 1000, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000002, 6.69, 'PERA', 1, 1000, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000003, 10.49, 'ABACATE', 1, 1000, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000004, 14.99, 'PÃO DAGUA', 2, 100, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000005, 6.00, 'ROSCA', 2, 150, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000006, 79.90, 'PICANHA', 3, 30, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000007, 39.90, 'PONTA DE LOMBO', 3, 35, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000008, 9.99, 'QUEIJO 150MG', 4, 40, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000009, 17.49, 'LEITE EM PÓ NINHO INTEGRAL LATA 380G', 5, 45, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000010, 8.99, 'DESINFETANTE PINHO BRIL 500ML', 6, 50, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000011, 17.39, 'DESODORANTE REXONA WOMEN ACTIVE 150ML', 7, 50, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000012, 21.99, 'MUSSARELA PECA 400G SCALA', 8, 55, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000013, 49.90, 'VERMOUTH CORTEZANO TINTO 900 ML', 9, 60, true);
INSERT INTO produto (codigo_barra, valor_venda, nome, id_categoria, estoque, ativo) VALUES (7890000000014, 34.90, 'VINHO SAINT GERMAIN CABERNET MERLOT TINTO SUAVE 750ML', 10, 65, true);

INSERT INTO forma_pagamento (nome) VALUES ('DINHEIRO');
INSERT INTO forma_pagamento (nome) VALUES ('CARTÃO');
INSERT INTO forma_pagamento (nome) VALUES ('PIX');
INSERT INTO forma_pagamento (nome) VALUES ('CREDIÁRIO');

INSERT INTO pedido (id, data_pedido, id_cliente, id_forma_pagamento) VALUES (1, '2024-08-14 08:21:00', 1, 3);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (1, 1, 7890000000001, 3, 8.9);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (1, 2, 7890000000008, 1, 9.99);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (1, 3, 7890000000014, 1, 34.90);

INSERT INTO pedido (id, data_pedido, id_cliente, id_forma_pagamento) VALUES (2, '2024-08-14 07:21:00', 5, 3);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (2, 1, 7890000000006, 1, 79.90);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (2, 2, 7890000000007, 1, 39.90);

INSERT INTO pedido (id, data_pedido, id_cliente, id_forma_pagamento) VALUES (3, '2024-08-14 07:21:00', 3, 1);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (3, 1, 7890000000006, 1, 79.90);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (3, 2, 7890000000007, 1, 39.90);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (3, 3, 7890000000001, 3, 8.9);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (3, 4, 7890000000008, 1, 9.99);

INSERT INTO pedido (id, data_pedido, id_cliente, id_forma_pagamento) VALUES (4, '2024-08-14 07:21:00', 6, 1);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (4, 1, 7890000000006, 1, 79.90);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (4, 2, 7890000000007, 1, 39.90);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (4, 3, 7890000000008, 1, 9.99);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (4, 4, 7890000000008, 1, 9.99);

INSERT INTO pedido (id, data_pedido, id_cliente, id_forma_pagamento) VALUES (5, '2024-08-14 07:21:00', 2, 2);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (5, 1, 7890000000006, 1, 79.90);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (5, 2, 7890000000001, 3, 8.9);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (5, 3, 7890000000007, 1, 39.90);

INSERT INTO pedido (id, data_pedido, id_cliente, id_forma_pagamento) VALUES (6, '2024-08-14 07:21:00', 1, 4);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (6, 1, 7890000000006, 1, 79.90);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (6, 2, 7890000000007, 1, 39.90);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (6, 3, 7890000000001, 3, 8.9);
INSERT INTO item_pedido (id_pedido, sequencial, codigo_barra, quantidade, valor_unitario) VALUES (6, 4, 7890000000008, 1, 9.99);

-- SELECT -----------------------------------------------------------------------------------------------------------------------------

SELECT 
	forma_pagamento.nome AS forma_pagamento,
	COUNT(*) AS quantidade_comprada,
	SUM(quantidade * valor_unitario) AS valor_compras
FROM item_pedido
INNER JOIN pedido ON (pedido.id = item_pedido.id_pedido)
INNER JOIN forma_pagamento ON (pedido.id_forma_pagamento = forma_pagamento.id)
GROUP BY forma_pagamento.nome

SELECT 
	categoria.nome AS categoria_produto,
	SUM(produto.estoque) AS produtos_total
FROM produto
INNER JOIN categoria ON (categoria.id = produto.id_categoria)
GROUP BY categoria.nome