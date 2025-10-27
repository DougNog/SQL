<?php

echo "<link rel='stylesheet' href='edit.css'>";


$conn = new mysqli("localhost", "root", "senaisp","escola");

$id = $_GET['id'];
$result = $conn->query("SELECT * FROM cliente WHERE id = $id");
$row = $result->fetch_assoc();
?>

<form action="update.php" method="POST">
    <input type="hidden" name="id" value="<?php echo $row['id']; ?>">
    nome: <input type="text" name="nome" value="<?php echo $row['nome']; ?>"><br>
    endereco: <input type="text" name="endereco" value="<?php echo $row['endereco']; ?>"><br>
    estado: <input type="text" name="estado" value="<?php echo $row['estado']; ?>"><br>
    cidade: <input type="text" name="cidade" value="<?php echo $row['cidade']; ?>"><br>

    <input type="submit" value="Atualizar">
</form>