import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String fotoProfil; // Tambahkan parameter foto profil

  ProfilePage({required this.fotoProfil});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 400, // Atur lebar Container sesuai preferensi
              height: 400, // Atur tinggi Container sesuai preferensi
              child: Card(
                elevation: 8, // Tambahkan bayangan (shadow) pada Card
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                          20.0), // Atur jarak dari semua sisi
                      child: Container(
                        width: 160, // Atur lebar Container sesuai preferensi
                        height: 160, // Atur tinggi Container sesuai preferensi
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .circle, // Mengatur bentuk menjadi lingkaran
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, // Warna bayangan
                              blurRadius: 5, // Ukuran blur
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage(
                              fotoProfil), // Gunakan foto profil dari parameter
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Regy Putra Adithia',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '15-2020-079',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'regy.putra@mhs.itenas.ac.id',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
