CREATE TABLE `pedidos` (
  `id_pedido` integer PRIMARY KEY AUTO_INCREMENT,
  `id_cliente` integer,
  `id_funcionario` integer,
  `id_status_produto` integer,
  `id_tipo_pedido` integer,
  `id_forma_pagamento` integer,
  `data_pedido` timestamp DEFAULT (now()),
  `valor_total_pedido` decimal(10,2) NOT NULL
);