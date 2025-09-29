-- cria e seleciona o banco
CREATE DATABASE IF NOT EXISTS Livraria;
USE Livraria;
SELECT DATABASE();

CREATE TABLE Autores (
  Codigo_Autor INT AUTO_INCREMENT PRIMARY KEY,
  Nome VARCHAR(100) NOT NULL,
  Nacionalidade VARCHAR(100),
  Data_Nascimento DATE
);

CREATE TABLE Editoras (
  CNPJ CHAR(14) PRIMARY KEY,             
  Nome_Editora VARCHAR(100) NOT NULL,
  Endereco VARCHAR(100),
  Contato VARCHAR(100),
  Telefone VARCHAR(30),
  Cidade VARCHAR(100)
);

CREATE TABLE Clientes (
  CPF CHAR(11) PRIMARY KEY,             
  Nome_Cliente VARCHAR(100) NOT NULL,
  Email VARCHAR(100),
  Telefone VARCHAR(30),
  Data_Nascimento DATE
);

CREATE TABLE Livros (
  Codigo_Livro INT AUTO_INCREMENT PRIMARY KEY,
  Titulo VARCHAR(100) NOT NULL,
  Genero VARCHAR(100),
  Preco DECIMAL(10,2) NOT NULL,
  Quantidade INT NOT NULL,
  Codigo_Autor INT NOT NULL,
  CNPJ_Editora CHAR(14) NOT NULL,
  CONSTRAINT fk_livros_autor
    FOREIGN KEY (Codigo_Autor) REFERENCES Autores (Codigo_Autor),
  CONSTRAINT fk_livros_editora
    FOREIGN KEY (CNPJ_Editora) REFERENCES Editoras (CNPJ)
);

CREATE TABLE Vendas (
  codigo_venda   INT AUTO_INCREMENT PRIMARY KEY,
  Data_Venda DATETIME NOT NULL,
  CPF CHAR(11)  NOT NULL,         
  Codigo_Livro INT NOT NULL,         
  Quantidade INT UNSIGNED NOT NULL,
  Valor_Total DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_vendas_cliente
    FOREIGN KEY (CPF) REFERENCES Clientes (CPF),
  CONSTRAINT fk_vendas_livro
    FOREIGN KEY (Codigo_Livro) REFERENCES Livros (Codigo_Livro)
);

INSERT INTO Autores (Nome, Nacionalidade, Data_Nascimento)
VALUES
  ('Machado de Assis', 'Brasileiro', '1839-06-21'),
  ('J. K. Rowling', 'Britânica', '1965-07-31'),
  ('George Orwell', 'Britânico', '1903-06-25');


INSERT INTO Editoras (CNPJ, Nome_Editora, Endereco, Contato, Telefone, Cidade)
VALUES
  ('12345678000199', 'Editora Globo', 'Rua A, 123', 'Maria Silva', '1122334455', 'São Paulo'),
  ('98765432000155', 'Rocco', 'Av. B, 456', 'João Souza', '1198765432', 'Rio de Janeiro'),
  ('55566677000122', 'Companhia das Letras', 'Rua C, 789', 'Ana Costa', '1133445566', 'São Paulo');


INSERT INTO Clientes (CPF, Nome_Cliente, Email, Telefone, Data_Nascimento)
VALUES
  ('12345678901', 'Carlos Pereira', 'carlos@email.com', '11999998888', '1985-04-12'),
  ('98765432100', 'Fernanda Lima', 'fernanda@email.com', '11911112222', '1990-09-20'),
  ('11122233344', 'João Oliveira', 'joao@email.com', '11888887777', '1975-01-05');


INSERT INTO Livros (Titulo, Genero, Preco, Quantidade, Codigo_Autor, CNPJ_Editora)
VALUES
  ('Dom Casmurro', 'Romance', 39.90, 50, 1, '12345678000199'),
  ('Harry Potter e a Pedra Filosofal', 'Fantasia', 59.90, 100, 2, '98765432000155'),
  ('1984', 'Ficção Científica', 49.90, 80, 3, '55566677000122');


INSERT INTO Vendas (Data_Venda, CPF, Codigo_Livro, Quantidade, Valor_Total)
VALUES
  ('2025-09-20 15:30:00', '12345678901', 1, 1, 39.90),
  ('2025-09-21 10:15:00', '98765432100', 2, 2, 119.80),
  ('2025-09-22 09:00:00', '11122233344', 3, 1, 49.90);
  
-- Consulta * Todos os dados 
select * from autores, Clientes;
select * from Clientes;
select * from editoras;
select * from livros;
select * from vendas;
select * from autores;

-- Consulta por Campos 
select Titulo from livros;
select Nome from autores;
select Titulo, Genero from livros;

-- Consulta por data com condição 
select Titulo, Preco from livros
where Quantidade > 5;

-- Consulta por crescente e decrescente 
select Titulo, Codigo_Livro from livros
order by Codigo_Livro desc; 

-- Consulta por limite de resultado 
select Codigo_Livro from livros
limit 2;

-- Renomer coluna com AS
select Titulo as nome, Quantidade as estoque 
from livros;

-- Funções agregadas 
select count(*) as Total_Livros 
from livros;

select sum(Preco) as Total_Livros_Valor 
from livros;

select avg(Preco) as Total_Livros_media
from livros;

-- Agrupamentos com GROUP BY
select Titulo, count(*) as quantidade 
from livros
group by Titulo;

-- Uso de AND ou OR 
select Titulo, Preco from livros
where Titulo = "Harry Potter e a Pedra Filosofal" and Preco > 30;

