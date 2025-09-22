create database BIBLIOTECA;
use biblioteca;

create table livros (
codigo int not null,
nome varchar(100) not null,
ano_lancamento int not null,
autor varchar(100) not null,
primary key (codigo)
);

select * from livros;

ALTER TABLE livros
ADD COLUMN editora VARCHAR(100),
ADD COLUMN genero VARCHAR(50);

INSERT INTO livros (codigo, nome, ano_lancamento, autor, editora, genero) VALUES
(1, 'A Química do Amor', 2005, 'Dra. Elara Vance', 'Editora Saber Químico', 'Romance Científico');

INSERT INTO livros (codigo, nome, ano_lancamento, autor, editora, genero) VALUES
(2, 'Manutenção Industrial Avançada', 2018, 'Eng. Carlos Andrade', 'Editora Técnica Prática', 'Engenharia Industrial');

INSERT INTO livros (codigo, nome, ano_lancamento, autor, editora, genero) VALUES
(3, 'Automação na Indústria Química', 2022, 'Dra. Sofia Mendes', 'Inovação Publicações', 'Tecnologia Industrial');

INSERT INTO livros (codigo, nome, ano_lancamento, autor, editora, genero) VALUES
(4, 'Gestão de Projetos para Engenheiros', 2015, 'Prof. Ricardo Silva', 'Liderança Editorial', 'Gestão e Planejamento');

INSERT INTO livros (codigo, nome, ano_lancamento, autor, editora, genero) VALUES
(5, 'Segurança em Processos Químicos', 2019, 'Dr. Eduardo Costa', 'Segurança Corporativa', 'Segurança do Trabalho');

UPDATE livros
SET ano_lancamento = 2006,
    editora = 'Nova Visão Editora'
WHERE codigo = 1;

UPDATE livros
SET genero = 'Engenharia e Gestão'
WHERE codigo = 4;

UPDATE livros
SET autor = 'Eng. Carlos Andrade Junior'
WHERE codigo = 2;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create table funcionarios (
codigo int not null,
nome varchar(100) not null,
cargo varchar(100) not null,
salario decimal(7,2) not null,
primary key (codigo)
);

select * from funcionarios;

ALTER TABLE funcionarios
ADD COLUMN data_contratacao DATE,
ADD COLUMN departamento VARCHAR(50);

INSERT INTO funcionarios (codigo, nome, cargo, salario, data_contratacao, departamento) VALUES
(1, 'Ana Paula Gomes', 'Gerente de Manutenção', 9500.00, '2010-03-15', 'Manutenção');

INSERT INTO funcionarios (codigo, nome, cargo, salario, data_contratacao, departamento) VALUES
(2, 'Bruno Santos Lima', 'Engenheiro de Produção', 7800.00, '2015-07-01', 'Produção');

INSERT INTO funcionarios (codigo, nome, cargo, salario, data_contratacao, departamento) VALUES
(3, 'Carla Oliveira Rocha', 'Técnica de Instrumentação', 4200.50, '2018-11-20', 'Manutenção');

INSERT INTO funcionarios (codigo, nome, cargo, salario, data_contratacao, departamento) VALUES
(4, 'Daniel Alves Costa', 'Analista de Processos', 6100.75, '2017-09-10', 'Engenharia');

INSERT INTO funcionarios (codigo, nome, cargo, salario, data_contratacao, departamento) VALUES
(5, 'Elisa Pereira Silva', 'Coordenadora de Projetos', 8900.25, '2013-05-25', 'Projetos');

UPDATE funcionarios
SET salario = 10000.00
WHERE codigo = 1;

UPDATE funcionarios
SET departamento = 'Pesquisa e Desenvolvimento',
    data_contratacao = '2017-09-01'
WHERE codigo = 4;

UPDATE funcionarios
SET cargo = 'Especialista em Instrumentação'
WHERE codigo = 3;

-- apagando tabelas 
delete from funcionarios;
delete from livros;
