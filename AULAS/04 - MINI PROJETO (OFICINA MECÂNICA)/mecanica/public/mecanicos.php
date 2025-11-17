<?php
require_once __DIR__ . '/../db/conexao.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'criar') {
    $nome = $conn->real_escape_string($_POST['nome'] ?? '');
    $cpf  = $conn->real_escape_string($_POST['cpf'] ?? '');
    $conn->query("INSERT INTO mecanicos (cpf_mecanico, nome_mecanico) VALUES ('$cpf','$nome')");
    header("Location: mecanicos.php"); exit;
}
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'deletar') {
    $id = intval($_POST['id']);
    $conn->query("DELETE FROM mecanicos WHERE id_mecanico=$id");
    header("Location: mecanicos.php"); exit;
}

$result = $conn->query("SELECT * FROM mecanicos ORDER BY id_mecanico DESC");
?>

<?php include __DIR__ . '/../includes/header.php'; ?>
<h2>🔧 Mecânicos</h2>

<form method="POST">
  <input type="hidden" name="acao" value="criar">
  <input type="text" name="nome" placeholder="Nome do Mecânico" required>
  <input type="text" name="cpf" placeholder="CPF" required>
  <button type="submit">Adicionar</button>
</form>

<table>
<tr><th>ID</th><th>Nome</th><th>CPF</th><th>Ações</th></tr>
<?php while($row = $result->fetch_assoc()): ?>
<tr>
  <td><?= $row['id_mecanico'] ?></td>
  <td><?= htmlspecialchars($row['nome_mecanico']) ?></td>
  <td><?= htmlspecialchars($row['cpf_mecanico']) ?></td>
  <td>
    <form method="POST" style="display:inline" onsubmit="return confirm('Excluir mecânico?');">
      <input type="hidden" name="acao" value="deletar">
      <input type="hidden" name="id" value="<?= $row['id_mecanico'] ?>">
      <button class="del">Excluir</button>
    </form>
  </td>
</tr>
<?php endwhile; ?>
</table>

<?php include __DIR__ . '/../includes/footer.php'; ?>
