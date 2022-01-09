import 'package:ds_hrm/constants/route_name.dart';
import 'package:ds_hrm/model/user.dart';
import 'package:ds_hrm/services/auth_service.dart';
import 'package:ds_hrm/services/firestore_service.dart';
import 'package:ds_hrm/ui/shared/bottom_sheet_type.dart';
import 'package:ds_hrm/ui/views/language/locale_sheet_view.dart';
import 'package:ds_hrm/viewmodel/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';

class LoginViewModel extends BaseModel {
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();
  final _bottomSheetService = locator<BottomSheetService>();

  bool _isObscure = true;

  bool get isObscure => _isObscure;

  toggleObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
  final formKey = GlobalKey<FormState>();

  var localeSheetBuilder = {
    BottomSheetType.floating: (context, sheetRequest, completer) =>
        LocaleSheetView(
          completer: completer,
          request: sheetRequest,
        )
  };

  Future login({
    required String email,
    required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        navigateToHome();
      } else {
        await _dialogService.showDialog(
          title: 'Login Failed',
          description: 'Something went wrong!',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failed',
        description: result,
      );
    }
  }

  Future signUpUser() async {
    setBusy(true);
    var result = await _authenticationService.signUpWithEmail(
        email: 'admin@ds.gov',
        password: "Admin#2021",
        fullName: 'Admin DS Bandarawela');
    setBusy(false);
  }

  void navigateToHome() async {
    Department department = currentUser!.department;
    switch(department){

      case Department.ADMIN:
        _navigationService.replaceWith(HomeViewRoute);
        break;
      case Department.LAND:
        _navigationService.replaceWith(LandHomeViewRoute);
        break;
      case Department.SALES:
        // TODO: Handle this case.
        break;
    }

  }

  showLocaleSheet() async {
    _bottomSheetService.setCustomSheetBuilders(localeSheetBuilder);

    await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.floating,
        isScrollControlled: false,
        title: '',
        mainButtonTitle: '',
        barrierDismissible: true,
        secondaryButtonTitle: '');
  }
}
