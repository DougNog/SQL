<?php

echo "<link rel='stylesheet' href='delet.css'>";

$conn = new mysqli("localhost", 'root', 'senaisp','escola');
if ($conn->connect_error) {
    die('Erro de coneção'. $conn->connect_error);
}

$id = $_GET['id'];

$stmt = $conn->prepare("DELETE FROM cliente WHERE id = ?");
$stmt->bind_param('i',$id);

if ($stmt->execute()) {
    echo'Usuario deletado com sucesso';
} else {
    echo "Erro ao deletar: " . $stmt->error;
}
echo "<br><a href ='list.php'>Voltar para a lista</a>";

$stmt->close();
$conn->close();

?>