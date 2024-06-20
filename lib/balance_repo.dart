class BalanceRepo {
  Stream<double> getBalanceStream() async* {
    await Future.delayed(const Duration(seconds: 1));

    yield 100;
  }
}
