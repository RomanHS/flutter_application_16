import 'package:flutter/material.dart';
import 'package:flutter_application_16/auth_cobit.dart';
import 'package:flutter_application_16/balance_cubit.dart';
import 'package:flutter_application_16/sl.dart';
import 'package:flutter_application_16/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///
        title: BlocBuilder(
          bloc: SL.authSL<UserCubit>(),
          builder: (BuildContext context, String user) {
            return Text(user);
          },
        ),

        ///
        actions: [
          ///
          BlocBuilder(
            bloc: SL.userSL<BalanceCubit>(),
            builder: (BuildContext context, double? balance) {
              return Text(balance?.toStringAsFixed(2) ?? '-');
            },
          ),

          ///
          IconButton(
            onPressed: () => SL.authSL<AuthCubit>().logOut(),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}
