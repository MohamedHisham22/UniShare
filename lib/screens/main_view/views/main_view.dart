import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/home_view/views/home_view.dart';

// ignore: must_be_immutable
class MainView extends StatelessWidget {
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  MainView({super.key});
  List<Widget> _buildScreens() {
    return [
      HomeView(),
      Center(child: Text('explore')),
      Center(child: Text('add')),
      Center(child: Text('liked')),
      Center(child: Text('chat')),
    ];
  }

  static String id = '/main';
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      padding: const EdgeInsets.only(top: 3),
      backgroundColor: Colors.grey.shade600,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: 60,
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property
    );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home_outlined),
      iconSize: 35,
      activeColorPrimary: kPrimaryColor,
      inactiveColorPrimary: Color(0xffD9D9D9),
    ),
    PersistentBottomNavBarItem(
      iconSize: 35,
      icon: Icon(Icons.list),
      activeColorPrimary: kPrimaryColor,
      inactiveColorPrimary: Color(0xffD9D9D9),
    ),
    PersistentBottomNavBarItem(
      iconSize: 35,
      icon: Icon(Icons.add, color: Colors.white),
      activeColorPrimary: kPrimaryColor,
      inactiveColorPrimary: Color(0xffD9D9D9),
    ),
    PersistentBottomNavBarItem(
      iconSize: 35,
      icon: Icon(CupertinoIcons.heart),
      activeColorPrimary: kPrimaryColor,
      inactiveColorPrimary: Color(0xffD9D9D9),
    ),
    PersistentBottomNavBarItem(
      iconSize: 35,
      icon: Icon(Icons.chat_outlined),
      activeColorPrimary: kPrimaryColor,
      inactiveColorPrimary: Color(0xffD9D9D9),
    ),
  ];
}
