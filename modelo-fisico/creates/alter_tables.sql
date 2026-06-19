CREATE DATABASE db_cantinho_massa;

use db_cantinho_massa;

ALTER TABLE `enderecos` ADD FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`);

ALTER TABLE `funcionarios` ADD FOREIGN KEY (`id_cargo`) REFERENCES `cargos` (`id_cargo`);

ALTER TABLE `produtos` ADD FOREIGN KEY (`id_categoria`) REFERENCES `categorias_produtos` (`id_categoria`);

ALTER TABLE `produtos` ADD FOREIGN KEY (`id_status`) REFERENCES `status` (`id_status`);

ALTER TABLE `produtos_ingredientes` ADD FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id_produto`);

ALTER TABLE `produtos_ingredientes` ADD FOREIGN KEY (`id_ingrediente`) REFERENCES `ingredientes` (`id_ingrediente`);

ALTER TABLE `estoques` ADD FOREIGN KEY (`id_ingrediente`) REFERENCES `ingredientes` (`id_ingrediente`);

ALTER TABLE `estoques` ADD FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id_fornecedor`);

ALTER TABLE `pedidos` ADD FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`);

ALTER TABLE `pedidos` ADD FOREIGN KEY (`id_funcionario`) REFERENCES `funcionarios` (`id_funcionario`);

ALTER TABLE `pedidos` ADD FOREIGN KEY (`id_status_produto`) REFERENCES `status` (`id_status`);

ALTER TABLE `pedidos` ADD FOREIGN KEY (`id_tipo_pedido`) REFERENCES `tipos_pedidos` (`id_tipo_pedido`);

ALTER TABLE `pedidos` ADD FOREIGN KEY (`id_forma_pagamento`) REFERENCES `formas_pagamentos` (`id_forma_pagamento`);

ALTER TABLE `itens_pedidos` ADD FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`);

ALTER TABLE `itens_pedidos` ADD FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id_produto`);

ALTER TABLE `entregas` ADD FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`);

ALTER TABLE `entregas` ADD FOREIGN KEY (`id_entregador_funcionario`) REFERENCES `funcionarios` (`id_funcionario`);

ALTER TABLE `entregas` ADD FOREIGN KEY (`id_status_entrega`) REFERENCES `status` (`id_status`);
