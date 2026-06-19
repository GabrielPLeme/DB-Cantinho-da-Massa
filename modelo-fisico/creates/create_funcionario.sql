
CREATE TABLE `funcionarios` (
  `id_funcionario` integer PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `id_cargo` integer,
  `salario` decimal(10,2),
  `celular` varchar(11) NOT NULL,
  `data_admissao` timestamp NOT NULL,
  `data_demissao` date
);