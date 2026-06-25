/*
CONSULTAS ANALÍTICAS - SISTEMA DE DELIVERY

01 - KPI: Faturamento Total
02 - KPI: Total de Pedidos
03 - KPI: Ticket Médio
04 - KPI: Total de Clientes
05 - KPI: Produtos Ativos
06 - KPI: Funcionários Ativos

07 - Faturamento por Mês
08 - Pedidos por Mês
09 - Status dos Pedidos
10 - Top 10 Produtos
11 - Forma de Pagamento
12 - Tipo de Pedido
13 - Receita por Categoria
14 - Entregas por Mês
15 - Receita das Taxas de Entrega
16 - Pedidos por Dia da Semana
17 - Top 10 Clientes
18 - Desempenho dos Funcionários
19 - Situação do Estoque
20 - Fornecedores

====================================================
*/

-- =====================================================
-- KPI 1 - Faturamento Total (DINÂMICO)
-- Objetivo:
-- Exibir o faturamento total da empresa filtrado por ano.
-- Esse KPI permite analisar o desempenho financeiro anual.
-- Como usar: CALL sp_faturamento_total(colocar o ano);
-- =====================================================

DELIMITER //

CREATE PROCEDURE sp_faturamento_total(IN ano INT)
BEGIN
    SELECT
        SUM(valor_total_pedido) AS faturamento_total
    FROM pedidos
    WHERE YEAR(data_pedido) = ano;
END //

DELIMITER ;

-- =====================================================
-- KPI 2 - Total de Pedidos
-- Objetivo:
-- Mostrar a quantidade total de pedidos realizados em 2024.
-- Utilizado para medir o volume de vendas.
--
--Como usar:
-- SELECT * FROM vw_total_pedidos WHERE ano = 2024;
-- =====================================================

CREATE OR REPLACE VIEW vw_total_pedidos AS
SELECT
    YEAR(data_pedido) AS ano,
    COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY YEAR(data_pedido);


-- =====================================================
-- KPI 3 - Ticket Médio
-- Objetivo:
-- Calcular o valor médio gasto por pedido durante o ano.
-- Auxilia na análise do comportamento de compra dos clientes.
--
-- Como usar: 
--SELECT * FROM vw_ticket_medio WHERE ano = 2024;
-- =====================================================

CREATE OR REPLACE VIEW vw_ticket_medio AS
SELECT
    YEAR(data_pedido) AS ano,
    ROUND(AVG(valor_total_pedido), 2) AS ticket_medio
FROM pedidos
GROUP BY YEAR(data_pedido);


-- =====================================================
-- KPI 4 - Cliente Ativo
-- Objetivo:
-- Verificar se um cliente é ativo ou inativo com base
-- no número de pedidos realizados no sistema.
-- Um cliente é considerado ATIVO quando possui pelo menos
-- um pedido cadastrado.
--
-- Como usar:
-- CALL sp_clientes_status(1); -> Clientes Ativos
-- CALL sp_clientes_status(0); -> Clientes Inativos

-- =====================================================

DELIMITER //

CREATE PROCEDURE sp_clientes_status(IN tipo INT)
BEGIN
    SELECT
        c.id_cliente,
        c.nome,
        COUNT(p.id_pedido) AS total_pedidos,
        CASE
            WHEN COUNT(p.id_pedido) > 0 THEN 'ATIVO'
            ELSE 'INATIVO'
        END AS status_cliente
    FROM clientes c
    LEFT JOIN pedidos p
        ON p.id_cliente = c.id_cliente
    GROUP BY c.id_cliente, c.nome
    HAVING
        (tipo = 1 AND COUNT(p.id_pedido) > 0)
        OR
        (tipo = 0 AND COUNT(p.id_pedido) = 0);
END //

DELIMITER ;

-- =====================================================
-- KPI 5 - Produtos Ativos
-- Objetivo:
-- Mostrar a quantidade de produtos disponíveis para venda,
-- ou seja, produtos com status ativo no sistema.
--
-- Como usar: 
-- SELECT * FROM vw_produtos_ativos;
-- =====================================================

CREATE OR REPLACE VIEW vw_produtos_ativos AS
SELECT
    COUNT(*) AS produtos_ativos
