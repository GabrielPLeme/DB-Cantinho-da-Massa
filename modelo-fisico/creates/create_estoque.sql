CREATE TABLE `estoques` (
  `id_estoque` integer PRIMARY KEY AUTO_INCREMENT,
  `id_ingrediente` integer,
  `id_fornecedor` integer,
  `quantidade` decimal(10,2) NOT NULL,
  `unidade_medida` varchar(20) NOT NULL,
  `data_validade` date NOT NULL
);