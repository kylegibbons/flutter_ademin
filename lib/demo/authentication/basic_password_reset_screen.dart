import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/animation/animated_icon.dart';
import 'package:flutkit_ademin/widgets/base_ui/alert.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/public_master_layout/public_footer.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class BasicPasswordResetScreen extends StatefulWidget {
  const BasicPasswordResetScreen({super.key});

  @override
  State<BasicPasswordResetScreen> createState() =>
      _BasicPasswordResetScreenState();
}

class _BasicPasswordResetScreenState extends State<BasicPasswordResetScreen> {
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
                                  Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: themeData.colorScheme.primary,
                                      fontSize: kBodyLarge,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: kDefaultPadding / 2),
                                  const Text('Reset your password with Ademin'),
                                  const SizedBox(height: 1.5 * kDefaultPadding),
                                  CustomAnimatedIcon(
                                    symbol: Symbols.lock_reset_sharp,
                                    color: kSuccessColor,
                                    size: 86,
                                    duration: const Duration(seconds: 3),
                                    animationType: LoopingAnimationType.rotate,
                                    weight: 300,
                                  ),
                                  const SizedBox(height: 1.5 * kDefaultPadding),
                                  Alert(
                                    htmlContent:
                                        "Enter your email and we'll send you the instructions!",
                                    kColor: kWarningColor,
                                    isOutlined: false,
                                  ),
                                  const SizedBox(height: kDefaultPadding),
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

                                        const SizedBox(height: kDefaultPadding),

                                        //Email
                                        CustomTextFormField(
                                          hintText: "Enter email",
                                          validator:
                                              FormBuilderValidators.email(),
                                          suffixIcon: Icons.email_outlined,
                                        ),

                                        const SizedBox(
                                          height: 2 * kDefaultPadding,
                                        ),

                                        //Sign in button
                                        FlatButton(
                                          kText: 'Send Reset Link',
                                          kTextColor: Colors.white,
                                          bgColor: kSuccessColor,
                                          isFullWidth: true,
                                          onPressed: _submit,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 1.5 * kDefaultPadding),

                      // sign in link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Never mind, I remember it now — ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).go(RouteUri.basicSignIn);
                            },
                            child: const Text(
                              'Click here',
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
