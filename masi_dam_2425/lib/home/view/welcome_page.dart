import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/avatar_api.dart';
import 'package:masi_dam_2425/api/shop_api.dart';
import 'package:masi_dam_2425/app/bloc/app_bloc.dart';
import 'package:masi_dam_2425/home/bloc/inventory_bloc.dart';
import 'package:masi_dam_2425/home/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/profile/cubit/avatar_cubit.dart';
import 'package:masi_dam_2425/profile/cubit/profile_cubit.dart';
import 'package:masi_dam_2425/profile/view/profile_page.dart';
import 'package:masi_dam_2425/profile/widgets/avatar_summary.dart';
import 'package:masi_dam_2425/shop/shop_cubit.dart';
import 'package:masi_dam_2425/shop/shop_page.dart';

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
            BlocProvider<AvatarCubit>.value(
              value: context.read<AvatarCubit>(),
            ),
            BlocProvider<ShopCubit>(
              create: (context) => ShopCubit(
                context.read<UserApiServices>().shopApi as ShopFirestoreApi,
              )..loadShop(),
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
    return BlocBuilder<AvatarCubit, AvatarState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        } else if (state.avatar != null) {
          return AvatarSummary(
            profile: state.avatar!,
            action: () =>
                _goToProfilePage(context, context.read<AvatarCubit>()),
          );
        } else {
          return const Text('Failed to load profile.');
        }
      },
    );
  }

  _goToProfilePage(context, AvatarCubit avatarCubit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AvatarCubit>.value(
              value: avatarCubit,
            ),
            BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(
                avatarCubit,
                context.read<AuthenticationRepository>(),
              ),
            ),
          ],
          child: ProfilePage(),
        ),
      ),
    );
  }
}
