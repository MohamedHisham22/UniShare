// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:unishare/constants.dart';
// import 'package:unishare/screens/home_view/views/home_view.dart';

// class MainView extends StatelessWidget {
//   final PersistentTabController _controller = PersistentTabController(
//     initialIndex: 0,
//   );

//   MainView({super.key});
//   List<Widget> _buildScreens() {
//     return [
//       HomeView(),
//       Center(child: Text('explore')),
//       Center(child: Text('add')),
//       Center(child: Text('liked')),
//       Center(child: Text('chat')),
//     ];
//   }

//   static String id = '/main';
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       handleAndroidBackButtonPress: true, // Default is true.
//       resizeToAvoidBottomInset:
//           true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
//       stateManagement: true, // Default is true.
//       hideNavigationBarWhenKeyboardAppears: true,
//       padding: const EdgeInsets.only(top: 3),
//       backgroundColor: Colors.grey.shade600,
//       isVisible: true,
//       animationSettings: const NavBarAnimationSettings(
//         navBarItemAnimation: ItemAnimationSettings(

//           duration: Duration(milliseconds: 400),
//           curve: Curves.ease,
//         ),
//         screenTransitionAnimation: ScreenTransitionAnimationSettings(

//           animateTabTransition: true,
//           duration: Duration(milliseconds: 200),
//           screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
//         ),
//       ),
//       confineToSafeArea: true,
//       navBarHeight: 60,
//       navBarStyle:
//           NavBarStyle.style15, // Choose the nav bar style with this property
//     );
//   }
// }

// List<PersistentBottomNavBarItem> _navBarsItems() {
//   return [
//     PersistentBottomNavBarItem(
//       icon: Icon(Icons.home_outlined),
//       iconSize: 35,
//       activeColorPrimary: kPrimaryColor,
//       inactiveColorPrimary: Color(0xffD9D9D9),
//     ),
//     PersistentBottomNavBarItem(
//       iconSize: 35,
//       icon: Icon(Icons.list),
//       activeColorPrimary: kPrimaryColor,
//       inactiveColorPrimary: Color(0xffD9D9D9),
//     ),
//     PersistentBottomNavBarItem(
//       iconSize: 35,
//       icon: Icon(Icons.add, color: Colors.white),
//       activeColorPrimary: kPrimaryColor,
//       inactiveColorPrimary: Color(0xffD9D9D9),
//     ),
//     PersistentBottomNavBarItem(
//       iconSize: 35,
//       icon: Icon(CupertinoIcons.heart),
//       activeColorPrimary: kPrimaryColor,
//       inactiveColorPrimary: Color(0xffD9D9D9),
//     ),
//     PersistentBottomNavBarItem(
//       iconSize: 35,
//       icon: Icon(Icons.chat_outlined),
//       activeColorPrimary: kPrimaryColor,
//       inactiveColorPrimary: Color(0xffD9D9D9),
//     ),
//   ];
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/constants.dart';
import 'package:unishare/screens/home_view/views/home_view.dart';
import 'package:unishare/screens/main_view/cubit/main_view_cubit.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  static String id = '/main';

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeView(),
      Center(child: Text('Listings')),
      Center(child: Text('Liked')),
      Center(child: Text('Chat')),
    ];

    return Scaffold(
      bottomNavigationBar: BlocBuilder<MainViewCubit, int>(
        builder: (context, selectedIndex) {
          return SizedBox(
            height: 80,
            child: Wrap(
              children: [
                BottomNavigationBar(
                  selectedItemColor: kPrimaryColor,
                  unselectedItemColor: const Color.fromARGB(255, 121, 121, 121),
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  currentIndex: selectedIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    context.read<MainViewCubit>().updateIndex(index);
                  },
                  selectedIconTheme: const IconThemeData(size: 30),
                  unselectedIconTheme: const IconThemeData(size: 30),
                  backgroundColor: const Color.fromARGB(255, 231, 231, 231),

                  items: const [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(top: 13),
                        child: Icon(Icons.home_outlined, size: 34),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(top: 13),
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.list, size: 34),
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(top: 13),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(CupertinoIcons.heart, size: 34),
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(top: 13),
                        child: Icon(Icons.chat_outlined, size: 34),
                      ),
                      label: '',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        height: 62,
        width: 62,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            onPressed: () {},
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocBuilder<MainViewCubit, int>(
        builder: (context, selectedIndex) {
          return screens[selectedIndex];
        },
      ),
    );
  }
}
