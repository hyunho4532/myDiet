import 'package:flutter/material.dart';
import 'package:mydiet/presentation/const.dart';

// 영양 성분 Row 위젯
class DietInfoRow<T> extends StatefulWidget {
  final String text;
  final T data;

  const DietInfoRow({
    super.key,
    required this.text,
    required this.data
  });

  @override
  State<DietInfoRow> createState() => _RowState();
}

// 4대 영양 성분 차트 형태 Row 위젯 (Home 탭에 구현)
class HomeDietRow<T> extends StatefulWidget {
  final String label;
  final String value;

  const HomeDietRow({
    super.key,
    required this.label,
    required this.value
  });

  @override
  State<StatefulWidget> createState() => _DietRowState();
}

// 영얃소 차트 형태 Row 위젯 (Home 탭에 구현)
class HomeNutrientRow<T> extends StatefulWidget {
  final String label;
  final String value;

  const HomeNutrientRow({
    super.key,
    required this.label,
    required this.value
  });

  @override
  State<StatefulWidget> createState() => _NutrientRowState();
}

class _RowState extends State<DietInfoRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          widget.text,
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey
          ),
        ),

        Text(
          "${widget.data}",
          style: TextStyle(
              fontSize: 14,
              color: Colors.black
          ),
        )
      ],
    );
  }
}

class _DietRowState extends State<HomeDietRow> {
  final color = Const().buildColors()[1];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.label,
            style: TextStyle(fontSize: 14, color: color),
          ),
        ),
        Text(
          widget.value,
          style: TextStyle(fontSize: 14, color: color),
        ),
      ],
    );
  }
}

class _NutrientRowState extends State<HomeNutrientRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            widget.value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Const().buildColors()[1],
            ),
          ),
        ],
      ),
    );
  }
}