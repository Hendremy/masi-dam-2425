import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/profile/cubit/avatar_cubit.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // Add more controllers if there are more fields
  // final TextEditingController phoneController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();

  ProfilePage({Key? key}) : super(key: key);

  static Page<void> page() => MaterialPage<void>(child: ProfilePage());

  @override
  Widget build(BuildContext context) {
    context.read<AvatarCubit>().loadAvatar();
    return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<AvatarCubit, AvatarState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              }

              final avatar = state.avatar;
              if (avatar != null) {
                nameController.text = avatar.name;
                emailController.text = avatar.email;
                // Initialize other controllers with avatar data
                // phoneController.text = avatar.phone;
                // addressController.text = avatar.address;
              } else {
                return const Center(child: Text('Failed to load profile.'));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _ProfileInputField(
                      controller: nameController,
                      labelText: 'Name',
                      hintText: 'Enter your name',
                    ),
                    const SizedBox(height: 10),
                    _ProfileInputField(
                      controller: emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                    // Add more input fields for other avatar information
                    // const SizedBox(height: 10),
                    // _ProfileInputField(
                    //   controller: phoneController,
                    //   labelText: 'Phone',
                    //   hintText: 'Enter your phone number',
                    // ),
                    // const SizedBox(height: 10),
                    // _ProfileInputField(
                    //   controller: addressController,
                    //   labelText: 'Address',
                    //   hintText: 'Enter your address',
                    // ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final name = nameController.text.trim();
                        final email = emailController.text.trim();
                        // Get values from other controllers
                        // final phone = phoneController.text.trim();
                        // final address = addressController.text.trim();


                        context.read<AvatarCubit>().updateAvatar(
                              displayName: name,
                              email: email,
                            );
                      },
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}

class _ProfileInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  const _ProfileInputField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
