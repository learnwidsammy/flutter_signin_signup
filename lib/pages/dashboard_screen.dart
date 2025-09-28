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

  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;
  final double _scrollThreshold = 10.0;
  double _lastScrollOffset = 0.0;

  final List<Widget Function(ScrollController?)> _pageBuilders = [
    (controller) => CoursesPage(scrollController: controller),
    (controller) => SchedulePage(scrollController: controller),
    (controller) => ProgressPage(scrollController: controller),
    (controller) => SettingsPage(scrollController: controller),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final currentScroll = _scrollController.offset;

    if (currentScroll > _lastScrollOffset + _scrollThreshold) {
      // Scrolling down (hide)
      if (_isVisible) {
        setState(() => _isVisible = false);
      }
    } else if (currentScroll < _lastScrollOffset - _scrollThreshold) {
      // Scrolling up (show)
      if (!_isVisible) {
        setState(() => _isVisible = true);
      }
    }
    _lastScrollOffset = currentScroll;
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      // Dashboard: just close drawer
      Navigator.pop(context);
    } else {
      setState(() {
        _selectedIndex = index - 1;
      });
      Navigator.pop(context); // Close drawer
    }
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

    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final Widget currentPage = _pageBuilders[_selectedIndex](
      isMobile ? _scrollController : null,
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
        drawer: isMobile
            ? null
            : AppDrawer(
                currentTheme: theme,
                isDarkMode: _isDarkMode,
                onToggleTheme:
                    _toggleTheme, // Passing the state-modifying function
                drawerItems: _drawerItems,
                selectedIndex: _selectedIndex,
                onItemTapped: _onItemTapped,
              ),
        body: isMobile
            ? Stack(
                children: [
                  currentPage,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      transform: Matrix4.translationValues(
                        0,
                        _isVisible ? 0 : 100,
                        0,
                      ),
                      child: _buildCustomBottomBar(theme),
                    ),
                  ),
                ],
              )
            : currentPage,
      ),
    );
  }

  // Widget to build the individual navigation icons
  Widget _buildNavItem(IconData icon, int index, {bool isSelected = false}) {
    return IconButton(
      icon: Icon(
        icon,
        size: 28,
        color: isSelected ? Colors.pink.shade700 : Colors.grey.shade600,
      ),
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  // Widget to build the central FAB
  Widget _buildCentralFab() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.pink,
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () {
            // Handle the central close/action button tap
          },
        ),
      ),
    );
  }

  // Widget that creates the pill-shaped bottom navigation bar
  Widget _buildCustomBottomBar(ThemeData theme) {
    // The total height of the bar, including padding
    const double barHeight = 70.0;

    final List<IconData> leftIcons = [
      Icons.home_outlined, // Home/Courses
      Icons.person_outline, // Person/Schedule
    ];

    final List<IconData> rightIcons = [
      Icons.favorite_border, // Heart/Progress
      Icons.notifications_outlined, // Bell/Settings
    ];

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 24.0,
      ), // Standard floating distance
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The main pill-shaped container
          Container(
            height: barHeight,
            width: MediaQuery.of(context).size.width * 0.85, // 85% width
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(barHeight / 2),
              border: Border.all(
                color: Colors.pink.shade100,
                width: 2,
              ), // Light pink border
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Left side icons
                _buildNavItem(leftIcons[0], 0, isSelected: _selectedIndex == 0),
                _buildNavItem(leftIcons[1], 1, isSelected: _selectedIndex == 1),

                // Spacer for the FAB
                const SizedBox(width: 60),

                // Right side icons
                _buildNavItem(
                  rightIcons[0],
                  2,
                  isSelected: _selectedIndex == 2,
                ),
                _buildNavItem(
                  rightIcons[1],
                  3,
                  isSelected: _selectedIndex == 3,
                ),
              ],
            ),
          ),

          // The central Floating Action Button (FAB) positioned on top of the pill
          // Translate it up by half its height to center it vertically on the pill edge
          Transform.translate(
            offset: const Offset(0, -barHeight / 2 + 10),
            child: _buildCentralFab(),
          ),
        ],
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
