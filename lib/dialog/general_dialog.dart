import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pretty_dialog/dialog/overlay_helper.dart';

import '../empty.dart';
import 'dialog_helper.dart';

class GeneralDialog extends StatelessWidget {
  final String? title, subTitle;
  final Widget? icon;
  //
  final String yesAction;
  final String? noAction, cancelAction;
  final Color? yesColor, noColor, cancelColor;

  GeneralDialog(
      {Key? key,
      this.title,
      this.subTitle,
      this.icon,
      required this.yesAction,
      this.noAction,
      this.cancelAction,
      this.yesColor,
      this.noColor,
      this.cancelColor})
      : super(key: key);

  bool get _titleExists => title != null && title!.isNotEmpty;

  bool get _subTitleExists => subTitle != null && subTitle!.isNotEmpty;

  static double _smallPadding = 5;
  static double _normalPadding = 20;
  static double smallFont = 16, bigFont = 22;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _normalPadding - 5, horizontal: _normalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(visible: icon != null, child: Container(margin: EdgeInsets.all(20), child: icon ?? Container())),
          Visibility(
              visible: icon != null,
              child: Empty(
                height: _normalPadding,
              )),
          //
          Visibility(
              visible: _titleExists,
              child: Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: bigFont, fontWeight: FontWeight.bold),
              )),
          Visibility(
              visible: _titleExists,
              child: Empty(
                height: _normalPadding,
              )),
          //
          Visibility(
              visible: _subTitleExists,
              child: Text(
                subTitle ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: smallFont),
              )),
          Visibility(
              visible: _subTitleExists,
              child: Empty(
                height: _normalPadding,
              )),
          //
          (noAction == null && cancelAction == null)
              ?
              // info dialog
              _buildYesBtn(context)
              : (noAction != null && cancelAction != null)
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildYesBtn(context),
                        Empty(
                          height: _smallPadding,
                        ),
                        _buildNoBtn(context),
                        Empty(
                          height: _normalPadding,
                        ),
                        _buildCancelBtn(context)
                      ],
                    )
                  : (noAction != null)
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildYesBtn(context),
                            Empty(
                              height: _smallPadding,
                            ),
                            _buildNoBtn(context),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildYesBtn(context),
                            Empty(
                              height: _smallPadding,
                            ),
                            _buildCancelBtn(context)
                          ],
                        )
        ],
      ),
    );
  }

  Widget _buildYesBtn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: TextButton(
        style: ButtonStyle(
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
            backgroundColor: WidgetStateProperty.all(yesColor ?? PrettyToast.successColor)),
        child: Text(
          yesAction,
          style: TextStyle(fontSize: smallFont, color: Theme.of(context).colorScheme.surface),
        ),
        onPressed: () => _returnWith(context, true),
      ),
    );
  }

  Widget _buildNoBtn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: TextButton(
        style: ButtonStyle(
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
            backgroundColor: WidgetStateProperty.all(noColor ?? PrettyToast.infoColor)),
        child: Text(noAction!, style: TextStyle(fontSize: smallFont, color: Theme.of(context).colorScheme.surface)),
        onPressed: () => _returnWith(context, false),
      ),
    );
  }

  Widget _buildCancelBtn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: OutlinedButton(
        style: ButtonStyle(
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
            foregroundColor: WidgetStateProperty.all(cancelColor ?? PrettyToast.infoColor),
            side: WidgetStateProperty.all(BorderSide(color: cancelColor ?? PrettyToast.infoColor, width: 1.3))),
        child: Text(cancelAction!, style: TextStyle(fontSize: smallFont)),
        onPressed: () => _returnWith(context, null),
      ),
    );
  }

  void _returnWith(BuildContext context, bool? result) {
    PrettyDialog.hideDialog(context, result);
  }
}
