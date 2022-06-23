import 'package:auto_size_text/auto_size_text.dart';
import 'package:ds_hrm/model/social_member.dart';
import 'package:ds_hrm/utils/app_utils.dart';
import 'package:ds_hrm/viewmodel/social/social_home_view_model.dart';
import 'package:ds_hrm/viewmodel/social/social_home_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:stacked/stacked.dart';

import '../../../model/employee.dart';
import '../../shared/app_colors.dart';
import '../../shared/shared_styles.dart';
import '../../shared/ui_helpers.dart';
import '../../widgets/app_stream_list.dart';
import '../../widgets/busy_overlay.dart';
import '../../widgets/text_field_widget.dart';

class SocialHomeView extends StatelessWidget {
  const SocialHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SocialHomeViewModel>.reactive(
      builder: (context, model, child) => BusyOverlay(
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
                    stream: model.streamMembers(),
                    itemBuilder: (index, emp) {
                      SocialMember u = emp as SocialMember;
                      return InkWell(
                        // onTappnTap: () => model.showStaffDetails(u),
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
                              _wTableContent(u.name),
                              _wTableContent(u.donationType?.title),
                              _wTableContent(u.nic),
                              _wTableContent(u.gnDivision?.title),
                              _wTableContent(u.mobile),
                              _wTableContent(
                                  '${u.dob!.toDate().year}-${u.dob!.toDate().month}-${u.dob!.toDate().day}'),
                            ])
                          ],
                        ),
                      );
                    },
                    emptyIcon: Icons.supervised_user_circle_outlined,
                    emptyText: 'No members found',
                    separator: EmptyBox,
                    isDark: model.isDark())
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SocialHomeViewModel(),
    );
  }
  Widget _wTableContent(String? value) => Padding(
    padding: fieldPaddingAll,
    child: Text(value??''),
  );


}

class _SearchBar extends ViewModelWidget<SocialHomeViewModel> {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, SocialHomeViewModel model) => SizedBox(
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

  Widget _buildSearchTypeButton(SocialHomeViewModel _) => Padding(
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
