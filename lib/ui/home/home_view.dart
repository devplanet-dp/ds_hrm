import 'package:animations/animations.dart';
import 'package:ds_hrm/model/user.dart';
import 'package:ds_hrm/ui/dashboard/dash_view.dart';
import 'package:ds_hrm/ui/drawer/drawer_view.dart';
import 'package:ds_hrm/ui/views/staff/staff_view.dart';
import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/viewmodel/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => BusyOverlay(
        show: model.isBusy,
        child: Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: DrawerView(
                      selectedIndex: model.setIndex,
                    )),
                Expanded(
                    flex: 5,
                    child: PageTransitionSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverse: model.reverse,
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return SharedAxisTransition(
                          child: child,
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                        );
                      },
                      child: getViewForIndex(
                          model.currentIndex, model.currentUser),
                    ))
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget getViewForIndex(int currentIndex, UserModel currentUser) {
    switch (currentIndex) {
      case 0:
        return DashView();
      case 1:
        return StaffView();
      case 2:
        return Container();
      case 3:
        return Container();
      case 4:
        return Container();
      default:
        return Container();
    }
  }
}
