import 'package:flutter/material.dart';
import 'package:waffibible/helper/font_size_preference.dart';

class FontSizeProvider with ChangeNotifier {
  double _fontSize = 15.0;
  FontSizePreference fontSizePreference = new FontSizePreference();

  double get fontSize => _fontSize;

  set fontSize(double value) {
    _fontSize = value;
    fontSizePreference.setFontSize(value);
    notifyListeners();
  }
}
