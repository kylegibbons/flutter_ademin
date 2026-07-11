import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/authentication/widgets/slider_section.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/public_master_layout/public_footer.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class SliderScreenLockScreen extends StatefulWidget {
  const SliderScreenLockScreen({super.key});

  @override
  State<SliderScreenLockScreen> createState() => _SliderScreenLockScreenState();
}

class _SliderScreenLockScreenState extends State<SliderScreenLockScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      GoRouter.of(context).go(RouteUri.home);
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
                                        ? 516
                                        : 288 + kDefaultPadding,
                                  ),

                                  // form
                                  Container(
                                    width: mediaQueryData.size.width >= 960
                                        ? 480
                                        : double.infinity,
                                    height: 516,
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
                                            'Lock Screen',
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
                                            'Authentication required. Please enter your password.',
                                          ),
                                          Spacer(),
                                          Align(
                                            alignment: Alignment.center,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.blueGrey
                                                  .withValues(alpha: 0.1),
                                              radius: 48,
                                              child: const CircleAvatar(
                                                radius: 42,
                                                backgroundImage: AssetImage(
                                                  'assets/images/avatar_2.jpg',
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: kDefaultPadding / 2,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Umar Hamzah',
                                              style: TextStyle(
                                                fontSize: kBodyLarge,
                                                fontWeight: FontWeight.w600,
                                                color: themeData
                                                    .colorScheme
                                                    .onSurface,
                                              ),
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
                                                  hintText: 'Enter password',
                                                  controller:
                                                      _passwordController,
                                                  isPassword: true,
                                                  validator: FormBuilderValidators.compose([
                                                    FormBuilderValidators.required(),
                                                    FormBuilderValidators.password(),
                                                  ]),
                                                  onChanged: (_) => setState(
                                                    () {},
                                                  ), // So confirm password validator gets updated
                                                ),

                                                const SizedBox(
                                                  height: 1.5 * kDefaultPadding,
                                                ),

                                                //Sign in button
                                                FlatButton(
                                                  kText: 'Unlock',
                                                  kTextColor: Colors.white,
                                                  bgColor: kSuccessColor,
                                                  isFullWidth: true,
                                                  onPressed: _submit,
                                                ),
                                              ],
                                            ),
                                          ),

                                          const SizedBox(
                                            height: 2 * kDefaultPadding,
                                          ),

                                          // sign in link
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Not you? Return to ",
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
                                                  'Sign In',
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

                                          SizedBox(height: 2 * kDefaultPadding),
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
