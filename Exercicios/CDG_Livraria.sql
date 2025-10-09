-- Gera��o de Modelo f�sico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Autores (
Nacionalidade varchar(100),
Data_Nascimento date,
Nome varchar(100),
Codigo_Autor int Auto_Increment PRIMARY KEY,
Codigo_Livro int Auto_Increment
)

CREATE TABLE Editoras (
CNPJ int Auto_Increment PRIMARY KEY,
Nome_Editora varchar(100),
Endereco varchar(100),
Contato varchar(100),
Telefone varchar(100),
Cidade varchar(100),
Codigo_Livro int Auto_Increment
)

CREATE TABLE Clientes (
Nome_Cliente varchar(100),
email varchar(100),
Telefone varchar(100),
CPF varchar(11) PRIMARY KEY,
Data_Nascimento date
)

CREATE TABLE Livros (
Quantidade int,
Autor varchar(100),
Codigo_Livro int Auto_Increment PRIMARY KEY,
Preco varchar(100),
Titulo varchar(100),
Genero varchar(100),
Editora varchar(100)
)

CREATE TABLE Vendas (
Data_Venda date,
Nome_Cliente varchar(100),
Titulo varchar(100),
codigo_venda int Auto_Increment PRIMARY KEY,
Quantidade int,
Valor_Total varchar(100),
CPF varchar(11),
Codigo_Livro int,
FOREIGN KEY(CPF) REFERENCES Clientes (CPF)
)

ALTER TABLE Autores ADD FOREIGN KEY(Codigo_Livro) REFERENCES Livros (Codigo_Livro)
ALTER TABLE Editoras ADD FOREIGN KEY(Codigo_Livro) REFERENCES Livros (Codigo_Livro)
