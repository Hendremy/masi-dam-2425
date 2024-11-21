import 'package:flutter/widgets.dart';
import 'package:masi_dam_2425/app/app.dart';
import 'package:masi_dam_2425/home/home.dart';
import 'package:masi_dam_2425/login/login.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
