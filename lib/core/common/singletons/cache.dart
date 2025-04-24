class Cache {
  Cache._internal();

  static final Cache instance = Cache._internal();

  String? _sessionToken;

  String? get sessionToken => _sessionToken;

  void setSessionToken(String? newToken) {
    if (_sessionToken != newToken) _sessionToken = newToken;
  }

  void resetSession() {
    setSessionToken(null);
  }
}
