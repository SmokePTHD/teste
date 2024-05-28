<?php

include('conexao.php');

$sql = "SELECT id, nome, apelido, email, telemovel, status, cargo, foto FROM usuarios";
$result = $conn->query($sql);

function formatarTelefone($telefone) {
    return preg_replace("/(\+351)(\d{3})(\d{3})(\d{3})/", "$1 $2 $3 $4", $telefone);
}

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $nome = $row['nome'];
        $apelido = $row['apelido'];
        $iniciais = strtoupper(substr($nome, 0, 1) . substr($apelido, 0, 1));
        $telemovel = formatarTelefone($row['telemovel']);

        echo '<tr>';
        echo '<td class="align-middle fs-0 py-3">';
        echo '<div class="form-check mb-0">';
        echo '<input class="form-check-input" type="checkbox" id="table-view-tickets-' . $row['id'] . '" data-bulk-select-row="data-bulk-select-row" />';
        echo '</div>';
        echo '</td>';
        echo '<td class="align-middle client white-space-nowrap pe-3 pe-xxl-4 ps-2">';
        echo '<div class="d-flex align-items-center gap-2 position-relative">';
        echo '<div class="avatar avatar-xl">';
        if (!empty($row['foto'])) {
            echo '<img class="rounded-circle" src="' . $row['foto'] . '" alt="Foto de ' . $nome . ' ' . $apelido . '">';
        } else {
            echo '<div class="avatar-name rounded-circle"><span>' . $iniciais . '</span></div>';
        }
        echo '</div>';
        echo '<h6 class="mb-0"><a class="stretched-link text-900" href="#">' . $nome . ' ' . $apelido . '</a></h6>';
        echo '</div>';
        echo '</td>';
        echo '<td class="align-middle subject py-2 pe-4"><a class="fw-semi-bold" href="#">' . $row['email'] . '</a></td>';
        echo '<td class="align-middle subject py-2 pe-4"><a class="fw-semi-bold">' . $telemovel . '</a></td>';
        echo '<td class="align-middle status fs-0 pe-4"><small class="badge rounded badge-soft-' . ($row['status'] == 'online' ? 'success' : 'secondary') . '">' . ucfirst($row['status']) . '</small></td>';
        echo '<td class="align-middle agent">';
        echo '<select class="form-select form-select-sm w-auto ms-auto" aria-label="agents actions">';
        echo '<option' . ($row['cargo'] == 'Selecionar Cargo' ? ' selected="selected"' : '') . '>Selecionar Cargo</option>';
        echo '<option' . ($row['cargo'] == 'Dona' ? ' selected="selected"' : '') . '>Dona</option>';
        echo '<option' . ($row['cargo'] == 'Gestor' ? ' selected="selected"' : '') . '>Gestor</option>';
        echo '<option' . ($row['cargo'] == 'Khalid' ? ' selected="selected"' : '') . '>Khalid</option>';
        echo '</select>';
        echo '</td>';
        echo '</tr>';
    }
} else {
    echo '<tr><td colspan="6" class="text-center">Sem Funcionarios</td></tr>';
}

$conn->close();
?>
