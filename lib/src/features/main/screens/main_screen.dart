import 'package:app_nib/src/features/admin/screens/admin_panel_settings_screen.dart';
import 'package:app_nib/src/features/home/screens/home_screen.dart';
import 'package:app_nib/src/features/main/main_store.dart';
import 'package:app_nib/src/features/news/screens/news_screen.dart';
import 'package:app_nib/src/features/profile/screens/profile_screen.dart';
import 'package:app_nib/src/shared/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentScreenIndex = 0;
  final _screenController = PageController(initialPage: 0);
  late final AuthService _authService;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _authService = context.read();

    _screens = [
      const HomeScreen(),
      const NewsScreen(),
      if (_authService.hasRole('admin')) const AdminPanelSettingsScreen(),
      const ProfileScreen(),
    ];

    _authService.addListener(() {
      if (_authService.loggedUser == null) {
        Navigator.of(context).pushReplacementNamed('/screens/sign-in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentScreenIndex,
        enableFeedback: true,
        onTap: _changePage,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Inicio"),
          const BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "Noticias"),
          if (_authService.hasRole('admin')) const BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings_outlined), label: "Admin"),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Perfil"),
        ],
      ),
      floatingActionButton: _buildFloatActionButton(),
    );
  }

  void _changePage(int index) {
    if (index == _currentScreenIndex) return;
    setState(() {
      _currentScreenIndex = index;
      _screenController.jumpToPage(_currentScreenIndex);
    });
  }

  Widget? _buildFloatActionButton() {
    final auth = context.read<AuthService>();
    if (_currentScreenIndex == 1 && auth.can('article.create')) {
      return FloatingActionButton.extended(onPressed: () {}, label: const Text('Nova Noticia'));
    }
    return null;
  }
}
