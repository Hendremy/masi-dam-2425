import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:masi_dam_2425/common/custom_input_field.dart';
import 'package:masi_dam_2425/login/cubit/login_cubit.dart';
import 'package:masi_dam_2425/sign_up/view/sign_up_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5, // Add shadow effect for the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child: Padding(
              padding:
                  const EdgeInsets.all(16), // Internal padding for the card
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/greenmon-logo.png',
                    height: 120,
                  ),
                  const SizedBox(height: 16),
                  _EmailInput(),
                  const SizedBox(height: 8),
                  _PasswordInput(),
                  const SizedBox(height: 8),
                  _LoginButton(),
                  const SizedBox(height: 4),
                  _SignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginCubit cubit) => cubit.state.email.displayError,
    );

    return CustomInputField(
      key: const Key('loginForm_emailInput_textField'),
      labelText: 'Email Address',
      hintText: 'Enter your email',
      icon: Icons.email,
      obscureText: false,
      type: TextInputType.emailAddress,
      action: (email) => context.read<LoginCubit>().emailChanged(email),
      errorText: displayError != null ? 'invalid email' : null,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginCubit cubit) => cubit.state.password.displayError,
    );

    return CustomInputField(
      key: const Key('loginForm_passwordInput_textField'),
      labelText: 'Password',
      hintText: 'Enter your password',
      icon: Icons.lock,
      obscureText: true,
      type: TextInputType.visiblePassword,
      action: (password) => context.read<LoginCubit>().passwordChanged(password),
      errorText: displayError != null ? '' : null,
    );

  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (LoginCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (LoginCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: const Color(0xFFFFD600),
      ),
      onPressed: isValid
          ? () => context.read<LoginCubit>().logInWithCredentials()
          : null,
      child: const Text('LOGIN'),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
