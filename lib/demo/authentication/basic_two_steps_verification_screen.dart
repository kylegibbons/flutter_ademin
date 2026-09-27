import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/animation/animated_icon.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/public_master_layout/public_footer.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class BasicTwoStepsVerificationScreen extends StatefulWidget {
  const BasicTwoStepsVerificationScreen({super.key});

  @override
  State<BasicTwoStepsVerificationScreen> createState() =>
      _BasicTwoStepsVerificationScreenState();
}

class _BasicTwoStepsVerificationScreenState
    extends State<BasicTwoStepsVerificationScreen> {
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
                                  const SizedBox(height: 1.5 * kDefaultPadding),
                                  CustomAnimatedIcon(
                                    symbol: Symbols.key_sharp,
                                    color: kPrimaryColor,
                                    size: 72,
                                    duration: const Duration(seconds: 2),
                                    animationType: LoopingAnimationType.bounce,
                                    weight: 300,
                                  ),
                                  const SizedBox(height: 1.5 * kDefaultPadding),
                                  Text(
                                    'Verify Your Email',
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                      fontSize: kBodyLarge,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: kDefaultPadding / 2),
                                  Wrap(
                                    children: [
                                      Text(
                                        'Plese enter the 4-digit code sent to ',
                                      ),
                                      Text(
                                        'u**********h@gmail.com',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              themeData.colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2 * kDefaultPadding),
                                  const FourDigitInputField(),
                                  const SizedBox(height: 2 * kDefaultPadding),
                                  FlatButton(
                                    kText: 'Confirm',
                                    kTextColor: Colors.white,
                                    bgColor: kSuccessColor,
                                    isFullWidth: true,
                                    onPressed: () {
                                      GoRouter.of(context).go(RouteUri.home);
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

// four digit input field

class FourDigitInputField extends StatefulWidget {
  const FourDigitInputField({super.key});

  @override
  State<FourDigitInputField> createState() => _FourDigitInputFieldState();
}

class _FourDigitInputFieldState extends State<FourDigitInputField> {
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (_) => FocusNode(),
    growable: false,
  );
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
    growable: false,
  );

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var ctrl in _controllers) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(4, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: _buildInput(index),
          ),
        );
      }),
    );
  }

  Widget _buildInput(int index) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: kTableHeaderColor,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 1.5 * kBodyLarge,
          fontWeight: FontWeight.w600,
          color: themeData.colorScheme.onSurface,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(counterText: ''),
        onChanged: (value) => _onChanged(value, index),
      ),
    );
  }
}
