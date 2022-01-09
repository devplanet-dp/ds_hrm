import 'package:ds_hrm/constants/route_name.dart';
import 'package:ds_hrm/model/employee.dart';
import 'package:ds_hrm/ui/employee/emp_view.dart';
import 'package:ds_hrm/ui/home/land_home_view.dart';
import 'package:ds_hrm/ui/views/welcome_view.dart';
import 'package:flutter/material.dart';

import 'home/home_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case WelcomeViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: WelcomeView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: HomeView(),
      );
    case LandHomeViewRoute:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: LandHomeView(),
      );
    case EmpViewRoute:
      final emp = settings.arguments as Employee;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: EmpView(emp: emp),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute(
    {required String routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