select Titulo, Preco from livros
where Titulo = "Harry" or Preco > 30;

-- Condições extras com group by, having e order by 
select Codigo_Autor, count(*) as Total_Livros
from livros
group by Codigo_Autor 
having Total_Livros > 0
order by Total_Livros desc;

-- Uso do like 
select Titulo from livros
where Titulo like '%Harry%';

-- Uso do like com inicio por letras 
select Titulo from livros
where Titulo like '%H%';

-- Uso do like com o termino por letras 
select Titulo from livros
where Titulo like '%Ry%';

-- Uso do like por quantidade de letras 
select Titulo from livros
where Titulo like 'H____Y';

-- Combinando situações 
select Titulo, Preco from livros
where Titulo like '%Harry%'
order by Preco desc;


-- INSERIR 5 REGISTROS EM CADA TABELA

-- AUTORES
INSERT INTO Autores (Nome, Nacionalidade, Data_Nascimento)
VALUES
  ('Machado de Assis', 'Brasileiro', '1839-06-21'),
  ('J. K. Rowling', 'Britânica', '1965-07-31'),
  ('George Orwell', 'Britânico', '1903-06-25'),
  ('José de Alencar', 'Brasileiro', '1829-05-01'),
  ('Clarice Lispector', 'Brasileira', '1920-12-10');

-- EDITORAS
INSERT INTO Editoras (CNPJ, Nome_Editora, Endereco, Contato, Telefone, Cidade)
VALUES
  ('12345678000198', 'Editora Globo', 'Rua A, 123', 'Maria Silva', '1122334455', 'São Paulo'),
  ('98765432000154', 'Rocco', 'Av. B, 456', 'João Souza', '1198765432', 'Rio de Janeiro'),
  ('55566677000121', 'Companhia das Letras', 'Rua C, 789', 'Ana Costa', '1133445566', 'São Paulo'),
  ('22233344000176', 'Saraiva', 'Av. Paulista, 1000', 'Carlos Mendes', '1144556677', 'São Paulo'),
  ('99988877000132', 'Nova Fronteira', 'Rua D, 321', 'Paulo Almeida', '1177889900', 'Rio de Janeiro');

-- CLIENTES
INSERT INTO Clientes (CPF, Nome_Cliente, Email, Telefone, Data_Nascimento)
VALUES
  ('12345678900', 'Carlos Pereira', 'carlos@email.com', '11999998888', '1985-04-12'),
  ('98765432101', 'Fernanda Lima', 'fernanda@email.com', '11911112222', '1990-09-20'),
  ('11122233343', 'João Oliveira', 'joao@email.com', '11888887777', '1975-01-05'),
  ('22233344456', 'Mariana Santos', 'mariana@email.com', '1177778888', '1988-07-15'),
  ('33344455569', 'Ricardo Alves', 'ricardo@email.com', '1166667777', '1982-02-28');

-- LIVROS
INSERT INTO Livros (Titulo, Genero, Preco, Quantidade, Codigo_Autor, CNPJ_Editora)
VALUES
  ('São Bernardo', 'Romance', 85.00, 25, 1, '11122233000199'),
  ('Poemas', 'Poesia', 70.00, 40, 2, '33344455000111'),
  ('Por Quem os Sinos Dobram', 'Ficção', 125.00, 15, 3, '77788899000144'),
  ('O Amor nos Tempos do Cólera', 'Realismo Mágico', 145.00, 20, 4, '66677788000122'),
  ('O Caso dos Dez Negrinhos', 'Mistério', 135.00, 30, 5, '44455566000188');

-- VENDAS
INSERT INTO Vendas (Data_Venda, CPF, Codigo_Livro, Quantidade, Valor_Total)
VALUES
  ('2025-09-20 15:30:00', '12345678901', 1, 1, 39.90),
  ('2025-09-21 10:15:00', '98765432100', 2, 2, 119.80),
  ('2025-09-22 09:00:00', '11122233344', 3, 1, 49.90),
  ('2025-09-25 14:10:00', '22233344455', 4, 1, 120.00),
  ('2025-09-26 17:30:00', '33344455566', 5, 2, 300.00);


-- CONSULTAS

-- Quantidade de livros
SELECT COUNT(*) AS Total_Livros FROM Livros;

-- Livros que começam com "A" e preço > 100
SELECT Titulo, Preco 
FROM Livros
WHERE Titulo LIKE 'A%' AND Preco > 100;

-- Soma do valor das vendas
SELECT SUM(Valor_Total) AS Soma_Vendas FROM Vendas;

-- Quantidade total de livros em estoque
SELECT SUM(Quantidade) AS Estoque_Total FROM Livros;


-- EXCLUSÃO E ALTERAÇÃO

-- Apagar o livro de código 5
DELETE FROM Livros WHERE Codigo_Livro = 5;

-- Alterar tabela e adicionar coluna de ano de publicação
ALTER TABLE Livros ADD COLUMN Ano_Publicacao DATE;

-- Atualizar os livros com anos de publicação
UPDATE Livros SET Ano_Publicacao = '1899-01-01' WHERE Codigo_Livro = 1;
UPDATE Livros SET Ano_Publicacao = '1997-06-26' WHERE Codigo_Livro = 2;
UPDATE Livros SET Ano_Publicacao = '1949-06-08' WHERE Codigo_Livro = 3;
UPDATE Livros SET Ano_Publicacao = '1844-01-01' WHERE Codigo_Livro = 4;





