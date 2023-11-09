import 'package:flutter/material.dart';
import 'theme_provider.dart';

class SettingsPage extends StatelessWidget {
  final ThemeProvider themeProvider;

  SettingsPage({required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Mode Gelap'),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleDarkMode();
              },
            ),
          ),
        ],
      ),
    );
  }
}
