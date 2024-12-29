import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/avatar_api.dart';
import 'package:masi_dam_2425/app/bloc/app_bloc.dart';
import 'package:masi_dam_2425/home/view/home_page.dart';
import 'package:masi_dam_2425/login/view/login_page.dart';
import 'package:masi_dam_2425/network/bloc/network_bloc.dart';
import 'package:masi_dam_2425/plantnet_options.dart';
import 'package:masi_dam_2425/profile/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/theme.dart';

import '../../inventory/cubit/inventory_cubit.dart';

class App extends StatelessWidget {

  final AuthenticationRepository authenticationRepository;

  const App({
    required this.authenticationRepository,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
        RepositoryProvider<UserApiServices>(
          create: (context) => UserApiServices(
            firestoreDb: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instanceFor(bucket: "gs://hepl-masi5-flutter.firebasestorage.app"),
            auth: FirebaseAuth.instance,
            plantnetOptions: PlantnetOptions.currentPlatform,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NetworkBloc>(
            lazy: false,
            create: (_) => NetworkBloc()..add(NetworkObserve()),
          ),
          BlocProvider<AppBloc>(
            lazy: false,
            create: (_) => AppBloc(
              authenticationRepository: authenticationRepository,
            )..add(const AppUserLoginRequested()),
          ),
           BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
                  repository: context.read<UserApiServices>().avatarApi
                      as AvatarFirestoreApi,
                )),
          BlocProvider<InventoryCubit>(
            create: (context) => InventoryCubit(
              context.read<UserApiServices>().inventoryApi,
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.status == AppStatus.authenticated) {
            return HomePage(); // Replace with your home page widget
          } else  {
            return LoginPage(); // Replace with your login page widget
          }
        },
      ),
    );
  }
}
