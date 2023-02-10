import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBool({required String key, required bool value}) async => await sharedPreferences.setBool(key, value);

  static bool? getBool({required String key}) => sharedPreferences.getBool(key);
}
