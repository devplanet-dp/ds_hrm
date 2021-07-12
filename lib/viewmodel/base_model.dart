import 'package:ds_hrm/model/user.dart';
import 'package:ds_hrm/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../locator.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final ThemeService _themeService = locator<ThemeService>();

  bool isDark() => _themeService.isDarkMode;

  UserModel get currentUser => _authenticationService.currentUser;

  toggleTheme() => _themeService.toggleDarkLightTheme();

  bool _busy = false;

  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void applyChanges() => notifyListeners();
}
