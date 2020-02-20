import 'dart:async';

import 'package:fetris/FetrisColorTheme.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject<FetrisColorTheme> selectedThemeSubject =
    BehaviorSubject.seeded(FetrisColorTheme.chill());
Stream<FetrisColorTheme> selectedTheme =
    selectedThemeSubject.stream.map((theme) {
  // Forgot to serialize J and Z when I added them. Classic.
  return FetrisColorTheme(
      t: theme.t,
      straight: theme.straight,
      square: theme.square,
      l: theme.l,
      j: theme.j ?? theme.l,
      s: theme.s,
      z: theme.z ?? theme.s,
      grid: theme.grid,
      gridLine: theme.gridLine,
      backgroundColor: theme.backgroundColor,
      accentColor: theme.accentColor,
      isDark: theme.isDark);
});
