import 'dart:async';
import 'package:flutter_application_16/auth_cobit.dart';
import 'package:flutter_application_16/auth_repo.dart';
import 'package:flutter_application_16/balance_cubit.dart';
import 'package:flutter_application_16/balance_repo.dart';
import 'package:flutter_application_16/user_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class SL {
  static final GetIt authSL = GetIt.asNewInstance();
  static final GetIt userSL = GetIt.asNewInstance();

  static void initAuthSL() {
    /// Cubit
    authSL.registerLazySingleton(() => UserCubit());
    authSL.registerLazySingleton(() => AuthCubit(authRepo: authSL()));

    /// Repo
    authSL.registerLazySingleton(() => AuthRepo());
  }

  static Future<void> startAuthSL() async {
    final UserCubit userCubit = authSL();

    final AuthCubit authCubit = authSL();

    userCubit.init(userStream: authCubit.getUserStream());

    await authCubit.init();

    userCubit.stream.listen(_onUser);
  }

  static void initUserSL(String user) {
    ///
    userSL.registerSingleton(user);

    /// Cubit
    userSL.registerLazySingleton(
      () => BalanceCubit(user: userSL(), balanceRepo: userSL()),
      dispose: (BalanceCubit value) => value.close(),
    );

    /// Repo
    userSL.registerLazySingleton(() => BalanceRepo());
  }

  static Future<void> startUserSL() async {
    final BalanceCubit balanceCubit = userSL();

    balanceCubit.init();
  }

  static Future<void> disposeUserSL() => userSL.reset();

  static void _onUser(String user) async {
    if (user.isEmpty) {
      await disposeUserSL();
    }
    //
    else {
      initUserSL(user);
      await startUserSL();
    }
  }
}
