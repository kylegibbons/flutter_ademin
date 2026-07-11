import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/dialog.dart';
import 'package:flutter_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutter_ademin/widgets/helper/card_description.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:flutter_ademin/widgets/base_ui/toast.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class ShowCodeCard extends StatefulWidget {
  final Widget uiView;
  final String? codeView; // Optional codeView argument
  final String cardTitle;
  final String? description;
  final double height;

  const ShowCodeCard({
    super.key,
    required this.cardTitle,
    this.description,
    required this.uiView,
    this.codeView, // Now optional
    this.height = 600,
  });

  @override
  State<ShowCodeCard> createState() => _ShowCodeCardState();
}

class _ShowCodeCardState extends State<ShowCodeCard> {
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

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // card header
          CardHeader(
            kText: widget.cardTitle,
            kWidget: widget.codeView != null
                ? Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: kDefaultPadding,
                    ),
                    child: Row(
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
                    ),
                  )
                : null,
          ),
          const Divider(height: 0, thickness: 0.6),

          // description
          if (widget.description != null)
            Padding(
              padding: const EdgeInsets.only(
                top: kDefaultPadding,
                left: kDefaultPadding,
                right: kDefaultPadding,
              ),
              child: CardDescription(content: widget.description),
            ),

          // code view && uiview
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            // Conditionally show the code view or the UI view based on the showCode flag and whether codeView is provided
            child: (_showCode && widget.codeView != null)
                ? CodeView(
                    codeView: widget.codeView,
                    syntaxTheme: syntaxTheme,
                    height: widget.height,
                  )
                : widget.uiView,
          ),
        ],
      ),
    );
  }
}

// Code View

class CodeView extends StatelessWidget {
  const CodeView({
    super.key,
    required this.syntaxTheme,
    required this.height,
    this.codeView,
  });

  final SyntaxTheme syntaxTheme;
  final double height;
  final String? codeView;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: themeData.colorScheme.outline,
          width: outlineWidth,
        ),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Column(
        children: [
          // utility button
          Container(
            decoration: BoxDecoration(
              color: kTableHeaderColor,
              border: Border(
                bottom: BorderSide(
                  color: themeData.colorScheme.outline,
                  width: outlineWidth,
                ),
              ),
            ),
            child: Row(
              children: [
                showCodeTitle(themeData),
                Spacer(),
                // fullscreen button
                Tooltip(
                  message: 'View Fullscreen',
                  child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: CustomDialog(
                              isFullScreen: true,
                              content: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: themeData.colorScheme.outline,
                                    width: outlineWidth,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    defaultRadius,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: kTableHeaderColor,
                                        border: Border(
                                          bottom: BorderSide(
                                            color:
                                                themeData.colorScheme.outline,
                                            width: outlineWidth,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          showCodeTitle(themeData),
                                          Spacer(),
                                          Tooltip(
                                            message: 'Exit Fullscreen',
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                kDefaultPadding / 2,
                                              ),
                                              child: InkWell(
                                                child: Icon(
                                                  Icons
                                                      .fullscreen_exit_outlined,
                                                  size: 20,
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ),
                                          copyButton(context),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height -
                                          119,
                                      child: syntaxView(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.fullscreen_outlined, size: 20),
                    ),
                  ),
                ),
                // copy button
                copyButton(context),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: height - 39,
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadiusGeometry.only(
                bottomLeft: Radius.circular(defaultRadius),
                bottomRight: Radius.circular(defaultRadius),
              ),
              child: syntaxView(),
            ),
          ),
        ],
      ),
    );
  }

  Padding showCodeTitle(ThemeData themeData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Text(
        "dart",
        style: TextStyle(color: themeData.colorScheme.onSurface),
      ),
    );
  }

  SyntaxView syntaxView() {
    return SyntaxView(
      code: codeView ?? '', // Safe null check
      syntax: Syntax.DART,
      syntaxTheme: syntaxTheme,
      fontSize: kBodyMedium,
      withZoom: true,
      withLinesCount: true,
      expanded: true,
      selectable: true,
    );
  }

  Tooltip copyButton(BuildContext context) {
    return Tooltip(
      message: 'Copy Code',
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: InkWell(
          onTap: () {
            if (codeView != null) {
              Clipboard.setData(ClipboardData(text: codeView!));

              // success message
              Toast.showToast(
                context: context,
                icon: Icons.check_circle_outline,
                message: 'Code copied to clipboard!',
                color: kPrimaryColor,
                alignment: Alignment.topRight,
                bottomBorder: true,
                showCloseButton: true,
              );
            }
          },
          child: Icon(Icons.copy, size: 16),
        ),
      ),
    );
  }
}
