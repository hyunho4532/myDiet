import 'dart:math';

import 'package:flutter/material.dart';

class CupPainter extends CustomPainter {
  final double waterLevel; // 0.0(빈컵) ~ 1.0(가득)
  final Listenable? repaint;

  CupPainter({
    required this.waterLevel,
    this.repaint
  }) : super(repaint: repaint);

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

    // 컵 그리기
    canvas.drawRRect(cupRect, glassPaint);

    // 물결
    final waterPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF76C7F0).withOpacity(0.8),
          const Color(0xFF76C7F0).withOpacity(0.4),
        ]
      ).createShader(cupRect.outerRect);

    final waterPath = Path();
    final waterHeight = h * 0.94 - (h * 0.88 * waterLevel);

    // 물결 시작점 (왼쪽 아래)
    waterPath.moveTo(inset, h * 0.94);

    // 위로 곡선 물결
    const waveCount = 2.0;
    const amplitude = 8.0; // 물결 높이
    for (double x = inset; x <= w - inset; x++) {
      final dx = (x - inset) / (w - inset);
      final dy = sin(dx * waveCount * pi * 2) * amplitude;
      waterPath.lineTo(x, waterHeight + dy);
    }

    // 오른쪽 아래까지 닫기
    waterPath.lineTo(w - inset, h * 0.94);
    waterPath.close();

    canvas.drawPath(waterPath, waterPaint);
  }

  @override
  bool shouldRepaint(covariant CupPainter oldDelegate) {
    return oldDelegate.waterLevel != waterLevel;
  }
}