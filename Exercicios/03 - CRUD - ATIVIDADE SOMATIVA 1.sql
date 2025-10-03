create database Plataforma_Cursos;
use Plataforma_Cursos;

-- Criação da tabela Alunos
CREATE TABLE Alunos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    data_nascimento DATE
);

-- Criação da tabela Cursos
CREATE TABLE Cursos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    carga_horaria INT,
    status ENUM('ativo', 'inativo') NOT NULL
);

-- Criação da tabela Inscrições
CREATE TABLE Inscricoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    curso_id INT,
    data_inscricao DATE,
    FOREIGN KEY (aluno_id) REFERENCES Alunos(id),
    FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

-- Criação da tabela Avaliações
CREATE TABLE Avaliacoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    inscricao_id INT,
    nota DECIMAL(4,2),
    comentario TEXT,
    FOREIGN KEY (inscricao_id) REFERENCES Inscricoes(id)
);

-- Inserindo alunos
INSERT INTO Alunos (nome, email, data_nascimento) VALUES
('Ana Silva', 'ana@email.com', '2000-05-10'),
('Bruno Costa', 'bruno@email.com', '1998-11-23'),
('Carlos Souza', 'carlos@email.com', '1996-01-15'),
('Mariana Lima', NULL, '2002-07-30'),
('Fernanda Alves', 'fernanda@email.com', '1999-03-12');

-- Inserindo cursos
INSERT INTO Cursos (titulo, descricao, carga_horaria, status) VALUES
('Banco de Dados MySQL', 'Curso introdutório de MySQL', 40, 'ativo'),
('Programação em Java', 'Fundamentos de Java', 60, 'ativo'),
('HTML e CSS', 'Criação de páginas web', 25, 'ativo'),
('Python Básico', 'Introdução à linguagem Python', 45, 'ativo'),
('Gestão de Projetos', 'Conceitos de gerenciamento de projetos', 30, 'inativo');

-- Inserindo inscrições
INSERT INTO Inscricoes (aluno_id, curso_id, data_inscricao) VALUES
(1, 1, '2025-01-10'),
(2, 2, '2025-02-15'),
(3, 3, '2025-03-20'),
(4, 4, '2025-04-05'),
(5, 5, '2025-05-01');

-- Inserindo avaliações
INSERT INTO Avaliacoes (inscricao_id, nota, comentario) VALUES
(1, 8.5, 'Bom desempenho, precisa praticar mais.'),
(2, 9.2, 'Excelente participação.'),
(3, 7.8, 'Regular, pode melhorar.'),
(4, 10.0, 'Nota máxima, ótimo trabalho!');

-- Atualizar email de um aluno
UPDATE Alunos
SET email = 'novo_email_ana@email.com'
WHERE id = 1;

-- Alterar carga horária de um curso
UPDATE Cursos
SET carga_horaria = 50
WHERE id = 3;

-- Corrigir nome de aluno
UPDATE Alunos
SET nome = 'Carlos de Souza'
WHERE id = 3;

-- Mudar status de curso
UPDATE Cursos
SET status = 'ativo'
WHERE id = 5;

-- Alterar nota de uma avaliação
UPDATE Avaliacoes
SET nota = 9.5
WHERE id = 3;

-- Excluir uma inscrição
DELETE FROM Inscricoes
WHERE id = 5;

-- Excluir um curso
DELETE FROM Cursos
WHERE id = 4;

-- Excluir uma avaliação ofensiva
DELETE FROM Avaliacoes
WHERE id = 3;

-- Excluir um aluno
DELETE FROM Alunos
WHERE id = 2;

-- Excluir todas inscrições de um curso encerrado (exemplo: curso 5)
DELETE FROM Inscricoes
WHERE curso_id = 5;

-- 1. Listar todos os alunos cadastrados
SELECT * FROM Alunos;

-- 2. Exibir apenas os nomes e e-mails dos alunos
SELECT nome, email FROM Alunos;

-- 3. Listar cursos com carga horária maior que 30 horas
SELECT * FROM Cursos
WHERE carga_horaria > 30;

-- 4. Exibir cursos que estão inativos
SELECT * FROM Cursos
WHERE status = 'inativo';

-- 5. Buscar alunos nascidos após o ano 1995
SELECT * FROM Alunos
WHERE YEAR(data_nascimento) > 1995;

-- 6. Exibir avaliações com nota acima de 9
SELECT * FROM Avaliacoes
WHERE nota > 9;

-- 7. Contar quantos cursos estão cadastrados
SELECT COUNT(*) AS total_cursos
FROM Cursos;

-- 8. Listar os 3 cursos com maior carga horária
SELECT titulo, carga_horaria
FROM Cursos
ORDER BY carga_horaria DESC
LIMIT 3;

-- Criar índice para busca rápida por email de aluno
CREATE INDEX idx_aluno_email ON Alunos(email);
