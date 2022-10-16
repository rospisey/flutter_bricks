import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:{{package_name}}/widget/service/launch_url.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const/app_data.dart';
import '../../utils/link_text_span.dart';

/// An about icon button used on the example's app app bar.
class AboutIconButton extends StatelessWidget {
  const AboutIconButton({super.key, this.color});

  /// The color used on the icon button.
  ///
  /// If null, default to Icon() class default color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info, color: color),
      onPressed: () {
        showAppAboutDialog(context);
      },
    );
  }
}

// This [showAppAboutDialog] function is based on the [AboutDialog] example
// that exist(ed) in the Flutter Gallery App.
void showAppAboutDialog(BuildContext context) async{
  final ThemeData theme = Theme.of(context);
  final TextStyle aboutTextStyle = theme.textTheme.bodyLarge!;
  final TextStyle footerStyle = theme.textTheme.bodySmall!;
  final TextStyle linkStyle =
      theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary);

  final MediaQueryData media = MediaQuery.of(context);
  final double width = media.size.width;
  final double height = media.size.height;

  // Get the card's ShapeBorder from the themed card shape.
  // This was kind of interesting to do, seem to work, for this case at least.
  final ShapeBorder? shapeBorder = theme.cardTheme.shape;
  double buttonRadius = 4; // Default un-themed value
  if (shapeBorder is RoundedRectangleBorder?) {
    final BorderRadiusGeometry? border = shapeBorder?.borderRadius;
    if (border is BorderRadius?) {
      final Radius? radius = border?.topLeft;
      buttonRadius = radius?.x == radius?.y ? (radius?.x ?? 4.0) : 4.0;
    }
  }
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appName = packageInfo.appName;
String packageName = packageInfo.packageName;
String version = packageInfo.version;
String buildNumber = packageInfo.buildNumber;

  showAboutDialog(
    context: context,
    applicationName: AppData.title(context),
    applicationVersion: '$version Build-$buildNumber',
    applicationIcon:
        // Container(height: 30,width: 30,child: Image.asset("assets/icons.png"),),
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // FlexThemeModeOptionButton(
        //   optionButtonBorderRadius: buttonRadius,
        //   selected: true,
        //   width: 30,
        //   height: 30,
        //   flexSchemeColor: FlexSchemeColor(
        //     primary: theme.colorScheme.primary,
        //     primaryContainer: theme.colorScheme.primaryContainer,
        //     secondary: theme.colorScheme.secondary,
        //     secondaryContainer: theme.colorScheme.secondaryContainer,
        //   ),
        // ),
        Container(
          height: 60,
          width: 60,
          child: Image.asset("assets/icons.png"),
        ),
        Divider(),
        Container(
          height: 60,
          width: 60,
          child: IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: FaIcon(FontAwesomeIcons.facebook,size: 40),
            onPressed: ()async {
              await launchUrl(Uri.parse('fb://profile/100047632187836'));
            }),
        ),
        // Container(
        //   height: 60,
        //   width: 60,
        //   child: IconButton(
        //     // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
        //     icon: FaIcon(FontAwesomeIcons.github,size: 40),
        //     onPressed: () {
        //       print("Pressed");
        //     })
        // ),
        
      ],
    ),
    applicationLegalese:
        '${AppData.copyright}\n${AppData.author}\n${AppData.license}',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text: 'The ${AppData.title(context)} application  '
                    'features of the math dictionary \n\n'
                    'To learn more, check out our project on github ',
              ),
              // LinkTextSpan(
              //   style: linkStyle,
              //   uri: AppData.packageUri,
              //   text: 'pub.dev',
              // ),
              TextSpan(
                style: aboutTextStyle,
                text: '. It also includes the source '
                    'code of this application.\n\n',
              ),
              TextSpan(
                style: footerStyle,
                text: 'Built with Flutter ${AppData.flutterVersion} \n'
                    // 'using ${AppData.packageName} '
                    // '${AppData.packageVersion}\n'
                    'Media size (w:${width.toStringAsFixed(0)}, '
                    'h:${height.toStringAsFixed(0)})\n\n',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
