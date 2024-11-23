import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/login/login.dart';
import 'package:masi_dam_2425/network/bloc/network_bloc.dart';
import 'package:masi_dam_2425/network/view/no_network_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8),
          child:
              BlocBuilder<NetworkBloc, NetworkState>(builder: (context, state) {
                if (state is NetworkFailure) {
                  return NoNetworkPage();
                } else {
                  return BlocProvider(
                    create: (_) =>
                        LoginCubit(context.read<AuthenticationRepository>()),
                    child: const LoginForm(),
                  );
                }
              }
              )
      ),
    );
  }
}
