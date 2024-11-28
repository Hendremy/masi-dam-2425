import 'package:flutter/widgets.dart';
import 'package:masi_dam_2425/app/app.dart';
import 'package:masi_dam_2425/home/view/welcome_page.dart';
import 'package:masi_dam_2425/inventory/view/inventory_page.dart';
import 'package:masi_dam_2425/inventory/view/shop_page.dart';
import 'package:masi_dam_2425/login/login.dart';
import 'package:masi_dam_2425/plants/view/calendar_page.dart';
import 'package:masi_dam_2425/plants/view/plants_page.dart';
import 'package:masi_dam_2425/profile/view/profile_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [WelcomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.calendar:
      return [CalendarPage.page()];
    case AppStatus.profile:
      return [ProfilePage.page()];
    case AppStatus.plants:
      return [PlantsPage.page()];
    case AppStatus.inventory:
      return [InventoryPage.page()];
    case AppStatus.shop:
      return [ShopPage.page()];
  }
}
