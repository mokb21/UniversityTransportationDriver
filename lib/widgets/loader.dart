import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:university_transportation_driver/config/themes/theme_constants.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.3,
          child: const ModalBarrier(dismissible: false, color: Colors.black),
        ),
        SpinKitDualRing(color: ThemeConstants.PrimaryColor)
      ],
    );
  }
}
