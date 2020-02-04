import 'package:fetris/FetrisColorTheme.dart';
import 'package:fetris/SelectedTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Drawer.dart';
import 'TetrisBoard.dart';

void main() {
  selectedTheme.listen((theme) {
    print("Theme: $theme");
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: theme.backgroundColor,
      statusBarBrightness: theme.isDark ? Brightness.light : Brightness.dark,
      statusBarIconBrightness:
          theme.isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: theme.backgroundColor,
      systemNavigationBarIconBrightness:
          theme.isDark ? Brightness.light : Brightness.dark,
    ));
  });
  runApp(MyApp());
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
          body: SafeArea(
              child: Stack(children: [
            TetrisBoard(),
            DrawerButton(),
          ]))),
    );
  }
}
