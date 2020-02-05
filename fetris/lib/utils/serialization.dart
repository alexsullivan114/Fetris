import 'dart:convert';
import 'dart:ui';

import 'package:fetris/FetrisColorTheme.dart';

String serializeColor(Color color) {
  final colorMap = {
    "a": color.alpha,
    "r": color.red,
    "b": color.blue,
    "g": color.green,
  };

  return jsonEncode(colorMap);
}

Color deserializeColor(Map<String, dynamic> colorMap) {
  return Color.fromARGB(colorMap["a"], colorMap["r"], colorMap["b"], colorMap["g"]);
}

String serializeTheme(FetrisColorTheme theme) {
  final themeMap = {
    "t": serializeColor(theme.t),
    "straight": serializeColor(theme.straight),
    "square": serializeColor(theme.square),
    "l": serializeColor(theme.l),
    "s": serializeColor(theme.s),
    "grid": serializeColor(theme.grid),
    "gridLine": serializeColor(theme.gridLine),
    "backgroundColor": serializeColor(theme.backgroundColor),
    "accentColor": serializeColor(theme.accentColor),
    "isDark": theme.isDark,
  };

  return jsonEncode(themeMap);
}

FetrisColorTheme deserializeTheme(Map<String, dynamic> themeMap) {
  return FetrisColorTheme(
    t: deserializeColor(json.decode(themeMap["t"])),
    straight: deserializeColor(json.decode(themeMap["straight"])),
    square: deserializeColor(json.decode(themeMap["square"])),
    l: deserializeColor(json.decode(themeMap["l"])),
    s: deserializeColor(json.decode(themeMap["s"])),
    grid: deserializeColor(json.decode(themeMap["grid"])),
    gridLine: deserializeColor(json.decode(themeMap["gridLine"])),
    backgroundColor: deserializeColor(json.decode(themeMap["backgroundColor"])),
    accentColor: deserializeColor(json.decode(themeMap["accentColor"])),
    isDark: themeMap["isDark"]);
}