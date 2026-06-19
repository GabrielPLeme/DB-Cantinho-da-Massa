CREATE TABLE `clientes` (
  `id_cliente` integer PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(10),
  `celular` varchar(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `data_cadastro` timestamp DEFAULT (now())
);