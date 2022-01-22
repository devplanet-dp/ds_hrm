import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/ui/views/staff/staff_view.dart';
import 'package:ds_hrm/ui/widgets/busy_button.dart';
import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/ui/widgets/text_field_widget.dart';
import 'package:ds_hrm/utils/device_utils.dart';
import 'package:ds_hrm/viewmodel/lease/lease_view_model.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

class TaxView extends StatelessWidget {
  const TaxView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaxViewModel>.reactive(
      builder: (context, model, child) => BusyOverlay(
        show: model.busy,
        child: ResponsiveBuilder(builder: (context, size) {
          return SafeArea(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: true,
                      iconTheme: IconThemeData(color: kAltBg),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      // leading: IconButton(
                      //   color: kAltBg,
                      //   icon: Icon(LineIcons.backward),
                      //   onPressed: () => model.goBack(),
                      // ),
                      title: Text(
                        'lease_cal',
                        style: kHeading3Style.copyWith(
                            fontWeight: FontWeight.w800, color: kAltBg),
                      ).tr(),
                      centerTitle: false,
                      elevation: 1,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            label: Text(
                              DeviceUtils.getFormattedTimeNow(),
                              style: kBodyStyle.copyWith(
                                  color: kAltWhite,
                                  fontWeight: FontWeight.bold),
                            ),
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
                              sectionTitle: 'general'.tr(),
                              input: _buildGeneralInput(context, model)),
                          verticalSpaceSmall,
                          FormSection(
                              index: 2,
                              sectionTitle: 'period'.tr(),
                              input: _buildPeriod(model)),
                          verticalSpaceSmall,
                          FormSection(
                              index: 3,
                              sectionTitle: 'data'.tr(),
                              input: _buildData(model)),
                          verticalSpaceSmall,
                          FormSection(
                              index: 4,
                              sectionTitle: 'revised'.tr(),
                              input: _buildRevised(model)),
                          verticalSpaceSmall,
                          BoxButtonWidget(
                              buttonText: 'submit'.tr(),
                              buttonColor: kcPrimaryColor,
                              isLoading: model.busy,
                              onPressed: () {
                                if (!model.busy) {
                                  if (model.formKey.currentState!.validate()) {}
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: kBorderSmall,
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.4))),
                    ))
              ],
            ),
          );
        }),
      ),
      viewModelBuilder: () => TaxViewModel(),
    );
  }

  Widget _buildGeneralInput(BuildContext context, TaxViewModel _) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FormInput(controller: _.nameTEC, hintText: 'full_name.hint'),
          verticalSpaceSmall,
          FormInput(controller: _.permitNoTEC, hintText: 'lease_no'),
        ],
      );

  Widget _buildPeriod(TaxViewModel _) => Row(
        children: [
          Expanded(
              child: FormInput(
            controller: _.fromTEC,
            hintText: 'from',
          )),
          horizontalSpaceMedium,
          Expanded(
              child: FormInput(
            controller: _.toTEC,
            hintText: 'to',
          ))
        ],
      );

  Widget _buildData(TaxViewModel _) => Column(
        children: [
          FormInput(
            controller: _.installmentTEC,
            hintText: 'installment',
          ),
          verticalSpaceSmall,
          Row(
            children: [
              Expanded(
                  child: FormInput(
                controller: _.fineRateTEC,
                hintText: 'fine_rate',
              )),
              horizontalSpaceSmall,
              Expanded(
                  child: FormInput(
                controller: _.monthDueTEC,
                hintText: 'month_due',
              ))
            ],
          ),
        ],
      );

  Widget _buildRevised(TaxViewModel _) => Column(
        children: [
          FormInput(
            controller: _.everyTEC,
            hintText: 'every',
          ),
          verticalSpaceSmall,
          Row(
            children: [
              Expanded(
                  child: FormInput(
                controller: _.rateTEC,
                hintText: 'rate',
              )),
              horizontalSpaceSmall,
              Expanded(
                  child: FormInput(
                controller: _.lastRevisedTEC,
                hintText: 'last_rate',
              ))
            ],
          ),
        ],
      );
}

class FormInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isOptional;

  const FormInput(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.isOptional = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      isEmail: false,
      isCapitalize: false,
      borderColor: kcPrimaryColor.withOpacity(0.4),
      fillColor: Colors.transparent,
      isDark: false,
      hintText: '$hintText'.tr(),
      validator: (value) {
        if (isOptional) {
          return null;
        } else if (value!.isEmpty) {
          return 'common.empty'.tr();
        } else {
          return null;
        }
      },
    );
  }
}
