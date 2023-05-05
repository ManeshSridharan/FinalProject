import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_final_project/screens/appointment_page.dart';
import 'package:flutter_final_project/screens/help_page.dart';
import 'package:flutter_final_project/screens/home.dart';
import 'package:flutter_final_project/screens/medication_page.dart';
import 'package:flutter_final_project/screens/rewards_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  // const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Theme.of(context).primaryColor,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(3),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}

List<Widget> _buildScreens() {
  return [
    HomeScreen(),
    AppointmentPage(),
    MedicationPage(),
    HelpPage(),
    RewardsPage()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home),
      title: ("Home"),
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.calendar_month),
      title: ("Appointment"),
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.medication),
      title: ("Medication"),
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.help),
      title: ("Help"),
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.emoji_events),
      title: ("Rewards"),
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.black,
    ),
  ];
}
