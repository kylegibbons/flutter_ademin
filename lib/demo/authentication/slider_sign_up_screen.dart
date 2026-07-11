import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/authentication/widgets/slider_section.dart';
import 'package:flutter_ademin/demo/authentication/widgets/social_login_section.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/public_master_layout/public_footer.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class SliderSignUpScreen extends StatefulWidget {
  const SliderSignUpScreen({super.key});

  @override
  State<SliderSignUpScreen> createState() => _SliderSignUpScreenState();
}

class _SliderSignUpScreenState extends State<SliderSignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

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
                                        ? 660
                                        : 288 + kDefaultPadding,
                                  ),

                                  // form
                                  Container(
                                    width: mediaQueryData.size.width >= 960
                                        ? 480
                                        : double.infinity,
                                    height: 660,
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
                                          // sign in form
                                          Text(
                                            'Create New Account',
                                            style: TextStyle(
                                              color:
                                                  themeData.colorScheme.primary,
                                              fontSize: kBodyLarge,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: kDefaultPadding / 2),
                                          Text(
                                            'Unlock your Ademin free account now',
                                          ),
                                          Spacer(),
                                          FormBuilder(
                                            key: _formKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Email',
                                                  style: TextStyle(
                                                    color: themeData
                                                        .colorScheme
                                                        .onSurface,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: kDefaultPadding / 2,
                                                ),

                                                //Email
                                                CustomTextFormField(
                                                  hintText: "Enter email",
                                                  validator:
                                                      FormBuilderValidators.email(),
                                                  suffixIcon:
                                                      Icons.email_outlined,
                                                ),

                                                SizedBox(
                                                  height: kDefaultPadding,
                                                ),

                                                Text(
                                                  'Username',
                                                  style: TextStyle(
                                                    color: themeData
                                                        .colorScheme
                                                        .onSurface,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: kDefaultPadding / 2,
                                                ),

                                                //Email
                                                CustomTextFormField(
                                                  hintText: "Enter username",
                                                  validator:
                                                      FormBuilderValidators.username(
                                                        minLength: 5,
                                                        maxLength: 20,
                                                        allowDash: true,
                                                      ),
                                                  suffixIcon:
                                                      Icons.person_outline,
                                                ),

                                                SizedBox(
                                                  height: kDefaultPadding,
                                                ),

                                                Text(
                                                  'Password',
                                                  style: TextStyle(
                                                    color: themeData
                                                        .colorScheme
                                                        .onSurface,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: kDefaultPadding / 2,
                                                ),

                                                //Password
                                                CustomTextFormField(
                                                  hintText: 'Enter password',
                                                  isPassword: true,
                                                  validator:
                                                      FormBuilderValidators.password(
                                                        minLength: 8,
                                                        maxLength: 20,
                                                        minLowercaseCount: 1,
                                                        minNumberCount: 1,
                                                        minUppercaseCount: 1,
                                                        minSpecialCharCount: 1,
                                                        errorText:
                                                            'Min 8 chars, with upper, lower, number & symbol.',
                                                      ),
                                                ),

                                                SizedBox(
                                                  height: kDefaultPadding,
                                                ),

                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: kTextColor,
                                                      fontSize: kBodyMedium,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            "By registering you agree to the Ademin ",
                                                      ),
                                                      TextSpan(
                                                        text: 'Terms of Use',
                                                        style: TextStyle(
                                                          color: themeData
                                                              .colorScheme
                                                              .primary,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 1.5 * kDefaultPadding,
                                                ),

                                                //Sign in button
                                                FlatButton(
                                                  kText: 'Sign Up',
                                                  kTextColor: Colors.white,
                                                  bgColor: kSuccessColor,
                                                  isFullWidth: true,
                                                  onPressed: _submit,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.5 * kDefaultPadding,
                                          ),

                                          // social media sign in
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Divider(
                                                  color: themeData
                                                      .colorScheme
                                                      .outline, // Line color
                                                  thickness:
                                                      0.3, // Line thickness
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: kDefaultPadding,
                                                ),
                                                child: Text(
                                                  'Create account with',
                                                  style: TextStyle(
                                                    color: themeData
                                                        .colorScheme
                                                        .onSurface,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Divider(
                                                  color: themeData
                                                      .colorScheme
                                                      .outline, // Line color
                                                  thickness:
                                                      0.3, // Line thickness
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height: 1.5 * kDefaultPadding,
                                          ),

                                          SocialLogin(),

                                          Spacer(),
                                          // sign up link
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Already have an account ? ",
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
                      Spacer(flex: 1),
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
