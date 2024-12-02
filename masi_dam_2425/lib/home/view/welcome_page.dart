import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/app/bloc/app_bloc.dart';
import 'package:masi_dam_2425/home/bloc/inventory_bloc.dart';
import 'package:masi_dam_2425/home/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/inventory/view/inventory_page.dart';
import 'package:masi_dam_2425/inventory/view/shop_page.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/plants/view/calendar_page.dart';
import 'package:masi_dam_2425/plants/view/plants_page.dart';
import 'package:masi_dam_2425/plants/widgets/plant_tile.dart';
import 'package:masi_dam_2425/profile/cubit/avatar_cubit.dart';
import 'package:masi_dam_2425/profile/cubit/profile_cubit.dart';
import 'package:masi_dam_2425/profile/view/profile_page.dart';
import 'package:masi_dam_2425/profile/widgets/avatar_summary.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: WelcomePage());

  @override
  Widget build(BuildContext context) {
    context.read<AvatarCubit>().loadAvatar();
    return MultiBlocProvider(
      providers: [
        BlocProvider<InventoryBloc>(
          create: (context) => InventoryBloc(
            api: context.read<UserApiServices>().inventoryApi,
          ),
        ),
        BlocProvider<PlantsBloc>(
          create: (context) => PlantsBloc(
            api: context.read<UserApiServices>().plantsApi,
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              key: const Key('homePage_logout_iconButton'),
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AppBloc>().add(const AppLogoutPressed());
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              AvatarSection(),
              InventorySection(),
              PlantsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class AvatarSection extends StatelessWidget {
  const AvatarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvatarCubit, AvatarState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        } else if (state.avatar != null) {
          return AvatarSummary(
            profile: state.avatar!,
            action: () => _goToProfilePage(context),
          );
        } else {
          return const Text('Failed to load profile.');
        }
      },
    );
  }

  _goToProfilePage(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<AvatarCubit>.value(
                value: context.read<AvatarCubit>(),
              ),
              BlocProvider<ProfileCubit>(
                create: (context) => ProfileCubit(
                  context.read<AvatarCubit>(),
                  context.read<AuthenticationRepository>(),
                ),
              ),
            ],
            child: ProfilePage(),
          ),
        ));
  }
}

class InventorySection extends StatelessWidget {
  const InventorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryBloc, InventoryState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShopPage()),
                  );
                },
                icon: const Icon(Icons.currency_exchange),
                label: Text('${state.inventory?.coins ?? 0} Coins'),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InventoryPage()),
                  );
                },
                icon: const Icon(Icons.backpack),
                label: const Text("Inventory"),
              ),
            ],
          );
        }
      },
    );
  }
}

class PlantsSection extends StatelessWidget {
  const PlantsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantsBloc, PlantsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlantsPage()),
                      );
                    },
                    child: const Text('Plants'),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CalendarPage()),
                      );
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
              ...state.plants.map((Plant plant) => PlantTile(plant)).toList(),
            ],
          );
        }
      },
    );
  }
}
