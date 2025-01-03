import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/login/cubit/login_cubit.dart';
import 'package:masi_dam_2425/login/view/login_form.dart';
import 'package:masi_dam_2425/network/bloc/network_bloc.dart';
import 'package:masi_dam_2425/network/no_network_dialog.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state is NetworkFailure) {
          Network.showNoNetworkDialog(context);
        }
      },
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: BlocProvider(
              create: (_) =>
                  LoginCubit(context.read<AuthenticationRepository>()),
              child: const LoginForm(),
            ),
        ),
      ),
    );


  }
}
