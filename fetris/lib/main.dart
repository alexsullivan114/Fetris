import 'package:flutter/material.dart';

import 'TetrisBoard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
        return TetrisBoard(constraints);
      })),
    );
  }
}

enum Tetrominoe { STRAIGHT, SQUARE, T, L, S }
