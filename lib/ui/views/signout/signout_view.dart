import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/ui/widgets/busy_button.dart';
import 'package:ds_hrm/viewmodel/login/login_view_model.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

class SignOutView extends StatelessWidget {
  const SignOutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => ResponsiveBuilder(
        builder: (context,size) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'sign_out'.tr(),
                style: kHeading3Style.copyWith(
                    fontWeight: FontWeight.bold, color: kAltBg),
              ),
              verticalSpaceSmall,
              Text(
                'sign_out_message'.tr(),
                style: kBodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kAltBg.withOpacity(.5)),
              ),
              verticalSpaceSmall,
              SizedBox(
                width: size.screenSize.width/2,
                child: BoxButtonWidget(
                    buttonText: 'sign_out'.tr(),
                    buttonColor: kcPrimaryColor,
                    isLoading: model.busy,
                    onPressed: () {
                      if (!model.busy) {
                        model.signOut(context);
                      }
                    }),
              )
            ],
          );
        }
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
