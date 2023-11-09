import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String username = '';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String msg = '';

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2/apku/login.php"),
      body: {
        "username": usernameController.text,
        "password": passwordController.text.toString(),
      },
    );

    if (response.statusCode == 200) {
      var datauser = json.decode(response.body);

      if (datauser.isNotEmpty) {
        if (datauser[0]['level'] == 'admin') {
          Navigator.pushReplacementNamed(context, '/AdminPage');
        } else if (datauser[0]['level'] == 'user') {
          Navigator.pushReplacementNamed(context, '/DashboardPage');
        }

        setState(() {
          username = datauser[0]['username'];
        });
      } else {
        setState(() {
          msg = "Login Fail";
        });
      }
    } else {
      setState(() {
        msg = "HTTP Request Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF00425A), // Ubah warna atas
              Color(0xFF00425A), // Ubah warna bawah
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book,
                      size: 40,
                      color: Colors.white, // Ubah warna ikon
                    ),
                    SizedBox(width: 10),
                    Text(
                      'APKU',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ubah warna teks
                      ),
                    ),
                  ],
                ),
                Card(
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Colors.white, // Ubah warna tombol Login
                                padding: EdgeInsets.symmetric(horizontal: 40),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Color(
                                        0xFF00425A)), // Ubah warna teks tombol
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/RegisterPage');
                              },
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Colors.white, // Ubah warna tombol Register
                                padding: EdgeInsets.symmetric(horizontal: 40),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Color(
                                        0xFF00425A)), // Ubah warna teks tombol
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          msg,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
