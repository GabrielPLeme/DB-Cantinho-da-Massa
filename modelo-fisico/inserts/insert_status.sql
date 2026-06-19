INSERT INTO status (nome_status, tipo_status, descricao) VALUES
('Disponível', 'produto', 'Produto disponível para venda'),
('Indisponível', 'produto', 'Produto fora de estoque'),
('Em preparo', 'pedido', 'Pedido sendo preparado'),
('Pronto', 'pedido', 'Pedido pronto para saída'),
('Entregue', 'pedido', 'Pedido entregue'),
('Cancelado', 'pedido', 'Pedido cancelado'),
('Ativo', 'funcionario', 'Funcionário ativo'),
('Inativo', 'funcionario', 'Funcionário desligado'),
('Em rota', 'entrega', 'Pedido em entrega'),
('Finalizado', 'entrega', 'Entrega concluída');
