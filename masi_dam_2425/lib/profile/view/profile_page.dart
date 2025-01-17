import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/common/custom_input_field.dart';
import 'package:masi_dam_2425/profile/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/profile/view/goodbye_page.dart';
import 'package:masi_dam_2425/profile/view/profile_summary_widget.dart';
import 'package:masi_dam_2425/profile/widgets/user_widget.dart';
import 'package:workmanager/workmanager.dart';

import '../../app/bloc/app_bloc.dart';

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
              Workmanager().registerOneOffTask(
              "local", "show_notification_task", initialDelay: Duration(seconds: 10), inputData: {
                "title": "Message from Greenmon",
                "message": "You have been logged out.",
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
                return showProfile(state, context);
              }
              return const SizedBox.shrink();

            }
            ))));
  }

  Padding showProfile(ProfileLoaded state, BuildContext context) {
    final profile = state.profile;
    
    final nameController = TextEditingController(text: profile.name);
    final emailController = TextEditingController(text: profile.connectionData.email);
    final passwordController = TextEditingController();
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ProfileSummaryWidget(profile: profile),
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
              showDeletionDoubleCheck(context, passwordController);
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

  void showDeletionDoubleCheck(BuildContext context, TextEditingController passwordController) {
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
                CustomInputField(
                  controller: passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  obscureText: true,
                  icon: Icons.lock,
                  type: TextInputType.text,
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
  }
}
