import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyUsername = 'username';
  static const _keyId = 'emailId';
  static const _keyPhotoUrl = 'photoUrl';

  static bool booksAdded = false;
  static const _keyUploadedBooks = 'uploadedBooks';

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
    photoUrl ??= '';
    return await _preferences?.setString(_keyPhotoUrl, photoUrl);
  }

  static Future setUploadedBooks(String book) async {
    if (booksAdded == false) {
      booksAdded = true;
      return await _preferences?.setStringList(_keyUploadedBooks, [book]);
    }
    else {
      List<String> addedBooks = _preferences?.getStringList(_keyUploadedBooks) ?? [];
      addedBooks.add(book);
      return await _preferences?.setStringList(_keyUploadedBooks, addedBooks);
    }
  }

  static String getUsername() => _preferences?.getString(_keyUsername) ?? '';

  static String getId() => _preferences?.getString(_keyId) ?? '';

  static String getPhotoUrl() => _preferences?.getString(_keyPhotoUrl) ?? '';

  static List<String> getUploadedBooks() => _preferences?.getStringList(_keyUploadedBooks) ?? [];

  static void removePreferences() {
    _preferences?.remove(_keyUsername);
    _preferences?.remove(_keyId);
    _preferences?.remove(_keyPhotoUrl);
  }

  // debugging purposes
  static void removeBooks() {
    _preferences?.remove(_keyUploadedBooks);
  }
}
