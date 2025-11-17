<?php
require_once __DIR__ . '/../db/conexao.php';

// criar
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'criar') {
    $nome = $conn->real_escape_string($_POST['nome'] ?? '');
    $cpf  = $conn->real_escape_string($_POST['cpf'] ?? '');
    $conn->query("INSERT INTO clientes (cpf_cliente, nome_cliente) VALUES ('$cpf','$nome')");
    header("Location: clientes.php"); exit;
}

// editar (exibe form via GET?id=)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'editar') {
    $id = intval($_POST['id']);
    $nome = $conn->real_escape_string($_POST['nome'] ?? '');
    $cpf  = $conn->real_escape_string($_POST['cpf'] ?? '');
    $conn->query("UPDATE clientes SET nome_cliente='$nome', cpf_cliente='$cpf' WHERE id_cliente=$id");
    header("Location: clientes.php"); exit;
}

// deletar
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'deletar') {
    $id = intval($_POST['id']);
    $conn->query("DELETE FROM clientes WHERE id_cliente=$id");
    header("Location: clientes.php"); exit;
}

$result = $conn->query("SELECT * FROM clientes ORDER BY id_cliente DESC");
$edit = null;
if(isset($_GET['id'])){
    $id = intval($_GET['id']);
    $r = $conn->query("SELECT * FROM clientes WHERE id_cliente=$id")->fetch_assoc();
    if($r) $edit = $r;
}
?>

<?php include __DIR__ . '/../includes/header.php'; ?>
<h2>👤 Clientes</h2>

<?php if($edit): ?>
<form method="POST">
  <input type="hidden" name="acao" value="editar">
  <input type="hidden" name="id" value="<?= $edit['id_cliente'] ?>">
  <input type="text" name="nome" value="<?= htmlspecialchars($edit['nome_cliente']) ?>" placeholder="Nome" required>
  <input type="text" name="cpf" value="<?= htmlspecialchars($edit['cpf_cliente']) ?>" placeholder="CPF" required>
  <button type="submit">Salvar Alterações</button>
  <a class="botao" href="clientes.php" style="background:#777;padding:10px;border-radius:6px;text-decoration:none;color:#fff">Cancelar</a>
</form>
<?php else: ?>
<form method="POST">
  <input type="hidden" name="acao" value="criar">
  <input type="text" name="nome" placeholder="Nome" required>
  <input type="text" name="cpf" placeholder="CPF" required>
  <button type="submit">Adicionar Cliente</button>
</form>
<?php endif; ?>

<table>
<tr><th>ID</th><th>Nome</th><th>CPF</th><th>Ações</th></tr>
<?php while($row = $result->fetch_assoc()): ?>
<tr>
  <td><?= $row['id_cliente'] ?></td>
  <td><?= htmlspecialchars($row['nome_cliente']) ?></td>
  <td><?= htmlspecialchars($row['cpf_cliente']) ?></td>
  <td>
    <a href="clientes.php?id=<?= $row['id_cliente'] ?>" class="botao" style="background:#117a65;padding:6px 10px">Editar</a>
    <form method="POST" style="display:inline" onsubmit="return confirm('Excluir cliente?');">
      <input type="hidden" name="acao" value="deletar">
      <input type="hidden" name="id" value="<?= $row['id_cliente'] ?>">
      <button class="del">Excluir</button>
    </form>
  </td>
</tr>
<?php endwhile; ?>
</table>

<?php include __DIR__ . '/../includes/footer.php'; ?>
