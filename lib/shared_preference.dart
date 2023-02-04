import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  // Username
  static Future setUsername(String username) async =>
      await _preferences?.setString(
        "username",
        username,
      );
  static String? getUsername() => _preferences?.getString("username");

  // Password
  // static Future setPassword(String password) async =>
  //     await _preferences?.setString(
  //       "password",
  //       password,
  //     );
  // static String? getPassword() => _preferences?.getString("password");

  // SetToken
  // static Future setToken(String token) async => await _preferences?.setString(
  //       "token",
  //       token,
  //     );
  // static String? getToken() => _preferences?.getString("token");

  // Set UserId
  static Future setUserId(String userId) async => await _preferences?.setString(
        "userId",
        userId,
      );
  static String? getUserId() => _preferences?.getString("userId");

  // Set UserStatus
  // static Future setUserStatus(String isAdmin) async =>
  //     await _preferences?.setString(
  //       "isAdmin",
  //       isAdmin,
  //     );
  // static String? getUserStatus() => _preferences?.getString("isAdmin");

  // Set subscriptionStatus
  // static Future setIsSubscribed(bool? isSubscribed) async =>
  //     await _preferences?.setBool("isSubscribed", isSubscribed!);
  // static bool? getIsSubscribed() => _preferences?.getBool("isSubscribed");
}
