import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/utils.dart';
import '../faith/pages/pages.dart';
import '../lessons/lessons.dart';
import '../settings/pages/pages.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const LessonsPage(),
    const FaithPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedFontSize: 14,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/home/lessons_outlined.png",
                width: 30,
                height: 30,
              ),
              activeIcon: Image.asset("assets/images/home/lessons_filled.png",
                  color: primaryGreen, width: 30, height: 30),
              label: lang.seerah,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/home/moon_outlined.png",
                width: 25,
                height: 25,
              ),
              activeIcon: Image.asset("assets/images/home/moon_filled.png",
                  color: primaryGreen, width: 25, height: 25),
              label: lang.my_iman,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/home/settings_outlined.png",
                width: 25,
                height: 25,
              ),
              activeIcon: Image.asset("assets/images/home/settings_filled.png",
                  color: primaryGreen, width: 25, height: 25),
              label: lang.settings,
            ),
          ],
          selectedItemColor: primaryGreen),
    );
  }
}
