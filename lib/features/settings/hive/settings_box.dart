import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class SettingsBox {
  static Box box = Hive.box('settingsBox');

  static set darkMode(bool value) {
    box.put('darkMode', value);
  }

  static bool get darkMode {
    return box.get('darkMode', defaultValue: false);
  }

  static set themeColor(Color themeColor) {
    box.put('themeColor', themeColor.value);
  }

  static Color get themeColor {
    int colorCode = box.get('themeColor', defaultValue: Colors.red.value);
    return Color(colorCode);
  }

  static set useMaterialYou(bool value) {
    box.put('useMaterialYou', value);
  }

  static bool get useMaterialYou {
    return box.get('useMaterialYou', defaultValue: false);
  }

  static set useAmoledBlack(bool value) {
    box.put('useAmoledBlack', value);
  }

  static bool get useAmoledBlack {
    return box.get('useAmoledBlack', defaultValue: false);
  }

  static ValueListenable<Box> listenable() {
    return box.listenable(
        keys: ['darkMode', 'themeColor', 'useMaterialYou', 'useAmoledBlack']);
  }
}
