import 'package:auto_size_text/auto_size_text.dart';
import 'package:ds_hrm/model/education.dart';
import 'package:ds_hrm/model/employee.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/ui/widgets/text_field_widget.dart';
import 'package:ds_hrm/utils/app_utils.dart';
import 'package:ds_hrm/utils/device_utils.dart';
import 'package:ds_hrm/viewmodel/staff/staff_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:stacked/stacked.dart';

class StaffView extends StatelessWidget {
  const StaffView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StaffViewModel>.reactive(
      onModelReady: (model) {
        model.getDevDivisions();
        model.getAdminDivisions();
      },
      builder: (context, model, child) => BusyOverlay(
        show: model.busy,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: Icon(
              Icons.supervised_user_circle_outlined,
              color: kAltBg,
            ),
            title: Text(
              'add_staff',
              style: kHeading3Style.copyWith(
                  fontWeight: FontWeight.w800, color: kAltBg),
            ).tr(),
            centerTitle: false,
            elevation: 1,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActionChip(
                  label: Text(
                    'submit'.tr().toUpperCase(),
                    style: kBodyStyle.copyWith(
                        color: kAltWhite, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (model.formKey.currentState!.validate()) {
                      model.addStaff();
                    }
                  },
                  backgroundColor: kcPrimaryColorLight,
                ),
              )
            ],
          ),
          body: Form(
            key: model.formKey,
            child: ListView(
              padding: fieldPaddingAll,
              children: [
                FormSection(
                    index: 1,
                    sectionTitle: 'personal_info'.tr(),
                    input: _buildPersonalInput(context, model)),
                verticalSpaceSmall,
                FormSection(
                    index: 2,
                    sectionTitle: 'bio'.tr(),
                    input: _buildBio(model)),
                verticalSpaceSmall,
                FormSection(
                    index: 3,
                    sectionTitle: 'emerge_contact'.tr(),
                    input: _buildEmergencyInput(context, model)),
                verticalSpaceSmall,
                FormSection(
                    index: 4,
                    sectionTitle: 'job_info'.tr(),
                    input: _buildJobInput(context, model)),
                verticalSpaceSmall,
                FormSection(
                    index: 5,
                    sectionTitle: 'education_qual'.tr(),
                    input: _EducationInput(
                      model: model,
                    )),
                verticalSpaceSmall,
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => StaffViewModel(),
    );
  }

  //region emergency

  Widget _buildEmergencyInput(BuildContext context, StaffViewModel _) => Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildEmergeNameInput(_)),
              horizontalSpaceSmall,
              Expanded(child: _buildEmergeMobileInput(_)),
            ],
          ),
        ],
      );

  Widget _buildEmergeNameInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.emergeNameTEC,
        hintText: 'emerge_name.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'emerge_name.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildEmergeMobileInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        isMoney: true,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        maxLength: 10,
        controller: _.emergeMobileTEC,
        hintText: 'emerge_mobile.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'emerge_mobile.empty'.tr();
          } else {
            return null;
          }
        },
      );

  //endregion

  //region personal info
  Widget _buildFirstNameInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.firstNameTEC,
        hintText: 'emp_name_first.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'emp_name_first.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildEmailInput(StaffViewModel _) => AppTextField(
        isEmail: true,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.emailTEC,
        hintText: 'email.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'email.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildMobileInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        isMoney: true,
        maxLength: 10,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.mobileTEC,
        hintText: 'mobile.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'mobile.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildLastNameInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.lastNameTEC,
        hintText: 'emp_name_last.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'emp_name_last.hint'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildNICInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: true,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.nicTEC,
        hintText: 'nic.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'nic.hint'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildAddressInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: true,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        minLine: 3,
        maxLength: 500,
        isDark: _.isDark(),
        controller: _.addressTEC,
        hintText: 'address.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'address.hint'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildPersonalInput(BuildContext context, StaffViewModel _) => Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildFirstNameInput(_)),
              horizontalSpaceSmall,
              Expanded(child: _buildLastNameInput(_)),
            ],
          ),
          verticalSpaceSmall,
          Row(
            children: [
              Expanded(child: _buildDOBInput(context, _)),
              horizontalSpaceSmall,
              Expanded(child: _buildNICInput(_)),
            ],
          ),
          verticalSpaceSmall,
          Row(
            children: [
              Expanded(child: _buildMobileInput(_)),
              horizontalSpaceSmall,
              Expanded(child: _buildEmailInput(_)),
            ],
          ),
          verticalSpaceSmall,
          _buildAddressInput(_),
          verticalSpaceSmall,
          Row(
            children: [
              Expanded(child: _buildDivisionInput(context, _)),
              horizontalSpaceSmall,
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      );

  Future<Null> _selectDate(
      BuildContext context, StaffViewModel model, bool isDOB) async {
    final DateTime? picked = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1950, 1, 1),
        maxTime: DateTime(2030, 1, 1));

    if (picked != null) {
      isDOB ? model.setDOB(picked) : model.setJoinedDate(picked);
    }
  }

  Widget _buildDOBInput(BuildContext context, StaffViewModel model) => InkWell(
        onTap: () async {
          DeviceUtils.hideKeyboard(context);
          await _selectDate(context, model, true);
        },
        child: AppTextField(
          isEnabled: false,
          controller: model.dobTEC,
          maxLength: 3,
          borderColor: kcPrimaryColor.withOpacity(0.4),
          prefixIcon: Icon(Icons.calendar_today_rounded),
          isDark: model.isDark(),
          fillColor: Colors.transparent,
          hintText: 'dob.hint'.tr(),
          validator: (value) {
            if (value!.isEmpty) {
              return 'dob.empty'.tr();
            } else {
              return null;
            }
          },
        ),
      );

  Widget _buildDivisionInput(context, StaffViewModel _) {
    return InkWell(
      onTap: () {
        DeviceUtils.hideKeyboard(context);
        _showDivisions(context, _);
      },
      child: AppTextField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'division.empty'.tr();
          } else {
            return null;
          }
        },
        isEnabled: false,
        controller: _.divisionTEC,
        hintText: 'division.hint'.tr(),
        isMoney: true,
        isDark: _.isDark(),
        fillColor: Colors.transparent,
        borderColor: kcPrimaryColor.withOpacity(0.4),
      ),
    );
  }

  Future<void> _showDivisions(context, StaffViewModel _) async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('division.hint').tr(),
          message: Text('division.title').tr(),
          actions: List.generate(
              _.devDivision.length,
              (index) => CupertinoActionSheetAction(
                  onPressed: () {
                    _.setDivision(_.devDivision[index].title);
                  },
                  child: Text(_.devDivision[index].title))),
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

