import 'package:flutter/material.dart';
import 'package:flutter_application_16/auth_page.dart';
import 'package:flutter_application_16/home_page.dart';
import 'package:flutter_application_16/sl.dart';
import 'package:flutter_application_16/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, String>(
      ///
      bloc: SL.authSL<UserCubit>(),

      ///
      listener: (BuildContext context, String user) => navigatorKey.currentState?.pushReplacementNamed(user.isEmpty ? '/' : 'home'),

      ///
      child: MaterialApp(
        ///
        navigatorKey: navigatorKey,

        ///
        initialRoute: SL.authSL<UserCubit>().state.isEmpty ? '/' : 'home',

        ///
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute<void>(
                builder: (BuildContext context) => const AuthPage(),
              );

            case 'home':
              return MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage(),
              );
          }

          return null;
        },
      ),
    );
  }
}
