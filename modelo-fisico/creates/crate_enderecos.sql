CREATE TABLE `enderecos` (
  `id_endereco` integer PRIMARY KEY AUTO_INCREMENT,
  `id_cliente` integer,
  `rua` varchar(100) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `cidade` varchar(25) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `complemento` varchar(50),
  `tipo_endereco` varchar(25) NOT NULL,
  `principal` boolean DEFAULT false
);