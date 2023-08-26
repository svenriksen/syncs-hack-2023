import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyUsername = 'username';
  static const _keyId = 'emailId';
  static const _keyPhotoUrl = 'photoUrl';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUsername(String username) async {
    return await _preferences?.setString(_keyUsername, username);
  }

  static Future setId(String emailId) async {
    return await _preferences?.setString(_keyId, emailId);
  }

  static Future setPhotoUrl(String? photoUrl) async {
    photoUrl ??= 'assets/default_profile_pic.jpg';
    return await _preferences?.setString(_keyPhotoUrl, photoUrl);
  }

  static String getUsername() => _preferences?.getString(_keyUsername) ?? '';

  static String getId() => _preferences?.getString(_keyId) ?? '';

  static String getPhotoUrl() => _preferences?.getString(_keyPhotoUrl) ?? '';

  static void removePreferences() {
    _preferences?.remove(_keyUsername);
    _preferences?.remove(_keyId);
    _preferences?.remove(_keyPhotoUrl);
  }
}