FROM produtos
WHERE id_status = 1;

-- =====================================================
-- KPI 6 - Funcionários por Status
-- Objetivo:
-- Retornar funcionários ativos ou inativos conforme parâmetro.
-- Considera ativo quem NÃO possui data de demissão.
--
-- Como usar:
-- CALL sp_funcionarios_status(1); -- ativos
-- CALL sp_funcionarios_status(0); -- inativos
-- =====================================================

DELIMITER //

CREATE PROCEDURE sp_funcionarios_status(IN tipo INT)
BEGIN
    SELECT
        f.id_funcionario,
        f.nome,
        f.data_demissao,
        CASE
            WHEN f.data_demissao IS NULL THEN 'ATIVO'
            ELSE 'INATIVO'
        END AS status_funcionario
    FROM funcionarios f
    WHERE
        (tipo = 1 AND f.data_demissao IS NULL)
        OR
        (tipo = 0 AND f.data_demissao IS NOT NULL);
END //

DELIMITER ;

-- =====================================================
-- Consulta 7 - Faturamento por Mês
-- Objetivo:
-- Demonstrar a evolução do faturamento ao longo dos meses de 2024.
-- =====================================================

SELECT
    MONTH(data_pedido) mes_num,
    MONTHNAME(data_pedido) mes,
    SUM(valor_total_pedido) faturamento
FROM pedidos
WHERE YEAR(data_pedido)=2024
GROUP BY MONTH(data_pedido), MONTHNAME(data_pedido)
ORDER BY mes_num;

-- =====================================================
-- Consulta 8 - Pedidos por Mês
-- Objetivo:
-- Exibir a quantidade de pedidos realizados em cada mês.
-- =====================================================

SELECT
    MONTH(data_pedido) mes_num,
    MONTHNAME(data_pedido) mes,
    COUNT(*) total_pedidos
FROM pedidos
WHERE YEAR(data_pedido)=2024
GROUP BY MONTH(data_pedido), MONTHNAME(data_pedido)
ORDER BY mes_num;

-- =====================================================
-- Consulta 9 - Status dos Pedidos
-- Objetivo:
-- Apresentar a quantidade de pedidos em cada status.
-- Permite acompanhar o fluxo operacional dos pedidos.
-- =====================================================

SELECT
    s.nome_status,
    COUNT(*) quantidade
FROM pedidos p
JOIN status s
ON s.id_status = p.id_status_produto
GROUP BY s.nome_status;


-- =====================================================
-- Consulta 10 - Top 10 Produtos Mais Vendidos
-- Objetivo:
-- Identificar os produtos com maior quantidade de vendas
-- e maior geração de receita.
-- =====================================================

SELECT
    pr.nome,
    SUM(ip.quantidade) quantidade_vendida,
    SUM(ip.sub_total_pedido) receita
FROM itens_pedidos ip
JOIN produtos pr
ON pr.id_produto = ip.id_produto
GROUP BY pr.nome
ORDER BY quantidade_vendida DESC
LIMIT 10;

-- =====================================================
-- Consulta 11 - Formas de Pagamento
-- Objetivo:
-- Mostrar quais formas de pagamento são mais utilizadas
-- pelos clientes.
-- =====================================================

SELECT
    fp.nome_forma_pagamento,
    COUNT(*) quantidade
FROM pedidos p
JOIN formas_pagamentos fp
ON fp.id_forma_pagamento = p.id_forma_pagamento
GROUP BY fp.nome_forma_pagamento;

-- =====================================================
-- Consulta 12 - Tipos de Pedido
-- Objetivo:
-- Exibir a distribuição dos pedidos por modalidade
-- (delivery, retirada, consumo no local etc.).
-- =====================================================

SELECT
    tp.nome_tipo,
    COUNT(*) quantidade
FROM pedidos p
JOIN tipos_pedidos tp
ON tp.id_tipo_pedido = p.id_tipo_pedido
GROUP BY tp.nome_tipo;

-- =====================================================
-- Consulta 13 - Receita por Categoria
-- Objetivo:
-- Demonstrar quais categorias de produtos geram maior faturamento.
-- =====================================================

SELECT
    cp.nome_categoria,
    SUM(ip.sub_total_pedido) receita
