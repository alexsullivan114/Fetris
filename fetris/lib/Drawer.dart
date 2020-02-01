import 'package:fetris/SelectedTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'FetrisColorTheme.dart';
import 'Pair.dart';
import 'Tetrominoe.dart';

class DrawerContents extends StatelessWidget {
  final themes = [
    Pair(FetrisColorTheme.halloween(), "Halloween"),
    Pair(FetrisColorTheme.grayScale(), "Gray Scale"),
    Pair(FetrisColorTheme.material(), "Material")
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> themeSwatches = themes.map((pair) {
      return InkWell(
        child: ThemeListItem(pair.first, pair.second),
        onTap: () {
          selectedTheme.add(pair.first);
          Navigator.pop(context);
        },
      );
    }).toList();

    return ListView(children: themeSwatches);
  }
}

class ThemeListItemSwatch extends StatelessWidget {
  final FetrisColorTheme _theme;

  ThemeListItemSwatch(this._theme);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: ThemeSwatchPainter(this._theme));
  }
}

class ThemeSwatchPainter extends CustomPainter {
  final FetrisColorTheme _theme;

  ThemeSwatchPainter(this._theme);

  @override
  void paint(Canvas canvas, Size size) {
    final topWidth = size.width / 3;
    final bottomWidth = size.width / 2;
    final swatchHeight = size.height / 2;

    _drawSwatch(_theme[Tetrominoe.L], 0, 0, topWidth, swatchHeight, canvas);
    _drawSwatch(
        _theme[Tetrominoe.T], topWidth, 0, topWidth, swatchHeight, canvas);
    _drawSwatch(_theme[Tetrominoe.STRAIGHT], topWidth * 2, 0, topWidth,
        swatchHeight, canvas);
    _drawSwatch(_theme[Tetrominoe.SQUARE], 0, swatchHeight, bottomWidth,
        swatchHeight, canvas);
    _drawSwatch(_theme[Tetrominoe.S], bottomWidth, swatchHeight, bottomWidth,
        swatchHeight, canvas);
  }

  void _drawSwatch(Color color, double left, double top, double width,
      double height, Canvas canvas) {
    final paint = Paint()
      ..strokeWidth = 1
      ..color = color;
    final rect = Rect.fromLTWH(left, top, width, height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ThemeListItem extends StatelessWidget {
  final FetrisColorTheme _theme;
  final String _themeName;

  ThemeListItem(this._theme, this._themeName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 50,
              height: 50,
              child: ThemeListItemSwatch(this._theme),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(_themeName),
          )
        ],
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: Icon(Icons.menu),
      color: Colors.black,
    );
  }
}
