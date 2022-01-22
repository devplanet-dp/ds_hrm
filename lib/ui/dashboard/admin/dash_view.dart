import 'package:auto_size_text/auto_size_text.dart';
import 'package:ds_hrm/model/employee.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/ui/widgets/app_stream_list.dart';
import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/ui/widgets/creation_aware_list.dart';
import 'package:ds_hrm/ui/widgets/text_field_widget.dart';
import 'package:ds_hrm/ui/widgets/tile_widget.dart';
import 'package:ds_hrm/utils/app_utils.dart';
import 'package:ds_hrm/utils/device_utils.dart';
import 'package:ds_hrm/viewmodel/dashboard/dash_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stacked/stacked.dart';

class DashView extends StatelessWidget {
  const DashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashViewModel>.reactive(
      onModelReady: (_) {
        _.getAdminDivisions();
      },
      builder: (context, model, child) => GestureDetector(
        onTap: () => DeviceUtils.hideKeyboard(context),
        child: BusyOverlay(
          show: model.busy,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
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
                  Text(
                    'emp'.tr(),
                    style: kHeading3Style.copyWith(fontWeight: FontWeight.bold),
                  ),
                  verticalSpaceMedium,
                  _SearchBar(),
                  verticalSpaceMedium,
                  _TableHeaders(),
                  verticalSpaceSmall,
                  AppStreamList(
                      stream: model.streamEmployees(),
                      itemBuilder: (index, emp) {
                        Employee u = emp as Employee;
                        return InkWell(
                          onTap: () => model.showStaffDetails(u),
                          child: Table(
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1),
                              4: FlexColumnWidth(2),
                              5: FlexColumnWidth(1),
                            },
                            children: [
                              TableRow(children: [
                                _wTableContent('${u.firstName} ${u.lastName}'),
                                _wTableContent(u.department!),
                                _wTableContent(u.division!),
                                _wTableContent(u.mobileNumber!),
                                _wTableContent(u.nic!),
                                _wTableContent(
                                    '${u.joinedDate!.toDate().year}-${u.joinedDate!.toDate().month}-${u.joinedDate!.toDate().day}'),
                              ])
                            ],
                          ),
                        );
                      },
                      emptyIcon: Icons.supervised_user_circle_outlined,
                      emptyText: 'No employees found',
                      separator: EmptyBox,
                      isDark: model.isDark())
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => DashViewModel(),
    );
  }

  Widget _wTableContent(String value) => Padding(
        padding: fieldPaddingAll,
        child: Text(value),
      );

  Widget _buildEmpCount(Stream<List<Employee>> stream) =>
      StreamBuilder<List<Employee>>(
          stream: stream,
          builder: (_, snapshot) => Text(
                '${snapshot.data?.length ?? 0}',
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

class _SearchBar extends ViewModelWidget<DashViewModel> {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DashViewModel model) => SizedBox(
        width: context.screenWidth(percent: 0.5),
        child: Row(
          children: [
            // _buildSearchTypeButton(model),
            // horizontalSpaceSmall,
            Expanded(
              flex: 5,
              child: AppTextField(
                isTextArea: false,
                controller: model.searchTEC,
                hintText: 'search'.tr(),
                borderColor: kAltWhite,
                fillColor: kAltWhite,
                onChanged: model.onValueChanged,
                prefixIcon: _buildSearchTypeButton(model),
              ),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.text_aligncenter),
                ))
          ],
        ),
      );

  Widget _buildSearchTypeButton(DashViewModel _) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LineIcon.search(),
        horizontalSpaceSmall,
        DropdownButton<SearchType>(
              value: _.selectedSearchType,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              isDense: true,
              underline: EmptyBox,
              onChanged: (SearchType? type) {
                _.onSearchTypeSelected(type!);
              },
              items: SearchType.values
                  .map<DropdownMenuItem<SearchType>>((SearchType value) {
                return DropdownMenuItem<SearchType>(
                  value: value,
                  child: Text(value.toShortString().toUpperCase(),style: kCaptionStyle,),
                );
              }).toList(),
            ),
      ],
    ),
  );
}

class _TableHeaders extends StatelessWidget {
  const _TableHeaders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(2),
        5: FlexColumnWidth(1),
      },
      children: [
        TableRow(children: [
          _wHeaderText('name'.tr()),
          _wHeaderText('department.hint'.tr()),
          _wHeaderText('division.hint'.tr()),
          _wHeaderText('mobile.title'.tr()),
          _wHeaderText('nic.hint'.tr()),
          _wHeaderText('join_date.hint'.tr()),
        ])
      ],
    );
  }

  Widget _wHeaderText(String title) => Padding(
        padding: fieldPaddingAll * 1.2,
        child: AutoSizeText(
          title,
          style: kBodyStyle.copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      );
}

class _EmployeeList extends StatelessWidget {
  const _EmployeeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashViewModel>.reactive(
      onModelReady: (_) {
        // _.listenToEmp();
      },
      disposeViewModel: false,
      builder: (context, model, child) => ListView.separated(
          separatorBuilder: (_, index) => Divider(),
          shrinkWrap: true,
          itemCount: model.employees.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            Employee u = model.employees[index];
            return CreationAwareListItem(
              itemCreated: () {
                if (index % 20 == 0) model.requestMoreData();
              },
              child: ListTile(
                isThreeLine: true,
                leading: CircleAvatar(
                  backgroundColor: kcPrimaryColorLight,
                  child: Text(u.firstName![0].toUpperCase()),
                ),
                title: AutoSizeText(
                  '${u.firstName} ${u.lastName}',
                  maxLines: 1,
                ),
                subtitle: AutoSizeText(
                  '${u.department}',
                  maxLines: 3,
                ),
              ),
            );
          }),
      viewModelBuilder: () => DashViewModel(),
    );
  }
}
