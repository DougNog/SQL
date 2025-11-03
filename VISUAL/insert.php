<?php
$nome = $_POST['nome'] ;
$endereco = $_POST['endereco'] ;
$estado = $_POST['estado'] ;
$cidade = $_POST['cidade'] ;

$conn = new mysqli("localhost", "root", "senaisp", "escola"); // troque senha se necessário

if ($conn->connect_error) {
    die("Erro de conexão: " . $conn->connect_error);
}

$sql = "INSERT INTO cliente (nome, endereco, estado, cidade) VALUES ('$nome','$endereco', '$estado', '$cidade')";
if ($conn->query($sql) === TRUE) {
    echo "Dados salvos com sucesso!";
} else {
    echo "Erro: " . $conn->error;
}

$conn->close();
?>
