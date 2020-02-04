import 'package:fetris/Tetrominoe.dart';
import 'package:flutter/material.dart';

class FetrisColorTheme {
  final Color t;
  final Color straight;
  final Color square;
  final Color l;
  final Color s;
  final Color grid;
  final Color gridLine;
  final Color backgroundColor;
  final Color accentColor;
  final bool isDark;

  operator [](Tetrominoe tetrominoe) {
    switch (tetrominoe) {
      case Tetrominoe.STRAIGHT:
        return straight;
        break;
      case Tetrominoe.SQUARE:
        return square;
        break;
      case Tetrominoe.T:
        return t;
        break;
      case Tetrominoe.L:
        return l;
        break;
      case Tetrominoe.S:
        return s;
        break;
    }
  }

  FetrisColorTheme(
      {this.t,
      this.straight,
      this.square,
      this.l,
      this.s,
      this.grid,
      this.gridLine,
      this.backgroundColor,
      this.accentColor,
      this.isDark});

  factory FetrisColorTheme.halloween() {
    return FetrisColorTheme(
        t: Color(0xFFF5CD08),
        straight: Color(0xFFE9804D),
        square: Color(0xFFEB6123),
        l: Color(0xFFBFDA7A),
        s: Color(0xFF96C457),
        grid: Colors.black,
        gridLine: Colors.deepPurpleAccent,
        backgroundColor: Colors.black,
        accentColor: Colors.white,
        isDark: true);
  }

  factory FetrisColorTheme.grayScale() {
    return FetrisColorTheme(
        t: Color(0xFFDDDDDD),
        straight: Color(0xFFCCCCCC),
        square: Color(0xFF999999),
        l: Color(0xFF666666),
        s: Color(0xFF333333),
        grid: Colors.white,
        gridLine: Colors.black,
        backgroundColor: Colors.grey,
        accentColor: Colors.black,
        isDark: false);
  }

  factory FetrisColorTheme.material() {
    return FetrisColorTheme(
        t: Colors.red,
        straight: Colors.cyanAccent,
        square: Colors.yellow,
        l: Colors.green,
        s: Colors.blue,
        grid: Colors.white,
        gridLine: Colors.deepOrange,
        backgroundColor: Colors.white,
        accentColor: Colors.black,
        isDark: false);
  }

  factory FetrisColorTheme.chill() {
    return FetrisColorTheme(
        t: Color(0xFFE27d60),
        straight: Color(0xFF85DCFF),
        square: Color(0xFFE8A87C),
        l: Color(0xFFC38D9E),
        s: Color(0xFF41B3A3),
        grid: Colors.white,
        gridLine: Color(0xFF342582),
        backgroundColor: Color(0xFF85DCCC),
        accentColor: Colors.black,
        isDark: false);
  }
}
