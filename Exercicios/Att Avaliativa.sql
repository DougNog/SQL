
CREATE DATABASE ManutencaoIndustrial;
USE ManutencaoIndustrial; 

CREATE TABLE Fornecedor (
    Fcodigo INT PRIMARY KEY,
    Fnome VARCHAR(100) NOT NULL,
    Status VARCHAR(20) DEFAULT 'Ativo', 
    Cidade VARCHAR(100)
);


CREATE TABLE Peca (
    Pcodigo INT PRIMARY KEY,
    Pnome VARCHAR(100) NOT NULL,
    Cor VARCHAR(50) NOT NULL,
    Peso DECIMAL(10, 2) NOT NULL,
    Cidade VARCHAR(100) NOT NULL
);

-- Tabela Instituicao
CREATE TABLE Instituicao (
    Icodigo INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela Projeto
CREATE TABLE Projeto (
    PRcod INT PRIMARY KEY,
    PRnome VARCHAR(100) NOT NULL,
    Cidade VARCHAR(100),
    Icod INT,
    FOREIGN KEY (Icod) REFERENCES Instituicao(Icodigo)
);

CREATE TABLE Fornecimento (
    Fcod INT,
    Pcod INT,
    PRcod INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY (Fcod, Pcod, PRcod), 
    FOREIGN KEY (Fcod) REFERENCES Fornecedor(Fcodigo) ON DELETE CASCADE,
    FOREIGN KEY (Pcod) REFERENCES Peca(Pcodigo) ON DELETE CASCADE,
    FOREIGN KEY (PRcod) REFERENCES Projeto(PRcod) ON DELETE CASCADE
);


USE ManutencaoIndustrial;


CREATE TABLE Cidade (
    Ccod INT PRIMARY KEY,
    Cnome VARCHAR(100) NOT NULL,
    UF CHAR(2) NOT NULL
);


ALTER TABLE Projeto
DROP CONSTRAINT projeto_icod_fkey; 


ALTER TABLE Projeto
DROP COLUMN Icod;

ALTER TABLE Projeto
ADD COLUMN Ccod INT,
ADD CONSTRAINT fk_projeto_cidade
FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);


ALTER TABLE Fornecedor
ADD COLUMN Fone VARCHAR(20);


ALTER TABLE Fornecedor
DROP COLUMN Cidade;


ALTER TABLE Fornecedor
ADD COLUMN Ccod INT,
ADD CONSTRAINT fk_fornecedor_cidade
FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);


ALTER TABLE Peca
DROP COLUMN Cidade;


ALTER TABLE Peca
ADD COLUMN Ccod INT,
ADD CONSTRAINT fk_peca_cidade
FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);

DROP TABLE Instituicao;


USE ManutencaoIndustrial;


CREATE INDEX idx_fornecedor_ccod ON Fornecedor (Ccod);
CREATE INDEX idx_peca_ccod ON Peca (Ccod);
CREATE INDEX idx_projeto_ccod ON Projeto (Ccod);


CREATE INDEX idx_fornecedor_fnome ON Fornecedor (Fnome);
CREATE INDEX idx_fornecedor_status ON Fornecedor (Status);
CREATE INDEX idx_peca_pnome ON Peca (Pnome);
CREATE INDEX idx_projeto_prnome ON Projeto (PRnome);
CREATE INDEX idx_cidade_cnome_uf ON Cidade (Cnome, UF);

