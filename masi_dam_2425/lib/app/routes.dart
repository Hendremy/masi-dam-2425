import 'package:flutter/widgets.dart';
import 'package:masi_dam_2425/app/bloc/app_bloc.dart';
import 'package:masi_dam_2425/home/view/welcome_page.dart';
import 'package:masi_dam_2425/login/view/login_page.dart';
import 'package:masi_dam_2425/plants/view/calendar_page.dart';
import 'package:masi_dam_2425/plants/view/plants_page.dart';

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
    case AppStatus.plants:
      return [PlantsPage.page()];
  }
}
