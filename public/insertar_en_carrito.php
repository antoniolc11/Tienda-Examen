<?php
session_start();

require '../vendor/autoload.php';

try {
    $id = obtener_get('id');

    if ($id === null) {
        return volver();
    }

    $pdo = conectar();
    $sent = $pdo->query("SELECT * FROM articulos WHERE id = $id");
    $articulo = $sent->fetch();

    if ($articulo['unidades'] <= 0) {
        $_SESSION['error'] = 'No existen unidades del producto que quiere seleccionar.';
        return volver();
    }

    $carrito = unserialize(carrito());
    $carrito->insertar($id);
    $_SESSION['carrito'] = serialize($carrito);
} catch (ValueError $e) {
    // TODO: mostrar mensaje de error en un Alert
}

volver();
