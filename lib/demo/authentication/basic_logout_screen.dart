import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/animation/animated_icon.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/public_master_layout/public_footer.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class BasicLogoutScreen extends StatefulWidget {
  const BasicLogoutScreen({super.key});

  @override
  State<BasicLogoutScreen> createState() => _BasicLogoutScreenState();
}

class _BasicLogoutScreenState extends State<BasicLogoutScreen> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/pattern.png"),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kPrimaryColor.withValues(alpha: 1.0),
              kSuccessColor.withValues(alpha: 0.7),
            ],
          ),
        ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding,
                          horizontal: kDefaultPadding,
                        ),
                        child: Image.asset(AppSettings.logoPath, height: 28.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: const Text(
                          AppSettings.appDescription,
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 2 * kDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: SizedBox(
                            width: 480,
                            child: Padding(
                              padding: const EdgeInsets.all(
                                2 * kDefaultPadding,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 3 * kDefaultPadding),
                                  CustomAnimatedIcon(
                                    symbol: Symbols.exit_to_app_sharp,
                                    color: kSuccessColor,
                                    size: 80,
                                    duration: const Duration(seconds: 2),
                                    animationType: LoopingAnimationType.scale,
                                    weight: 300,
                                  ),
                                  const SizedBox(height: 3 * kDefaultPadding),
                                  Text(
                                    'You are logged out',
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                      fontSize: kBodyLarge,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: kDefaultPadding / 2),
                                  const Text(
                                    'For security reasons, you’ve been logged out. Sign in to resume your work.',
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 1.5 * kDefaultPadding),
                                  FlatButton(
                                    kText: 'Sign In',
                                    kTextColor: Colors.white,
                                    bgColor: kSuccessColor,
                                    isFullWidth: true,
                                    onPressed: () {
                                      GoRouter.of(
                                        context,
                                      ).go(RouteUri.basicSignIn);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding,
                        ),
                        child: const PublicFooter(),
                      ),
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
