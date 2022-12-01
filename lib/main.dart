import 'package:flutter/material.dart';
import '../map/page.dart';
import 'dashboard/page.dart';
import 'appbar.dart';
import 'package:custom_floating_action_button/custom_floating_action_button.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFed701b),
      onPrimary:  Color(0xFFed701b),
      secondary: Color(0xFF6b6b6b),
      onSecondary: Color(0xFF6b6b6b),
      error: Color(0xFFcb1a1a),
      onError: Color(0xFFcb1a1a),
      background: Colors.white,
      onBackground: Colors.white,
      surface: Colors.black,
      onSurface: Colors.black
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WovonApp',
        theme: ThemeData(
            colorScheme: colorScheme,
            useMaterial3: false),
        darkTheme: ThemeData(
            colorScheme: colorScheme,
            useMaterial3: false),
        themeMode: ThemeMode.light,
        home: CustomFloatingActionButton(
          body: Scaffold(
            backgroundColor: Colors.black,
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight * 2),
              child: WovonAppBar(),
            ),
            body: Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                    borderRadius: BorderRadius.only(
                        bottomLeft:  Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)
                    )
                ),
                child: _pages[_selectedIndex]
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: ""
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.map_rounded),
                    label: ""
                ),
              ],
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Colors.black,
              selectedItemColor: const Color(0xFFed701b),
              unselectedItemColor: Colors.white,
              onTap: _onDestinationSelected,
              currentIndex: _selectedIndex,
            )


            // NavigationBar(
            //   selectedIndex: _selectedIndex,
            //   onDestinationSelected: _onDestinationSelected,
            //   destinations: const [
            //     NavigationDestination(
            //       icon: Icon(Icons.dashboard),
            //       label: "Dashboard",
            //     ),
            //     NavigationDestination(
            //       icon: Icon(Icons.map),
            //       label: "Map",
            //     ),
            //   ],
            // ),
          ),
          openFloatingActionButton: const Icon(Icons.add, color: Colors.white),
          closeFloatingActionButton: const Icon(Icons.close, color: Colors.white),
          options: [
            GestureDetector(
              onTap: () async {
                var url = Uri.https("wa.me", "/+5491124649778");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              child:  const CircleAvatar(
                backgroundColor: Color(0xFF25d366),
                child: Icon(Icons.whatsapp, color: Colors.white),
              ),
            ),
            GestureDetector(
              onTap: () async {
                var url = Uri.https("t.me", "/wovonbot");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              child:  const CircleAvatar(
                backgroundColor: Color(0xFF0088cc),
                child: Icon(Icons.telegram, color: Colors.white),
              ),
            ),
          ],
          type: CustomFloatingActionButtonType.verticalUp,
          floatinButtonColor: const Color(0xFFed701b),
          backgroundColor: Colors.transparent,
        )
    );
  }
}