import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitDoubleBounce(
        color: Colors.yellow,
        size: 40,
      ),
    );
  }
}
