import 'package:bloc/bloc.dart';
import 'package:flutter_application_16/auth_repo.dart';

sealed class AuthState {
  const AuthState();

  String? get user;
}

class NotAuthState extends AuthState {
  const NotAuthState();

  @override
  String? get user => null;
}

class LoadedAuthState extends AuthState {
  const LoadedAuthState();

  @override
  String? get user => null;
}

class UserAuthState extends AuthState {
  @override
  final String user;

  const UserAuthState(this.user);
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit({
    required this.authRepo,
  }) : super(const NotAuthState());

  Stream<String> get userStream => stream.map((AuthState state) => state.user ?? '');

  Future<void> init() async {
    final String? user = await authRepo.getUser();

    if (user != null) {
      emit(UserAuthState(user));
    }
  }

  void logIn(String login) async {
    final AuthState state = this.state;

    if (state is! NotAuthState) {
      return;
    }

    emit(const LoadedAuthState());

    final String user = await authRepo.logIn(login);

    emit(UserAuthState(user));
  }

  void logOut() async {
    final AuthState state = this.state;

    if (state is! UserAuthState) {
      return;
    }

    emit(const LoadedAuthState());

    await authRepo.logOut(state.user);

    emit(const NotAuthState());
  }
}
