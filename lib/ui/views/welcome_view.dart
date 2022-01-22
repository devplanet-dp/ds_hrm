import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ds_hrm/constants/app_assets.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/ui/widgets/background_overlay.dart';
import 'package:ds_hrm/ui/widgets/brand_bg_widget.dart';
import 'package:ds_hrm/ui/widgets/busy_button.dart';
import 'package:ds_hrm/ui/widgets/busy_overlay.dart';
import 'package:ds_hrm/ui/widgets/text_field_widget.dart';
import 'package:ds_hrm/utils/validators.dart';
import 'package:ds_hrm/viewmodel/login/login_view_model.dart';
import 'package:ds_hrm/viewmodel/welcome/welcome_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      builder: (context, model, child) => BusyOverlay(
        show: model.busy,
        child: ResponsiveBuilder(
          builder: (_, size) {
            return Scaffold(
              body: Stack(
                children: [
                  BrandBgWidget(imgName: kImgWelcome),
                  BackgroundOverlayWidget(
                    isDark: true,
                  ),
                  size.isMobile
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                EmblemWidget(),
                                verticalSpaceMedium,
                                Padding(
                                  padding: fieldPaddingAll,
                                  child: _LoginForm(),
                                ),
                                verticalSpaceLarge
                              ],
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: _buildCenterTile(context, size.isMobile),
                        )
                ],
              ),
            );
          },
        ),
      ),
      viewModelBuilder: () => WelcomeViewModel(),
    );
  }

  Widget _buildCenterTile(BuildContext context, bool isMobile) => Padding(
        padding: fieldPaddingAll,
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: kBorderMedium),
          clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          child: Container(
            height: context.screenHeight(percent: 0.7),
            width: context.screenWidth(percent: 0.7),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  // will be 10 by default if not provided
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: fieldPaddingAll,
                    child: Row(
                      children: [
                        Expanded(child: EmblemWidget()),
                        Expanded(child: _LoginForm()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _LoginForm extends StatelessWidget {

  //text controllers:-----------------------------------------------------------
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onModelReady: (model){

        //admin credentials
        // emailController.text = 'admin@ds.gov';
        // passwordController.text = 'Admin#2021';

        //land credentials
        // emailController.text = 'land@ds.gov';
        // passwordController.text = 'Land#2022';

        //account credentials
        // emailController.text = 'account@ds.gov';
        // passwordController.text = 'Account#2022';
      },
      builder: (context, model, child) => GestureDetector(

        child: Form(
          key: model.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'welcome'.tr(),
                  style: kBodyStyle.copyWith(
                      fontWeight: FontWeight.bold, color: kAltWhite),
                ),
                verticalSpaceSmall,
                _buildEmailInput(),
                verticalSpaceSmall,
                _buildPasswordInput(
                    onSuffixTapped: model.toggleObscure,
                    isObscure: model.isObscure),
                verticalSpaceSmall,
                BoxButtonWidget(
                    buttonText: 'sign_in'.tr(),
                    buttonColor: kcPrimaryColor,
                    isLoading: model.busy,
                    onPressed: () {
                      if (!model.busy) {
                        if (model.formKey.currentState!.validate()) {
                          model.login(
                              email: emailController.text,
                              password: passwordController.text.trim());
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }

  Widget _buildEmailInput() => AppTextField(
        isEmail: true,
        isCapitalize: false,
        borderColor: kAltWhite.withOpacity(0.4),
        fillColor: Colors.transparent,
        isDark: true,
        controller: emailController,
        hintText: 'email.hint'.tr(),
        validator: (value) {
          if (!Validator.isEmail(value!)) {
            return 'email.invalid'.tr();
          } else if (value.isEmpty) {
            return 'email.empty'.tr();
          } else {
            return null;
          }
        },
      );

  Widget _buildPasswordInput(
          {required VoidCallback onSuffixTapped, required bool isObscure}) =>
      AppTextField(
        isPassword: isObscure,
        isDark: true,
        isCapitalize: false,
        borderColor: kAltWhite.withOpacity(0.4),
        fillColor: Colors.transparent,
        suffix: InkWell(
          onTap: onSuffixTapped,
          child: Icon(
            isObscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: kAltWhite,
          ),
        ),
        controller: passwordController,
        hintText: 'pwd.hint'.tr(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'pwd.empty'.tr();
          } else {
            return null;
          }
        },
      );
}

class EmblemWidget extends StatelessWidget {
  const EmblemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (_, size) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            kIcDSLogo,
            height: context.screenHeight(percent: size.isMobile ? 0.2 : 0.3),
            width: context.screenWidth(percent: size.isMobile ? 0.2 : 0.3),
          ),
          verticalSpaceMedium,
          AutoSizeText(
            'ds'.tr(),
            maxLines: 1,
            style: kHeading2Style.copyWith(
                fontWeight: FontWeight.bold, color: kAltWhite),
          ),
          AutoSizeText(
            'bandarawela'.tr(),
            maxLines: 1,
            style: kHeading3Style.copyWith(
                fontWeight: FontWeight.bold, color: kAltWhite),
          ),
        ],
      );
    });
  }
}
