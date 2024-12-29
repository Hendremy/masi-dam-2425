import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:masi_dam_2425/sign_up/cubit/sign_up_cubit.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
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
            margin: const EdgeInsets.symmetric(horizontal: 16), // Space between card and screen edges
            child: Padding(
              padding: const EdgeInsets.all(16), // Internal padding for the card
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Sign Up", style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 8),
                  Image.asset(
                    'assets/greenmon-logo.png',
                    height: 120,
                  ),
                  const SizedBox(height: 16),
                  _NameInput(),
                  const SizedBox(height: 8),
                  _EmailInput(),
                  const SizedBox(height: 8),
                  _PasswordInput(),
                  const SizedBox(height: 8),
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

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('signUpForm_nameInput_textField'),
      onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        labelText: 'Full Name',
        hintText: 'Enter your full name',
        hintStyle: const TextStyle(color: Colors.grey), // Grey color for hint text
        filled: true,
        fillColor: Colors.grey.shade100, // Subtle background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit cubit) => cubit.state.email.displayError,
    );

    return TextField(
      key: const Key('signUpForm_emailInput_textField'),
      onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        labelText: 'Email Address',
        hintText: 'Enter your email',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit cubit) => cubit.state.password.displayError,
    );

    return TextField(
      key: const Key('signUpForm_passwordInput_textField'),
      onChanged: (password) =>
          context.read<SignUpCubit>().passwordChanged(password),
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        labelText: 'Password',
        hintText: 'Enter your password',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (SignUpCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (SignUpCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('signUpForm_continue_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      onPressed: isValid
          ? () => context.read<SignUpCubit>().signUpFormSubmitted()
          : null,
      child: const Text('SIGN UP'),
    );
  }
}
