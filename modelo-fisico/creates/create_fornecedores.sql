CREATE TABLE `fornecedores` (
  `id_fornecedor` integer PRIMARY KEY AUTO_INCREMENT,
  `nome_fornecedor` varchar(25) NOT NULL,
  `telefone_fornecedor` varchar(10),
  `celular_fornecedor` varchar(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `cnpj_fornecedor` varchar(14) NOT NULL
);
