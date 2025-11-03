<?php

$conn = new mysqli("localhost", "root", "senaisp","livraria");
$result = $conn->query("SELECT * FROM usuarios");

echo "<h2>Usuarios</h2>";
echo "<table border = '1'>";
echo "<tr><th>ID</th><th>Nome</th><th>Email</th><th>Ações</th></tr>";

while ($row = $result->fetch_assoc()) {
    echo " <tr>
    <td>{$row['id_usuario']}</td>
    <td>{$row['nome']}</td>
    <td>{$row['email']}</td>
    <td><a href = 'edit.php?id_usuario={$row['id_usuario']}'>Editar</a></td>
    </tr>";
}
echo "</table>";
$conn -> close();

?>