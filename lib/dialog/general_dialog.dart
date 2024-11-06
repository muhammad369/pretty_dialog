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
      {Key? key, this.title,
      this.subTitle,
      this.icon,
      required this.yesAction,
      this.noAction,
      this.cancelAction,
      this.yesColor,
      this.noColor,
      this.cancelColor}) : super(key: key);

  bool get _titleExists => title != null && title!.isNotEmpty;

  bool get _subTitleExists => subTitle != null && subTitle!.isNotEmpty;

  static double _smallPadding = 2;
  static double _normalPadding = 20;

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
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
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
                style: Theme.of(context).textTheme.headlineSmall,
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
        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(yesColor ?? PrettyToast.successColor)),
        child: Text(
          yesAction,
          style: TextStyle(fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize),
        ),
        onPressed: () => _returnWith(context, true),
      ),
    );
  }

  Widget _buildNoBtn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: TextButton(
        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(noColor ?? PrettyToast.infoColor)),
        child: Text(noAction!, style: TextStyle(fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize)),
        onPressed: () => _returnWith(context, false),
      ),
    );
  }

  Widget _buildCancelBtn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: OutlinedButton(
        style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(cancelColor ?? PrettyToast.infoColor),
            side: WidgetStateProperty.all(BorderSide(color: cancelColor ?? PrettyToast.infoColor))),
        child: Text(cancelAction!, style: TextStyle(fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize)),
        onPressed: () => _returnWith(context, null),
      ),
    );
  }

  void _returnWith(BuildContext context, bool? result) {
    PrettyDialog.hideDialog(context, result);
  }

}
