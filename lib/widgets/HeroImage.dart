import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {

  final double height;

  const HeroImage({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Image.asset('images/crashFree.png'),),
        width: MediaQuery.of(context).size.width,
        height: height,
      );
  }

}