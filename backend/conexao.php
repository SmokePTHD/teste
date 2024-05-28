<?php 
$host = 'localhost';
$dbuser = 'root';
$dbpass = '';
$dbtable = 'clinica-rio-este';

$conn = mysqli_connect($host, $dbuser, $dbpass, $dbtable);

if (!$conn) {
    die('ERRO: '. mysqli_connect_error());
}

return $conn;
?>
