import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';
  static const String _loginTimeKey = 'login_time';
  static const String _rememberMeKey = 'remember_me';

  // SAVE TOKEN WITH TIMESTAMP
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_loginTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  // GET TOKEN
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // CHECK IF TOKEN EXISTS AND NOT EXPIRED
  Future<bool> hasValidToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);

    if (token == null || token.isEmpty) {
      return false;
    }

    // Opsional: Cek apakah token sudah expired (misalnya 30 hari)
    final loginTime = prefs.getInt(_loginTimeKey);
    if (loginTime != null) {
      final loginDate = DateTime.fromMillisecondsSinceEpoch(loginTime);
      final now = DateTime.now();
      final difference = now.difference(loginDate);

      // Token expired setelah 30 hari
      if (difference.inDays >= 30) {
        await clearAll();
        return false;
      }
    }

    return true;
  }

  // DELETE TOKEN
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_loginTimeKey);
  }

  // SAVE USER DATA
  Future<void> saveUserData(String userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, userData);
  }

  // GET USER DATA
  Future<String?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userDataKey);
  }

  // SAVE REMEMBER ME PREFERENCE
  Future<void> setRememberMe(bool remember) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, remember);
  }

  // GET REMEMBER ME PREFERENCE
  Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }

  // CLEAR ALL DATA
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // CLEAR ONLY AUTH DATA (keep other app settings)
  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userDataKey);
    await prefs.remove(_loginTimeKey);
    await prefs.remove(_rememberMeKey);
  }

  // CHECK IF USER IS LOGGED IN
  Future<bool> isLoggedIn() async {
    return await hasValidToken();
  }

  // GET LOGIN TIME
  Future<DateTime?> getLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    final loginTime = prefs.getInt(_loginTimeKey);
    if (loginTime != null) {
      return DateTime.fromMillisecondsSinceEpoch(loginTime);
    }
    return null;
  }

  // UPDATE TOKEN (refresh token functionality)
  Future<void> updateToken(String newToken) async {
    await saveToken(newToken);
  }
}
