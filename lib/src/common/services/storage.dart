import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices extends GetxController {
  static StorageServices get to => Get.find();
  late final SharedPreferences pref;

  Future<StorageServices> init() async {
    pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await pref.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await pref.setBool(key, value);
  }

  Future<bool> setList(String key, List<String> value) async {
    return await pref.setStringList(key, value);
  }

  String getString(String key) {
    return pref.getString(key) ?? '';
  }

  bool getBool(String key) {
    return pref.getBool(key) ?? false;
  }

  List<String> getList(String key) {
    return pref.getStringList(key) ?? [];
  }

  Future<bool> remove(String key) async {
    return await pref.remove(key);
  }
}
