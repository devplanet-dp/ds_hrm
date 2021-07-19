import 'package:ds_hrm/model/employee.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/ui/widgets/tile_widget.dart';
import 'package:ds_hrm/viewmodel/dashboard/dash_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stacked/stacked.dart';

class DashView extends StatelessWidget {
  const DashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashViewModel>.reactive(
      onModelReady: (_){
        _.getAdminDivisions();
      },
      builder: (context, model, child) => BusyOverlay(
        show: model.busy,
        child: Scaffold(
          body: ListView(
            padding: fieldPaddingAll,
            children: [
              Row(
                children: [
                  Text(
                    'dashboard'.tr(),
                    style: kHeading3Style.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              verticalSpaceMedium,
              Row(
                children: [
                  Expanded(
                      child: TileWidget(
                    subHeader: 'total_emp'.tr(),
                    isDark: model.isDark(),
                    onTap: () {},
                    icon: Icons.supervised_user_circle_outlined,
                    primaryColor: CupertinoColors.systemIndigo,
                    header: _buildEmpCount(model.streamEmployees()),
                  )),
                  horizontalSpaceMedium,
                  Expanded(
                      child: TileWidget(
                    subHeader: 'total_dep'.tr(),
                    isDark: model.isDark(),
                    onTap: () {},
                    icon: Icons.home_work_outlined,
                    primaryColor: CupertinoColors.systemPurple,
                    header: Text(
                      '${model.adminDivision.length}',
                      style: kHeading1Style.copyWith(
                          fontWeight: FontWeight.bold, color: kAltWhite),
                    ),
                  )),
                ],
              ),
              verticalSpaceMedium,

            ],
          ),
        ),
      ),
      viewModelBuilder: () => DashViewModel(),
    );
  }

  Widget _buildEmpCount(Stream<List<Employee>> stream) =>
      StreamBuilder<List<Employee>>(
          stream: stream,
          builder: (_, snapshot) => Text(
                '${snapshot.data?.length??0}',
                style: kHeading1Style.copyWith(
                    fontWeight: FontWeight.bold, color: kAltWhite),
              ));
}

class _PercentIndicator extends StatelessWidget {
  final String headerTitle;
  final String centerTitle;
  final double percentage;
  final double radius;
  final Color color;

  const _PercentIndicator(
      {Key? key,
      required this.headerTitle,
      required this.centerTitle,
      required this.percentage,
      this.radius = 120,
      this.color = kcPrimaryColorLight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: 5.0,
      percent: percentage,
      center: Text(
        centerTitle,
        style: kCaptionStyle,
      ),
      progressColor: color,
    );
  }
}
