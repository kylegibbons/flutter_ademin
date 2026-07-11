import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/authentication/widgets/slider_section.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/animation/animated_icon.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/public_master_layout/public_footer.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SliderPasswordCreateScreen extends StatefulWidget {
  const SliderPasswordCreateScreen({super.key});

  @override
  State<SliderPasswordCreateScreen> createState() =>
      _SliderPasswordCreateScreenState();
}

class _SliderPasswordCreateScreenState
    extends State<SliderPasswordCreateScreen> {
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
                                        ? 548
                                        : 288 + kDefaultPadding,
                                  ),

                                  // form
                                  Container(
                                    width: mediaQueryData.size.width >= 960
                                        ? 480
                                        : double.infinity,
                                    height: 548,
                                    decoration: BoxDecoration(
                                      color: themeData.colorScheme.surface,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 3 * kDefaultPadding,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 3 * kDefaultPadding),
                                          Text(
                                            'Create New Password',
                                            style: TextStyle(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontSize: kBodyLarge,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: kDefaultPadding / 2,
                                          ),
                                          const Text(
                                            'Your new password must be different from your previous one.',
                                          ),
                                          const SizedBox(
                                            height: 1.5 * kDefaultPadding,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: CustomAnimatedIcon(
                                              symbol: Symbols.password_sharp,
                                              color: kSuccessColor,
                                              size: 62,
                                              duration: const Duration(
                                                seconds: 1,
                                              ),
                                              animationType:
                                                  LoopingAnimationType.scale,
                                              weight: 300,
                                            ),
                                          ),
                                          Spacer(),

                                          FormBuilder(
                                            key: _formKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Password',
                                                  style: TextStyle(
                                                    color: themeData
                                                        .colorScheme
                                                        .onSurface,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: kDefaultPadding / 2,
                                                ),

                                                // Password
                                                CustomTextFormField(
                                                  labelText: 'Enter password',
                                                  hintText: 'Enter password',
                                                  isPassword: true,
                                                  controller:
                                                      _passwordController,
                                                  validator: FormBuilderValidators.compose([
                                                    FormBuilderValidators.required(),
                                                    FormBuilderValidators.password(),
                                                  ]),
                                                  onChanged: (_) => setState(
                                                    () {},
                                                  ), // So confirm password validator gets updated
                                                ),

                                                const SizedBox(
                                                  height: kDefaultPadding,
                                                ),

                                                Text(
                                                  'Confirm Password',
                                                  style: TextStyle(
                                                    color: themeData
                                                        .colorScheme
                                                        .onSurface,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: kDefaultPadding / 2,
                                                ),

                                                // Password
                                                CustomTextFormField(
                                                  labelText: 'Enter Password',
                                                  hintText: 'Enter password',
                                                  isPassword: true,
                                                  validator: FormBuilderValidators.compose([
                                                    FormBuilderValidators.equal(
                                                      _passwordController.text,
                                                      errorText:
                                                          'Passwords do not match',
                                                    ),
                                                  ]),
                                                ),

                                                const SizedBox(
                                                  height: 1.5 * kDefaultPadding,
                                                ),

                                                //Sign in button
                                                FlatButton(
                                                  kText: 'Reset Password',
                                                  kTextColor: Colors.white,
                                                  bgColor: kSuccessColor,
                                                  isFullWidth: true,
                                                  onPressed: _submit,
                                                ),
                                              ],
                                            ),
                                          ),

                                          Spacer(),
                                          // sign up link
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Never mind, I remember it now — ",
                                                style: TextStyle(
                                                  color: themeData
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  GoRouter.of(
                                                    context,
                                                  ).go(RouteUri.sliderSignIn);
                                                },
                                                child: Text(
                                                  'Click here',
                                                  style: TextStyle(
                                                    color: themeData
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(
                                            height: 2 * kDefaultPadding,
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
