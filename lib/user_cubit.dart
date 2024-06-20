import 'dart:async';
import 'package:bloc/bloc.dart';

class UserCubit extends Cubit<String> {
  UserCubit() : super('');

  StreamSubscription<String>? _streamSubscription;

  void init({
    required Stream<String> userStream,
  }) {
    if (_streamSubscription != null) {
      return;
    }

    _streamSubscription = userStream.listen(_onUser);
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }

  void _onUser(String user) {
    emit(user);
  }
}
