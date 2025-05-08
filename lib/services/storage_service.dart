import 'package:get_storage/get_storage.dart';
import 'package:jiwaapp_task7/model/user_model.dart';

class StorageService {
  // Create a getter for the storage instance to ensure it's only initialized when needed
  static GetStorage get _storage => GetStorage();

  // Token methods
  static String? getToken() {
    return _storage.read<String>('token');
  }

  static Future<void> setToken(String token) async {
    await _storage.write('token', token);
  }

  static Future<void> removeToken() async {
    await _storage.remove('token');
  }

  // User methods
  static UserModel? getUser() {
    final userData = _storage.read('user');
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  static Future<void> setUser(UserModel user) async {
    await _storage.write('user', user.toJson());
  }

  static Future<void> removeUser() async {
    await _storage.remove('user');
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return _storage.hasData('token');
  }

  // Clear all stored data (for logout)
  static Future<void> clearAll() async {
    await _storage.erase();
  }
}
