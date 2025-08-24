import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 빌더 객체 생성
// 1. dowBuilder: 캘린더뷰에 생성되는 날짜 형식 표시
Widget buildDow(BuildContext context, DateTime day) {
  final text = DateFormat.E('ko').format(day);

  Color color = (day.weekday == DateTime.sunday)
    ? Colors.red : (day.weekday == DateTime.saturday) ? Colors.blue : Colors.black;

  return Center(
    child: Text(
      text,
      style: TextStyle(color: color),
    ),
  );
}

// 2. markerBuilder: 캘린더 뷰에 점 표시