-- DROPS MODO DEV
DROP TABLE IF EXISTS contas_a_pagar;
DROP SEQUENCE IF EXISTS contas_a_pagar_codigo_seq;
DROP TABLE IF EXISTS forma_pagamento;
DROP SEQUENCE IF EXISTS forma_pagamento_codigo_seq;
DROP TABLE IF EXISTS locacao;
DROP TABLE IF EXISTS carro;
DROP TABLE IF EXISTS caminhao;
DROP TABLE IF EXISTS veiculo;
DROP SEQUENCE IF EXISTS veiculo_codigo_seq;
DROP TABLE IF EXISTS categoria;
DROP SEQUENCE IF EXISTS categoria_codigo_seq;
DROP TABLE IF EXISTS cliente;

-- VEÍCULOS ----------------------------------------------------------------------------------------------------------------------------------

 -- TABELA CATEGORIA
CREATE SEQUENCE IF NOT EXISTS categoria_codigo_seq;

CREATE TABLE IF NOT EXISTS categoria (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('categoria_codigo_seq'),
	nome_categoria CHARACTER VARYING(30) NOT NULL,

	CONSTRAINT categoria_pk PRIMARY KEY (codigo)
);

-- TABELA VEICULO
CREATE SEQUENCE IF NOT EXISTS veiculo_codigo_seq;

