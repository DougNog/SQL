-- =============================================


CREATE DATABASE mecanica;
USE mecanica;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    cpf_cliente VARCHAR(14) NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL
);

CREATE TABLE mecanicos (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    cpf_mecanico VARCHAR(14) NOT NULL,
    nome_mecanico VARCHAR(100) NOT NULL
);

CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(100),
    ano INT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao_servico VARCHAR(255) NOT NULL,
    preco_servico DECIMAL(10,2) NOT NULL
);

CREATE TABLE ordens_servico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    data_emissao DATE,
    data_conclusao DATE,
    id_mecanico INT,
    id_veiculo INT,
    FOREIGN KEY (id_mecanico) REFERENCES mecanicos(id_mecanico),
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo)
);

CREATE TABLE pecas (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    descricao_peca VARCHAR(100),
    preco_peca DECIMAL(10,2),
    qtde_estoque_peca INT
);

CREATE TABLE os_pecas (
    id_os INT,
    id_peca INT,
    qtde_utilizada INT,
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY (id_os) REFERENCES ordens_servico(id_os),
    FOREIGN KEY (id_peca) REFERENCES pecas(id_peca)
);

CREATE TABLE os_servicos (
    id_os INT,
    id_servico INT,
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os) REFERENCES ordens_servico(id_os),
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico)
);

CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    capacidade_total INT,
    responsavel_estoque VARCHAR(100),
    localizacao VARCHAR(100)
);

INSERT INTO clientes (cpf_cliente, nome_cliente) VALUES
('111.111.111-11', 'João da Silva'),
('222.222.222-22', 'Maria Oliveira'),
('333.333.333-33', 'Carlos Souza'),
('444.444.444-44', 'Fernanda Lima'),
('555.555.555-55', 'Rafael Pereira'),
('666.666.666-66', 'Patrícia Santos'),
('777.777.777-77', 'Lucas Almeida'),
('888.888.888-88', 'Juliana Castro'),
('999.999.999-99', 'André Fernandes'),
('123.456.789-10', 'Roberta Nunes'),
('234.567.890-11', 'Marcelo Duarte'),
('345.678.901-22', 'Beatriz Ramos'),
('456.789.012-33', 'Eduardo Campos');

INSERT INTO mecanicos (cpf_mecanico, nome_mecanico) VALUES
('555.666.777-88', 'Pedro Mecânico'),
('999.888.777-66', 'Ana Reparadora'),
('111.222.333-44', 'José Freitas'),
('222.333.444-55', 'Cláudio Moreira'),
('333.444.555-66', 'Vanessa Lopes'),
('444.555.666-77', 'Rodrigo Tavares'),
('555.666.777-99', 'Marcos Carvalho'),
('666.777.888-00', 'Paulo Henrique'),
('777.888.999-11', 'Larissa Gomes'),
('888.999.000-22', 'Tiago Rocha'),
('999.000.111-33', 'Camila Duarte'),
('000.111.222-44', 'Felipe Rezende'),
('111.222.333-55', 'Carla Menezes');

INSERT INTO veiculos (placa, modelo, ano, id_cliente) VALUES
('AAA1A11', 'Fiat Uno', 2010, 1),
('BBB2B22', 'Chevrolet Onix', 2020, 2),
('CCC3C33', 'Volkswagen Gol', 2015, 3),
('DDD4D44', 'Toyota Corolla', 2019, 4),
('EEE5E55', 'Honda Civic', 2021, 5),
('FFF6F66', 'Hyundai HB20', 2018, 6),
('GGG7G77', 'Renault Sandero', 2017, 7),
('HHH8H88', 'Jeep Compass', 2022, 8),
('III9I99', 'Nissan Kicks', 2021, 9),
('JJJ0J00', 'Peugeot 208', 2019, 10),
('KKK1K11', 'Ford Ka', 2016, 11),
('LLL2L22', 'Fiat Argo', 2020, 12),
('MMM3M33', 'Volkswagen Polo', 2023, 13);

INSERT INTO servicos (descricao_servico, preco_servico) VALUES
('Troca de óleo', 150.00),
('Revisão completa', 500.00),
('Troca de freios', 300.00),
('Troca de embreagem', 850.00),
('Balanceamento e alinhamento', 200.00),
('Substituição de correia dentada', 400.00),
('Limpeza de bicos injetores', 250.00),
('Troca de amortecedores', 900.00),
('Recarga de ar-condicionado', 180.00),
('Diagnóstico eletrônico', 120.00),
('Troca de bateria', 350.00),
('Troca de filtro de ar', 80.00),
('Reparo no sistema elétrico', 600.00);

