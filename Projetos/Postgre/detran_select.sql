SELECT 
    ano.id AS id_ano,
    tipo.nome AS tipo,
    marca.nome AS marca,
    modelo.nome AS modelo,
    combustivel.nome AS combustivel,
    ano.ano_fabricacao,
    ano.valor::MONEY AS valor
FROM ano
INNER JOIN combustivel ON (combustivel.id = ano.id_combustivel)
INNER JOIN modelo ON (modelo.id = ano.id_modelo)
INNER JOIN marca ON (marca.id = modelo.id_marca)
INNER JOIN tipo ON (tipo.id = marca.id_tipo)
WHERE marca.nome ILIKE '%ferrari%'
ORDER BY ano.valor DESC

------------------------------------------------------------------------------------------------------------------------------
-- 1) Filtre os caminhões da marca “Volvo” fabricados entre os anos de 2007 a 2011 e que tenham valor entre 150.000 e 190.000;

SELECT
	ano_fabricacao AS ano,
	tipo.nome AS tipo,
	marca.nome AS marca,
	modelo.nome AS modelo,
	valor::MONEY AS valor
FROM ano
INNER JOIN modelo ON (modelo.id = ano.id_modelo)
INNER JOIN marca ON (marca.id = modelo.id_marca)
INNER JOIN tipo ON (tipo.id = marca.id_tipo)
WHERE marca.id = 116
AND (ano.ano_fabricacao BETWEEN 2007 AND 2011)
AND (ano.valor BETWEEN 150000 AND 190000)
AND tipo.id = 3
ORDER BY ano.valor

-----------------------------------------------------------------------------------------------------------------------------
-- 2) Filtre os caminhões da marca “Volvo” e que contenha no modelo a palavra “6x4” ordenando pelo valor;

SELECT 
	ano_fabricacao AS ano,
	tipo.nome AS tipo,
	marca.nome AS marca,
	modelo.nome AS modelo,
	valor::MONEY AS valor
FROM ano
INNER JOIN modelo ON (modelo.id = ano.id_modelo)
INNER JOIN marca ON (marca.id = modelo.id_marca)
INNER JOIN tipo ON (tipo.id = marca.id_tipo)
WHERE marca.id = 116
AND modelo.nome ILIKE '%6x4%'
AND tipo.id = 3
ORDER BY ano.valor

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3) Conte e some o valor de todas as motos da marca “honda” fabricados entre 2000 e 2005 agrupando pelo ano de fabricação e ordenando pela quantidade;

SELECT
	ano_fabricacao AS ano,
	COUNT(*) AS total_motos,
	SUM(ano.valor) AS soma_motos
FROM ano
INNER JOIN modelo ON (modelo.id = ano.id_modelo)
INNER JOIN marca ON (marca.id = modelo.id_marca)
INNER JOIN tipo ON (tipo.id = marca.id_tipo)
WHERE ano_fabricacao BETWEEN 2000 AND 2005
AND tipo.id = 2
GROUP BY ano.ano_fabricacao 
ORDER BY total_motos
	