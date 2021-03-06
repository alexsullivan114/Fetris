import 'dart:convert';

import 'package:fetris/FetrisColorTheme.dart';
import 'package:fetris/streams/SelectedTheme.dart';
import 'package:fetris/utils/serialization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'Drawer.dart';
import 'game/TetrisBoard.dart';

void main() async {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(MyApp());
  await restoreTheme();
  selectedTheme.listen((theme) async {
    saveTheme(theme);
    updateSystemChrome(theme);
  });
}

Future<void> restoreTheme() async {
  final preferences = await SharedPreferences.getInstance();
  if (preferences.containsKey("theme")) {
    Map<String, dynamic> themeMap = jsonDecode(await preferences.get("theme"));
    final restoredTheme = deserializeTheme(themeMap);
    selectedThemeSubject.value = restoredTheme;
  }

  return;
}

void saveTheme(FetrisColorTheme theme) async {
  final preferences = await SharedPreferences.getInstance();
  await preferences.setString("theme", serializeTheme(theme));
}

void updateSystemChrome(FetrisColorTheme theme) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: theme.backgroundColor,
    statusBarBrightness: theme.isDark ? Brightness.light : Brightness.dark,
    statusBarIconBrightness: theme.isDark ? Brightness.light : Brightness.dark,
    systemNavigationBarColor: theme.backgroundColor,
    systemNavigationBarIconBrightness:
        theme.isDark ? Brightness.light : Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          drawer: Drawer(
            child: DrawerContents(),
          ),
          body: StreamBuilder<FetrisColorTheme>(
              stream: selectedTheme,
              builder: (context, snapshot) {
                final theme = snapshot.data != null
                    ? snapshot.data
                    : selectedThemeSubject.value;
                return Container(
                  color: theme.backgroundColor,
                  child: SafeArea(
                      child: Stack(children: [
                    TetrisBoard(),
                    DrawerButton(),
                  ])),
                );
              })),
    );
  }
}
