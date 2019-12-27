import 'package:flutter/material.dart';

enum Tetrominoe { STRAIGHT, SQUARE, T, L, S }

int tetrominoeHeight(Tetrominoe tetrominoe) {
  switch (tetrominoe) {
    case Tetrominoe.STRAIGHT:
      return 4;
      break;
    case Tetrominoe.SQUARE:
      return 2;
      break;
    case Tetrominoe.T:
      return 2;
      break;
    case Tetrominoe.L:
      return 3;
      break;
    case Tetrominoe.S:
      return 3;
      break;
  }

  return 0;
}

int tetrominoeWidth(Tetrominoe tetrominoe) {
  switch (tetrominoe) {
    case Tetrominoe.STRAIGHT:
      return 1;
      break;
    case Tetrominoe.SQUARE:
      return 2;
      break;
    case Tetrominoe.T:
      return 3;
      break;
    case Tetrominoe.L:
      return 2;
      break;
    case Tetrominoe.S:
      return 2;
      break;
  }

  return 0;
}

ColorSwatch<int> tetrominoeColor(Tetrominoe tetrominoe) {
  switch (tetrominoe) {
    case Tetrominoe.STRAIGHT:
      return Colors.cyanAccent;
      break;
    case Tetrominoe.SQUARE:
      return Colors.yellow;
      break;
    case Tetrominoe.T:
      return Colors.red;
      break;
    case Tetrominoe.L:
      return Colors.green;
      break;
    case Tetrominoe.S:
      return Colors.blue;
      break;
  }

  return Colors.grey;
}
