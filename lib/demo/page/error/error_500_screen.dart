import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/public_master_layout/public_footer.dart';
import 'package:go_router/go_router.dart';

class Error500Screen extends StatefulWidget {
  const Error500Screen({super.key});

  @override
  State<Error500Screen> createState() => _Error500ScreenState();
}

class _Error500ScreenState extends State<Error500Screen> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(color: themeData.colorScheme.surface),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: double.infinity,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        'ERROR',
                        style: TextStyle(
                          fontSize: kDisplaySmall,
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '500',
                        style: TextStyle(
                          fontSize: 2 * kDisplayLarge,
                          color: themeData.colorScheme.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Text(
                          'We can’t seem to find the page you are looking for!',
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            fontWeight: FontWeight.w500,
                            color: themeData.colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 2 * kDefaultPadding),
                      FlatButton(
                        kText: 'Back to Home Page',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        onPressed: () => GoRouter.of(context).go(RouteUri.home),
                      ),
                      Spacer(),

                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: PublicFooter(
                          textColor: themeData.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: kDefaultPadding),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
