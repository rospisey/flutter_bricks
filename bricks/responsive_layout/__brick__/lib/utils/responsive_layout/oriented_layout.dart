import 'package:flutter/material.dart';

class OrientedLayout extends StatelessWidget {

  final Widget landscapeBody;
  final Widget portraitBody;

  const OrientedLayout({ Key? key, required this.landscapeBody, required this.portraitBody }) : super(key: key);

  static bool isLandscape(context)
  {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return currentOrientation == Orientation.landscape;
  }

  static bool isPortrait(context)
  {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return currentOrientation != Orientation.landscape;
  }

  @override
  Widget build(BuildContext context) {

    if(isLandscape(context))
    {
      return landscapeBody;
    }

    return portraitBody;
  }
}