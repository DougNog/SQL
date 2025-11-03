<?php

echo "<link rel='stylesheet' href='list.css'>";


$conn = new mysqli("localhost", "root", "senaisp","escola");
$result = $conn->query("SELECT * FROM cliente");

echo "<h2>Usuarios</h2>";
echo "<table border = '1'>";
echo "<tr><th>ID</th><th>Nome</th><th>Estado</th><th>Cidade</th></tr>";

while ($row = $result->fetch_assoc()) {
    echo " <tr>
    <td>{$row['nome']}</td>
    <td>{$row['endereco']}</td>
    <td>{$row['estado']}</td>
    <td>{$row['cidade']}</td>
    <td><a href = 'edit.php?id={$row['id']}'>Editar</a></td>
    </tr>";
}
echo "</table>";
$conn -> close();

?>
