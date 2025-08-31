import 'package:flutter/material.dart';

class CupPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final cupRadius = w * 0.08;
    final inset = w * 0.14;

    final cupRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(inset, h * 0.06, w - inset * 2, h * 0.88),
      topLeft: Radius.circular(cupRadius),
      topRight: Radius.circular(cupRadius),
      bottomLeft: Radius.circular(cupRadius * 1.2),
      bottomRight: Radius.circular(cupRadius * 1.2),
    );

    // 유리 느낌(속 채움)
    final glassPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFE8F3FA).withOpacity(0.6),
          const Color(0xFFE8F3FA).withOpacity(0.2),
        ],
      ).createShader(cupRect.outerRect);

    // 컵 외곽선
    final outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF7DA4C0);

    canvas.drawRRect(cupRect, glassPaint);
    canvas.drawRRect(cupRect, outlinePaint);

    // 유리 반사 하이라이트
    final highlightPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomLeft,
        colors: [
          Colors.white.withOpacity(0.25),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(
        cupRect.left,
        cupRect.top,
        cupRect.width * 0.15,
        cupRect.height,
      ));

    canvas.drawRect(
      Rect.fromLTWH(
        cupRect.left,
        cupRect.top,
        cupRect.width * 0.15,
        cupRect.height,
      ),
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}