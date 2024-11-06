import 'package:flutter/material.dart';

class DialogWrapper extends StatelessWidget {
  final bool dismisable;
  final Widget child;
  final double maxWidth;

  const DialogWrapper({required this.child, this.dismisable = false, this.maxWidth = 400});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
