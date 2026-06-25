# 🍝 Cantinho da Massa • Data Platform

Plataforma de dados para gestão inteligente de um serviço de delivery de alimentos.
Inspirado em sistemas como `Uber Eats` e `iFood`

  
# 🏢 SOBRE O PRODUTO

O Cantinho da Massa Data Platform é um sistema de banco de dados
projetado para suportar operações de um delivery moderno.

A plataforma centraliza dados operacionais e analíticos,
permitindo controle e tomada de decisão baseada em dados.


# 🎯 Objetivo

- Gestão de pedidos
- Controle de clientes
- Gestão de funcionários
- Catálogo de produtos
- Controle de estoque
- Gestão de entregas
- Análise de performance (KPIs) 

# 🧠 ARQUITETURA DE DADOS

[ DATA MODELING LAYER ]
- Modelagem conceitual
- Modelagem lógica
- Modelagem física (SQL)

[ OPERATIONAL LAYER ]
- Tabelas transacionais
- Pedidos e clientes
- Estoque e fornecedores
- Entregas e pagamentos

[ ANALYTICS LAYER ]
- KPIs de negócio
- Views analíticas
- Procedures dinâmicas


### 📊 BUSINESS KPIs

- Faturamento total
- Ticket médio
- Total de pedidos
- Clientes ativos
- Produtos ativos
- Funcionários ativos
- Faturamento por mês
- Top produtos
- Top clientes
- Receita por categoria
- Situação de estoque

# ⚙️ STORED PROCEDURES (API LAYER)

-- Clientes por status
CALL sp_clientes_status(1); -- ativos
CALL sp_clientes_status(0); -- inativos

-- Funcionários por status
CALL sp_funcionarios_status(1); -- ativos
CALL sp_funcionarios_status(0); -- inativos

# 👁 VIEWS (ANALYTICS LAYER)

vw_faturamento_total
vw_ticket_medio
vw_produtos_ativos
vw_faturamento_mes
vw_top_produtos
vw_estoque_status


### 🗂 DATA MODEL

TABELAS PRINCIPAIS:
- pedidos
- clientes
- funcionarios
- produtos
- itens_pedidos
- entregas
- formas_pagamento
- categorias_produtos
- fornecedores
- estoques

# 🛠 TECH STACK

- PostgreSQL / MySQL
- SQL Avançado
- Views e Procedures
- Modelagem de Banco de Dados
- Git & GitHub

# 🚀 BUSINESS VALUE

O sistema permite responder perguntas como:

- Qual o faturamento da empresa?
- Quais produtos mais vendem?
- Quem são os melhores clientes?
- Quais dias têm mais pedidos?
- Onde há gargalos operacionais?

# 👨‍💻 AUTORES

- Andreza Fonseca Damasceno
- Gabriel Pereira Leme
- Gabriela Fernandes Beato

**Disciplina:** Banco de Dados  
**Curso:** Tecnologia em Sistemas para Internet
