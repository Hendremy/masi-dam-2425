import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/shop_api.dart';
import 'package:masi_dam_2425/home/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/inventory/view/inventory_page.dart';
import 'package:masi_dam_2425/network/bloc/network_bloc.dart';
import 'package:masi_dam_2425/network/no_network_dialog.dart';
import 'package:masi_dam_2425/plants/view/plants_page.dart';
import 'package:masi_dam_2425/profile/view/profile_page.dart';
import 'package:masi_dam_2425/inventory/cubit/inventory_cubit.dart';
import 'package:masi_dam_2425/permission_service.dart';
import 'package:masi_dam_2425/profile/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/shop/shop_cubit.dart';
import 'package:masi_dam_2425/shop/views/shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(LoadProfile());
    context.read<InventoryCubit>().loadInventory();
    PermissionService.requestNotificationPermission();

    return BlocListener<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state is NetworkFailure) {
          Network.showNoNetworkDialog(context);
        } else if (state is NetworkSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Connected to the internet'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: _buildScaffold(context),
    );
  }

  _buildScaffold(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Padding(
      //     padding: const EdgeInsets.all(8.0), // Optional padding for better alignment
      //     child: Image.asset('assets/greenmon-logo.png'), // Replace with your asset path
      //   ),        title: const Text('Dashboard'),
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.grass),
            label: 'Greenmons',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.inventory),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: <Widget>[
        _homePage(context),
        _shopPage(context),
        _inventoryPage(context),
        _profilePage(context),
      ][_selectedIndex],
    );
  }

  _homePage(BuildContext context) {
    return BlocProvider<PlantsBloc>(
      create: (context) => PlantsBloc(
        api: context.read<UserApiServices>().plantsApi,
      ),
      child: PlantsPage(),
    );
  }

  _shopPage(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>.value(
          value: context.read<ProfileBloc>(),
        ),
        BlocProvider<InventoryCubit>.value(
          value: context.read<InventoryCubit>(),
        ),
        BlocProvider<ShopCubit>(
          create: (context) => ShopCubit(
              context.read<UserApiServices>().shopApi as ShopFirestoreApi),
        )
      ],
      child: ShopPage(),
    );
  }

  _inventoryPage(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InventoryCubit>.value(
          value: context.read<InventoryCubit>(),
        ),
      ],
      child: InventoryPage(),
    );
  }

  _profilePage(BuildContext context) {
    return ProfilePage();
  }
}

class AvatarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoading) {
        return const CircularProgressIndicator();
      }
      if (state is ProfileLoaded) {
        return Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Text(state.profile.name),
            ],
          ),
        );
      }
      return const Text('Failed to load profile.');
    });
  }
}
// class AvatarSection extends StatelessWidget {
//   const AvatarSection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileBloc, ProfileState>(
//       builder: (context, state) {
//         if (state is ProfileLoading) {
//           return const CircularProgressIndicator();
//         }

//         if (state is ProfileLoaded) {
//           return ProfileSummaryWidget(
//             profile: state.profile,
//             action: () => {
//               _goToProfilePage(context),
//             }
//           );
//         }

//         return const Text('Failed to load profile.');
//       },
//     );
//   }

//   _goToProfilePage(context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ProfilePage(),
//       ),
//     );
//   }
// }
