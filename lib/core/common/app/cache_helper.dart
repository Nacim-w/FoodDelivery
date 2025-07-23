import 'dart:convert';

import 'package:legy/core/common/singletons/cache.dart';
import 'package:legy/features/home/model/home_profile_model.dart';
import 'package:legy/features/maps/model/saved_location_model.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  const CacheHelper(this._prefs);

  final SharedPreferences _prefs;

  static const _firstTimerKey = 'is-user-first-timer';
  static const _sessionTokenKey = 'user-session-token';
  static const _cartProductsKey = 'cart-products';
  static const _userProfileKey = 'user-profile';
  static const _savedLocationsKey = 'saved-locations';
  static const _refreshTokenKey = 'user-refresh-token';
  static const _lastOrderIdKey = 'last-active-order-id';

  // Session token
  String? getSessionToken() {
    final sessionToken = _prefs.getString(_sessionTokenKey);
    if (sessionToken != null) {
      Cache.instance.setSessionToken(sessionToken);
    }
    return sessionToken;
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
    await _prefs.remove(_refreshTokenKey);
    await _prefs.remove(_userProfileKey);
    await _prefs.remove(_lastOrderIdKey);
    Cache.instance.resetSession();
  }

  // First timer
  Future<void> cacheFirstTimer() async {
    await _prefs.setBool(_firstTimerKey, false);
  }

  bool isFirstTime() => _prefs.getBool(_firstTimerKey) ?? true;

  // Refresh token
  String? getRefreshToken() => _prefs.getString(_refreshTokenKey);

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

  // Cart
  Future<void> cacheCartProducts(List<ProductModel> products) async {
    final productListJson =
        jsonEncode(products.map((p) => p.toJson()).toList());
    await _prefs.setString(_cartProductsKey, productListJson);
  }

  List<ProductModel> getCartProducts() {
    final productListString = _prefs.getString(_cartProductsKey);
    if (productListString == null) return [];
    final List<dynamic> productListJson = jsonDecode(productListString);
    return productListJson.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<void> clearCart() async {
    await _prefs.remove(_cartProductsKey);
  }

  // User Profile
  Future<void> cacheUserProfile(HomeProfileModel profile) async {
    final profileJson = jsonEncode(profile.toJson());
    await _prefs.setString(_userProfileKey, profileJson);
  }

  HomeProfileModel? getCachedUserProfile() {
    final profileString = _prefs.getString(_userProfileKey);
    if (profileString == null) return null;
    final profileJson = jsonDecode(profileString);
    return HomeProfileModel.fromJson(profileJson);
  }

  // Saved locations
  Future<void> cacheSavedLocations(List<SavedLocation> locations) async {
    final locationsJson = jsonEncode(locations.map((e) => e.toJson()).toList());
    await _prefs.setString(_savedLocationsKey, locationsJson);
  }

  List<SavedLocation> getSavedLocations() {
    final locationsString = _prefs.getString(_savedLocationsKey);
    if (locationsString == null) return [];
    final List<dynamic> decoded = jsonDecode(locationsString);
    return decoded.map((e) => SavedLocation.fromJson(e)).toList();
  }

  // ✅ New: Last active order ID
  Future<void> cacheLastActiveOrderId(String orderId) async {
    await _prefs.setString(_lastOrderIdKey, orderId);
  }

  Future<String?> getLastActiveOrderId() async {
    return _prefs.getString(_lastOrderIdKey);
  }

  Future<void> clearLastActiveOrderId() async {
    await _prefs.remove(_lastOrderIdKey);
  }
}
