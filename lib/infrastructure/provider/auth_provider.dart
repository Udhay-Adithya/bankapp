import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/auth_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  Future<bool> login(String username, String faceId, String fingerprint) async {
    bool isAuthenticated = await AuthService.login(
      username: username,
      faceId: faceId,
      fingerprint: fingerprint,
    );
    state = isAuthenticated;
    return isAuthenticated;
  }

  Future<bool> signUp(
      String username, String email, String faceId, String fingerprint) async {
    bool isRegistered = await AuthService.signUp(
      username: username,
      email: email,
      faceId: faceId,
      fingerprint: fingerprint,
    );
    return isRegistered;
  }

  
}
