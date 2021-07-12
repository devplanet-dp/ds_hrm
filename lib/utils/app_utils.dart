import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ds_hrm/ui/widgets/push_widget.dart';

showErrorMessage(BuildContext context, String message) {
  return PushNotification.of(context)
      .show(NotificationContent(title: 'Oops', body: message, isError: true));
}

showSuccessMessage(
    {required BuildContext context, required String message, String title = 'Success'}) {
  return PushNotification.of(context)
      .show(NotificationContent(title: title, body: message, isError: false));
}
String removeFirstWord(String word){
  if (word.length > 0)
  {
    int i = word.indexOf(" ")+1;
    String str=word.substring(i);
    return str;
  }
  return word;
}
final kFormatCurrency = new NumberFormat.simpleCurrency(locale: 'en_US');

void launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

void launchInstaProfile(String userName) async {
  var url = 'https://www.instagram.com/$userName/';
  await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
