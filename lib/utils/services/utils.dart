import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  Utils._();

  /// method to unfocus keyboard if keyboard is visible or input has focus
  static void unFocus(BuildContext context) {
    final focusNode = FocusScope.of(context);
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  /// method to request next focus if has
  static bool nextFocus(BuildContext context) {
    final focusNode = FocusScope.of(context);
    if (focusNode.canRequestFocus) {
      return focusNode.nextFocus();
    }
    return false;
  }

  /// method to remove html tags from given data
  static String removeHtmlTags(String data) {
    data ??= 'N/A';
    RegExp regExp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return data
        ?.replaceAll('<li>', '\n\t\u2022 ')
        ?.replaceAll(regExp, "")
        ?.replaceAll("&nbsp;", " ")
        ?.replaceAll("&amp;", "&")
        ?.replaceAll("&quot;", "\"")
        ?.replaceAll("&#39;", "\'")
        ?.replaceAll("&rsquo;", "'") ??
        "N/A";
  }

  /// method to show toast message
 static Future<bool> showToast(String msg, {Toast toastLength}) {
    if (msg != null && msg.trim().isNotEmpty) {
      return Fluttertoast.showToast(msg: msg, toastLength: toastLength);
    }
    return Future.value(false);
  }


}
