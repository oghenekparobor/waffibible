import 'package:shared_preferences/shared_preferences.dart';

class FontSizePreference {
  static const FONTSIZE_STATUS = "FONTSIZE";

  setFontSize(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(FONTSIZE_STATUS, value);
  }

  Future<double> getFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(FONTSIZE_STATUS) ?? 15.0;
  }
}