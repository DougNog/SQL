<?php
// db/conexao.php
$host = "localhost";
$user = "root";
$pass = "senaisp"; 
$db   = "mecanica";
$port = 3306; 

$conn = new mysqli($host, $user, $pass, $db, $port);
if ($conn->connect_error) {
    die("Erro de conexão com o MySQL: " . $conn->connect_error);
}
$conn->set_charset('utf8');
?>