//endregion

  //region bio

  Widget _buildBio(StaffViewModel _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGender(_),
          Divider(),
          _buildNationality(_),
          Divider(),
          _buildReligion(_),
          Divider(),
          _buildMaritalStatus(_)
        ],
      );

  Widget _buildGender(StaffViewModel _) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style: kBodyStyle,
          ),
          verticalSpaceSmall,
          Wrap(
            spacing: 4,
            children: List.generate(Gender.values.length, (index) {
              Gender g = Gender.values[index];
              return ChoiceChip(
                  onSelected: (selected) {
                    selected ? _.setGender(g) : () {};
                  },
                  label: Text(g.toShortString()),
                  selected: _.isGenderSelected(g));
            }),
          )
        ],
      );

  Widget _buildNationality(StaffViewModel _) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nationality',
            style: kBodyStyle,
          ),
          verticalSpaceSmall,
          Wrap(
            spacing: 4,
            children: List.generate(Nationality.values.length, (index) {
              Nationality g = Nationality.values[index];
              return ChoiceChip(
                  onSelected: (selected) {
                    selected ? _.setNationality(g) : () {};
                  },
                  label: Text(g.toShortString()),
                  selected: _.isNationalitySelected(g));
            }),
          )
        ],
      );

  Widget _buildReligion(StaffViewModel _) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Religion',
            style: kBodyStyle,
          ),
          verticalSpaceSmall,
          Wrap(
            spacing: 4,
            children: List.generate(Religion.values.length, (index) {
              Religion g = Religion.values[index];
              return ChoiceChip(
                  onSelected: (selected) {
                    selected ? _.setReligion(g) : () {};
                  },
                  label: Text(g.toShortString()),
                  selected: _.isReligionSelected(g));
            }),
          )
        ],
      );

  Widget _buildMaritalStatus(StaffViewModel _) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Married',
            style: kBodyStyle,
          ),
          verticalSpaceSmall,
          Checkbox(value: _.isMarried, onChanged: (value) => _.toggleMarried())
        ],
      );

