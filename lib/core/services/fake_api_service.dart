class FakeApiService {
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == "test@test.com" && password == "123456") {
      return {
        "success": true,
        "token": "dummy_token_123",
        "name": "Mohamed Hesham",
        "email": email,
      };
    }

    return {"success": false, "message": "Invalid Email or Password"};
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    return {
      "success": true,
      "message": "Account Created Successfully",
      "token": "new_dummy_token",
      "name": name,
      "email": email,
    };
  }

  static Future<Map<String, dynamic>> getProfile() async {
    await Future.delayed(const Duration(seconds: 1));

    return {
      "name": "Mohamed Hesham",
      "email": "test@test.com",
      "phone": "+20 1000000000",
      "orders": 5,
      "rating": 4.9,
    };
  }
}