CREATE TABLE IF NOT EXISTS veiculo (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('veiculo_codigo_seq'),
	ano DATE NOT NULL,
	marca CHARACTER VARYING(30) NOT NULL,
	modelo CHARACTER VARYING(30) NOT NULL,
	chassi CHARACTER VARYING(30) NOT NULL,
	valor_de_locacao NUMERIC(10, 2) NOT NULL,
	placa CHARACTER VARYING(10) NOT NULL,
	codigo_categoria INTEGER NOT NULL,

	CONSTRAINT veiculo_pk PRIMARY KEY (codigo),
	CONSTRAINT veiculo_categoria_codigo_categoria_fk FOREIGN KEY (codigo_categoria) REFERENCES categoria (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA CARRO
CREATE TABLE IF NOT EXISTS carro (

	codigo INTEGER NOT NULL,
	tamanho_bagageiro_litros NUMERIC(10, 2) NOT NULL,
	hibrido_ou_nao CHARACTER VARYING(30) NOT NULL,

	CONSTRAINT veiculo_carro_pk PRIMARY KEY (codigo),
	CONSTRAINT carro_veiculo_codigo_veiculo_fk FOREIGN KEY (codigo) REFERENCES veiculo (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA CAMINHÃO
CREATE TABLE IF NOT EXISTS caminhao (

	codigo INTEGER NOT NULL,
	truncado_ou_nao CHARACTER VARYING(30) NOT NULL,
	tipo_carroceria CHARACTER VARYING(30) NOT NULL,

	CONSTRAINT veiculo_caminhao_pk PRIMARY KEY (codigo),
	CONSTRAINT caminhao_veiculo_codigo_veiculo_fk FOREIGN KEY (codigo) REFERENCES veiculo (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA CLIENTE ----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS cliente (

	nome CHARACTER VARYING(100) NOT NULL,
	cpf NUMERIC NOT NULL,
	celular CHARACTER VARYING(30) NOT NULL,
	numero_cnh INTEGER NOT NULL,
	cartao_de_credito INTEGER NOT NULL,
	
	CONSTRAINT cliente_pk PRIMARY KEY (cpf)
);

 -- LOCAÇÃO ----------------------------------------------------------------------------------------------------------------------------------
 
 -- TABELA LOCAÇÃO
CREATE TABLE IF NOT EXISTS locacao (

	cpf_cliente NUMERIC NOT NULL,
	codigo_veiculo INTEGER NOT NULL,
	data_locacao DATE NOT NULL,
	data_devolucao DATE NOT NULL,

	CONSTRAINT locacao_pk PRIMARY KEY (data_locacao, codigo_veiculo),
	CONSTRAINT locacao_veiculo_codigo_veiculo_fk FOREIGN KEY (codigo_veiculo) REFERENCES veiculo (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- TABELA FORMA DE PAGAMENTO
CREATE SEQUENCE IF NOT EXISTS forma_pagamento_codigo_seq;

CREATE TABLE IF NOT EXISTS forma_pagamento (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('forma_pagamento_codigo_seq'),
	nome CHARACTER VARYING(20) NOT NULL,

	CONSTRAINT forma_pagamento_pk PRIMARY KEY (codigo)
);

-- TABELA CONTAS A PAGAR
CREATE SEQUENCE IF NOT EXISTS contas_a_pagar_codigo_seq;

CREATE TABLE IF NOT EXISTS contas_a_pagar (

	codigo INTEGER NOT NULL DEFAULT NEXTVAL('contas_a_pagar_codigo_seq'),
	valor_locacao NUMERIC(10, 2) NOT NULL,
	desconto NUMERIC NOT NULL,
	data_vencimento DATE NOT NULL,
	data_pagamento DATE NOT NULL,
	codigo_forma_pagamento INTEGER NOT NULL,

	CONSTRAINT contas_a_pagar_pk PRIMARY KEY (codigo),
	CONSTRAINT contas_a_pagar_forma_pagamento_codigo_forma_pagamento_fk FOREIGN KEY (codigo_forma_pagamento) REFERENCES forma_pagamento (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- INSERTS -----------------------------------------------------------------------------------------------------------------------------------

INSERT INTO categoria (nome_categoria) VALUES ('Popular'), ('Luxo'), ('Transporte');

INSERT INTO veiculo (ano, marca, modelo, chassi, valor_de_locacao, placa, codigo_categoria) VALUES
('2000-09-28', 'Marca1', 'Modelo1', 'Chassi1', 400.50, 12345, 1),
('2024-05-10', 'Marca2', 'Modelo2', 'Chassi2', 700.00, 67890, 2),
('2013-03-12', 'Marca3', 'Modelo3', 'Chassi3', 635.00, 24680, 3);

INSERT INTO carro (codigo, tamanho_bagageiro_litros, hibrido_ou_nao) VALUES
(1, 10.00, 'Não é Híbrido'),
(2, 20.00, 'É Híbrido');

INSERT INTO caminhao (codigo, truncado_ou_nao, tipo_carroceria) VALUES
(3, 'É Truncado', 'Caçamba');

INSERT INTO cliente (nome, cpf, celular, numero_cnh, cartao_de_credito) VALUES 
('José da Silva', 11111111111, '(48)11111-1111', 11111, 111),
('Britney Spears', 22222222222, '(48)22222-2222', 22222, 222),
('Carlos Roberto', 33333333333, '(48)33333-3333', 33333, 333);

INSERT INTO locacao (cpf_cliente, codigo_veiculo , data_locacao, data_devolucao) VALUES
(11111111111, 1, '2024-08-14', '2024-08-20'),
(22222222222, 2, '2024-08-15', '2024-09-10'),
--(22222222222, 1, '2024-08-14', '2024-09-10'), -- Teste Veículo alugado no mesmo dia
(22222222222, 1, '2024-08-15', '2024-09-10'),
(33333333333, 3, '2024-08-16', '2024-08-23');

INSERT INTO forma_pagamento (nome) VALUES
('Cartão de Crédito'),
('Cartão de Débito'),
('Boleto'),
('PIX');

INSERT INTO contas_a_pagar (valor_locacao, desconto, data_vencimento, data_pagamento, codigo_forma_pagamento) VALUES
(400.50, 5, '2024-08-13', '2024-08-13', 2),
(700.00, 10, '2024-08-14', '2024-08-14', 4),
(400.50, 10, '2024-08-14', '2024-08-14', 4),
(635.00, 3, '2024-08-15', '2024-08-15', 3);