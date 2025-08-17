import 'package:flutter/material.dart';
import 'package:mydiet/presentation/const.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class PersistentTabview extends StatefulWidget {
  const PersistentTabview({super.key});

  @override
  State<PersistentTabview> createState() => _PersistentTabviewState();
}

class _PersistentTabviewState extends State<PersistentTabview> {
  late final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      onItemSelected: (index) {
        setState(() {
          _controller.index = index;
        });
      },
      controller: _controller,
      floatingActionButton: _controller.index == 1 // Diet 탭일 때만
          ? FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.add),
      ) : null,
      screens: Const().buildScreens(),
      items: Const().buildNavItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Colors.white,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style3,
    );
  }
}