FROM itens_pedidos ip
JOIN produtos pr
ON pr.id_produto = ip.id_produto
JOIN categorias_produtos cp
ON cp.id_categoria = pr.id_categoria
GROUP BY cp.nome_categoria
ORDER BY receita DESC;

-- =====================================================
-- Consulta 14 - Entregas por Mês
-- Objetivo:
-- Exibir a quantidade de entregas realizadas em cada mês.
-- =====================================================

SELECT
    MONTH(p.data_pedido) mes_num,
    MONTHNAME(p.data_pedido) mes,
    COUNT(*) total_entregas
FROM entregas e
JOIN pedidos p
ON p.id_pedido = e.id_pedido
GROUP BY MONTH(p.data_pedido),
         MONTHNAME(p.data_pedido)
ORDER BY mes_num;

-- =====================================================
-- Consulta 15 - Receita das Taxas de Entrega
-- Objetivo:
-- Mostrar o total arrecadado com taxas de entrega por mês.
-- =====================================================

SELECT
    MONTH(p.data_pedido) mes_num,
    MONTHNAME(p.data_pedido) mes,
    SUM(e.taxa_entrega) receita_taxa
FROM entregas e
JOIN pedidos p
ON p.id_pedido = e.id_pedido
GROUP BY MONTH(p.data_pedido),
         MONTHNAME(p.data_pedido)
ORDER BY mes_num;

-- =====================================================
-- Consulta 16 - Pedidos por Dia da Semana
-- Objetivo:
-- Identificar quais dias da semana apresentam maior volume
-- de pedidos e faturamento.
-- =====================================================

SELECT
    DAYNAME(data_pedido) dia_semana,
    COUNT(*) pedidos,
    SUM(valor_total_pedido) faturamento
FROM pedidos
GROUP BY DAYNAME(data_pedido);

-- =====================================================
-- Consulta 17 - Top 10 Clientes
-- Objetivo:
-- Listar os clientes que mais realizaram pedidos,
-- considerando quantidade, valor gasto e ticket médio.
-- =====================================================

SELECT
    c.nome,
    COUNT(p.id_pedido) pedidos,
    SUM(p.valor_total_pedido) total_gasto,
    AVG(p.valor_total_pedido) ticket_medio
FROM clientes c
JOIN pedidos p
ON p.id_cliente = c.id_cliente
GROUP BY c.nome
ORDER BY total_gasto DESC
LIMIT 10;

-- =====================================================
-- Consulta 18 - Desempenho dos Funcionários
-- Objetivo:
-- Avaliar a produtividade dos funcionários com base
-- na quantidade de pedidos atendidos e faturamento gerado.
-- =====================================================

SELECT
    f.nome,
    COUNT(p.id_pedido) pedidos_atendidos,
    SUM(p.valor_total_pedido) faturamento_gerado
FROM funcionarios f
JOIN pedidos p
ON f.id_funcionario = p.id_funcionario
GROUP BY f.nome
ORDER BY pedidos_atendidos DESC;

-- =====================================================
-- Consulta 19 - Situação do Estoque
-- Objetivo: Monitorar o estoque de ingredientes e identificar
-- itens em situação crítica ou com baixo estoque.
-- =====================================================

SELECT
    i.nome_ingrediente,
    e.quantidade,
    e.unidade_medida,
    e.data_validade,
    CASE
        WHEN e.quantidade < 10 THEN 'CRÍTICO'
        WHEN e.quantidade < 30 THEN 'BAIXO'
        ELSE 'OK'
    END AS status_estoque
FROM estoques e
JOIN ingredientes i
ON i.id_ingrediente = e.id_ingrediente;

-- =====================================================
-- Consulta 20 - Fornecedores
-- Objetivo:
-- Apresentar os fornecedores responsáveis pelo abastecimento
-- do estoque, considerando a quantidade de itens fornecidos.
-- =====================================================

SELECT
    f.nome_fornecedor,
    COUNT(e.id_estoque) itens_fornecidos,
    SUM(e.quantidade) quantidade_total
FROM fornecedores f
JOIN estoques e
ON e.id_fornecedor = f.id_fornecedor
GROUP BY f.nome_fornecedor
ORDER BY quantidade_total DESC;