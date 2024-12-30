import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/profile/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/profile/view/goodbye_page.dart';
import 'package:masi_dam_2425/profile/view/profile_summary_widget.dart';
import 'package:workmanager/workmanager.dart';

import '../../app/bloc/app_bloc.dart';
import '../../model/avatar.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(title: const Text('Profile'), actions: [
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              context.read<AppBloc>().add(const AppLogoutPressed());
              // Navigator.of(context).pop(); // Removed the pop as profile is now on root widget (Nav change)
              // Test if notifications works in background
              Workmanager().registerOneOffTask(
              "local", "show_notification_task", initialDelay: Duration(seconds: 10), inputData: {
                "title": "Hello",
                "message": "World"
              });
            },
          ),
        ],),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProfileUpdating) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      const Text(
                        'Profile is updating',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );

              }

              if (state is ProfileError) {
                return Center(child: Text('Error: ${state.message}'));
              }

              if (state is ProfileLoaded) {
                final profile = state.profile;

                final nameController = TextEditingController(text: profile.name);
                final emailController = TextEditingController(text: profile.connectionData.email);
                final passwordController = TextEditingController();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      AvatarWidget(avatar: profile),
                      const SizedBox(height: 30),
                      UserWidget(
                          user: profile,
                          nameController: nameController,
                          emailController: emailController),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ProfileBloc>().add(UpdateProfile(
                              profile.copyWith(
                                  name: nameController.text,
                                  connectionData: profile.connectionData.copyWith(
                                      email: emailController.text))
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          backgroundColor: Colors.white,
                        ),
                        child: state is ProfileUpdating
    ? const CircularProgressIndicator()
        : const Text('Update Profile'),
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
                                      onPressed: () async {
                                        final password = passwordController.text;
                                        final profileBloc = context.read<ProfileBloc>();
                                        final isDeleted = await profileBloc.deleteAccount(password);
                                        if (isDeleted) {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (context) => GoodbyePage()),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Account deletion failed. Please try again.')),
                                          );
                                          Navigator.of(context).pop();
                                        }
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
              }
              return const SizedBox.shrink();

            }
            ))));
  }
}

class AvatarWidget extends StatelessWidget {
  final Avatar avatar;

  const AvatarWidget({Key? key, required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileSummaryWidget(profile: avatar);
  }
}


class UserWidget extends StatelessWidget {
  final Avatar user;
  final nameController, emailController;

  UserWidget(
      {Key? key,
      required this.user,
      required this.nameController,
      required this.emailController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            elevation: Theme.of(context).cardTheme.elevation,
            color: Theme.of(context).cardTheme.color,
            margin: Theme.of(context).cardTheme.margin,
            shape: Theme.of(context).cardTheme.shape,
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
                          "Last login: ${user.connectionData.lastLoginFormatted()}",
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
                          "Account Creation Date: ${user.connectionData.firstLoginFormatted()}",
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
                        color: (user.connectionData.isVerified)
                            ? Colors.green
                            : Colors.red,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Account verified: ${user.connectionData.isVerified ? 'Yes' : 'No'}",
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
                      active: false,
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
