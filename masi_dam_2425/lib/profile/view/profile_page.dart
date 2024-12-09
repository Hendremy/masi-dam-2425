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
              final passwordController = TextEditingController();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    AvatarWidget(avatar: avatar!),
                    const SizedBox(height: 30),
                    UserWidget(
                        user: user!,
                        nameController: nameController,
                        emailController: emailController),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileCubit>().updateProfileDetails(
                              displayName: nameController.text,
                              email: emailController.text,
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: Colors.white,
                      ),
                      child: Text("Update Profile"),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete your Account?'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('If you select Delete we will delete your account on our server.'),
                                    const SizedBox(height: 16),
                                    ProfileInputField(
                                      controller: passwordController,
                                      labelText: 'Password',
                                      hintText: 'Enter your password',
                                      obscureText: true,
                                      icon: Icons.lock,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                      child: Text("Delete Profile"),
                    ),
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

  UserWidget(
      {Key? key,
      required this.user,
      required this.nameController,
      required this.emailController})
      : super(key: key);

  @override
  Widget build(Object context) {
    return Column(
      children: [
        Card(
            elevation: 2,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.login, color: Colors.orange, size: 24),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Last login: ${user.formattedAccountLastLoginDate}",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: Colors.purple, size: 24),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Account Creation Date: ${user.formattedAccountCreationDate}",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: (user.emailVerified ?? false)
                            ? Colors.green
                            : Colors.red,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Account verified: ${user.emailVerified! ? 'Yes' : 'No'}",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  ProfileInputField(
                    controller: nameController,
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    active: true,
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),
                  ProfileInputField(
                      controller: emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      active: user.emailVerified!,
                      icon: Icons.email),
                  SizedBox(height: 16),
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
  final IconData? icon;
  final bool obscureText;

  const ProfileInputField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.active = true,
    required this.icon,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(this.icon, color: Colors.blue),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
      ),
      enabled: active,
    );
  }
}
