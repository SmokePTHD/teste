<?php 
$host = '';
$dbuser = '';
$dbpass = '';
$dbtable = '';

$conn = mysqli_connect($host, $dbuser, $dbpass, $dbtable);

if (!$conn) {
    die('ERRO: '. mysqli_connect_error());
}

return $conn;

?>