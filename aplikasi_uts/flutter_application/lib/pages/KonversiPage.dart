import 'package:flutter/material.dart';

class KonversiMataUangPage extends StatefulWidget {
  @override
  _KonversiMataUangPageState createState() => _KonversiMataUangPageState();
}

class _KonversiMataUangPageState extends State<KonversiMataUangPage> {
  double _inputValue = 0.0;
  double _result = 0.0;
  String _selectedCurrency = 'USD'; // Mata uang default

  final List<String> _currencies = ['USD', 'EUR', 'JPY', 'GBP', 'AUD', 'IDR'];

  void _convertCurrency() {
    setState(() {
      // Contoh perhitungan konversi mata uang sederhana
      if (_selectedCurrency == 'USD') {
        _result = _inputValue;
      } else if (_selectedCurrency == 'EUR') {
        _result = _inputValue * 0.85; // Contoh nilai konversi dari USD ke EUR
      } else if (_selectedCurrency == 'JPY') {
        _result = _inputValue * 110.0; // Contoh nilai konversi dari USD ke JPY
      } else if (_selectedCurrency == 'GBP') {
        _result = _inputValue * 0.72; // Contoh nilai konversi dari USD ke GBP
      } else if (_selectedCurrency == 'AUD') {
        _result = _inputValue * 1.33; // Contoh nilai konversi dari USD ke AUD
      } else if (_selectedCurrency == 'IDR') {
        _result = _inputValue *
            15000; // Contoh nilai konversi dari USD ke IDR (1 USD = 15,000 IDR)
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Mata Uang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah uang (USD)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _inputValue = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedCurrency,
              items: _currencies.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCurrency = value ?? 'USD';
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: Text('Konversi', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 20),
            Text(
              'Hasil Konversi: $_result $_selectedCurrency',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: KonversiMataUangPage()));
