import 'package:flutter/material.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/injector/service_locator.dart';
import 'activitas/dashboard_activity_page.dart';
import 'kalori/dashboard_kalori_page.dart';
import 'obat/dashboard_obat_page.dart';
import 'info/info_page.dart';

class HomePage extends StatefulWidget {
  final int currentPage;
  const HomePage({super.key, required this.currentPage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentPage;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(_selectedIndex);
    });
  }

  String _updateTitle(int currentPage) {
    switch (currentPage) {
      case 0:
        return 'Home';
      case 1:
        return 'Aktivitas';
      case 2:
        return 'Kalori';
      case 3:
        return 'Obat';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _selectedIndex == 0
            ? null
            : AppBar(
                title: Text(_updateTitle(_selectedIndex).toUpperCase()),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.account_circle, size: 50),
                    onPressed: () {
                      sl<AppNavigator>().pushNamed(profilePage);
                    },
                  ),
                ],
              ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onItemTapped,
          children: const [
            InfoPage(),
            DashboardActivityPage(),
            DashboardKaloriPage(),
            DashboardObatPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(color: Colors.white),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.run_circle),
              label: 'Aktivitas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: 'Kalori',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_information),
              label: 'Obat',
            ),
          ],
        ),
      ),
    );
  }
}
