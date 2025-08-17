import 'package:flutter/material.dart';
import 'package:mydiet/presentation/screens/home_screen.dart';
import 'package:mydiet/presentation/screens/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

/// Const: 전역 상수 관리
class Const {
  // 색상 관리
  List<Color> buildColors() {
    return [
      Color(0xff2d67f4),
      Color(0xffe1e1e1)
    ];
  }

  // 네비게이션 화면 관리
  List<Widget> buildScreens() {
    return [
      HomeScreen(),
      ProfileScreen()
    ];
  }

  // 네비게이션 아이템 관리
  List<PersistentBottomNavBarItem> buildNavItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("홈"),
        activeColorPrimary: buildColors()[0],
        inactiveColorPrimary: buildColors()[1],
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/first": (final context) => const HomeScreen(),
            "/second": (final context) => const ProfileScreen(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("프로필"),
        activeColorPrimary: buildColors()[0],
        inactiveColorPrimary: buildColors()[1],
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/first": (final context) => const HomeScreen(),
            "/second": (final context) => const ProfileScreen(),
          },
        ),
      ),
    ];
  }
}