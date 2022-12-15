<?php
session_start();

require '../../src/auxiliar.php';

$id = obtener_post('id');

// if (!comprobar_csrf()) {
//     return volver_admin();
// }

if (!isset($id)) {
    return volver_admin();
}


$pdo = conectar();
$sent = $pdo->prepare("UPDATE validados 
                               SET validado = false
                            WHERE id = :id");
$sent->execute([':id' => $id]);

$_SESSION['exito'] = 'El usuario se ha invalidado correctamente.';

volver_admin_user();
