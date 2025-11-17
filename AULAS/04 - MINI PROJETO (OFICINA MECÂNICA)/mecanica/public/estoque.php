<?php
require_once __DIR__ . '/../db/conexao.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'criar') {
    $cap = intval($_POST['capacidade'] ?? 0);
    $resp = $conn->real_escape_string($_POST['responsavel'] ?? '');
    $loc = $conn->real_escape_string($_POST['localizacao'] ?? '');
    $conn->query("INSERT INTO estoque (capacidade_total, responsavel_estoque, localizacao) VALUES ($cap,'$resp','$loc')");
    header("Location: estoque.php"); exit;
}
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'deletar') {
    $id = intval($_POST['id']);
    $conn->query("DELETE FROM estoque WHERE id_estoque=$id");
    header("Location: estoque.php"); exit;
}

$result = $conn->query("SELECT * FROM estoque ORDER BY id_estoque DESC");
?>

<?php include __DIR__ . '/../includes/header.php'; ?>
<h2>📦 Estoque</h2>

<form method="POST">
  <input type="hidden" name="acao" value="criar">
  <input type="number" name="capacidade" placeholder="Capacidade total" required>
  <input type="text" name="responsavel" placeholder="Responsável" required>
  <input type="text" name="localizacao" placeholder="Localização" required>
  <button type="submit">Adicionar Estoque</button>
</form>

<table>
<tr><th>ID</th><th>Capacidade</th><th>Responsável</th><th>Localização</th><th>Ações</th></tr>
<?php while($row = $result->fetch_assoc()): ?>
<tr>
  <td><?= $row['id_estoque'] ?></td>
  <td><?= $row['capacidade_total'] ?></td>
  <td><?= htmlspecialchars($row['responsavel_estoque']) ?></td>
  <td><?= htmlspecialchars($row['localizacao']) ?></td>
  <td>
    <form method="POST" style="display:inline" onsubmit="return confirm('Excluir este estoque?');">
      <input type="hidden" name="acao" value="deletar">
      <input type="hidden" name="id" value="<?= $row['id_estoque'] ?>">
      <button class="del">Excluir</button>
    </form>
  </td>
</tr>
<?php endwhile; ?>
</table>

<?php include __DIR__ . '/../includes/footer.php'; ?>
