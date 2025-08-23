import 'package:flutter/material.dart';

import '../info/info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
      _pageController.jumpToPage(_currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _onItemTapped,
          children: const [
            Placeholder(),
            Placeholder(),
            Placeholder(),
            InfoPage(),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Handle item tap
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Handle item tap
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentPage,
          onTap: _onItemTapped,
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(color: Colors.white),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          ],
        ),
      ),
    );
  }
}
