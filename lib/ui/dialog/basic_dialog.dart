import 'package:age_calculator/age_calculator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ds_hrm/model/employee.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/ui/widgets/box_text.dart';
import 'package:ds_hrm/utils/app_utils.dart';
import 'package:ds_hrm/utils/timeago.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:stacked_services/stacked_services.dart';

enum DialogType { basic }

enum BasicDialogStatus { success, error, warning }

const Color kcRedColor = Color(0xfff44336);
const Color kcOrangeColor = Color(0xffff9800);

class BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const BasicDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: _BasicDialogContent(request: request, completer: completer));
  }
}

class _BasicDialogContent extends StatelessWidget {
  const _BasicDialogContent({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  final DialogRequest request;
  final Function(DialogResponse dialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    Employee emp = request.customData as Employee;
    String age = dateDifference(DateTime.now(), emp.dob!.toDate());
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenWidthPercentage(context, percentage: 0.04),
          ),
          padding: fieldPaddingAll,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kRadiusLarge),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalSpaceSmall,
              BoxText.headingOne(
                request.title ?? '',
                align: TextAlign.center,
              ),
              verticalSpaceSmall,
              BoxText.subheading(
                request.description ?? '',
                align: TextAlign.center,
              ),
              verticalSpaceSmall,
              SingleChildScrollView(
                child: Column(
                  children: [
                    verticalSpaceSmall,
                    SectionDivider(title: 'personal_info'),
                    verticalSpaceSmall,
                    FieldItem(
                        title: 'mobile.hint',
                        subtitle: emp.mobileNumber!,
                        leading: LineIcon.mobilePhone()),
                    verticalSpaceSmall,
                    FieldItem(
                        title: 'email.hint',
                        subtitle: emp.email!,
                        leading: LineIcon.male()),
                    verticalSpaceSmall,
                    FieldItem(
                        title: 'nic.hint',
                        subtitle: emp.nic!,
                        leading: LineIcon.addressCard()),
                    verticalSpaceSmall,
                    FieldItem(
                        title: 'address.hint',
                        subtitle: emp.address!,
                        leading: LineIcon.map()),
                    verticalSpaceSmall,
                    FieldItem(
                        title: 'gender.hint',
                        subtitle: emp.gender!.toShortString(),
                        leading: LineIcon.male()),
                    verticalSpaceSmall,
                    FieldItem(
                        title: 'age',
                        subtitle: _getAge(emp.dob!.toDate()),
                        leading: LineIcon.male()),
                    verticalSpaceSmall,
                    FieldItem(
                        title: 'dob.hint',
                        subtitle:
                            '${emp.dob!.toDate().year}/${emp.dob!.toDate().month}/${emp.dob!.toDate().day}',
                        leading: LineIcon.calendar()),
                    verticalSpaceSmall,
                    SectionDivider(title: 'job_info'),
                    FieldItem(
                        title: 'emp_code.hint',
                        subtitle: emp.empCode!,
                        leading: LineIcon.code()),
                    verticalSpaceSmall,
                    FieldItem(
                        title: 'join_date.hint',
                        subtitle:
                            '${emp.joinedDate!.toDate().year}/${emp.joinedDate!.toDate().month}/${emp.joinedDate!.toDate().day} ',
                        leading: LineIcon.calendar()),
                    verticalSpaceSmall,
                    FieldItem(
                        title: 'department.hint',
                        subtitle: emp.department!,
                        leading: LineIcon.warehouse()),
                    verticalSpaceSmall,
                    FieldItem(
                        title: 'head.hint',
                        subtitle: emp.head!,
                        leading: LineIcon.heading()),
                  ],
                ),
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (request.secondaryButtonTitle != null)
                    TextButton(
                      onPressed: () =>
                          completer(DialogResponse(confirmed: false)),
                      child: BoxText.body(
                        request.secondaryButtonTitle!,
                        color: Colors.black,
                      ),
                    ),
                  TextButton(
                    onPressed: () => completer(DialogResponse(confirmed: true)),
                    child: BoxText.body(
                      request.mainButtonTitle ?? '',
                      color: kcPrimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  String _getAge(DateTime dob) {
    final duration = AgeCalculator.age(dob);
    return '${duration.years} Years ${duration.months} Months ${duration.days} Days';
  }

  IconData _getStatusIcon(dynamic regionDialogStatus) {
    if (regionDialogStatus is BasicDialogStatus)
      switch (regionDialogStatus) {
        case BasicDialogStatus.error:
          return Icons.close;
        case BasicDialogStatus.warning:
          return Icons.warning_amber;
        default:
          return Icons.check;
      }
    else {
      return Icons.check;
    }
  }
}

class FieldItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget leading;
  final bool removePadding;
  final VoidCallback? onTap;

  const FieldItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leading,
    this.removePadding = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            onTap: onTap ?? () {},
            contentPadding: removePadding
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            dense: false,
            leading: CircleAvatar(
                radius: 24, backgroundColor: kAltWhite, child: leading),
            title: Text(
              title,
              maxLines: 3,
              textAlign: TextAlign.start,
              style: kBodyStyle.copyWith(
                  fontWeight: FontWeight.bold, color: kcPrimaryColor),
            ).tr(),
          ),
        ),
        Expanded(
          flex: 5,
          child: AutoSizeText(
            subtitle,
            maxLines: 4,
            style: kBodyStyle,
          ),
        )
      ],
    );
  }
}

class SectionDivider extends StatelessWidget {
  final String title;

  const SectionDivider({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: kHeading3Style.copyWith(fontWeight: FontWeight.bold),
        ).tr(),
        horizontalSpaceMedium,
        Expanded(child: Divider())
      ],
    );
  }
}
