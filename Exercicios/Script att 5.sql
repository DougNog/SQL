create database REMOTERC;
use remoterc;
select database();

create table produto (
codigo int not null,
unidade char(3) not null,
descricao varchar(30) not null,
valor_unit decimal (7,2) not null,
primary key (codigo)
);
insert into produto
values (1, 'kg', 'Arroz', '30'), (2, 'kg', 'Feijao', '35'), (3, 'kg', 'Eduardo Rocha', '0.50'), (4, 'kg', 'Pao', '2');

select * from produto;

update produto 
set valor_unit = 32.00
where descricao = 'Arroz';

update produto
set valor_unit = 33,
descricao = 'Feijao Preto'
where codigo = 2;

update produto set valor_unit = valor_unit + (valor_unit * 0.10);

create table vendedor (
codigo int not null,
nome varchar(20) not null,
salario decimal(7,2) not null,
fsalarial char(1) not null,
primary key (codigo)
);

select * from vendedor;

insert into vendedor 
values (1,'Eduardo Rocha',3.50, 1),(2,'Douglas', 25000,2);

insert into vendedor
values (3,'Murilo Coletta',0.1, 3);

update vendedor
set salario = 3150
where fsalarial = 1;

update vendedor set salario = salario + (salario * 0.10)
where fsalarial = 2;

update vendedor
set salario = 3500
where fsalarial = 3;

-- dletar valores
insert into vendedor 
values (4,'Hiron',1.50, 4);

delete from vendedor
where salario <2500;

delete from produto;

-- registro unico
delete from produtos where codigo = '01';

-- regsitro multiplo 
delete from vendedor where fsalarial = 2;

-- intervalo (operador AND)
delete from vendedor where fsalarial >= 1 and codigo <= 2;









