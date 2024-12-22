import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/shop_api.dart';
import 'package:masi_dam_2425/app/bloc/app_bloc.dart';
import 'package:masi_dam_2425/home/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/inventory/cubit/inventory_cubit.dart';
import 'package:masi_dam_2425/profile/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/profile/view/profile_summary_widget.dart';
import 'package:masi_dam_2425/shop/shop_cubit.dart';
import 'package:masi_dam_2425/shop/views/shop_page.dart';

import '../../profile/view/profile_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: WelcomePage());

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(LoadProfile());
    context.read<InventoryCubit>().loadInventory();
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
          title: const Text('Dashboard'),
          elevation: 0,
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const AvatarSection(),
              const SizedBox(height: 16.0),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // Two cards per row
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    _buildFlatCard(
                      context,
                      icon: Icons.shop,
                      title: "Shop",
                      color: Colors.blueAccent,
                      onTap: () {
                        _goToShopPage(context);
                      },
                    ),
                    _buildFlatCard(
                      context,
                      icon: Icons.inventory,
                      title: "Inventory",
                      color: Colors.orangeAccent,
                      onTap: () {},
                    ),
                    _buildFlatCard(
                      context,
                      icon: Icons.eco,
                      title: "Plants",
                      color: Colors.greenAccent,
                      onTap: () {},
                    ),
                    _buildFlatCard(
                      context,
                      icon: Icons.calendar_today,
                      title: "Calendar",
                      color: Colors.pinkAccent,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2), // Light flat color background
          borderRadius: BorderRadius.circular(12), // Rounded edges
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: color),
            ),
          ],
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
}
