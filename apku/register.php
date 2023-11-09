<?php
include 'conn.php';

if (isset($_POST['username']) && isset($_POST['password']) && isset($_POST['level'])) {
  $username = $_POST['username'];
  $password = $_POST['password'];
  $level = $_POST['level'];

  // Cek apakah username sudah ada di database
  $checkQuery = "SELECT * FROM admin WHERE username = ?";
  $stmt = $connect->prepare($checkQuery);
  $stmt->bind_param("s", $username);
  $stmt->execute();
  $stmt->store_result();

  if ($stmt->num_rows > 0) {
    // Username sudah ada, kirim respons error
    $response = array('error' => 'Username sudah digunakan');
  } else {
    // Username belum ada, lakukan pendaftaran
    $insertQuery = "INSERT INTO admin (username, password, level) VALUES (?, ?, ?)";
    $insertStmt = $connect->prepare($insertQuery);
    $insertStmt->bind_param("sss", $username, $password, $level);

    if ($insertStmt->execute()) {
      // Pendaftaran sukses
      $response = array('success' => 'Pendaftaran berhasil');
    } else {
      // Gagal melakukan pendaftaran
      $response = array('error' => 'Pendaftaran gagal');
    }
  }

  echo json_encode($response);
} else {
  // Data POST yang diperlukan tidak lengkap
  echo json_encode(array('error' => 'Data tidak lengkap'));
}
