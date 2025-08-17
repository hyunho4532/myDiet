import 'package:flutter/material.dart';
import 'package:mydiet/presentation/screens/diet_screen.dart';
import 'package:mydiet/presentation/screens/home_screen.dart';
import 'package:mydiet/presentation/screens/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

/// Const: 전역 상수 관리
class Const {
  // 색상 관리
  List<Color> buildColors() {
    return [
      Color(0xff2d67f4),
      Color(0xffb8b8b8),
      Color(0xff9ac2ff)
    ];
  }

  // 네비게이션 화면 관리
  List<Widget> buildScreens() {
    return [
      HomeScreen(),
      DietScreen(),
      ProfileScreen()
    ];
  }

  // 네비게이션 라우트 및 네비게이터 설정
  RouteAndNavigatorSettings buildRouteAndNaviSettings() {
    return RouteAndNavigatorSettings(
      initialRoute: "/",
      routes: {
        "/first": (final context) => const HomeScreen(),
        "/second": (final context) => const DietScreen(),
        "/third": (final context) => const ProfileScreen(),
      },
    );
  }

  // 네비바 에니메이션 설정
  NavBarAnimationSettings buildNavBarAnimationSettings() {
    return const NavBarAnimationSettings(
      navBarItemAnimation: ItemAnimationSettings(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimationSettings(
        animateTabTransition: true,
        duration: Duration(milliseconds: 200),
        screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
      ),
    );
  }

  // 네비게이션 아이템 관리
  List<PersistentBottomNavBarItem> buildNavItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("홈"),
        activeColorPrimary: buildColors()[0],
        inactiveColorPrimary: buildColors()[1],
        routeAndNavigatorSettings: buildRouteAndNaviSettings()
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add),
        title: ("식단"),
        activeColorPrimary: buildColors()[0],
        inactiveColorPrimary: buildColors()[1],
        routeAndNavigatorSettings: buildRouteAndNaviSettings()
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("프로필"),
        activeColorPrimary: buildColors()[0],
        inactiveColorPrimary: buildColors()[1],
        routeAndNavigatorSettings: buildRouteAndNaviSettings()
      ),
    ];
  }
}