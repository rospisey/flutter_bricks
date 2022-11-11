import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {

  static const int mobileMaxWidth = 640;
  static const int tabletMaxWidth = 768;
  static const int desktopMaxWidth = 1024;
  //final int largeMaxWidth = 1280;
  //final int extraLargeMaxWidth = 1536;

  final Widget mobileBody;
  final Widget desktopBody;
  final Widget? tabletBody;
  final Widget? largeBody;
  //final Widget? extraLargeBody;

  const ResponsiveLayout(
      {
        Key? key,
        required this.mobileBody,
        required this.desktopBody,
        this.tabletBody,
        this.largeBody
        //this.extraLargeBody
      })
      : super(key: key);

  static bool isMobile(context)
  {
    return MediaQuery.of(context).size.width <= mobileMaxWidth;
  }

  static bool isTablet(context)
  {
    return mobileMaxWidth < MediaQuery.of(context).size.width
    && MediaQuery.of(context).size.width <= tabletMaxWidth;
  }

  static bool isDesktop(context)
  {
    return tabletMaxWidth < MediaQuery.of(context).size.width
    && MediaQuery.of(context).size.width <= desktopMaxWidth;
  }

  static bool isLarge(context)
  {
    return desktopMaxWidth < MediaQuery.of(context).size.width;
    // && MediaQuery.of(context).size.width <= largeMaxWidth;
  }

  /*
  bool isExtraLarge(context)
  {
    return largeMaxWidth < MediaQuery.of(context).size.width
    // && MediaQuery.of(context).size.width <= largeMaxWidth
    ;
  }
  */

  @override
  Widget build(BuildContext context) {

    /*
    if(isExtraLarge(context))
    {
      if(extraLargeBody != null)
      {
        return extraLargeBody!;
      }
      else if(largeBody != null)
      {
        return largeBody!;
      }

      return desktopBody;
    }
    */

    if(isLarge(context))
    {
      if(largeBody != null)
      {
        return largeBody!;
      }

      return desktopBody;
    }

    if(isDesktop(context))
    {
      return desktopBody;
    }

    if(isTablet(context))
    {
      if(tabletBody != null)
      {
        return tabletBody!;
      }

      return mobileBody;
    }

    // if(isMobile(context))
    // {
    //   return mobileBody;
    // }

    return mobileBody;
  }

}