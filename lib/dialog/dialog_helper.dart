import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dialog_wrapper.dart';
import 'general_dialog.dart';
import 'options_dialog.dart';
import 'overlay_helper.dart';

abstract class PrettyDialog {
  PrettyDialog._();

  static Future<bool> showAlertDialog(BuildContext context,
      {required AlertType alertType, String? title, String? subTitle, required String okText, Color? okColor, String? cancelText, Color? cancelColor}) async {
    return await showCustomDialog(
        context,
        GeneralDialog(
          title: title,
          subTitle: subTitle,
          yesAction: okText,
          yesColor: okColor,
          cancelAction: cancelText,
          cancelColor: cancelColor,
          icon: Icon(
            alertType == AlertType.success
                ? Icons.check_circle
                : alertType == AlertType.info
                    ? Icons.info_rounded
                    : alertType == AlertType.warning
                        ? Icons.warning_rounded
                        : Icons.error,
            size: 70,
            color: alertType == AlertType.success
                ? PrettyToast.successColor
                : alertType == AlertType.info
                    ? PrettyToast.infoColor
                    : alertType == AlertType.warning
                        ? PrettyToast.warningColor
                        : PrettyToast.errorColor,
          ),
        ));
  }

  static Future<bool?> showActionDialog(BuildContext context,
      {String? title,
      String? subTitle,
      required String yesText,
      Color? yesColor,
      String? cancelText,
      Color? cancelColor,
      String? noText,
      Color? noColor,
      IconData? icon,
      Color? iconColor}) {
    return showCustomDialog<bool?>(
        context,
        GeneralDialog(
          title: title,
          subTitle: subTitle,
          yesAction: yesText,
          yesColor: yesColor,
          noAction: noText,
          noColor: noColor,
          cancelAction: cancelText,
          cancelColor: cancelColor,
          icon: icon == null
              ? null
              : Icon(
                  icon,
                  size: 70,
                  color: iconColor ?? Theme.of(context).primaryColor,
                ),
        ));
  }

  static Future<int?> showOptionsDialog(BuildContext context,
      {String? title, String? subTitle, IconData? icon, Color? iconColor, Color? optionsColor, required List<String> options}) {
    return showCustomDialog<int?>(
      context,
      OptionsDialog(
        title: title,
        subTitle: subTitle,
        icon: icon == null
            ? null
            : Icon(
          icon,
          size: 70,
          color: iconColor?? Theme.of(context).primaryColor,
        ),
        //iconColor: iconColor,
        optionsColor: optionsColor,
        options: options,
      ),
    );
  }

  static Future<T?> showCustomDialog<T>(BuildContext context, Widget dialogView, {bool dismisable = false, double maxWidth = 400}) {
    return showDialog<T>(
        context: context,
        builder: (_) => DialogWrapper(
              maxWidth: maxWidth,
              dismisable: dismisable,
              child: dialogView,
            ),
        barrierDismissible: false);
  }

  /// used to hide the last shown dialog
  static void hideDialog<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }
}

enum AlertType { success, info, warning, error }
