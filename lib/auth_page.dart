import 'package:flutter/material.dart';
import 'package:flutter_application_16/auth_cobit.dart';
import 'package:flutter_application_16/sl.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthPage'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => SL.authSL<AuthCubit>().logIn('test'),
          child: const Text('Auth'),
        ),
      ),
    );
  }
}
