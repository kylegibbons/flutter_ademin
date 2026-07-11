import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/authentication/widgets/social_login_section.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/public_master_layout/public_footer.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class BasicSignUpScreen extends StatefulWidget {
  const BasicSignUpScreen({super.key});

  @override
  State<BasicSignUpScreen> createState() => _BasicSignUpScreenState();
}

class _BasicSignUpScreenState extends State<BasicSignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      GoRouter.of(context).go(RouteUri.basicSignIn);
    } else {
      debugPrint('Validation failed');
    }
  }

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
                                  // sign in form
                                  Text(
                                    'Create New Account',
                                    style: TextStyle(
                                      color: themeData.colorScheme.primary,
                                      fontSize: kBodyLarge,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: kDefaultPadding / 2),
                                  const Text(
                                    'Unlock your Ademin free account now',
                                  ),
                                  const SizedBox(height: 1.5 * kDefaultPadding),
                                  FormBuilder(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email',
                                          style: TextStyle(
                                            color:
                                                themeData.colorScheme.onSurface,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: kDefaultPadding / 2,
                                        ),

                                        //Email
                                        CustomTextFormField(
                                          hintText: "Enter email",
                                          validator:
                                              FormBuilderValidators.email(),
                                          suffixIcon: Icons.email_outlined,
                                        ),

                                        const SizedBox(height: kDefaultPadding),

                                        Text(
                                          'Username',
                                          style: TextStyle(
                                            color:
                                                themeData.colorScheme.onSurface,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        const SizedBox(
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
                                          suffixIcon: Icons.person_outline,
                                        ),

                                        const SizedBox(height: kDefaultPadding),

                                        Text(
                                          'Password',
                                          style: TextStyle(
                                            color:
                                                themeData.colorScheme.onSurface,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: kDefaultPadding / 2,
                                        ),

                                        //Password
                                        CustomTextFormField(
                                          hintText: 'Enter password',
                                          isPassword: true,
                                          validator: FormBuilderValidators.password(
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

                                        const SizedBox(height: kDefaultPadding),

                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: kTextColor,
                                              fontSize: kBodyMedium,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text:
                                                    "By registering you agree to the Ademin ",
                                              ),
                                              TextSpan(
                                                text: 'Terms of Use',
                                                style: TextStyle(
                                                  color: themeData
                                                      .colorScheme
                                                      .primary,
                                                  fontWeight: FontWeight.w600,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(
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
                                  const SizedBox(height: 1.5 * kDefaultPadding),

                                  // social media sign in
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: themeData
                                              .colorScheme
                                              .outline, // Line color
                                          thickness: 0.3, // Line thickness
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding,
                                        ),
                                        child: Text(
                                          'Create account with',
                                          style: TextStyle(
                                            color:
                                                themeData.colorScheme.onSurface,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: themeData
                                              .colorScheme
                                              .outline, // Line color
                                          thickness: 0.3, // Line thickness
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 1.5 * kDefaultPadding),

                                  SocialLogin(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 1.5 * kDefaultPadding),
                      // sign up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account ? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).go(RouteUri.basicSignIn);
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
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
