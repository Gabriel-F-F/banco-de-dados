----------------------------------------------------------------------------------------------------------------------
-- 1. Construa duas consultas SQL e faça o join de acordo com o modelo acima. 
-- O primeiro SQL deve apresentar o resultado de todos os alunos independente de ter ou não cidade e signo preenchido. 

SELECT 
	aluno.id,
	aluno.nome,
	aluno.cpf,
	aluno.rg,
	aluno.data_nascimento,
	aluno.sexo,
	aluno.mae,
	aluno.celular,
	aluno.tipo_sanguineo,
	aluno.altura,
	aluno.peso,
	cidade.cidade,
	signo.nome AS signo
FROM aluno
LEFT JOIN cidade ON (cidade.id = aluno.id_cidade)
LEFT JOIN signo ON (signo.id = aluno.id_signo)
ORDER BY aluno.id

-- O segundo SQL deve trazer apenas alunos com cidade e signo preenchidos. Trate colunas duplicadas se  houver.

SELECT 
	aluno.id,
	aluno.nome,
	aluno.cpf,
	aluno.rg,
	aluno.data_nascimento,
	aluno.sexo,
	aluno.mae,
	aluno.celular,
	aluno.tipo_sanguineo,
	aluno.altura,
	aluno.peso,
	cidade.cidade,
	signo.nome AS signo
FROM aluno
INNER JOIN cidade ON (cidade.id = aluno.id_cidade)
INNER JOIN signo ON (signo.id = aluno.id_signo)
ORDER BY aluno.id

----------------------------------------------------------------------------------------------------------------------
-- 2. Selecione os dados do aluno, cidade e signo aplicando os seguintes filtros. 
-- Aluno com altura maior que 1.90 que tenha o tipo sanguíneo “o” que possua signo e que tenha peso maior ou igual a 70.

SELECT
	aluno.id,
	aluno.nome,
	aluno.cpf,
	aluno.rg,
	aluno.data_nascimento,
	aluno.sexo,
	aluno.mae,
	aluno.celular,
	aluno.tipo_sanguineo,
	aluno.altura,
	aluno.peso,
	cidade.cidade,
	signo.nome AS signo
FROM aluno
LEFT JOIN cidade ON (cidade.id = aluno.id_cidade)
INNER JOIN signo ON (signo.id = aluno.id_signo)
WHERE aluno.altura > 1.90
AND aluno.tipo_sanguineo ILIKE '%o%'
AND aluno.peso >= 70
ORDER BY aluno.id

----------------------------------------------------------------------------------------------------------------------
-- 3. Selecione os dados do aluno e cidade aplicando os seguintes filtros. 
-- Alunos que não sejam do estado de SC, do sexo feminino e que nasceram entre 01/01/1990 e 01/01/2000.

SELECT 
	aluno.id,
	aluno.nome,
	aluno.cpf,
	aluno.rg,
	aluno.data_nascimento,
	aluno.sexo,
	aluno.mae,
	aluno.celular,
	aluno.tipo_sanguineo,
	aluno.altura,
	aluno.peso,
	cidade.cidade
FROM aluno
INNER JOIN cidade ON (cidade.id = aluno.id_cidade)
WHERE cidade.estado <> 'SC'
AND aluno.sexo ILIKE '%F%'
AND aluno.data_nascimento BETWEEN '1990-01-01' AND '2000-01-01'
ORDER BY aluno.id

----------------------------------------------------------------------------------------------------------------------
-- 4. Selecione os dados do aluno, cidade e signo aplicando os seguintes filtros: 
-- Alunos do signo de “Virgem” que tenham peso entre 80 e 90 quilos 
-- e que morem na cidade de Blumenau/SC.

SELECT
	aluno.id,
	aluno.nome,
	aluno.cpf,
	aluno.rg,
	aluno.data_nascimento,
	aluno.sexo,
	aluno.mae,
	aluno.celular,
	aluno.tipo_sanguineo,
	aluno.altura,
	aluno.peso,
	cidade.cidade,
	signo.nome AS signo
FROM aluno
INNER JOIN cidade ON (cidade.id = aluno.id_cidade)
INNER JOIN signo ON(signo.id = aluno.id_signo)
WHERE aluno.id_signo = 8
AND aluno.peso BETWEEN 80 AND 90
AND aluno.id_cidade = 21
ORDER BY aluno.id
----------------------------------------------------------------------------------------------------------------------
-- 5. Selecione os dados do aluno e cidade aplicando os seguintes filtros. 
-- Alunos da cidade de “Tubarão” que tenham peso acima de 100 e que tenham tipo sanguíneo negativo.

SELECT
	aluno.id,
	aluno.nome,
	aluno.cpf,
	aluno.rg,
	aluno.data_nascimento,
	aluno.sexo,
	aluno.mae,
	aluno.celular,
	aluno.tipo_sanguineo,
	aluno.altura,
	aluno.peso,
	cidade.cidade
FROM aluno
INNER JOIN cidade ON (cidade.id = aluno.id_cidade)
WHERE cidade.cidade ILIKE '%Tubar_o%'  -- O '_' do ILIKE é um coringa que ignora o caractere especificado,
AND aluno.peso > 100		       -- o postgre não o associará na busca
AND aluno.tipo_sanguineo ILIKE '%-%'
ORDER BY aluno.id

----------------------------------------------------------------------------------------------------------------------
-- 6. Selecione os dados do aluno aplicando os seguintes filtros. 
-- Alunos que tenham no nome a palavra “pedro” e que o CPF termine com “77”.

SELECT
	aluno.id,
	aluno.nome,
	aluno.cpf,
	aluno.rg,
	aluno.data_nascimento,
	aluno.sexo,
	aluno.mae,
	aluno.celular,
	aluno.tipo_sanguineo,
	aluno.altura,
	aluno.peso
