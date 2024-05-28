<?php
session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $usuario = $_POST['usuario'];
    $password = $_POST['password'];

    include("./conexao.php");

    if ($conn) {
        $stmt = $conn->prepare("SELECT id, password, cargo FROM usuarios WHERE (usuario = ? OR email = ?)");
        if ($stmt) {
            $stmt->bind_param("ss", $usuario, $usuario);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows == 1) {
                $row = $result->fetch_assoc();
                if (password_verify($password, $row['password'])) {
                    $_SESSION['user_id'] = $row['id'];
                    $_SESSION['usuario'] = $usuario;
                    $_SESSION['cargo'] = $row['cargo'];

                    $stmt_update = $conn->prepare("UPDATE usuarios SET status = 'online' WHERE id = ?");
                    if ($stmt_update) {
                        $stmt_update->bind_param("i", $row['id']);
                        $stmt_update->execute();
                        $stmt_update->close();
                    } else {
                        error_log("Erro ao preparar a atualização de status: " . $conn->error);
                    }
                    
                    header("Location: ../index.php");
                    exit();
                } else {
                    header("Location: ../pages/authentication/login.html");
                    exit();
                }
            } else {
                header("Location: ../pages/authentication/login.html");
                exit();
            }

            $stmt->close();
        } else {
            error_log("Erro ao preparar a consulta: " . $conn->error);
        }
        
        $conn->close();
    } else {
        error_log("Erro na conexão com o banco de dados");
    }
}
?>
