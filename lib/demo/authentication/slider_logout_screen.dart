import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/authentication/widgets/slider_section.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/animation/animated_icon.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/public_master_layout/public_footer.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SliderLogoutScreen extends StatefulWidget {
  const SliderLogoutScreen({super.key});

  @override
  State<SliderLogoutScreen> createState() => _SliderLogoutScreenState();
}

class _SliderLogoutScreenState extends State<SliderLogoutScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      GoRouter.of(context).go(RouteUri.sliderSignIn);
    } else {
      debugPrint('Validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);

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
              kSuccessColor.withValues(alpha: 0.7),
              kPrimaryColor.withValues(alpha: 0.8),
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
                      Spacer(flex: 2),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2 * kDefaultPadding,
                          left: kDefaultPadding,
                          right: kDefaultPadding,
                          bottom: kDefaultPadding,
                        ),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: SizedBox(
                            width: 960,
                            child: Container(
                              decoration: BoxDecoration(
                                color: kPrimaryColor.withValues(alpha: 01),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/images/slider_bg.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                  opacity: 0.1,
                                ),
                              ),
                              child: Wrap(
                                children: [
                                  // Slider
                                  AuthScreenSlider(
                                    height: mediaQueryData.size.width >= 960
                                        ? 400
                                        : 288 + kDefaultPadding,
                                  ),

                                  // form
                                  Container(
                                    width: mediaQueryData.size.width >= 960
                                        ? 480
                                        : double.infinity,
                                    height: 400,
                                    decoration: BoxDecoration(
                                      color: themeData.colorScheme.surface,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 2 * kDefaultPadding,
                                        vertical: 2 * kDefaultPadding,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Spacer(),
                                          CustomAnimatedIcon(
                                            symbol: Symbols.exit_to_app_sharp,
                                            color: kSuccessColor,
                                            size: 80,
                                            duration: const Duration(
                                              seconds: 2,
                                            ),
                                            animationType:
                                                LoopingAnimationType.scale,
                                            weight: 300,
                                          ),
                                          Spacer(),
                                          Text(
                                            'You are logged out',
                                            style: TextStyle(
                                              color: themeData
                                                  .colorScheme
                                                  .onSurface,
                                              fontSize: kBodyLarge,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: kDefaultPadding / 2,
                                          ),
                                          const Text(
                                            'For security reasons, you’ve been logged out. Sign in to resume your work.',
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(
                                            height: 1.5 * kDefaultPadding,
                                          ),
                                          FlatButton(
                                            kText: 'Sign In',
                                            kTextColor: Colors.white,
                                            bgColor: kSuccessColor,
                                            isFullWidth: true,
                                            onPressed: _submit,
                                          ),
                                        ],
                                      ),
                                    ),
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
