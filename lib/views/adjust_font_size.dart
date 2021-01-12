import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waffibible/provider/dark_theme_provider.dart';
import 'package:waffibible/provider/font_size_provider.dart';

class AdjustFontSize extends StatefulWidget {
  const AdjustFontSize({Key key}) : super(key: key);

  @override
  _AdjustFontSizeState createState() => _AdjustFontSizeState();
}

class _AdjustFontSizeState extends State<AdjustFontSize> {
  double font = 15.0;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final size = Provider.of<FontSizeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                color: themeChange.darkTheme
                    ? Color.fromRGBO(70, 70, 70, 1)
                    : Colors.grey.shade300,
                child: Slider(
                  min: (size.fontSize / 2),
                  max: (size.fontSize * 3),
                  value: size.fontSize,
                  onChanged: (value) {
                    size.fontSize = value;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
