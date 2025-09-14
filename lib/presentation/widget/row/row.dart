import 'package:flutter/material.dart';

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

// 4대 영양 성분 차트 형태 Row 위젯
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

class _DietRowState extends State<DietInfoRow> {
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