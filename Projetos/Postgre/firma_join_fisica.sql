-- JOINS

-- item de venda -> relacionar com pedido e produto
-- organizar o nome as colunas e tabelas

SELECT 
	pedido.id,
	pedido.data_pedido,
	ip.sequencial,
	ip.codigo_barra,
	produto.nome AS nome_produto,
	ip.quantidade,
	ip.valor_unitario,
	(ip.quantidade * ip.valor_unitario) AS valor_total,
	fp.nome
FROM item_pedido ip
INNER JOIN produto ON (produto.codigo_barra = ip.codigo_barra)
INNER JOIN pedido ON (ip.id_pedido = pedido.id)
INNER JOIN forma_pagamento fp ON (fp.id = pedido.id_forma_pagamento)

-- relacionar o cliente com cliente_pf e cliente pj
-- listar apenas clientes pessoa fisica

SELECT 
	pf.nome AS nome_pessoa_fisica,
	pf.cpf,
	pf.data_nascimento,
	pf.sexo
FROM cliente
INNER JOIN cliente_pf pf ON (cliente.id = pf.id)

-- listar apenas clientes pessoa juridica

SELECT 
	pj.nome_fantasia, 
	pj.razao_social,
	pj.cnpj,
	pj.incricao_estadual
FROM cliente
INNER JOIN cliente_pj pj ON (cliente.id = pj.id)

-- listas tudo das 3 tabelas

SELECT 
	cliente.whatsapp AS cliente_whatsapp,
	cliente.email AS cliente_email,
	pf.nome AS nome_pessoa_fisica,
	pf.cpf,
	pf.data_nascimento,
	pj.nome_fantasia AS nome_fantasia_pessoa_juridica, 
	pj.razao_social, 
	pj.cnpj
FROM cliente
LEFT JOIN cliente_pf pf ON (pf.id = cliente.id)
LEFT JOIN cliente_pj pj ON (pj.id = cliente.id)