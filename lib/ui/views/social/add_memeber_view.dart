import 'package:ds_hrm/viewmodel/social/social_view_model.dart';
import 'package:ds_hrm/viewmodel/social/social_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/device_utils.dart';
import '../../shared/app_colors.dart';
import '../../shared/shared_styles.dart';
import '../../shared/ui_helpers.dart';
import '../../widgets/busy_overlay.dart';
import '../../widgets/text_field_widget.dart';
import '../staff/staff_view.dart';

class AddMemebrView extends StatelessWidget {
  const AddMemebrView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SocialViewModel>.reactive(
      onModelReady: (model){
        model.getDevDivisions();
        model.getDonationTypes();
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
              'add_member',
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
                      model.addMember();
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
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SocialViewModel(),
    );
  }

  Widget _buildPersonalInput(BuildContext context, SocialViewModel _) => Column(
    children: [
      Row(
        children: [
          Expanded(child: _buildNameInput(_)),
          horizontalSpaceSmall,
          Expanded(child: _buildNICInput(_)),
        ],
      ),
      verticalSpaceSmall,
      Row(
        children: [
          Expanded(child: _buildDOBInput(context, _)),
          horizontalSpaceSmall,
          Expanded(child: _buildMobileInput(_)),
        ],
      ),
      verticalSpaceSmall,
      _buildAddressInput(_),
      verticalSpaceSmall,
      Row(
        children: [
          Expanded(child: _buildDivisionInput(context, _)),
          horizontalSpaceSmall,
          Expanded(child: _buildDonationInput(context, _)),
        ],
      ),
    ],
  );

  //region personal info
  Widget _buildNameInput(SocialViewModel _) => AppTextField(
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

  Widget _buildMobileInput(SocialViewModel _) => AppTextField(
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
  Widget _buildNICInput(SocialViewModel _) => AppTextField(
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

  Widget _buildAddressInput(SocialViewModel _) => AppTextField(
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

  Future<Null> _selectDate(
      BuildContext context, SocialViewModel model) async {
    final DateTime? picked = await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1950, 1, 1),
        maxTime: DateTime(2030, 1, 1));

    if (picked != null) {
       model.setDOB(picked);
    }
  }

  Widget _buildDOBInput(BuildContext context, SocialViewModel model) => InkWell(
    onTap: () async {
      DeviceUtils.hideKeyboard(context);
      await _selectDate(context, model);
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

  Widget _buildDivisionInput(context, SocialViewModel _) {
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

  Future<void> _showDivisions(context, SocialViewModel _) async {
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
                    _.setDivision(_.devDivision[index]);
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

  Widget _buildDonationInput(context, SocialViewModel _) {
    return InkWell(
      onTap: () {
        DeviceUtils.hideKeyboard(context);
        _showDonationType(context, _);
      },
      child: AppTextField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'donation.empty'.tr();
          } else {
            return null;
          }
        },
        isEnabled: false,
        controller: _.donationTypeTEC,
        hintText: 'donation.hint'.tr(),
        isMoney: true,
        isDark: _.isDark(),
        fillColor: Colors.transparent,
        borderColor: kcPrimaryColor.withOpacity(0.4),
      ),
    );
  }

  Future<void> _showDonationType(context, SocialViewModel _) async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('donation.hint').tr(),
          message: Text('donation.title').tr(),
          actions: List.generate(
              _.devDonationType.length,
                  (index) => CupertinoActionSheetAction(
                  onPressed: () {
                    _.setDonation(_.devDonationType[index]);
                  },
                  child: Text(_.devDonationType[index].title??''))),
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
}
