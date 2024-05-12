import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // ...
  AuthService._privateConstructor();

  static final AuthService instance = AuthService._privateConstructor();

  Future<void> changePassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {
    _validateInput(email, oldPassword, newPassword);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw _NotLoggedInException();
    }

    try {
      await _reauthenticateUser(user, email, oldPassword);
      await _updatePassword(user, newPassword);
    } catch (e) {
      throw _PasswordChangeException(e);
    }
  }

  void _validateInput(String email, String oldPassword, String newPassword) {
    if (email.isEmpty || oldPassword.isEmpty || newPassword.isEmpty) {
      throw _InvalidInputException();
    }
  }

  Future<void> _reauthenticateUser(User user, String email, String password) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    await user.reauthenticateWithCredential(credential);
  }

  Future<void> _updatePassword(User user, String newPassword) async {
    await user.updatePassword(newPassword);
  }
}

class _NotLoggedInException implements Exception {
  @override
  String toString() => 'User is not logged in';
}

class _InvalidInputException implements Exception {
  @override
  String toString() => 'Invalid input provided';
}

class _PasswordChangeException implements Exception {
  final dynamic error;

  _PasswordChangeException(this.error);

  @override
  String toString() => 'Failed to change password: $error';
}