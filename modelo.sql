// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

/*
===============================================================================
PADRONIZAÇÃO DO MODELO LÓGICO
===============================================================================

Este banco de dados foi desenvolvido seguindo padrões de modelagem lógica
para garantir organização, legibilidade, manutenção e escalabilidade do sistema.

Padrões adotados:

- Utilização de nomes de tabelas no plural.
- Utilização do padrão snake_case para nomes de tabelas e colunas.
- Chaves primárias padronizadas com prefixo "id_".
- Chaves estrangeiras nomeadas conforme a tabela de referência.
- Relacionamentos N:N implementados através de tabelas associativas.
- Separação de entidades para evitar redundância de dados.
- Utilização de tipos apropriados para cada informação:
  * decimal(10,2) para valores monetários;
  * timestamp para data e hora;
  * date para datas simples;
  * boolean para valores lógicos.
- Estrutura baseada nos princípios de normalização até a 3FN.
- Modelo desenvolvido para um sistema de delivery/restaurante.

Objetivo da modelagem:
Garantir integridade dos dados, facilitar futuras manutenções
e permitir expansão do sistema de forma organizada.

===============================================================================
*/


Project project_name {
  database_type: 'PostgreSQL'
  Note: 'database criado para um projeto de delivery/restaurante'
}

Table clientes {
  id_cliente integer [pk, increment]
  nome varchar(100) [not null]
  telefone varchar(10)
  celular varchar(11) [not null]
  email varchar(50) [not null]
  cpf varchar(14) [not null]
  data_cadastro timestamp [default: `now()`]
}

Table enderecos {
  id_endereco integer [pk, increment]
  id_cliente integer [ref: > clientes.id_cliente]
  rua varchar(100) [not null]
  numero varchar(10) [not null]
  cidade varchar(25) [not null]
  cep varchar(8) [not null]
  complemento varchar(50)
  tipo_endereco varchar(25) [not null]
  principal boolean [default: false]
}

Table cargos {
  id_cargo integer [pk, increment]
  nome_cargo varchar(25) [not null]
  descricao varchar(50) [not null]
}

Table funcionarios {
  id_funcionario integer [pk, increment]
  nome varchar(100) [not null]
  id_cargo integer [ref: > cargos.id_cargo]
  salario decimal(10,2)
  celular varchar(11) [not null]
  data_admissao timestamp [not null]
  data_demissao date
}

Table categorias_produtos {
  id_categoria integer [pk, increment]
  nome_categoria varchar(25) [not null]
}

Table status {
  id_status integer [pk, increment]
  nome_status varchar(50) [not null]
  tipo_status varchar(15) [not null]
  descricao text [not null]
}

Table tipos_pedidos {
  id_tipo_pedido integer [pk, increment]
  nome_tipo varchar(25) [not null]
}

Table formas_pagamentos {
  id_forma_pagamento integer [pk, increment]
  nome_forma_pagamento varchar(30) [not null]
}

Table produtos {
  id_produto integer [pk, increment]
  id_categoria integer [ref: > categorias_produtos.id_categoria]
  id_status integer [ref: > status.id_status]
  nome varchar(25) [not null]
  preco decimal(10,2) [not null]
  descricao text [not null]
}

Table ingredientes {
  id_ingrediente integer [pk, increment]
  nome_ingrediente varchar(25) [not null]
}

Table produtos_ingredientes {
  id_produto integer [ref: > produtos.id_produto]
  id_ingrediente integer [ref: > ingredientes.id_ingrediente]
}

Table fornecedores {
  id_fornecedor integer [pk, increment]
  nome_fornecedor varchar(25) [not null]
  telefone_fornecedor varchar(10)
  celular_fornecedor varchar(11) [not null]
  email varchar(50) [not null]
  cnpj_fornecedor varchar(14) [not null]
}

Table estoques {
  id_estoque integer [pk, increment]
  id_ingrediente integer [ref: > ingredientes.id_ingrediente]
  id_fornecedor integer [ref: > fornecedores.id_fornecedor]
  quantidade decimal(10,2) [not null]
  unidade_medida varchar(20) [not null]
  data_validade date [not null]
}

Table pedidos {
  id_pedido integer [pk, increment]
  id_cliente integer [ref: > clientes.id_cliente]
  id_funcionario integer [ref: > funcionarios.id_funcionario]
  id_status_produto integer [ref: > status.id_status]
  id_tipo_pedido integer [ref: > tipos_pedidos.id_tipo_pedido]
  id_forma_pagamento integer [ref: > formas_pagamentos.id_forma_pagamento]
  data_pedido timestamp [default: `now()`]
  valor_total_pedido decimal(10,2) [not null]
}

Table itens_pedidos {
  id_item_pedido integer [pk, increment]
  id_pedido integer [ref: > pedidos.id_pedido]
  id_produto integer [ref: > produtos.id_produto]
  preco decimal(10,2) [not null]
  quantidade integer [not null]
  sub_total_pedido decimal(10,2) [note: 'preco * quantidade']
}

Table entregas {
  id_entrega integer [pk, increment]
  id_pedido integer [ref: > pedidos.id_pedido]
  id_entregador_funcionario integer [ref: > funcionarios.id_funcionario]
  id_status_entrega integer [ref: > status.id_status]
  horario_saida timestamp [not null]
  horario_entrega timestamp
  taxa_entrega decimal(10,2) [not null]
}