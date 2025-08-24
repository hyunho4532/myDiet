import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mydiet/presentation/controller/diet_c.dart';
import 'package:table_calendar/table_calendar.dart';

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
Widget buildMarker(BuildContext context, DateTime day, DietController dietController) {
  // 해당 날짜에 Diet가 있는 지 확인
  final dayDiets = dietController.diets.where(
          (diet) => isSameDay(diet.foodDate, day)
  ).toList();

  // 없으면 표시 X
  if (dayDiets.isEmpty) return SizedBox();

  // dayDiets의 개수만큼 점을 여러 개 표시한다.
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: dayDiets.map((diet) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: Colors.blue, // 점 색상
          shape: BoxShape.circle,
        ),
      );
    }).toList(),
  );
}