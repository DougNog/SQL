create database EXEMPLO3;
use EXEMPLO3;

create table if not exists Clientes (
COD_Cliente int auto_increment primary key not null,
Nome_Cliente varchar(100) not null,
CPF_Cliente varchar(14) not null,
Endereco varchar(100) not null,
Estado char(2) default 'SP',
Celular varchar(19) not null
);

create table if not exists Produto (
COD_Produto int auto_increment primary key not null,
Nome_Produto varchar(255) not null,
Qtde int,
Valor decimal (5,2) not null,
descicao varchar(255)
);

create table Fornecedor (
COD_Fornecedor int auto_increment not null,
Nome_Fornecedor varchar(100) not null,
CNPJ varchar(18) not null,
Celular varchar(19) not null,
Endereco varchar(100) not null,
primary key (COD_Fornecedor)
);

create table Tem (
COD_Tem int auto_increment primary key not null,
COD_Fornecedor int,
COD_Produto int,
foreign key (COD_Produto) references Produto (COD_Produto),
foreign key (COD_Fornecedor) references Fornecedor (COD_Fornecedor)
);

-- Acresentar o campo cidade em clientes --
-- Alterar o campo valor produtos para decimal (7,2)
-- Acresentar o campo cidade e estado em fornecedor e definir o estado como padrão 'SP'

alter table Clientes
add Cidade char(40);

alter table Produto
modify column Valor decimal(7,2);

alter table Fornecedor
add Cidade char(40);
add Estado char(2) default 'SP';
