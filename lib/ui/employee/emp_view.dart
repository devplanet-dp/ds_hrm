import 'package:age_calculator/age_calculator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ds_hrm/model/education.dart';
import 'package:ds_hrm/model/employee.dart';
import 'package:ds_hrm/ui/dialog/basic_dialog.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class EmpView extends StatelessWidget {
  final Employee emp;

  const EmpView({Key? key, required this.emp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${emp.firstName} ${emp.lastName}',
          style: kHeading3Style.copyWith(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: true,
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenWidthPercentage(context, percentage: 0.04),
        ),
        padding: fieldPaddingAll,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kRadiusLarge),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpaceMedium,
              SectionDivider(title: 'personal_info'),
              verticalSpaceMedium,
              FieldItem(
                  title: 'mobile.hint',
                  subtitle: emp.mobileNumber!,
                  leading: LineIcon.mobilePhone()),
              verticalSpaceSmall,
              FieldItem(
                  title: 'email.hint',
                  subtitle: emp.email!,
                  leading: Icon(Icons.email_outlined)),
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
                  leading: Icon(Icons.wc_outlined)),
              verticalSpaceSmall,
              FieldItem(
                  title: 'age',
                  subtitle: _getAge(emp.dob!.toDate()),
                  leading: Icon(Icons.phone)),
              verticalSpaceSmall,
              FieldItem(
                  title: 'dob.hint',
                  subtitle:
                      '${emp.dob!.toDate().year}/${emp.dob!.toDate().month}/${emp.dob!.toDate().day}',
                  leading: LineIcon.calendar()),
              verticalSpaceMedium,
              SectionDivider(title: 'bio'),
              verticalSpaceMedium,
              FieldItem(
                  title: 'marital.hint',
                  subtitle: emp.maritalStatus!
                      ? 'marital.true'.tr()
                      : 'marital.false'.tr(),
                  leading: Icon(Icons.family_restroom)),
              verticalSpaceSmall,
              FieldItem(
                  title: 'nationality.hint',
                  subtitle: emp.nationality!.toShortString(),
                  leading: Icon(Icons.people_alt_outlined)),
              verticalSpaceSmall,
              FieldItem(
                title: 'religion.hint',
                subtitle: emp.religion!.toShortString(),
                leading: Icon(Icons.assignment_ind_outlined),
              ),
              verticalSpaceSmall,
              verticalSpaceMedium,
              SectionDivider(title: 'job_info'),
              verticalSpaceMedium,
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
                  title: 'designation.hint',
                  subtitle: emp.designation!,
                  leading: Icon(Icons.work_outline)),
              verticalSpaceSmall,
              FieldItem(
                title: 'work_location.hint',
                subtitle: emp.religion!.toShortString(),
                leading: Icon(Icons.home_work),
              ),
              verticalSpaceSmall,
              FieldItem(
                  title: 'head.hint',
                  subtitle: emp.head!,
                  leading: LineIcon.heading()),
              verticalSpaceMedium,
              SectionDivider(title: 'education_qual'),
              verticalSpaceMedium,
              _buildAddedEducation(emp.education),
              verticalSpaceMedium,
              SectionDivider(title: 'emerge_contact'),
              verticalSpaceMedium,
              FieldItem(
                  title: 'emerge_name.hint',
                  subtitle: emp.emergeContactName!,
                  leading: Icon(Icons.contact_mail_outlined)),
              verticalSpaceSmall,
              FieldItem(
                  title: 'emerge_mobile.hint',
                  subtitle: emp.emergeMobileNumber!,
                  leading: Icon(Icons.phone)),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
    );
  }

  String _getAge(DateTime dob) {
    final duration = AgeCalculator.age(dob);
    return '${duration.years} Years ${duration.months} Months ${duration.days} Days';
  }

  Widget _buildAddedEducation(List<Education> _) => _.isEmpty
      ? Text(
          'empty_education'.tr(),
          style: kBodyStyle,
        )
      : ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _.length,
          itemBuilder: (__, index) {
            Education e = _[index];
            return ListTile(
              shape: RoundedRectangleBorder(borderRadius: kBorderSmall),
              isThreeLine: true,
              leading: CircleAvatar(
                backgroundColor: kcPrimaryColorLight,
                child: Text(
                  e.year,
                  style: kCaptionStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              title: AutoSizeText(
                e.name,
                maxLines: 1,
              ),
              subtitle: AutoSizeText(
                e.institution,
                maxLines: 1,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              verticalSpaceSmall,
        );
}
