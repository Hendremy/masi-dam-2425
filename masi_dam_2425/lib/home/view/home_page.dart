import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/shop_api.dart';
import 'package:masi_dam_2425/home/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/inventory/view/inventory_page.dart';
import 'package:masi_dam_2425/profile/view/profile_page.dart';
import 'package:masi_dam_2425/home/view/inventory_summary_widget.dart';
import 'package:masi_dam_2425/inventory/cubit/inventory_cubit.dart';
import 'package:masi_dam_2425/permission_service.dart';
import 'package:masi_dam_2425/profile/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/profile/view/profile_summary_widget.dart';
import 'package:masi_dam_2425/shop/shop_cubit.dart';
import 'package:masi_dam_2425/shop/views/shop_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(LoadProfile());
    context.read<InventoryCubit>().loadInventory();
    PermissionService.requestNotificationPermission();
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlantsBloc>(
          create: (context) => PlantsBloc(
            api: context.read<UserApiServices>().plantsApi,
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0), // Optional padding for better alignment
            child: Image.asset('assets/greenmon-logo.png'), // Replace with your asset path
          ),        title: const Text('Dashboard'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const AvatarSection(),
              const SizedBox(height: 16.0),
              InventorySummaryWidget(
                onShopTap: () => _goToShopPage(context),
                onInventoryTap: () => _goToInventoryPage(context),
              ),

            ],
          ),
        ),
      ),
    );
  }

  _goToShopPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<ProfileBloc>.value(
              value: context.read<ProfileBloc>(),
            ),
            BlocProvider<InventoryCubit>.value(
              value: context.read<InventoryCubit>(),
            ),
            BlocProvider<ShopCubit>(
              create: (context) => ShopCubit(
                  context.read<UserApiServices>().shopApi as ShopFirestoreApi
              ),
            )
          ],
          child: ShopPage(),
        ),
      ),
    );
  }

  _goToInventoryPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<InventoryCubit>.value(
              value: context.read<InventoryCubit>(),
            ),
          ],
          child: InventoryPage(),
        ),
      ),
    );
  }

}

class AvatarSection extends StatelessWidget {
  const AvatarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const CircularProgressIndicator();
        }

        if (state is ProfileLoaded) {
          return ProfileSummaryWidget(
            profile: state.profile,
            action: () => {
              _goToProfilePage(context),
            }
          );
        }

        return const Text('Failed to load profile.');
      },
    );
  }

  _goToProfilePage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<PlantsBloc, PlantsState>(
  //     builder: (context, state) {
  //       if (state.isLoading) {
  //         return const CircularProgressIndicator();
  //       } else {
  //         return Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (newContext) => PlantsPage(
  //                             plantsBloc: context.read<PlantsBloc>()
  //                           )),
  //                     );
  //                   },
  //                   child: const Text('Plants'),
  //                 ),
  //                 IconButton(
  //                   onPressed: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => const CalendarPage()),
  //                     );
  //                   },
  //                   icon: const Icon(Icons.calendar_month),
  //                 ),
  //               ],
  //             ),
  //             ...state.plants.map((Plant plant) => NewPlantTile(plant: plant,)).toList(),
  //           ],
  //         );
  //       }
  //     },
  //   );
  // }
}
