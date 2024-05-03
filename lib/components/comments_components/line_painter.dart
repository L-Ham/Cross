
import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[600]!
      ..strokeWidth = 1.0;

    
    canvas.drawLine(const Offset(3, 0), Offset(3, size.height), paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}