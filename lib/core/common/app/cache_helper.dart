import 'package:legy/core/common/singletons/cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  const CacheHelper(this._prefs);

  final SharedPreferences _prefs;
  static const _firstTimerKey = 'is-user-first-timer';
  static const _sessionTokenKey = 'user-session-token';

  String? getSessionToken() {
    final sessionToken = _prefs.getString(_sessionTokenKey);
    if (sessionToken case String()) {
      Cache.instance.setSessionToken(sessionToken);
    }
    return sessionToken;
  }

  Future<void> cacheFirstTimer() async {
    await _prefs.setBool(_firstTimerKey, false);
  }

  Future<bool> cacheSessionToken(String token) async {
    try {
      final result = await _prefs.setString(_sessionTokenKey, token);
      Cache.instance.setSessionToken(token);
      return result;
    } catch (_) {
      return false;
    }
  }

  Future<void> resetSession() async {
    await _prefs.remove(_sessionTokenKey);
    Cache.instance.resetSession();
  }

  bool isFirstTime() => _prefs.getBool(_firstTimerKey) ?? true;

  //refresh token
  static const _refreshTokenKey = 'user-refresh-token';

  String? getRefreshToken() {
    final refreshToken = _prefs.getString(_refreshTokenKey);
    return refreshToken;
  }

  Future<bool> cacheRefreshToken(String token) async {
    try {
      return await _prefs.setString(_refreshTokenKey, token);
    } catch (_) {
      return false;
    }
  }

  Future<void> resetRefreshToken() async {
    await _prefs.remove(_refreshTokenKey);
  }
}