FROM aluno
WHERE aluno.nome ILIKE '%pedro%'
AND aluno.cpf ILIKE '%77'
ORDER BY aluno.id

----------------------------------------------------------------------------------------------------------------------
-- 7. Selecione os dados do aluno, cidade e signo aplicando os seguintes filtros. 
-- Alunos com nome iniciando com “La” que o DDD do celular seja “48” 
-- com signo diferente de “Libra” e que tenha tipo sanguíneo “B”;

SELECT
	aluno.id,
	aluno.nome,
	aluno.cpf,
	aluno.rg,
	aluno.data_nascimento,
	aluno.sexo,
	aluno.mae,
	aluno.celular,
	aluno.tipo_sanguineo,
	aluno.altura,
	aluno.peso,
	cidade.cidade,
	signo.nome AS signo
FROM aluno
LEFT JOIN cidade ON (cidade.id = aluno.id_cidade)
INNER JOIN signo ON (signo.id = aluno.id_signo)
WHERE aluno.nome ILIKE 'la%'
AND aluno.celular ILIKE '(48)%'
AND aluno.id_signo <> 7
AND aluno.tipo_sanguineo ILIKE 'b%'
ORDER BY aluno.id

----------------------------------------------------------------------------------------------------------------------
-- 8. Conte os alunos aplicando os seguintes filtros: 
-- Alunos das cidades de “Florianópolis”, “Tubarão” e “Lages” que não tenham signo 
-- que tenham no tipo sanguíneo a letra “B”;

SELECT 
	aluno.id,
	aluno.nome,
	aluno.cpf,
	aluno.rg,
	aluno.data_nascimento,
	aluno.sexo,
	aluno.mae,
	aluno.celular,
	aluno.tipo_sanguineo,
	aluno.altura,
	aluno.peso,
	cidade.cidade,
	signo.nome AS signo
FROM aluno
INNER JOIN cidade ON (cidade.id = aluno.id_cidade)
INNER JOIN signo ON (signo.id = aluno.id_signo)
WHERE (aluno.id_cidade = 9 OR aluno.id_cidade = 12 OR aluno.id_cidade = 17)
AND aluno.tipo_sanguineo ILIKE '%b%'
ORDER BY aluno.id

----------------------------------------------------------------------------------------------------------------------
-- 9. Some o peso e gere a média da altura e peso dos aluno de tubarão;

SELECT
	SUM(aluno.peso) AS peso_tubarao,
	ROUND(AVG(aluno.altura), 2) AS media_altura_tubarao,
	ROUND(AVG(aluno.peso), 2) AS media_peso_tubarao
FROM aluno
WHERE aluno.id_cidade = 12

----------------------------------------------------------------------------------------------------------------------
-- 10. Agrupe os alunos da cidade de “Tubarão” por tipo sanguíneo e:
-- conte a quantidade de alunos por tipo;
-- gere e média de altura por tipo;
-- gere a média de peso por tipo;
-- arredonde os dados quando necessário.

SELECT
	aluno.tipo_sanguineo,
	COUNT(aluno.tipo_sanguineo) AS pessoas_tubarao,
	ROUND(AVG(aluno.altura), 2) AS media_altura,
	ROUND(AVG(aluno.peso), 2) AS media_peso
FROM aluno
INNER JOIN cidade ON (cidade.id = aluno.id_cidade)
WHERE aluno.id_cidade = 12
GROUP BY aluno.tipo_sanguineo

----------------------------------------------------------------------------------------------------------------------
-- 11. Agupe os dados por sexo e tipo sanguineo e:
-- conte a quantidade de alunos;
-- conta de maneira distinta as cidades encontradas no agrupamento;
-- ordene o resultado por sexo decrecente e tipo sanguineo;

SELECT
	aluno.tipo_sanguineo,
	aluno.sexo,
	COUNT(*) AS quantidade_alunos,
	COUNT(DISTINCT cidade.cidade) AS quantidade_alunos_distintos
FROM aluno
INNER JOIN cidade ON (cidade.id = aluno.id_cidade)
GROUP BY aluno.sexo, aluno.tipo_sanguineo 
ORDER BY  aluno.tipo_sanguineo, aluno.sexo DESC

----------------------------------------------------------------------------------------------------------------------
-- 12. Agrupe os dados por cidade e:
-- conte a quantidade de alunos;
-- conte de maneira distinta o tipo sanguíneo;
-- selecione a maior altura de um aluno na cidade;
-- selecione o menor peso de um aluno na cidade;

SELECT
	cidade.cidade,
	COUNT(*) AS quantidade_alunos,
	COUNT(DISTINCT aluno.tipo_sanguineo) AS tipo_sanguineo_distinto,
	MAX(aluno.altura) AS maior_altura,
	MIN(aluno.altura) AS menor_altura
FROM aluno
INNER JOIN cidade ON (cidade.id = aluno.id_cidade)
GROUP BY cidade.cidade
ORDER BY quantidade_alunos DESC

----------------------------------------------------------------------------------------------------------------------
-- 13. Agrupe os dados por signo e sexo e:
-- conte os alunos em cada grupo;
-- calcule a média de altura de cada grupo
-- arredonde os dados quando necessário.
-- ordene o resultado por sexo decrecente e pelo contador de alunos decrecente;

SELECT
	signo.nome,
	aluno.sexo,
	COUNT(*) AS quantidade_alunos,
	ROUND(AVG(aluno.altura), 2) AS media_altura
FROM aluno
INNER JOIN signo ON (signo.id = aluno.id_signo)	
GROUP BY (signo.nome, aluno.sexo)
ORDER BY aluno.sexo DESC, quantidade_alunos DESC