import 'package:ds_hrm/ui/accounts/add_item_view.dart';
import 'package:ds_hrm/ui/drawer/account/account_drawer_view.dart';
import 'package:ds_hrm/ui/views/signout/signout_view.dart';
import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/viewmodel/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AccountHomeView extends StatelessWidget {
  const AccountHomeView({Key? key}) : super(key: key);

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
                    child: AccountDrawerView(
                      selectedIndex: model.setIndex,
                    )),
                Expanded(flex: 5, child: getViewForIndex(model.currentIndex))
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
        return Container();
      case 1:
        return Container();
      case 2:
        return const AddItemView();
      case 3:
        return SignOutView();
      default:
        return Container();
    }
  }
}
