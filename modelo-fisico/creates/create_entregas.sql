CREATE TABLE `entregas` (
  `id_entrega` integer PRIMARY KEY AUTO_INCREMENT,
  `id_pedido` integer,
  `id_entregador_funcionario` integer,
  `id_status_entrega` integer,
  `horario_saida` timestamp NOT NULL,
  `horario_entrega` timestamp,
  `taxa_entrega` decimal(10,2) NOT NULL
);
