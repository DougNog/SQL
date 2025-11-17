<?php
require_once __DIR__ . '/../db/conexao.php';

$clientesList = $conn->query("SELECT id_cliente, nome_cliente FROM clientes ORDER BY nome_cliente");

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'criar') {
    $placa = $conn->real_escape_string($_POST['placa'] ?? '');
    $modelo = $conn->real_escape_string($_POST['modelo'] ?? '');
    $ano = intval($_POST['ano'] ?? 0);
    $cliente = intval($_POST['cliente'] ?? 0);
    $conn->query("INSERT INTO veiculos (placa, modelo, ano, id_cliente) VALUES ('$placa','$modelo',$ano,$cliente)");
    header("Location: veiculos.php"); exit;
}
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'deletar') {
    $id = intval($_POST['id']);
    $conn->query("DELETE FROM veiculos WHERE id_veiculo=$id");
    header("Location: veiculos.php"); exit;
}

$result = $conn->query("SELECT v.*, c.nome_cliente FROM veiculos v JOIN clientes c ON v.id_cliente=c.id_cliente ORDER BY v.id_veiculo DESC");
?>

<?php include __DIR__ . '/../includes/header.php'; ?>
<h2>🚗 Veículos</h2>

<form method="POST">
  <input type="hidden" name="acao" value="criar">
  <input type="text" name="placa" placeholder="Placa" required>
  <input type="text" name="modelo" placeholder="Modelo" required>
  <input type="number" name="ano" placeholder="Ano" required min="1950" max="2100">
  <select name="cliente" required>
    <option value="">Selecione o Cliente</option>
    <?php while($c = $clientesList->fetch_assoc()): ?>
      <option value="<?= $c['id_cliente'] ?>"><?= htmlspecialchars($c['nome_cliente']) ?></option>
    <?php endwhile; ?>
  </select>
  <button type="submit">Adicionar Veículo</button>
</form>

<table>
<tr><th>ID</th><th>Placa</th><th>Modelo</th><th>Ano</th><th>Cliente</th><th>Ações</th></tr>
<?php while($row = $result->fetch_assoc()): ?>
<tr>
  <td><?= $row['id_veiculo'] ?></td>
  <td><?= htmlspecialchars($row['placa']) ?></td>
  <td><?= htmlspecialchars($row['modelo']) ?></td>
  <td><?= $row['ano'] ?></td>
  <td><?= htmlspecialchars($row['nome_cliente']) ?></td>
  <td>
    <form method="POST" style="display:inline" onsubmit="return confirm('Excluir veículo?');">
      <input type="hidden" name="acao" value="deletar">
      <input type="hidden" name="id" value="<?= $row['id_veiculo'] ?>">
      <button class="del">Excluir</button>
    </form>
  </td>
</tr>
<?php endwhile; ?>
</table>

<?php include __DIR__ . '/../includes/footer.php'; ?>
