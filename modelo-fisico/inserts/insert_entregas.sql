INSERT INTO entregas
(id_pedido, id_entregador_funcionario, id_status_entrega, horario_saida, horario_entrega, taxa_entrega)
VALUES
(1, 24, 5, NOW(), NULL, 7.00),
(2, 25, 5, NOW(), NOW(), 5.00),
(3, 26, 5, NOW(), NULL, 6.50),
(4, 27, 5, NOW(), NOW(), 8.00),
(5, 28, 5, NOW(), NULL, 7.50),
(6, 29, 5, NOW(), NOW(), 6.00);