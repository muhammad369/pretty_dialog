import 'package:flutter/widgets.dart';

abstract class FullFlex extends StatelessWidget {
  late Flex flex;
  bool isRow; //or column
  final String dims;
  List<Widget> children;
  List<Widget> wrappedChildren = [];

  void _throwExceptionForValue(String value) {
    throw new Exception(
        "Full ${isRow ? "Row" : "Col"} - The config '$value' is not allowed as ${isRow ? "width" : "height"}, allowed configs are:\r\n " +
            "- value, such as (100, 200, ...) \r\n" +
            "- ratios (flexes) that should fill the entire remaining space such as (1*, 2*, ...)\r\n" +
            "- 'auto' which will leave the widget's width as is");
  }

  FullFlex({
    required this.isRow,
    required this.dims,
    required this.children,
    MainAxisAlignment mainAccessAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    List<String> splitDims = this.dims.split(" ");


    for (int i = 0; i < children.length; i++) {
      if (splitDims.length <= i ||
          splitDims[i] == "auto" ||
          splitDims[i].isEmpty) {
        this.wrappedChildren.add(this.children[i]);
      } else if (splitDims[i].endsWith("*")) {
        int? flx;
        if ((flx = int.tryParse(
                splitDims[i].substring(0, splitDims[i].length - 1))) !=
            null) {
          this
              .wrappedChildren
              .add(Expanded(flex: flx!, child: this.children[i]));
        } else {
          _throwExceptionForValue(splitDims[i]);
        }
      } else if (int.tryParse(splitDims[i]) != null) {
        int w = int.tryParse(splitDims[i])!;

        this.wrappedChildren.add(isRow
            ? SizedBox(width: w.toDouble(), child: this.children[i])
            : SizedBox(height: w.toDouble(), child: this.children[i]));
      } else {
        _throwExceptionForValue(splitDims[i]);
      }
    }

    this.flex = isRow
        ? new Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAccessAlignment,
            children: wrappedChildren,
          )
        : new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAccessAlignment,
            children: wrappedChildren,
          );
  }

  @override
  Widget build(BuildContext context) {
    return this.flex;
  }
}

class FullRow extends FullFlex {
  ///FullRow is an extension to Row,
  ///set widths by a string with space separated values,
  ///
  ///allowed width configs are:
  ///
  ///- value, such as (100, 200, ...)
  ///
  ///- ratios (flexes) that should fill the entire remaining space with flex as the ratio such as ("1*", ...)
  ///
  ///- 'auto' which will leave the widget's width as is,
  ///
  ///example: "200 auto 1* "
  FullRow({
    required String widths,
    required List<Widget> children,
    MainAxisAlignment mainAccessAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(
          isRow: true,
          dims: widths,
          children: children,
          mainAccessAlignment: mainAccessAlignment,
          crossAxisAlignment: crossAxisAlignment,
        );
}

class FullCol extends FullFlex {
  ///FullCol is an extension to Column,
  ///set heights by a string with space separated values,
  ///
  ///allowed height configs are:
  ///
  ///- value, such as (100, 200, ...)
  ///
  ///- ratios (flexes) that should fill the entire remaining space with flex as the ratio such as ("1*", ...)
  ///
  ///- 'auto' which will leave the widget's width as is,
  ///
  ///example: "200 auto 1* "
  FullCol({
    required String heights,
    required List<Widget> children,
    MainAxisAlignment mainAccessAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(
          isRow: false,
          dims: heights,
          children: children,
          mainAccessAlignment: mainAccessAlignment,
          crossAxisAlignment: crossAxisAlignment,
        );
}
