import 'package:fetris/TetrominoePosition.dart';
import 'package:flutter/material.dart';

class TetrominoeBlock {
  final ColorSwatch<int> color;
  final Position position;

  TetrominoeBlock(this.color, this.position);
}
