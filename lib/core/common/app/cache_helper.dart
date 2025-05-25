import 'dart:convert';

import 'package:legy/core/common/singletons/cache.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  const CacheHelper(this._prefs);

  final SharedPreferences _prefs;
  static const _firstTimerKey = 'is-user-first-timer';
  static const _sessionTokenKey = 'user-session-token';
  static const _cartProductsKey = 'cart-products';
  static const _cartSupplementsKey = 'cart-supplements';

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

  Future<void> cacheCartProducts(List<ProductModel> products) async {
    final productListJson =
        jsonEncode(products.map((p) => p.toJson()).toList());
    await _prefs.setString(_cartProductsKey, productListJson);
  }

  // Get cart products from cache
  List<ProductModel> getCartProducts() {
    final productListString = _prefs.getString(_cartProductsKey);
    if (productListString == null) return [];
    final List<dynamic> productListJson = jsonDecode(productListString);
    return productListJson.map((json) => ProductModel.fromJson(json)).toList();
  }

  // Save cart supplements to cache
  Future<void> cacheCartSupplements(List<Supplement> supplements) async {
    final supplementListJson =
        jsonEncode(supplements.map((s) => s.toJson()).toList());
    await _prefs.setString(_cartSupplementsKey, supplementListJson);
  }

  // Get cart supplements from cache
  List<Supplement> getCartSupplements() {
    final supplementListString = _prefs.getString(_cartSupplementsKey);
    if (supplementListString == null) return [];
    final List<dynamic> supplementListJson = jsonDecode(supplementListString);
    return supplementListJson.map((json) => Supplement.fromJson(json)).toList();
  }

  // Clear cart
  Future<void> clearCart() async {
    await _prefs.remove(_cartProductsKey);
    await _prefs.remove(_cartSupplementsKey);
  }
}
