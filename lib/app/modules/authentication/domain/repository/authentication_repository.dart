import 'package:firebase_auth/firebase_auth.dart';
import 'package:tezda_task/app/modules/authentication/domain/service/authentication_service.dart';

import 'package:tezda_task/injection.dart';

class AuthenticationRepository {
  final _authenticationService = inj<AuthenticationService>();

  Future<UserCredential> login(String email, String password) {
    return _authenticationService.signIn(email, password);
  }

  Future<UserCredential> register(
      String email, String fullName, String phone, String password) {
    return _authenticationService.signUp(email, fullName, phone, password);
  }

  Future<void> signOut() {
    return _authenticationService.signOut();
  }
}
