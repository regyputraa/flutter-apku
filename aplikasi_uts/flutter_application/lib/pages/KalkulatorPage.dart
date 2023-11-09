import 'package:flutter/material.dart';
import 'package:flutter_application/pages/theme_provider.dart';
import 'package:provider/provider.dart';

class KalkulatorPage extends StatefulWidget {
  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String _output = '0';
  String _currentNumber = '';
  String _operator = '';
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _errorMessage = ''; // Tambahkan variabel pesan kesalahan

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _output = '0';
      _currentNumber = '';
      _operator = '';
      _num1 = 0.0;
      _num2 = 0.0;
      _errorMessage = ''; // Bersihkan pesan kesalahan saat tombol "C" ditekan
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/') {
      if (_currentNumber.isEmpty) {
        _errorMessage = "Masukkan angka terlebih dahulu.";
        return;
      }
      _num1 = double.parse(_currentNumber);
      _operator = buttonText;
      _currentNumber = '';
      _errorMessage = ''; // Bersihkan pesan kesalahan saat operator ditekan
    } else if (buttonText == '=') {
      if (_currentNumber.isEmpty) {
        _errorMessage = "Masukkan angka terlebih dahulu.";
        return;
      }
      _num2 = double.parse(_currentNumber);
      if (_operator == '+') {
        _currentNumber = (_num1 + _num2).toString();
      } else if (_operator == '-') {
        _currentNumber = (_num1 - _num2).toString();
      } else if (_operator == '*') {
        _currentNumber = (_num1 * _num2).toString();
      } else if (_operator == '/') {
        if (_num2 == 0) {
          _errorMessage = "Pembagian oleh nol tidak diizinkan.";
          return;
        }
        _currentNumber = (_num1 / _num2).toString();
      }
      _operator = '';
      _errorMessage = ''; // Bersihkan pesan kesalahan saat hasil diperoleh
    } else {
      _currentNumber += buttonText;
      _errorMessage = ''; // Bersihkan pesan kesalahan saat angka ditambahkan
    }

    setState(() {
      _output = _currentNumber;
    });
  }

  Widget _buildButton(String buttonText) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    Color buttonColor = isDarkMode ? Color(0xFF00425A) : Colors.white;
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color borderColor = isDarkMode ? Color(0xFF00425A) : Colors.grey;

    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            _buttonPressed(buttonText);
          },
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              color: textColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            onPrimary: borderColor,
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Sederhana'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0),
            ),
          ),
          Text(
            _errorMessage,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18.0,
            ),
          ),
          Divider(),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('/'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('*'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('C'),
                    _buildButton('0'),
                    _buildButton('='),
                    _buildButton('+'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
