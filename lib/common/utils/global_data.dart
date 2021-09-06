class MyGlobalData {
  static String token = '';
  static String refreshToken = '';
  static String tokenType = '';
  static int tokenValidPeriod = 0;
  static String tokenScope = '';

  static clearToken() {
    token = null;
    refreshToken = null;
    tokenType = null;
    tokenValidPeriod = 0;
    tokenScope = null;
  }
}
