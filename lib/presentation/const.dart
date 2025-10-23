import 'package:flutter/material.dart';
import 'package:mydiet/presentation/screens/diet_s.dart';
import 'package:mydiet/presentation/screens/home_s.dart';
import 'package:mydiet/presentation/screens/profile_s.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

/// Const: 전역 상수 관리
class Const {
  // 색상 관리
  List<Color> buildColors() {
    return [
      Color(0xff2d67f4),
      Color(0xffb8b8b8),
      Color(0xff9ac2ff),
      Color(0xffffffff)
    ];
  }

  // 차트 색상 관리
  List<Color> buildChartColor() {
    return [
      // 탄수화물
      Color(0xfffac45d),

      // 단백질
      Color(0xff6d9afd),

      // 지방
      Color(0xfffa6161),

      // 비타민
      Color(0xff91ff68)
    ];
  }

  // 네비게이션 화면 관리
  List<Widget> buildScreens() {
    return [
      HomeS(),
      DietS(),
      ProfileS()
    ];
  }

  // 네비게이션 라우트 및 네비게이터 설정
  RouteAndNavigatorSettings buildRouteAndNaviSettings() {
    return RouteAndNavigatorSettings(
      initialRoute: "/",
      routes: {
        "/first": (final context) => const HomeS(),
        "/second": (final context) => const DietS(),
        "/third": (final context) => const ProfileS(),
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
        routeAndNavigatorSettings: buildRouteAndNaviSettings(),
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

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}