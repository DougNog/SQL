<?php

$conn = new mysqli("localhost", "root", "senaisp","livraria");

$id = $_POST['id'];
$nome = $_POST['nome'];
$email = $_POST['email'];

$sql = "UPDATE usuarios SET nome = '$nome', email = '$email' WHERE id_usuario = $id";

if ($conn->query($sql) === TRUE) {
    echo "Registro atualizado com sucesso.";
    echo "<br><a href='index.html'>Voltar</a>";
} else {
    echo "Erro: " . $conn->error;
}

$conn->close();

?>