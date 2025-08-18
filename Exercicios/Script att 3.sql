-- Cria o banco de dados se ele não existir
CREATE DATABASE IF NOT EXISTS sistema_reservas;

-- Seleciona o banco de dados para uso
USE sistema_reservas;

-- 1. Tabela para Usuários (base)
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Funcao VARCHAR(100),
	Telefone varchar(100)
);

-- 2. Tabela para Reservas
CREATE TABLE Reservas (
    ID_Reserva INT AUTO_INCREMENT PRIMARY KEY,
    Data_Solicitacao date,
     Data_Devolucao date,
    Nome_Usuario varchar(100),
    Data_Retirada date
);

-- 3. Tabela para Fabricantes
CREATE TABLE Fabricantes (
    Id_Fabricante INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Fabricante VARCHAR(255) UNIQUE NOT NULL,
    Pais_Origem VARCHAR(100),
    Contato VARCHAR(255),
    Representante VARCHAR(20)
);

-- 4. Tabela para Equipamentos
CREATE TABLE Equipamentos (
    ID_Equipamento INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Equipamento VARCHAR(255) NOT NULL,
    NUM_Serie INT NOT NULL,
    Nome_Setor varchar(155) NOT NULL,
    Status TEXT
);

-- 5. Tabela para Setores
CREATE TABLE Ferramentas (
    ID_Setor INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Setor VARCHAR(255) UNIQUE NOT NULL,
    Responsavel varchar(255) NOT NULL,
    Contato varchar(19),
    localizacao VARCHAR(255)
);