INSERT INTO ordens_servico (data_emissao, data_conclusao, id_mecanico, id_veiculo) VALUES
('2025-11-01', '2025-11-02', 1, 1),
('2025-11-03', NULL, 2, 2),
('2025-11-04', '2025-11-06', 3, 3),
('2025-11-05', '2025-11-07', 4, 4),
('2025-11-06', '2025-11-08', 5, 5),
('2025-11-07', NULL, 6, 6),
('2025-11-08', '2025-11-09', 7, 7),
('2025-11-09', '2025-11-10', 8, 8),
('2025-11-10', NULL, 9, 9),
('2025-11-11', NULL, 10, 10),
('2025-11-12', '2025-11-14', 11, 11),
('2025-11-13', NULL, 12, 12),
('2025-11-14', '2025-11-16', 13, 13);

INSERT INTO pecas (descricao_peca, preco_peca, qtde_estoque_peca) VALUES
('Filtro de óleo', 50.00, 30),
('Pastilha de freio', 120.00, 20),
('Velas de ignição', 25.00, 100),
('Correia dentada', 150.00, 40),
('Bateria 60Ah', 350.00, 15),
('Amortecedor dianteiro', 450.00, 25),
('Filtro de ar', 60.00, 50),
('Lâmpada farol H7', 30.00, 80),
('Fluido de freio DOT4', 45.00, 60),
('Óleo sintético 5W30', 80.00, 100),
('Filtro de combustível', 70.00, 45),
('Sensor de temperatura', 90.00, 35),
('Bomba de combustível', 400.00, 20);

INSERT INTO os_pecas (id_os, id_peca, qtde_utilizada) VALUES
(1, 1, 1),
(1, 3, 4),
(2, 2, 1),
(3, 4, 1),
(4, 5, 1),
(5, 6, 2),
(6, 7, 1),
(7, 8, 2),
(8, 9, 1),
(9, 10, 4),
(10, 11, 1),
(11, 12, 1),
(12, 13, 1);

INSERT INTO os_servicos (id_os, id_servico) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10),
(10, 11),
(11, 12),
(12, 13);

INSERT INTO estoque (capacidade_total, responsavel_estoque, localizacao) VALUES
(500, 'Lucas Almeida', 'Galpão A'),
(1000, 'Fernanda Costa', 'Galpão B'),
(800, 'Rogério Martins', 'Depósito Central'),
(600, 'Patrícia Freitas', 'Anexo 1'),
(700, 'André Luiz', 'Anexo 2'),
(1200, 'Camila Rocha', 'Galpão C'),
(900, 'Felipe Barbosa', 'Setor D'),
(650, 'Jéssica Lima', 'Armazém 1'),
(1100, 'Mariana Duarte', 'Armazém 2'),
(750, 'Thiago Nunes', 'Estoque A'),
(950, 'Ricardo Borges', 'Estoque B'),
(1050, 'Gustavo Teixeira', 'Estoque C'),
(1150, 'Carolina Ribeiro', 'Estoque D');




SELECT * FROM clientes;

SELECT * FROM mecanicos;

SELECT * FROM ordens_servico;

SELECT * FROM pecas;

SELECT * FROM servicos;

SELECT * FROM veiculos;

SELECT * FROM veiculos WHERE modelo = 'Fiat Uno';

SELECT * FROM ordens_servico WHERE data_conclusao IS NOT NULL;

SELECT * FROM ordens_servico WHERE data_conclusao IS NULL;

SELECT * FROM pecas WHERE qtde_estoque_peca < 20;

SELECT * FROM pecas WHERE preco_peca > 100;

SELECT * FROM servicos WHERE preco_servico > 400;

SELECT * FROM veiculos WHERE ano > 2018;

SELECT c.nome_cliente, v.modelo, v.placa
FROM clientes c
JOIN veiculos v ON c.id_cliente = v.id_cliente;

SELECT os.id_os, m.nome_mecanico, os.data_emissao
FROM ordens_servico os
JOIN mecanicos m ON os.id_mecanico = m.id_mecanico;

SELECT os.id_os, p.descricao_peca, op.qtde_utilizada
FROM os_pecas op
JOIN pecas p ON op.id_peca = p.id_peca;

SELECT os.id_os, s.descricao_servico
FROM os_servicos oss
JOIN servicos s ON oss.id_servico = s.id_servico
JOIN ordens_servico os ON oss.id_os = os.id_os;

SELECT os.id_os,
SUM(p.preco_peca * op.qtde_utilizada) AS total_pecas
FROM os_pecas op
JOIN ordens_servico os ON op.id_os = os.id_os
JOIN pecas p ON op.id_peca = p.id_peca
GROUP BY os.id_os;

