import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/model/avatar.dart';
import 'package:masi_dam_2425/profile/cubit/profile_cubit.dart';
import 'package:masi_dam_2425/profile/widgets/avatar_summary.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().loadProfile();
    return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              }

              final user = state.profile?.user;
              final avatar = state.profile?.avatar;

              final nameController = TextEditingController(text: avatar?.name);
              final emailController = TextEditingController(text: user?.email);


              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    AvatarWidget(avatar: avatar!),
                    const SizedBox(height: 16),
                    UserWidget(user: user!, nameController: nameController, emailController: emailController),
                    const SizedBox(height: 16),
                    ElevatedButton(onPressed: () {
                          context.read<ProfileCubit>().updateProfileDetails(
                                displayName: nameController.text,
                                email: emailController.text,
                              );
                    }, child: const Text('Save')),
                  ],
                ),
              );
            },
          ),
        )));
  }
}

class AvatarWidget extends StatelessWidget {
  final Avatar avatar;

  const AvatarWidget({Key? key, required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarSummary(profile: avatar);
  }
}

class UserWidget extends StatelessWidget {
  final User user;
  final nameController, emailController;

  UserWidget({Key? key, required this.user, required this.nameController,  required this.emailController}) : super(key: key);

  @override
  Widget build(Object context) {
  
    return Column(
      children: [
        ProfileInputField(
          controller: nameController,
          labelText: 'Name',
          hintText: 'Enter your name',
          active: true,
        ),
        const SizedBox(height: 16),
        ProfileInputField(
          controller: emailController,
          labelText: 'Email',
          hintText: 'Enter your email',
          active: user.emailVerified!,
        ),
        Card(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user.lastSignInDate.toString(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Date',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user.creationDate.toString(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Account verified',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user.emailVerified.toString(),
                  ),
                ],
              ),
            ],
          ),
        )),
        const SizedBox(height: 16),
      ],
    );
  }
}

class ProfileInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool active;

  const ProfileInputField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.active,
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
      enabled: active,
    );
  }
}
