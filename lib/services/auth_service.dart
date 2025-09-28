class AuthService {
  static Future<bool> login(String email, String password) async {
    // Simulate network call
    await Future.delayed(const Duration(seconds: 1));
    return email == 'test@example.com' && password == 'password123';
  }

  static Future<bool> signup(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  static Future<void> loginWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  static Future<void> loginWithApple() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  static Future<void> loginWithBinance() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  static Future<void> loginWithWallet() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}