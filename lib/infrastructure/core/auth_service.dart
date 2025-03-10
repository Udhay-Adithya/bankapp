import 'package:local_auth/local_auth.dart';

import '../core/db_helper.dart';

class AuthService {
  // Sign Up Function
  static Future<bool> signUp({
    required String username,
    required String email,
    required String faceId,
    required String fingerprint,
  }) async {
    username = username.trim().toLowerCase(); // Normalize username

    final user = await DBHelper.getUser(username);
    if (user != null) {
      print("❌ Username already exists: $username");
      return false; // User already exists
    }

    await DBHelper.insertUser({
      'username': username,
      'email': email,
      'faceId': faceId,
      'fingerprint': fingerprint,
    });

    // Verify if user was inserted correctly
    final newUser = await DBHelper.getUser(username);
    print("🔹 Debug: User inserted → $newUser");

    return newUser != null;
  }

  // Login Function
  static Future<bool> login({
    required String username,
    required String faceId,
    required String fingerprint,
  }) async {
    username = username.trim().toLowerCase(); // Normalize username

    final user = await DBHelper.getUser(username);
    print("🔹 Debug: Fetched User Data → $user"); // See what’s in the DB

    if (user == null) {
      print("❌ User not found for username: $username");
      return false; // User does not exist
    }

    print("🆔 Stored Face ID: ${user['faceId']}, Input Face ID: $faceId");
    print(
        "🔑 Stored Fingerprint: ${user['fingerprint']}, Input Fingerprint: $fingerprint");

    // Validate credentials (faceId OR fingerprint should match)
    if (user['faceId'] == faceId || user['fingerprint'] == fingerprint) {
      print("✅ Authentication successful for $username");
      return true;
    }

    print("❌ Invalid credentials provided");
    return false;
  }

  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    final bool canAuthenticate =
        await auth.canCheckBiometrics || await auth.isDeviceSupported();
    if (!canAuthenticate) return false;

    return await auth.authenticate(
      localizedReason: "Authenticate to send money",
      options: const AuthenticationOptions(
        biometricOnly: true,
        useErrorDialogs: true,
        stickyAuth: true,
      ),
    );
  }
}
