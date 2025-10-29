<?php
header('Content-Type: application/json');
$file = __DIR__ . '/../data/clients.json';

$name = trim($_POST['name'] ?? '');
$email = trim($_POST['email'] ?? '');

if ($name === '' || $email === '') {
    echo json_encode(['success' => false, 'message' => 'Nom et email requis']);
    exit;
}

$data = [];
if (file_exists($file)) {
    $data = json_decode(file_get_contents($file), true);
}

// Déterminer un nouvel id
$ids = array_map(fn($c) => $c['id'], $data);
$newId = $ids ? max($ids) + 1 : 1;

$data[] = ['id' => $newId, 'name' => $name, 'email' => $email];

if (file_put_contents($file, json_encode($data, JSON_PRETTY_PRINT)) === false) {
    echo json_encode(['success' => false, 'message' => 'Erreur écriture fichier']);
    exit;
}

echo json_encode(['success' => true, 'message' => 'Client ajouté']);
