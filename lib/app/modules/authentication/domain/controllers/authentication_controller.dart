import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/app/modules/authentication/domain/repository/authentication_repository.dart';
import 'package:tezda_task/app/modules/authentication/presentation/pages/sign_in_page.dart';
import 'package:tezda_task/app/shared/classes/dashboard.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

final authenticationProvider = Provider(
  (ref) => AuthenticationController(
    AuthenticationRepository(),
  ),
);

class AuthenticationController {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationController(this._authenticationRepository);

  Future<void> login({required String email, required String password}) async {
    final res = await _authenticationRepository.login(email, password);

    if (res.user != null) {
      log(res);
      pushToAndClearStack(const Dashboard());
    }
  }

  Future<void> register(
      {required String email,
      required String fullName,
      required String phone,
      required String password}) async {
    final res = await _authenticationRepository.register(
        email, fullName, phone, password);

    log(res);

    pushToAndClearStack(const Dashboard());
  }

  Future<void> signOut() async {
    await _authenticationRepository.signOut();

    pushToAndClearStack(const SignInPage());
  }
}
