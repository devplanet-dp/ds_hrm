import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/ui/widgets/tile_widget.dart';
import 'package:ds_hrm/utils/device_utils.dart';
import 'package:ds_hrm/viewmodel/dashboard/land_dash_view_model.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:stacked/stacked.dart';

class LandDashboardView extends StatelessWidget {
  const LandDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandDashViewModel>.reactive(
      builder: (context, model, child) => GestureDetector(
          onTap: () => DeviceUtils.hideKeyboard(context),
          child: BusyOverlay(
            show: model.busy,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    verticalSpaceMedium,
                    Row(
                      children: [
                        Text(
                          'dashboard'.tr(),
                          style: kHeading2Style.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                    verticalSpaceMedium,
                    Row(
                      children: [
                        Expanded(
                            child: TileWidget(
                          subHeader: 'leasing'.tr(),
                          isDark: model.isDark(),
                          onTap: () =>model.toLeasingView(),
                          icon: LineIcon.moneyCheck().icon!,
                          primaryColor: CupertinoColors.systemIndigo,
                          header: EmptyBox,
                        )),
                        horizontalSpaceMedium,
                        Expanded(
                            child: EmptyBox),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
      viewModelBuilder: () => LandDashViewModel(),
    );
  }
}
