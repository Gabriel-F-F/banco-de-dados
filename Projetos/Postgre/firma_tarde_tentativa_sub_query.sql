SELECT
	cliente_pf.nome AS nome,
	cliente_pj.razao_social AS nome
FROM cliente
LEFT JOIN cliente_pf ON (cliente_pf.id = cliente.id)
LEFT JOIN cliente_pj ON (cliente_pj.id = cliente.id)
INNER JOIN pedido ON (pedido.id_cliente = cliente.id)
WHERE cliente.id IN (
SELECT
	pedido.id
FROM pedido
WHERE pedido.id_cliente = cliente.id);
