import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/avatar_api.dart';
import 'package:masi_dam_2425/app/bloc/app_bloc.dart';
import 'package:masi_dam_2425/app/routes.dart';
import 'package:masi_dam_2425/network/bloc/network_bloc.dart';
import 'package:masi_dam_2425/profile/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/theme.dart';

import '../../inventory/cubit/inventory_cubit.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider<UserApiServices>(
          create: (context) => UserApiServices(
            firestoreDb: FirebaseFirestore.instance,
            auth: FirebaseAuth.instance,
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
              authenticationRepository: _authenticationRepository,
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
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
