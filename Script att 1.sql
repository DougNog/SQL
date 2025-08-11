create database Industria_2;
use Industria_2;

create table Clientes (
ID_Cliente int,
Nome_Cliente varchar(255),
CPF_Cliente varchar(18),
Endereço varchar(255),
email varchar(255)
);

create table Produtos (
ID_Produto int,
Nome_Produto varchar(255),
Descricao text,
Preco_Venda decimal,
Estoque_Atual int
);

create table Vendas (
ID_Venda int,
Nome_Cliente varchar(255),
Data_Venda date,
Valor_Total decimal,
Status_Pagamento varchar(50)
);

create table Fornecedores (
ID_Fornecedor int,
Nome_Fornecedor varchar(255),
Contato varchar(255),
Telefone varchar(20),
Email varchar(255)
);

create table Materiais_Primas (
ID_Materia_Prima int,
Nome_Materia_Prima varchar(255),
Descricao text,
estoque_atual int,
preco_custo decimal
);