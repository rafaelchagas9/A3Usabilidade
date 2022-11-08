import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:olimpiadas/screens/homepage/favoritesScreen.dart';
import 'package:olimpiadas/screens/homepage/homeScreen.dart';
import 'package:olimpiadas/screens/homepage/profileScreen.dart';
import 'package:olimpiadas/screens/homepage/settingsScreen.dart';

import '../../auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    List<Widget> screens = const [
      HomeScreen(),
      FavoriteScreen(),
      ProfileScreen(),
      SettingsScreen()
    ];

    void onPageChanged(int index) {}

    void onItemTapped(int index) {
      pageController.jumpToPage(index);
    }

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: screens,
      ),
      extendBody: true,
      bottomNavigationBar: GNav(
        gap: 10.0,
        tabActiveBorder: Border.all(color: Colors.black, width: 1),
        iconSize: 30, // tab button icon size
        duration: Duration(milliseconds: 400), // tab animation duration
        haptic: false,
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        tabMargin: EdgeInsets.only(bottom: 10),
        tabs: [
          GButton(
            icon: Icons.home,
            text: "Início",
            hoverColor: Colors.grey[700], // tab button hover color
            curve: Curves.easeOutExpo, // tab animation curves
            onPressed: () => onItemTapped(0),
          ),
          GButton(
            icon: Icons.favorite,
            text: "Favoritos",
            rippleColor:
                Colors.grey[800], // tab button ripple color when pressed
            hoverColor: Colors.grey[700], // tab button hover color
            onPressed: () => onItemTapped(1),
          ),
          GButton(
            icon: Icons.person,
            text: "Perfil",
            rippleColor:
                Colors.grey[800], // tab button ripple color when pressed
            onPressed: () => onItemTapped(2),
          ),
          GButton(
            icon: Icons.settings,
            text: "Configurações",
            rippleColor:
                Colors.grey[800], // tab button ripple color when pressed
            onPressed: () => onItemTapped(3),
          ),
        ],
      ),
    );
  }
}
