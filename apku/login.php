<?php
include 'conn.php';

// Periksa apakah permintaan POST berisi data yang sesuai
if(isset($_POST['username']) && isset($_POST['password'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Hindari SQL Injection dengan menggunakan parameterized query
    $stmt = $connect->prepare("SELECT * FROM admin WHERE username=? and password=?");
    $stmt->bind_param("ss", $username, $password);
    $stmt->execute();

    $result = array();
    $queryResult = $stmt->get_result();

    // Ganti logika ini dengan yang sesuai untuk memproses data yang Anda butuhkan
    while ($fetchData = $queryResult->fetch_assoc()) {
        $result[] = $fetchData;
    }

    echo json_encode($result);
} else {
    // Tangani kasus jika data POST yang diperlukan tidak ada
    echo json_encode(array('error' => 'Data tidak lengkap'));
}
?>
