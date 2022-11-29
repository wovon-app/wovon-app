import 'package:flutter/material.dart';
import '../map/page.dart';
import 'dashboard/page.dart';
import 'appbar.dart';

void main() {
  runApp(const WovonApp());
}

class WovonApp extends StatefulWidget {
  const WovonApp({super.key});

  @override
  State<WovonApp> createState() => _WovonAppState();
}

class _WovonAppState extends State<WovonApp> {
  int _selectedIndex = 0;

  static const TextStyle _textStyle =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  final List<Widget> _pages = [
    const DashboardPage(),
    const MapPage(),
  ];

  void _onDestinationSelected(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WovonApp',
        theme: ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true),
        darkTheme: ThemeData(
            colorSchemeSeed: Colors.orange,
            useMaterial3: true,
            brightness: Brightness.dark),
        themeMode: ThemeMode.light,
        home: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight * 2),
            child: WovonAppBar(),
          ),
          body: _pages[_selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard),
                label: "Dashboard",
              ),
              NavigationDestination(
                icon: Icon(Icons.map),
                label: "Map",
              ),
            ],
          ),
        ));
  }
}
