import 'package:ds_hrm/constants/route_name.dart';
import 'package:ds_hrm/services/auth_service.dart';
import 'package:ds_hrm/services/firestore_service.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';

class StartupViewModel extends BaseModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser.data??false) {
      _navigationService.replaceWith(HomeViewRoute);
    } else {
      // _autoLogin();
      _navigationService.replaceWith(WelcomeViewRoute);
    }
  }
  _autoLogin()async{
    setBusy(true);
   await  _authenticationService.loginWithEmail(email: 'admin@ds.gov', password: 'Admin#2021');
    setBusy(false);
  }
}
