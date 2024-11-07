import 'dart:ui';

import 'package:flutter/material.dart';
import '../empty.dart';
import 'dialog_helper.dart';

class OptionsDialog extends StatefulWidget {
  final String? title, subTitle;
  final Widget? icon;
  final Color? optionsColor;
  final Color? iconColor;
  //
  final List<String> options;

  OptionsDialog({Key? key, this.title, this.subTitle, this.icon, this.iconColor, this.optionsColor, required this.options}) : super(key: key);

  @override
  State<OptionsDialog> createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  static double _smallPadding = 5;
  static double _normalPadding = 20;

  bool get _titleExists => widget.title != null && widget.title!.isNotEmpty;

  bool get _subTitleExists => widget.subTitle != null && widget.subTitle!.isNotEmpty;

  int selection = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _normalPadding - 5, horizontal: _normalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(visible: widget.icon != null, child: Container(margin: EdgeInsets.all(20), child: widget.icon ?? Container())),
          Visibility(
              visible: widget.icon != null,
              child: Empty(
                height: _normalPadding,
              )),
          //
          //
          Visibility(
              visible: _titleExists,
              child: Text(
                widget.title ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
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
                widget.subTitle ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              )),
          Visibility(
              visible: _subTitleExists,
              child: Empty(
                height: _normalPadding,
              )),
          //
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.options.mapIndexed(
                  (i, e) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildBtn(context, e, i),
                      Empty(
                        height: _smallPadding,
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildBtn(BuildContext context, String optionText, int index) {
    return Container(
      width: double.maxFinite,
      child: index == selection
          ? TextButton(
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all( widget.optionsColor ?? Theme.of(context).primaryColor)),
              child: Text(
                optionText,
                style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize, color: Theme.of(context).colorScheme.surface),
              ),
              onPressed: () => _returnWith(context, index),
            )
          : OutlinedButton(
              style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(widget.optionsColor ?? Theme.of(context).primaryColor),
                  side: WidgetStateProperty.all(BorderSide(color: widget.optionsColor ?? Theme.of(context).primaryColor))),
              child: Text(optionText, style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize, color: widget.optionsColor ?? Theme.of(context).primaryColor), ),
              onPressed: () => _setSelection(index),
            ),
    );
  }

  void _returnWith(BuildContext context, int? result) {
    PrettyDialog.hideDialog(context, result);
  }


  _setSelection(int index) {
    setState(() {
      selection = index;
    });
  }
}

extension<Y> on List<Y> {
  List<T> mapIndexed<T>(T Function(int index, Y item) mapper) {
    var tmp = <T>[];

    for (var i = 0; i < length; i++) {
      tmp.add(mapper(i, this[i]));
    }
    //
    return tmp;
  }
}
