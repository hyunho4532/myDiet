import 'package:flutter/material.dart';
import 'package:mydiet/presentation/widget/button/floating.dart';

/// visible: 어떤 상태에 따라서 위젯을 보여줄 지 말지 여부 결정
class Visible {
  Floating? visibleFloating(int index) {
    return index == 1 ? Floating(icon: Icon(Icons.add, color: Colors.white)) : null;
  }

  // category 설정
  Widget visibleCategory(String category) {
    switch (category) {
      case '튀김류':
        return Image.asset('assets/fried.png', width: 24, height: 24);
      case '밥류':
        return Image.asset('assets/rise.png', width: 24, height: 24);
      default:
        return Icon(Icons.category, color: Colors.grey);
    }
  }
}