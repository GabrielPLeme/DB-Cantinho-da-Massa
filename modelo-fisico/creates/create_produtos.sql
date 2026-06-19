CREATE TABLE `produtos` (
  `id_produto` integer PRIMARY KEY AUTO_INCREMENT,
  `id_categoria` integer,
  `id_status` integer,
  `nome` varchar(25) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `descricao` text NOT NULL
);