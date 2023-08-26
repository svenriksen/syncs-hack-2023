import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;
  
  static const _keyUsername = 'username';
  static const _emailId = 'emailId';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUsername(String username) async {
    return await _preferences?.setString(_keyUsername, username);
  } 
}