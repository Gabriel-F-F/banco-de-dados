SELECT
	cliente_pf.nome AS nome_fisico,
	SUM(item_pedido.quantidade) AS quantidade_pedidos
FROM cliente_pf
INNER JOIN pedido ON (pedido.id_cliente = cliente_pf.id)
INNER JOIN item_pedido ON (item_pedido.id_pedido = pedido.id)
WHERE cliente_pf.id IN (SELECT pedido.id_cliente
	     FROM pedido
	     WHERE id_cliente = cliente_pf.id)
GROUP BY nome_fisico