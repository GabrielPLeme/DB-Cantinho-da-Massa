CREATE TABLE `status` (
  `id_status` integer PRIMARY KEY AUTO_INCREMENT,
  `nome_status` varchar(50) NOT NULL,
  `tipo_status` varchar(15) NOT NULL,
  `descricao` text NOT NULL
);
