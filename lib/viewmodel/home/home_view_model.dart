import 'package:ds_hrm/model/user.dart';
import 'package:ds_hrm/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../../locator.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final _authenticationService = locator<AuthenticationService>();

  UserModel? get currentUser => _authenticationService.currentUser;

  final ThemeService _themeService = locator<ThemeService>();

  bool isDark() => _themeService.isDarkMode;
}
