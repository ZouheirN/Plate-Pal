import 'package:hive_ce_flutter/hive_flutter.dart';

class CacheBox {
  static final Box _box = Hive.box('cacheBox');

  static void putCache(String type, dynamic data) async {
    _box.put(type, data);
  }

  static dynamic getCache(String type) {
    return _box.get(type);
  }
}
