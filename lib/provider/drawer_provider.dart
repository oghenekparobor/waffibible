import 'package:flutter/material.dart';

class DrawerProvider with ChangeNotifier {
  bool _openedDrawer = false;

  bool get drawerStatus => _openedDrawer;

  set drawerStatus(bool value) {
    _openedDrawer = value;
    notifyListeners();
  }
}
