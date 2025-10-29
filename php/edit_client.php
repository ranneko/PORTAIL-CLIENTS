<?php
header('Content-Type: application/json');
$file = __DIR__ . '/../data/clients.json';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $id = intval($_GET['id'] ?? 0);
    if (!file_exists($file)) {
        echo json_encode(['success' => false, 'message' => 'Fichier non trouvé']);
        exit;
    }
    $data = json_decode(file_get_contents($file), true);
    foreach ($data as $client) {
        if ($client['id'] === $id) {
            echo json_encode($client);
            exit;
        }
    }
    echo json_encode(['success' => false, 'message' => 'Client non trouvé']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = intval($_POST['id'] ?? 0);
    $name = trim($_POST['name'] ?? '');
    $email = trim($_POST['email'] ?? '');
    if ($id <= 0 || $name === '' || $email === '') {
        echo json_encode(['success' => false, 'message' => 'Données invalides']);
        exit;
    }
    if (!file_exists($file)) {
        echo json_encode(['success' => false, 'message' => 'Fichier non trouvé']);
        exit;
    }
    $data = json_decode(file_get_contents($file), true);
    $found = false;
    foreach ($data as &$client) {
        if ($client['id'] === $id) {
            $client['name'] = $name;
            $client['email'] = $email;
            $found = true;
            break;
        }
    }
    if (!$found) {
        echo json_encode(['success' => false, 'message' => 'Client non trouvé']);
        exit;
    }
    if (file_put_contents($file, json_encode($data, JSON_PRETTY_PRINT)) === false) {
        echo json_encode(['success' => false, 'message' => 'Erreur écriture fichier']);
        exit;
    }
    echo json_encode(['success' => true, 'message' => 'Client modifié']);
}
