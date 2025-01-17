
import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/avatar.dart';
import 'package:masi_dam_2425/profile/view/profile_page.dart';

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