SELECT os.id_os,
SUM(s.preco_servico) AS total_servicos
FROM os_servicos oss
JOIN servicos s ON oss.id_servico = s.id_servico
JOIN ordens_servico os ON oss.id_os = os.id_os
GROUP BY os.id_os;

SELECT os.id_os,
COALESCE(SUM(p.preco_peca * op.qtde_utilizada), 0) +
COALESCE((SELECT SUM(s.preco_servico)
          FROM os_servicos oss
          JOIN servicos s ON oss.id_servico = s.id_servico
          WHERE oss.id_os = os.id_os), 0)
AS total_os
FROM ordens_servico os
LEFT JOIN os_pecas op ON os.id_os = op.id_os
LEFT JOIN pecas p ON op.id_peca = p.id_peca
GROUP BY os.id_os;

SELECT m.nome_mecanico, COUNT(os.id_os) AS total_os
FROM mecanicos m
LEFT JOIN ordens_servico os ON os.id_mecanico = m.id_mecanico
GROUP BY m.id_mecanico;

SELECT c.nome_cliente, COUNT(v.id_veiculo) AS total_veiculos
FROM clientes c
LEFT JOIN veiculos v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente;

SELECT p.descricao_peca, SUM(op.qtde_utilizada) AS total_usada
FROM pecas p
JOIN os_pecas op ON p.id_peca = op.id_peca
GROUP BY p.id_peca;

SELECT s.descricao_servico, COUNT(oss.id_servico) AS total_execucoes
FROM servicos s
JOIN os_servicos oss ON s.id_servico = oss.id_servico
GROUP BY s.id_servico;

SELECT c.nome_cliente, COUNT(os.id_os) AS total_os
FROM clientes c
JOIN veiculos v ON c.id_cliente = v.id_cliente
JOIN ordens_servico os ON os.id_veiculo = v.id_veiculo
GROUP BY c.id_cliente;

SELECT p.*
FROM pecas p
LEFT JOIN os_pecas op ON p.id_peca = op.id_peca
WHERE op.id_peca IS NULL;

SELECT m.nome_mecanico, COUNT(os.id_os) AS total_os
FROM mecanicos m
JOIN ordens_servico os ON m.id_mecanico = os.id_mecanico
GROUP BY m.id_mecanico
ORDER BY total_os DESC LIMIT 1;

SELECT SUM(p.preco_peca * op.qtde_utilizada) AS total_pecas_usadas
FROM pecas p
JOIN os_pecas op ON p.id_peca = op.id_peca;

SELECT SUM(preco_servico) AS total_servicos
FROM servicos s
JOIN os_servicos oss ON s.id_servico = oss.id_servico;

SELECT * FROM ordens_servico
WHERE MONTH(data_conclusao) = MONTH(CURDATE());

SELECT os.id_os, c.nome_cliente, v.modelo, v.placa, m.nome_mecanico
FROM ordens_servico os
JOIN veiculos v ON os.id_veiculo = v.id_veiculo
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN mecanicos m ON os.id_mecanico = m.id_mecanico;

SELECT c.*
FROM clientes c
LEFT JOIN veiculos v ON c.id_cliente = v.id_cliente
WHERE v.id_veiculo IS NULL;

SELECT s.*
FROM servicos s
LEFT JOIN os_servicos oss ON s.id_servico = oss.id_servico
WHERE oss.id_servico IS NULL;

SELECT *
FROM estoque
ORDER BY capacidade_total DESC LIMIT 1;

SELECT v.modelo, v.placa, COUNT(os.id_os) AS total_os
FROM veiculos v
LEFT JOIN ordens_servico os ON v.id_veiculo = os.id_veiculo
GROUP BY v.id_veiculo;

SELECT
(SELECT SUM(p.preco_peca * op.qtde_utilizada)
 FROM os_pecas op
 JOIN pecas p ON op.id_peca = p.id_peca)
+
(SELECT SUM(s.preco_servico)
 FROM os_servicos oss
 JOIN servicos s ON oss.id_servico = s.id_servico)
AS total_geral;

SELECT AVG(preco_servico) AS media_servicos
FROM servicos;

SELECT * FROM pecas ORDER BY qtde_estoque_peca DESC;

SELECT os.id_os,
COALESCE(SUM(p.preco_peca * op.qtde_utilizada),0) AS total_pecas,
COALESCE((SELECT SUM(preco_servico)
          FROM os_servicos oss 
          JOIN servicos s ON oss.id_servico = s.id_servico
          WHERE oss.id_os = os.id_os),0) AS total_servicos
FROM ordens_servico os
LEFT JOIN os_pecas op ON os.id_os = op.id_os
LEFT JOIN pecas p ON op.id_peca = p.id_peca
GROUP BY os.id_os;

SELECT * FROM clientes WHERE cpf_cliente = '111.111.111-11';
