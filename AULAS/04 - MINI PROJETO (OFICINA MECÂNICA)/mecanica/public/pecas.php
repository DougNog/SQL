<?php
require_once __DIR__ . '/../db/conexao.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'criar') {
    $desc = $conn->real_escape_string($_POST['descricao'] ?? '');
    $preco = floatval($_POST['preco'] ?? 0);
    $qtde = intval($_POST['qtde'] ?? 0);
    $conn->query("INSERT INTO pecas (descricao_peca, preco_peca, qtde_estoque_peca) VALUES ('$desc',$preco,$qtde)");
    header("Location: pecas.php"); exit;
}
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'deletar') {
    $id = intval($_POST['id']);
    $conn->query("DELETE FROM pecas WHERE id_peca=$id");
    header("Location: pecas.php"); exit;
}
$result = $conn->query("SELECT * FROM pecas ORDER BY id_peca DESC");
?>

<?php include __DIR__ . '/../includes/header.php'; ?>
<h2>🧩 Peças</h2>

<form method="POST">
  <input type="hidden" name="acao" value="criar">
  <input type="text" name="descricao" placeholder="Descrição da Peça" required>
  <input type="number" step="0.01" name="preco" placeholder="Preço" required>
  <input type="number" name="qtde" placeholder="Qtde em estoque" required>
  <button type="submit">Adicionar Peça</button>
</form>

<table>
<tr><th>ID</th><th>Descrição</th><th>Preço</th><th>Qtde</th><th>Ações</th></tr>
<?php while($row = $result->fetch_assoc()): ?>
<tr>
  <td><?= $row['id_peca'] ?></td>
  <td><?= htmlspecialchars($row['descricao_peca']) ?></td>
  <td>R$ <?= number_format($row['preco_peca'],2,',','.') ?></td>
  <td><?= $row['qtde_estoque_peca'] ?></td>
  <td>
    <form method="POST" style="display:inline" onsubmit="return confirm('Excluir peça?');">
      <input type="hidden" name="acao" value="deletar">
      <input type="hidden" name="id" value="<?= $row['id_peca'] ?>">
      <button class="del">Excluir</button>
    </form>
  </td>
</tr>
<?php endwhile; ?>
</table>

<?php include __DIR__ . '/../includes/footer.php'; ?>
