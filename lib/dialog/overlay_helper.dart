import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dialog/empty.dart';
import 'package:pretty_dialog/full_flex.dart';

abstract class PrettyToast {

  PrettyToast._();

  static Map<int, OverlayEntry?> _lastOverlays = {};

  // TODO: refactor to use the theme colors
  static Color successColor = const Color.fromRGBO(46, 204, 113, 1);
  static Color errorColor = const Color.fromRGBO(231, 76, 60, 1);
  static Color infoColor = const Color.fromRGBO(17, 110, 183, 1);
  static Color warningColor = const Color.fromRGBO(241, 196, 15, 1);

  static int _toastLayerId = 2, _progressLayerId = 1;

  static void showOverlay(BuildContext context, {int? durationInSeconds, int layerId = 0, required Widget widget}) {
    var _overlay = OverlayEntry(builder: (_) => widget);

    if (_lastOverlays[layerId] != null) {
      _lastOverlays[layerId]!.remove();
      _lastOverlays[layerId] = null;
    }
    var o = Overlay.of(context);
    if (o == null) {
      return;
    }
    o.insert(_overlay);
    _lastOverlays[layerId] = _overlay;

    if (durationInSeconds == null) return;

    Future.delayed(Duration(seconds: durationInSeconds), () {
      if (_lastOverlays[layerId] == null || _lastOverlays[layerId] != _overlay) return;
      _lastOverlays[layerId]!.remove();
      _lastOverlays[layerId] = null;
    });
  }

  static void hideOverlay([int layerId = 0]) {
    if (_lastOverlays[layerId] != null) {
      _lastOverlays[layerId]!.remove();
      _lastOverlays[layerId] = null;
    }
  }

  static void hideAllOverlays() {
    for (int index in _lastOverlays.keys) {
      hideOverlay(index);
    }
  }

  // toast methods

  static void showToast(BuildContext context, String text, Color color, IconData icon, int durationInSeconds) {
    showOverlay(context,
        durationInSeconds: durationInSeconds, layerId: _toastLayerId, widget: OverlayToast(text, color, icon));
  }

  static void showSuccessToast(BuildContext context, String text, {int seconds = 3}) {
    showToast(context, text, successColor, Icons.check_circle, seconds);
  }

  static void showErrorToast(BuildContext context,  String text, {int seconds = 3}) {
    showToast(context, text, errorColor, Icons.cancel, seconds);
  }

  static void showInfoToast(BuildContext context,  String text, {int seconds = 3}) {
    showToast(context, text, infoColor, Icons.info, seconds);
  }

  static void showWarningToast(BuildContext context, String text, {int seconds = 3}) {
    showToast(context, text, warningColor, Icons.warning_rounded, seconds);
  }

  // progress methods
  // layer index 1 is preserved for the progress indicator

  static void showProgressToast(BuildContext context, {required String text, durationInSeconds = 65}) {
    clearFocus(context);
    showOverlay(context, layerId: _progressLayerId, durationInSeconds: durationInSeconds, widget: OverlayProgress(text));
  }

  static void hideProgressToast() {
    hideOverlay(_progressLayerId);
  }

  static void clearFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}

// region Overlay Toast

class OverlayToast extends StatelessWidget {
  final String text;
  final Color color;
  final IconData iconData;

  OverlayToast(this.text, this.color, this.iconData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: FullCol(
        heights: "1* auto 1*",
        children: <Widget>[
          Empty(),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Material(
              elevation: 5,
              color: Colors.white,
              type: MaterialType.card,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide.none,
              ),
              child: FullRow(
                widths: "auto 1*",
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      iconData,
                      color: color,
                      size: 35,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: Text(text,
                          textAlign: TextAlign.start, style: TextStyle(color: color, fontSize: 16)))
                ],
              ),
            ),
          ),
          Empty()
        ],
      ),
    );
  }
}

// endregion

// region Progress Overlay

class OverlayProgress extends StatelessWidget {
  final String text;

  OverlayProgress(this.text);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        Center(
          child: Material(
            elevation: 2,
            color: Colors.white,
            type: MaterialType.card,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              side: BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// endregion
