<?php
require_once __DIR__ . '/../db/conexao.php';

// criar
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'criar') {
    $nome = $conn->real_escape_string($_POST['nome'] ?? '');
    $cpf  = $conn->real_escape_string($_POST['cpf'] ?? '');
    $conn->query("INSERT INTO clientes (cpf_cliente, nome_cliente) VALUES ('$cpf','$nome')");
    header("Location: clientes.php"); exit;
}

// editar
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'editar') {
    $id = intval($_POST['id']);
    $nome = $conn->real_escape_string($_POST['nome'] ?? '');
    $cpf  = $conn->real_escape_string($_POST['cpf'] ?? '');
    $conn->query("UPDATE clientes SET nome_cliente='$nome', cpf_cliente='$cpf' WHERE id_cliente=$id");
    header("Location: clientes.php"); exit;
}

// deletar - SOLUÇÃO COMPLETA E TESTADA
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['acao'] ?? '') === 'deletar') {
    $id = intval($_POST['id']);
    
    // Iniciar transação para garantir que tudo seja excluído ou nada seja
    $conn->begin_transaction();
    
    try {
        // 1. Buscar TODOS os veículos deste cliente
        $veiculos_result = $conn->query("SELECT id_veiculo FROM veiculos WHERE id_cliente = $id");
        
        if ($veiculos_result->num_rows > 0) {
            // Para CADA veículo do cliente
            while ($veiculo = $veiculos_result->fetch_assoc()) {
                $id_veiculo = $veiculo['id_veiculo'];
                
                // 2. Buscar TODAS as ordens de serviço deste veículo
                $ordens_result = $conn->query("SELECT id_os FROM ordens_servico WHERE id_veiculo = $id_veiculo");
                
                if ($ordens_result->num_rows > 0) {
                    // Para CADA ordem de serviço
                    while ($ordem = $ordens_result->fetch_assoc()) {
                        $id_os = $ordem['id_os'];
                        
                        // 3. Excluir da tabela os_pecas
                        $conn->query("DELETE FROM os_pecas WHERE id_os = $id_os");
                        
                        // 4. Excluir da tabela os_servicos  
                        $conn->query("DELETE FROM os_servicos WHERE id_os = $id_os");
                    }
                    
                    // 5. Excluir TODAS as ordens de serviço do veículo
                    $conn->query("DELETE FROM ordens_servico WHERE id_veiculo = $id_veiculo");
                }
            }
            
            // 6. Excluir TODOS os veículos do cliente
            $conn->query("DELETE FROM veiculos WHERE id_cliente = $id");
        }
        
        // 7. FINALMENTE excluir o cliente
        $conn->query("DELETE FROM clientes WHERE id_cliente = $id");
        
        // Confirmar todas as exclusões
        $conn->commit();
        
        header("Location: clientes.php"); 
        exit;
        
    } catch (Exception $e) {
        // Se der erro, desfazer tudo
        $conn->rollback();
        die("Erro ao excluir cliente: " . $e->getMessage());
    }
}

// Buscar clientes para exibir
$result = $conn->query("SELECT * FROM clientes ORDER BY id_cliente DESC");
$edit = null;

if(isset($_GET['id'])){
    $id = intval($_GET['id']);
    $r = $conn->query("SELECT * FROM clientes WHERE id_cliente = $id")->fetch_assoc();
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
    <form method="POST" style="display:inline" onsubmit="return confirm('⚠️ ATENÇÃO: Esta ação excluirá permanentemente o cliente, todos os seus veículos, ordens de serviço, peças e serviços relacionados. Deseja continuar?');">
      <input type="hidden" name="acao" value="deletar">
      <input type="hidden" name="id" value="<?= $row['id_cliente'] ?>">
      <button type="submit" class="del">Excluir</button>
    </form>
  </td>
</tr>
<?php endwhile; ?>
</table>

<?php include __DIR__ . '/../includes/footer.php'; ?>