import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutter_ademin/widgets/helper/card_description.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class ShowCodeContainer extends StatefulWidget {
  final Widget uiView;
  final String? codeView; // Optional codeView argument
  final String title;
  final String? description;
  final double height;

  const ShowCodeContainer({
    super.key,
    required this.title,
    this.description,
    required this.uiView,
    this.codeView, // Now optional
    this.height = 600,
  });

  @override
  State<ShowCodeContainer> createState() => _ShowCodeContainerState();
}

class _ShowCodeContainerState extends State<ShowCodeContainer> {
  bool _showCode = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final isMobile = mediaQueryData.size.width < kScreenWidthSm;

    bool isDarkMode = themeData.brightness == Brightness.dark;

    SyntaxTheme syntaxTheme = isDarkMode
        ? SyntaxTheme.vscodeDark()
        : SyntaxTheme.vscodeLight();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // card header
        CardHeader(
          kText: widget.title,
          isInsideCard: false,
          showDivider: false,
          kWidget: widget.codeView != null
              ? Row(
                  children: [
                    !isMobile
                        ? Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: kDefaultPadding / 2,
                            ),
                            child: const Text(
                              'Show code',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          )
                        : SizedBox.shrink(),
                    CustomSwitch(
                      value: _showCode,
                      onChanged: (bool value) {
                        setState(() {
                          _showCode = value;
                        });
                      },
                      activeColor: themeData.colorScheme.primary,
                      inactiveColor: kTextColor,
                      isOutlined: true,
                    ),
                  ],
                )
              : null,
        ),
        if (widget.description != null)
          Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding),
            child: CardDescription(content: widget.description),
          ),
        (_showCode && widget.codeView != null)
            ? CodeView(
                codeView: widget.codeView,
                syntaxTheme: syntaxTheme,
                height: widget.height,
              )
            : widget.uiView,
      ],
    );
  }
}
