import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: RegisterPage(),
  ));
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedLevel = 'user'; // Default level 'user'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pendaftaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: selectedLevel,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedLevel = newValue;
                            });
                          }
                        },
                        items: <String>['admin', 'user'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Level',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          registerUser(
                              context); // Panggil metode registerUser saat tombol ditekan
                        },
                        child: Text('Daftar', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerUser(BuildContext context) async {
    final response = await http.post(
      Uri.parse(
          'http://10.0.2.2/apku/register.php'), // Ganti dengan URL server PHP Anda
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
        'level': selectedLevel,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data berhasil disimpan di server.'),
          backgroundColor: Colors.green,
        ),
      );

      // Membersihkan kolom input setelah berhasil mendaftar
      usernameController.clear();
      passwordController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data di server.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
