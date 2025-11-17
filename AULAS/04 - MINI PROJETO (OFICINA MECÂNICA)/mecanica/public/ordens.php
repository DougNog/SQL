<?php
require_once __DIR__ . '/../db/conexao.php';

$veiculos = $conn->query("SELECT id_veiculo, modelo FROM veiculos ORDER BY modelo");
$mecanicos = $conn->query("SELECT id_mecanico, nome_mecanico FROM mecanicos ORDER BY nome_mecanico");

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'criar') {
    $veiculo = intval($_POST['veiculo'] ?? 0);
    $mecanico = intval($_POST['mecanico'] ?? 0);
    $conn->query("INSERT INTO ordens_servico (data_emissao, id_mecanico, id_veiculo) VALUES (CURDATE(),$mecanico,$veiculo)");
    header("Location: ordens.php"); exit;
}
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'deletar') {
    $id = intval($_POST['id']);
    $conn->query("DELETE FROM ordens_servico WHERE id_os=$id");
    header("Location: ordens.php"); exit;
}

$result = $conn->query("SELECT os.*, v.modelo, m.nome_mecanico
FROM ordens_servico os
LEFT JOIN veiculos v ON os.id_veiculo=v.id_veiculo
LEFT JOIN mecanicos m ON os.id_mecanico=m.id_mecanico
ORDER BY os.id_os DESC");
?>

<?php include __DIR__ . '/../includes/header.php'; ?>
<h2>📋 Ordens de Serviço</h2>

<form method="POST">
  <input type="hidden" name="acao" value="criar">
  <select name="veiculo" required>
    <option value="">Selecione o Veículo</option>
    <?php while($v = $veiculos->fetch_assoc()): ?>
      <option value="<?= $v['id_veiculo'] ?>"><?= htmlspecialchars($v['modelo']) ?></option>
    <?php endwhile; ?>
  </select>
  <select name="mecanico" required>
    <option value="">Selecione o Mecânico</option>
    <?php while($m = $mecanicos->fetch_assoc()): ?>
      <option value="<?= $m['id_mecanico'] ?>"><?= htmlspecialchars($m['nome_mecanico']) ?></option>
    <?php endwhile; ?>
  </select>
  <button type="submit">Criar OS</button>
</form>

<table>
<tr><th>ID</th><th>Data</th><th>Veículo</th><th>Mecânico</th><th>Ações</th></tr>
<?php while($row = $result->fetch_assoc()): ?>
<tr>
  <td><?= $row['id_os'] ?></td>
  <td><?= $row['data_emissao'] ?></td>
  <td><?= htmlspecialchars($row['modelo']) ?></td>
  <td><?= htmlspecialchars($row['nome_mecanico']) ?></td>
  <td>
    <form method="POST" style="display:inline" onsubmit="return confirm('Excluir esta OS?');">
      <input type="hidden" name="acao" value="deletar">
      <input type="hidden" name="id" value="<?= $row['id_os'] ?>">
      <button class="del">Excluir</button>
    </form>
  </td>
</tr>
<?php endwhile; ?>
</table>

<?php include __DIR__ . '/../includes/footer.php'; ?>
