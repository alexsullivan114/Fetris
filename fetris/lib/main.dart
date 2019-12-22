import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: CustomPaint(
          painter: ShapesPainter(),
          child: Container(
            height: 700,
          ),
        ),
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.yellow;

    // set the color property of the paint
    paint.color = Colors.deepOrange;

    double width = size.width.floor() / 8;
    for (int j = 0; (j * width) + width < size.height; j++) {
      for (int i = 0; i < width; i++) {
        Rect box = Rect.fromLTWH(width * i, j * width, width, width);
        canvas.drawRect(box, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
