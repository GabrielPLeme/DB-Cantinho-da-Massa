CREATE TABLE `itens_pedidos` (
  `id_item_pedido` integer PRIMARY KEY AUTO_INCREMENT,
  `id_pedido` integer,
  `id_produto` integer,
  `preco` decimal(10,2) NOT NULL,
  `quantidade` integer NOT NULL,
  `sub_total_pedido` decimal(10,2) COMMENT 'preco * quantidade'
);
