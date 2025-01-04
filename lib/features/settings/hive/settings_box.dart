import 'package:hive_flutter/hive_flutter.dart';

class SettingsBox {
  static Box box = Hive.box('settingsBox');

  static void setDarkMode(bool value) {
    box.put('darkMode', value);
  }
}
