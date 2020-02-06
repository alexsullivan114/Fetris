import 'dart:async';

import 'package:fetris/FetrisColorTheme.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject<FetrisColorTheme> selectedThemeSubject = BehaviorSubject.seeded(FetrisColorTheme.chill());
Stream<FetrisColorTheme> selectedTheme = selectedThemeSubject.stream;
