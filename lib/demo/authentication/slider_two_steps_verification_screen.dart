import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/authentication/widgets/slider_section.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/animation/animated_icon.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/public_master_layout/public_footer.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SliderTwoStepsVerificationScreen extends StatefulWidget {
  const SliderTwoStepsVerificationScreen({super.key});

  @override
  State<SliderTwoStepsVerificationScreen> createState() =>
      _SliderTwoStepsVerificationScreenState();
}

class _SliderTwoStepsVerificationScreenState
    extends State<SliderTwoStepsVerificationScreen> {
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
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
                                        ? 440
                                        : 288 + kDefaultPadding,
                                  ),

                                  // form
                                  Container(
                                    width: mediaQueryData.size.width >= 960
                                        ? 480
                                        : double.infinity,
                                    height: 440,
                                    decoration: BoxDecoration(
                                      color: themeData.colorScheme.surface,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 3 * kDefaultPadding,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Spacer(),
                                          CustomAnimatedIcon(
                                            symbol: Symbols.key_sharp,
                                            color: kPrimaryColor,
                                            size: 72,
                                            duration: const Duration(
                                              seconds: 2,
                                            ),
                                            animationType:
                                                LoopingAnimationType.bounce,
                                            weight: 300,
                                          ),
                                          Spacer(),
                                          Text(
                                            'Verify Your Email',
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
                                          Wrap(
                                            alignment: WrapAlignment.center,
                                            children: [
                                              Text(
                                                'Plese enter the 4-digit code sent to ',
                                              ),
                                              Text(
                                                'u**********h@gmail.com',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: themeData
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 2 * kDefaultPadding,
                                          ),
                                          const FourDigitInputField(),
                                          const SizedBox(
                                            height: 2 * kDefaultPadding,
                                          ),
                                          FlatButton(
                                            kText: 'Confirm',
                                            kTextColor: Colors.white,
                                            bgColor: kSuccessColor,
                                            isFullWidth: true,
                                            onPressed: () {
                                              GoRouter.of(
                                                context,
                                              ).go(RouteUri.home);
                                            },
                                          ),
                                          const SizedBox(
                                            height: 3 * kDefaultPadding,
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
