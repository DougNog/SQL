<?php

echo "<link rel='stylesheet' href='update.css'>";


$conn = new mysqli("localhost", "root", "senaisp","escola");

$id = $_POST['id'];
$nome = $_POST['nome'];
$endereco = $_POST['endereco'];
$estado = $_POST['estado'];
$cidade = $_POST['cidade'];

$sql = "UPDATE cliente SET nome = '$nome', endereco = '$endereco', estado = '$estado', cidade = '$cidade' WHERE id = $id";

if ($conn->query($sql) === TRUE) {
    echo "Registro atualizado com sucesso.";
    echo "<br><a href='index.html'>Voltar</a>";
} else {
    echo "Erro: " . $conn->error;
}

$conn->close();

?>