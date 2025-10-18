import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgSizedBox extends StatelessWidget {
  final String path;
  final double data;

  const SvgSizedBox({
    super.key,
    required this.path,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [
          SvgPicture.asset(
            path,
            width: 46,
            height: 46,
          ),

          Center(
              child: Text(
                  data.toStringAsFixed(2)
              )
          ),
        ],
      ),
    );
  }
}
