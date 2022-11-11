import 'package:flutter/material.dart';

import 'responsive_layout.dart';

class ResponsiveFlex {

  final int mobileFlex;
  final int desktopFlex;
  final int? tabletFlex;
  final int? largeFlex;
  //final int? extraLargeBody;

  ResponsiveFlex(
      {
        required this.mobileFlex,
        required this.desktopFlex,
        this.tabletFlex,
        this.largeFlex
        //this.extraLargeBody
      });

  int getFlex(BuildContext context) {

    if(ResponsiveLayout.isLarge(context))
    {
      if(largeFlex != null)
      {
        return largeFlex!;
      }

      return desktopFlex;
    }

    if(ResponsiveLayout.isDesktop(context))
    {
      return desktopFlex;
    }

    if(ResponsiveLayout.isTablet(context))
    {
      if(tabletFlex != null)
      {
        return tabletFlex!;
      }

      return mobileFlex;
    }

    // if(isMobile(context))
    // {
    //   return mobileBody;
    // }

    return mobileFlex;
  }

}