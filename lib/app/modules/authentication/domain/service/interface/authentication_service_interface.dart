abstract interface class AuthenticationServcieInterface {
  Future register(String email, String fullName, String phone, String password);
  Future login(String email, String password);
}
