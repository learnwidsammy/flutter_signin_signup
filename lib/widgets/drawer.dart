import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final ThemeData currentTheme;
  final bool isDarkMode;
  final Function(bool) onToggleTheme;
  final List<Map<String, dynamic>> drawerItems;
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AppDrawer({
    super.key,
    required this.currentTheme,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.drawerItems,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: currentTheme.cardColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blueGrey),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sammy B. Chhetri',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Merokhoj@gmail.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Courses'),
              selected: selectedIndex == 0,
              onTap: () => onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Schedule'),
              selected: selectedIndex == 1,
              onTap: () => onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text('Progress'),
              selected: selectedIndex == 2,
              onTap: () => onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              selected: selectedIndex == 3,
              onTap: () => onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}