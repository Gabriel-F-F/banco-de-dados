SELECT *
FROM item_pedido
WHERE valor_unitario > 30;

SELECT *
FROM item_pedido
WHERE NOT (valor_unitario > 30
AND valor_unitario < 40);

SELECT *
FROM item_pedido
WHERE (valor_unitario >= 50 OR valor_unitario <= 10)
AND quantidade = 1;

SELECT *
FROM item_pedido
WHERE (valor_unitario >= 50 OR valor_unitario <= 10)
AND quantidade <> 1;

SELECT *
FROM cliente_pf
WHERE id >= 4
AND id <= 6;

SELECT *
FROM cliente_pf
WHERE data_nascimento >= '1980-01-01'
AND data_nascimento <= '1989-12-31';

SELECT *
FROM cliente_pf
WHERE id BETWEEN 4 AND 6;

SELECT *
FROM cliente_pf
WHERE data_nascimento BETWEEN '1980-01-01' AND '1989-12-31';

SELECT *
FROM cliente_pf
WHERE data_nascimento > '1990-01-01';

SELECT *
FROM cliente_pf
WHERE id IN (4,6);

SELECT *
FROM cliente_pf
WHERE nome LIKE 'Guilherme%';

SELECT *
FROM cliente_pf
WHERE nome LIKE '%Mota';

SELECT *
FROM cliente_pf
WHERE nome LIKE '%Edson%';

SELECT *
FROM cliente_pf
WHERE nome ILIKE '%edson%';

SELECT *
FROM cliente_pf
WHERE ativo IS TRUE
ORDER BY data_nascimento DESC, nome;

--------------- AGRUPAMENTO ------------------

SELECT DISTINCT sexo
FROM cliente_pf;

SELECT id, nome, 'FISICA'::VARCHAR AS tipo
FROM cliente_pf
UNION ALL
SELECT id, razao_social, 'JURIDICA'::VARCHAR AS tipo
FROM cliente_pj;

SELECT COUNT(*) AS contador
FROM cliente_pf;

SELECT COUNT(DISTINCT sexo) AS contador_sexo
FROM cliente_pf;

SELECT SUM(quantidade * valor_unitario) AS total_compra
FROM item_pedido;

SELECT AVG(quantidade * valor_unitario) AS ticket_medio
FROM item_pedido;

SELECT ROUND(AVG(quantidade * valor_unitario), 2) AS ticket_medio
FROM item_pedido;

SELECT MAX(valor_unitario)
FROM item_pedido;

SELECT MIN(valor_unitario)
FROM item_pedido;

SELECT MAX(id) + 1 AS proximo_valor
FROM cliente;

SELECT COALESCE(MAX(id), 0) + 1 AS proximo_valor
FROM cliente;

SELECT * FROM item_pedido;
SELECT * FROM pedido;

SELECT
    id_pedido AS pedido,
    COUNT(*) AS quantidade_itens,
    SUM(quantidade * valor_unitario) AS valor_compras
FROM item_pedido
GROUP BY id_pedido;

SELECT
    cliente_pf.nome AS nome,
    COUNT(DISTINCT item_pedido.id_pedido) AS quantidade_pedidos,
    COUNT(*) AS quantidade_itens,
    SUM(quantidade * valor_unitario) AS valor_compras
FROM item_pedido
         INNER JOIN pedido ON (pedido.id = item_pedido.id_pedido)
         INNER JOIN cliente_pf ON (cliente_pf.id = pedido.id_cliente)
GROUP BY cliente_pf.nome;
--HAVING COUNT(DISTINCT item_pedido.id_pedido) > 1
