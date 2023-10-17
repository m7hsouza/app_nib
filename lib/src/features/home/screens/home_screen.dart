import 'package:app_nib/src/features/admin/screens/admin_panel_settings_screen.dart';
import 'package:app_nib/src/features/home/screens/user_screen.dart';
import 'package:app_nib/src/features/news/screens/news_screen.dart';
import 'package:app_nib/src/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentScreenIndex = 1;
  final _screenController = PageController(initialPage: 1);
  final _screens = [
    const NewsScreen(),
    const UserScreen(),
    const AdminPanelSettingsScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      Navigator.pushReplacementNamed(context, "/sign-in");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: _screens.length,
        controller: _screenController,
        onPageChanged: (index) {
          setState(() {
            _currentScreenIndex = index;
          });
        },
        itemBuilder: (_, index) {
          return _screens[_currentScreenIndex];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentScreenIndex,
        enableFeedback: true,
        onTap: _changePage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "Noticias"),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings_outlined), label: "Admin"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Perfil"),
        ],
      ),
    );
  }

  void _changePage(int index) {
    if (index == _currentScreenIndex) return;
    setState(() {
      _currentScreenIndex = index;
      _screenController.jumpToPage(_currentScreenIndex);
    });
  }
}
