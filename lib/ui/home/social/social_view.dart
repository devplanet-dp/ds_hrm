import 'package:ds_hrm/ui/drawer/social/social_drawer_view.dart';
import 'package:ds_hrm/ui/views/social/add_memeber_view.dart';
import 'package:ds_hrm/ui/views/social/search_member_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../viewmodel/home/home_view_model.dart';
import '../../drawer/admin/drawer_view.dart';
import '../../views/signout/signout_view.dart';
import '../../widgets/busy_overlay.dart';

class SocialView extends StatelessWidget {
  const SocialView({Key? key}) : super(key: key);

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
                    child: SocialDrawerView(
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
        return SocialHomeView();
      case 1:
        return AddMemebrView();
      case 2:
        return SignOutView();
      default:
        return Container();
    }
  }
}
