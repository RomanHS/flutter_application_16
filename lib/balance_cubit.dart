import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_application_16/balance_repo.dart';

class BalanceCubit extends Cubit<double?> {
  final String user;
  final BalanceRepo balanceRepo;

  StreamSubscription<double>? _streamSubscription;

  BalanceCubit({
    required this.user,
    required this.balanceRepo,
  }) : super(null);

  void init() {
    if (_streamSubscription != null) {
      return;
    }

    _streamSubscription = balanceRepo.getBalanceStream().listen(_onBalance);
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }

  void _onBalance(double balance) {
    emit(balance);
  }
}
