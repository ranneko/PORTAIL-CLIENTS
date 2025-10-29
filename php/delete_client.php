<?php
header('Content-Type: application/json');
$file = __DIR__ . '/../data/clients.json';

$id = intval($_POST['id'] ?? 0);
if ($id <= 0) {
    echo json_encode(['success' => false, 'message' => 'ID client invalide']);
    exit;
}
if (!file_exists($file)) {
    echo json_encode(['success' => false, 'message' => 'Fichier non trouvé']);
    exit;
}
$data = json_decode(file_get_contents($file), true);
$newData = array_filter($data, fn($c) => $c['id'] !== $id);
if (count($newData) === count($data)) {
    echo json_encode(['success' => false, 'message' => 'Client non trouvé']);
    exit;
}
if (file_put_contents($file, json_encode(array_values($newData), JSON_PRETTY_PRINT)) === false) {
    echo json_encode(['success' => false, 'message' => 'Erreur écriture fichier']);
    exit;
}
echo json_encode(['success' => true, 'message' => 'Client supprimé']);
