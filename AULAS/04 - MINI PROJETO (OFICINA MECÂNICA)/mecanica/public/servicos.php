<?php
require_once __DIR__ . '/../db/conexao.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'criar') {
    $desc = $conn->real_escape_string($_POST['descricao'] ?? '');
    $preco = floatval($_POST['preco'] ?? 0);
    $conn->query("INSERT INTO servicos (descricao_servico, preco_servico) VALUES ('$desc',$preco)");
    header("Location: servicos.php"); exit;
}
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'deletar') {
    $id = intval($_POST['id']);
    $conn->query("DELETE FROM servicos WHERE id_servico=$id");
    header("Location: servicos.php"); exit;
}
$result = $conn->query("SELECT * FROM servicos ORDER BY id_servico DESC");
?>

<?php include __DIR__ . '/../includes/header.php'; ?>
<h2>🧰 Serviços</h2>

<form method="POST">
  <input type="hidden" name="acao" value="criar">
  <input type="text" name="descricao" placeholder="Descrição do Serviço" required>
  <input type="number" step="0.01" name="preco" placeholder="Preço" required>
  <button type="submit">Adicionar Serviço</button>
</form>

<table>
<tr><th>ID</th><th>Descrição</th><th>Preço</th><th>Ações</th></tr>
<?php while($row = $result->fetch_assoc()): ?>
<tr>
  <td><?= $row['id_servico'] ?></td>
  <td><?= htmlspecialchars($row['descricao_servico']) ?></td>
  <td>R$ <?= number_format($row['preco_servico'],2,',','.') ?></td>
  <td>
    <form method="POST" style="display:inline" onsubmit="return confirm('Excluir serviço?');">
      <input type="hidden" name="acao" value="deletar">
      <input type="hidden" name="id" value="<?= $row['id_servico'] ?>">
      <button class="del">Excluir</button>
    </form>
  </td>
</tr>
<?php endwhile; ?>
</table>

<?php include __DIR__ . '/../includes/footer.php'; ?>