//endregion

  //region job

  Widget _buildJobInput(BuildContext context, StaffViewModel _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _buildEmpCodeInput(_)),
              horizontalSpaceSmall,
              Expanded(child: _buildDesignationInput(_)),
            ],
          ),
          verticalSpaceSmall,
          Row(
            children: [
              Expanded(child: _buildAdminDivisionInput(context, _)),
              horizontalSpaceSmall,
              Expanded(child: _buildDptHeadInput(_)),
            ],
          ),
          verticalSpaceSmall,
          Row(
            children: [
              Expanded(child: _buildJoinedInput(context, _)),
              horizontalSpaceSmall,
              Expanded(child: _buildExtensionInput(_)),
            ],
          ),
          verticalSpaceSmall,
          _buildWorkLocation(_),
          verticalSpaceSmall,
          _buildRemarksInput(_)
        ],
      );

  Widget _buildEmpCodeInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.empCodeTEC,
        hintText: 'emp_code.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'emp_code.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildExtensionInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.extensionTEC,
        hintText: 'extension.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'extension.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildRemarksInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        minLine: 3,
        controller: _.remarkTEC,
        hintText: 'remark.hint'.tr(),
      );

  Widget _buildDesignationInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.designationTEC,
        hintText: 'designation.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'designation.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildDptHeadInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.dpHeadTEC,
        hintText: 'head.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'head.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildAdminDivisionInput(context, StaffViewModel _) {
    return InkWell(
      onTap: () {
        DeviceUtils.hideKeyboard(context);
        _showAdminDivisions(context, _);
      },
      child: AppTextField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'department.empty'.tr();
          } else {
            return null;
          }
        },
        isEnabled: false,
        controller: _.adminDivisionTEC,
        hintText: 'department.hint'.tr(),
        isMoney: true,
        isDark: _.isDark(),
        fillColor: Colors.transparent,
        borderColor: kcPrimaryColor.withOpacity(0.4),
      ),
    );
  }

  Future<void> _showAdminDivisions(context, StaffViewModel _) async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('department.hint').tr(),
          message: Text('department.title').tr(),
          actions: List.generate(
              _.adminDivision.length,
              (index) => CupertinoActionSheetAction(
                  onPressed: () {
                    _.setAdminDivision(_.adminDivision[index].title);
                  },
                  child: Text(_.adminDivision[index].title))),
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  Widget _buildWorkLocation(StaffViewModel _) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Work location',
            style: kBodyStyle,
          ),
          verticalSpaceSmall,
          Wrap(
            spacing: 4,
            children: List.generate(WorkLocation.values.length, (index) {
              WorkLocation g = WorkLocation.values[index];
              return ChoiceChip(
                  onSelected: (selected) {
                    selected ? _.setWorkLocation(g) : () {};
                  },
                  label: Text(g.toShortString()),
                  selected: _.isWorkLocationSelected(g));
            }),
          )
        ],
      );

  Widget _buildJoinedInput(BuildContext context, StaffViewModel model) =>
      InkWell(
        onTap: () async {
          DeviceUtils.hideKeyboard(context);
          await _selectDate(context, model, false);
        },
        child: AppTextField(
          isEnabled: false,
          controller: model.joinedDateTEC,
          maxLength: 3,
          borderColor: kcPrimaryColor.withOpacity(0.4),
          prefixIcon: Icon(Icons.calendar_today_rounded),
          isDark: model.isDark(),
          fillColor: Colors.transparent,
          hintText: 'join_date.hint'.tr(),
          validator: (value) {
            if (value!.isEmpty) {
              return 'join_date.empty'.tr();
            } else {
              return null;
            }
          },
        ),
      );

//endregion

}

class FormSection extends StatelessWidget {
  final int index;
  final String sectionTitle;
  final Widget input;

  const FormSection(
      {Key? key,
      required this.index,
      required this.sectionTitle,
      required this.input})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: kBorderSmall,
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.4))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          index.toString(),
                          style: kHeading2Style.copyWith(
                              color: kAltBg.withOpacity(0.4),
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          sectionTitle.toUpperCase(),
                          style: kBodyStyle.copyWith(
                              color: kAltBg, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Expanded(flex: 5, child: input)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EducationInput extends StatelessWidget {
  final StaffViewModel model;

  _EducationInput({Key? key, required this.model}) : super(key: key);

  //keys :-----------------------------------------------------------
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _buildCourseNameInput(model)),
              horizontalSpaceSmall,
              Expanded(child: _buildInsInput(model)),
            ],
          ),
          verticalSpaceSmall,
          Row(
            children: [
              Expanded(child: _buildYearInput(model)),
              horizontalSpaceSmall,
              Expanded(child: _buildCourseType(model)),
            ],
          ),
          verticalSpaceSmall,
          _buildDescInput(model),
          verticalSpaceMedium,
          ActionChip(
              backgroundColor: kcPrimaryColorDark,
              label: Text(
                'ADD',
                style: kBodyStyle.copyWith(
                    color: kAltWhite, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  model.addEducation();
                }
              }),
          verticalSpaceMedium,
          _buildAddedEducation(model),
          verticalSpaceMedium,
        ],
      ),
    );
  }

  Widget _buildAddedEducation(StaffViewModel _) => ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _.education.length,
        itemBuilder: (__, index) {
          Education e = _.education[index];
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
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => _.removeEducation(e.id),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            verticalSpaceSmall,
      );

  //region education
  Widget _buildCourseNameInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.nameTEC,
        hintText: 'course_name.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'course_name.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildInsInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.institutionTEC,
        hintText: 'institution.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'institution.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildYearInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        maxLength: 4,
        controller: _.yearTEC,
        hintText: 'year.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'year.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildDescInput(StaffViewModel _) => AppTextField(
        isEmail: false,
        isCapitalize: false,
        borderColor: kcPrimaryColor.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: _.isDark(),
        controller: _.descTEC,
        hintText: 'desc.hint'.tr(),
      );

  Widget _buildCourseType(StaffViewModel _) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Course Type',
            style: kBodyStyle,
          ),
          verticalSpaceSmall,
          Wrap(
            spacing: 4,
            children: List.generate(CourseType.values.length, (index) {
              CourseType g = CourseType.values[index];
              return ChoiceChip(
                  onSelected: (selected) {
                    selected ? _.setCourseType(g) : () {};
                  },
                  label: Text(g.toShortString()),
                  selected: _.isCourseTypeSelected(g));
            }),
          )
        ],
      );

//endregion
}

