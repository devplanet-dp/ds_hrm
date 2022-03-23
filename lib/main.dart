import 'package:ds_hrm/constants/app_constants.dart';
import 'package:ds_hrm/ui/home/account/account_home_view.dart';
import 'package:ds_hrm/ui/home/admin/home_view.dart';
import 'package:ds_hrm/ui/router.dart';
import 'package:ds_hrm/ui/shared/app_theme.dart';
import 'package:ds_hrm/ui/startup/stratup_view.dart';
import 'package:ds_hrm/ui/views/lease/lease_view.dart';
import 'package:ds_hrm/ui/views/welcome_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'constants/app_assets.dart';
import 'locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft,
  ]).then((_) async {
    setupLocator();
    // InAppPurchaseConnection.enablePendingPurchases();
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp();
    await ThemeManager.initialise();
    runApp(EasyLocalization(
        child: MyApp(),
        supportedLocales: [Locale('en', 'US'), Locale('si', 'LK')],
        fallbackLocale: Locale('en', 'US'),
        useOnlyLangCode: true,
        path: kTranslation),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
        defaultThemeMode: ThemeMode.light,
        darkTheme: themeDataDark,
        lightTheme: themeData,
        builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          darkTheme: darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          title: APP_NAME,
          navigatorKey: StackedService.navigatorKey,
          theme: regularTheme,
          home: WelcomeView(),
          onGenerateRoute: generateRoute,
        ));
  }
}

