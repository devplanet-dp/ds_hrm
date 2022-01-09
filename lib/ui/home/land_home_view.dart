import 'package:ds_hrm/ui/dashboard/land_dash_view.dart';
import 'package:ds_hrm/ui/drawer/land_drawer_view.dart';
import 'package:ds_hrm/ui/views/signout/signout_view.dart';
import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/viewmodel/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LandHomeView extends StatelessWidget {
  const LandHomeView({Key? key}) : super(key: key);

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
                    child: LandDrawerView(
                      selectedIndex: model.setIndex,
                    )),
                Expanded(
                    flex: 5,
                    child: getViewForIndex(
                        model.currentIndex))
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget getViewForIndex(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return LandDashboardView();
      case 1:
        return SignOutView();
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
