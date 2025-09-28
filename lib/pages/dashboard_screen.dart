import 'package:flutter/material.dart';
import 'package:flutter_signin_signup1/pages/courses.dart';
import 'package:flutter_signin_signup1/pages/progress.dart';
import 'package:flutter_signin_signup1/pages/schedules.dart';
import 'package:flutter_signin_signup1/pages/settings.dart';
import 'package:flutter_signin_signup1/widgets/drawer.dart';
// Import the newly created drawer file

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Simple state management for the theme
  bool _isDarkMode = false;
  // Simple state management for the login status
  bool _isLoggedIn = true;

  // Toggle the theme between light and dark
  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  // Handle Login/Logout action
  void _toggleLoginStatus() {
    setState(() {
      _isLoggedIn = !_isLoggedIn;
    });
    // In a real app, this would navigate to a login screen or clear user data.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isLoggedIn ? 'Logged in successfully!' : 'Logged out.'),
      ),
    );
  }

  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    CoursesPage(),
    SchedulePage(),
    ProgressPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context); // Close drawer
    });
  }

  // Simple list of navigation items for the Drawer
  final List<Map<String, dynamic>> _drawerItems = [
    {'title': 'Dashboard', 'icon': Icons.dashboard},
    {'title': 'Courses', 'icon': Icons.book},
    {'title': 'Schedule', 'icon': Icons.calendar_today},
    {'title': 'Progress', 'icon': Icons.bar_chart},
    {'title': 'Settings', 'icon': Icons.settings},
  ];

  @override
  Widget build(BuildContext context) {
    // Determine the theme data based on the internal state
    final ThemeData theme = _isDarkMode
        ? ThemeData.dark().copyWith(
            // Customize dark theme colors here
            scaffoldBackgroundColor: const Color(0xFF1E1E1E),
            cardColor: const Color(0xFF2C2C2C),
          )
        : ThemeData.light().copyWith(
            // Customize light theme colors here
            scaffoldBackgroundColor: const Color(0xFFF0F0F0),
            cardColor: Colors.white,
          );

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Sams EduToolKit',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // The leading hamburger icon is provided by default by Scaffold
          elevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.textTheme.bodyLarge?.color,
          actions: [
            // Search Icon (which could expand the search bar on tap)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // TODO: Implement search bar expansion or navigation
              },
            ),
            // 3-Dotted Dropdown Menu
            _buildDropdownMenu(theme),
          ],
        ),
        // **UPDATED: Using the external AppDrawer widget**
        drawer: AppDrawer(
          currentTheme: theme,
          isDarkMode: _isDarkMode,
          onToggleTheme: _toggleTheme, // Passing the state-modifying function
          drawerItems: _drawerItems,
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }

  /// Helper Widget: Builds the 3-Dotted Dropdown Menu
  Widget _buildDropdownMenu(ThemeData theme) {
    final String loginText = _isLoggedIn ? 'Logout' : 'Login';
    final IconData loginIcon = _isLoggedIn ? Icons.logout : Icons.login;

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (String result) {
        switch (result) {
          case 'updates':
            // TODO: Navigate to an updates page or show a dialog
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Checking for updates...')),
            );
            break;
          case 'login_logout':
            _toggleLoginStatus();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        // Updates Option
        const PopupMenuItem<String>(
          value: 'updates',
          child: Row(
            children: [
              Icon(Icons.system_update_alt, size: 20),
              SizedBox(width: 8),
              Text('Updates'),
            ],
          ),
        ),
        // Login / Logout Button
        PopupMenuItem<String>(
          value: 'login_logout',
          child: Row(
            children: [
              Icon(loginIcon, size: 20),
              const SizedBox(width: 8),
              Text(loginText),
            ],
          ),
        ),
      ],
    );
  }
}
// ... (The rest of your main function for testing can remain here)