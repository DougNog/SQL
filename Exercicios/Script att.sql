create database Industria;
use Industria;

create table cliente (
 id_cliente int,
nome varchar(100),
endereco varchar(255),
telefone varchar(19),
email varchar (255)
);

create table Produtos (
id_produto int,
nome_produto varchar(255),
descricao varchar(255),
preco_unitario decimal,
estoque_atual int
);

create table Funcionário (
id_funcionario int,
nome_funcionário varchar(255),
cargo varchar(255),
telefone varchar(255),
email varchar(255)
);

create table Servico_Manutencao (
id_servico int,
data_solicitacao date,
data_agendamento date,
data_conclusao date,
descricao_problema varchar(255)
);

create table MateriaPrima (
id_materia_prima int,
nome_materia_prima varchar (250),
descricao varchar(250),
estoque_atual int,
preco_custo_unitario decimal
);
