class AuthRepo {
  Future<String?> getUser() async => null;

  Future<String> logIn(String login) async {
    await Future.delayed(const Duration(seconds: 1));

    return 'user-$login';
  }

  Future<void> logOut(String user) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
