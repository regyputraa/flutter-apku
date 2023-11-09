import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_application/pages/KalkulatorPage.dart';
import 'package:flutter_application/pages/KonversiPage.dart';
import 'package:flutter_application/pages/ProfilPage.dart';
import 'package:flutter_application/pages/TaskProvider.dart';
import 'package:flutter_application/pages/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatelessWidget {
  final String username;

  DashboardPage({required this.username});

  void _handleLogout(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.resetToDefault();
    Navigator.pushReplacementNamed(context, '/LoginPage');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Halo! $username', style: TextStyle(fontSize: 20.0)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  return ListView.builder(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            title: Text(taskProvider.tasks[index]),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(username),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/foto_profil.jpg'),
                radius: 48,
              ),
              accountEmail: null,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Color.fromARGB(255, 42, 42, 42)
                    : Color(0xFF00425A),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      fotoProfil: 'assets/foto_profil.jpg',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Kalkulator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KalkulatorPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Konversi Mata Uang'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KonversiMataUangPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting'),
              onTap: () {
                Navigator.pushNamed(context, '/SettingsPage');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _handleLogout(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Example: Show SnackBar when adding a new task
          Provider.of<TaskProvider>(context, listen: false).addTask("New Task");

          // Save tasks to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setStringList(
              'tasks', Provider.of<TaskProvider>(context, listen: false).tasks);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('New task added!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: isDarkMode
            ? Color.fromARGB(255, 18, 168, 18)
            : Color.fromARGB(255, 18, 168, 18),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ConvexAppBar(
        backgroundColor:
            isDarkMode ? Color.fromARGB(255, 42, 42, 42) : Color(0xFF00425A),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.list, title: 'List'),
        ],
        initialActiveIndex: 0,
        onTap: (int index) {
          if (index == 1) {
            Navigator.of(context).pushNamed('/TodoListPage');
          }
        },
      ),
    );
  }
}
