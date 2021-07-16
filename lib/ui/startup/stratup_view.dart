import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ds_hrm/constants/app_assets.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/shared_styles.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';
import 'package:ds_hrm/viewmodel/startup/startup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  _StartUpViewState createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (model) {
        _controller.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            model.handleStartUpLogic();
          }
        });
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: kcPrimaryColor,
        body: Stack(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: _controller,
                            curve: Interval(.3, 1.0, curve: Curves.easeOut))),
                    child: Image.asset(
                      kIcDSLogo,
                      width: context.screenWidth(percent: 0.4),
                      height: context.screenHeight(percent: 0.4),
                    ),
                  ),
                  verticalSpaceMedium,
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedTextKit(
                      repeatForever: false,
                      isRepeatingAnimation: false,

                      animatedTexts: [
                        TyperAnimatedText(
                            'Divisional Secretariat - Bandarawela',
                            textStyle:
                                kHeading1Style.copyWith(color: kAltWhite))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
