import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:fleather/fleather.dart' as fleather_editor;

//Quill Editor Example
class QuillEditorCustom extends StatefulWidget {
  const QuillEditorCustom({
    super.key,
    this.controller,
    this.onValidate,
    this.height = 400.0, // Default height if not specified
  });

  final QuillController? controller;
  final String? Function(String)? onValidate; // Validation callback
  final double height;

  @override
  State<QuillEditorCustom> createState() => _QuillEditorCustomState();
}

class _QuillEditorCustomState extends State<QuillEditorCustom> {
  late QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? QuillController.basic();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      // Only dispose if it was created internally
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: themeData.colorScheme.outline,
          width: outlineWidth,
        ),
        borderRadius: BorderRadius.circular(defaultRadius),
        color: themeData.colorScheme.surfaceContainerHighest,
      ),
      height: widget.height,
      child: Column(
        children: [
          IconTheme(
            data: IconThemeData(color: themeData.colorScheme.onSurface),
            child: QuillSimpleToolbar(
              controller: _controller,
              config: QuillSimpleToolbarConfig(
                toolbarIconAlignment: WrapAlignment.start,
                decoration: BoxDecoration(),
                iconTheme: QuillIconTheme(
                  iconButtonUnselectedData: IconButtonData(
                    color: themeData.colorScheme.onSurface,
                  ),
                  iconButtonSelectedData: IconButtonData(),
                ),
                buttonOptions: const QuillSimpleToolbarButtonOptions(
                  base: QuillToolbarBaseButtonOptions(
                    iconSize: 12, // Set your desired icon size here
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 0,
            color: themeData.colorScheme.outline,
            thickness: outlineWidth,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: themeData.colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(defaultRadius),
                  bottomRight: Radius.circular(defaultRadius),
                ),
              ),
              child: QuillEditor.basic(
                controller: _controller,
                config: QuillEditorConfig(
                  // padding: EdgeInsets.all(kDefaultPadding / 2),
                  customStyles: DefaultStyles(
                    paragraph: DefaultTextBlockStyle(
                      TextStyle(
                        color: themeData.colorScheme.onSurface,
                        // fontSize:
                        //     kBodyMedium, // Bootstrap's 1rem (16px) for body text
                      ),
                      HorizontalSpacing(8, 8), // Similar to mx-2
                      VerticalSpacing(8, 8), // Similar to my-2
                      VerticalSpacing(8, 8),
                      BoxDecoration(),
                    ),
                    h1: DefaultTextBlockStyle(
                      TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontSize: kHeadlineLarge, // Bootstrap h1: ~2rem (32px)
                        fontWeight: FontWeight.bold,
                      ),
                      HorizontalSpacing(8, 8),
                      VerticalSpacing(12, 12), // Increased spacing for headers
                      VerticalSpacing(12, 12),
                      BoxDecoration(),
                    ),
                    h2: DefaultTextBlockStyle(
                      TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontSize:
                            kHeadlineMedium, // Bootstrap h2: ~1.5rem (24px)
                        fontWeight: FontWeight.bold,
                      ),
                      HorizontalSpacing(8, 8),
                      VerticalSpacing(10, 10),
                      VerticalSpacing(10, 10),
                      BoxDecoration(),
                    ),

                    // Add h3, code, or other styles if needed
                    h3: DefaultTextBlockStyle(
                      TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontSize:
                            kHeadlineSmall, // Bootstrap h2: ~1.5rem (24px)
                        fontWeight: FontWeight.bold,
                      ),
                      HorizontalSpacing(8, 8),
                      VerticalSpacing(10, 10),
                      VerticalSpacing(10, 10),
                      BoxDecoration(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.onValidate != null)
            Text(
              widget.onValidate!(_controller.document.toPlainText()) ?? '',
              style: TextStyle(color: kErrorColor),
            ),
        ],
      ),
    );
  }
}

//Fleather Editor

class FleatherEditorCustom extends StatefulWidget {
  const FleatherEditorCustom({
    super.key,
    this.height = 400.0,
    this.controller,
    this.onValidate,
    this.autovalidateMode,
  });

  final double height;
  final fleather_editor.FleatherController? controller;
  final FormFieldValidator<String>? onValidate; // Validation callback
  final AutovalidateMode? autovalidateMode;

  @override
  State<FleatherEditorCustom> createState() => _FleatherEditorCustomState();
}

class _FleatherEditorCustomState extends State<FleatherEditorCustom> {
  final GlobalKey<FormFieldState<String>> _formFieldKey =
      GlobalKey<FormFieldState<String>>();
  late fleather_editor.FleatherController _controller;
  late final FocusNode _focusNode;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ??
        fleather_editor.FleatherController(
          document: fleather_editor.ParchmentDocument(),
        );
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    _controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(covariant FleatherEditorCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      if (widget.controller != null) {
        _controller = widget.controller!;
      }
      _controller.addListener(_onControllerChanged);
      _formFieldKey.currentState?.didChange(_controller.document.toPlainText());
    }
  }

  void _onControllerChanged() {
    final fieldState = _formFieldKey.currentState;
    fieldState?.didChange(_controller.document.toPlainText());
    if (widget.autovalidateMode != null &&
        widget.autovalidateMode != AutovalidateMode.disabled) {
      fieldState?.validate();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return FormField<String>(
      key: _formFieldKey,
      validator: widget.onValidate,
      autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
      initialValue: _controller.document.toPlainText(),
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: state.hasError
                      ? kErrorColor
                      : themeData.colorScheme.outline,
                  width: outlineWidth,
                ),
                borderRadius: BorderRadius.circular(defaultRadius),
                color: themeData.colorScheme.surfaceContainerHighest,
              ),
              height: widget.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconTheme(
                    data: IconThemeData(color: themeData.colorScheme.onSurface),
                    child: fleather_editor.FleatherToolbar.basic(
                      controller: _controller,
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: themeData.colorScheme.outline,
                    thickness: outlineWidth,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeData.colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(defaultRadius),
                          bottomRight: Radius.circular(defaultRadius),
                        ),
                      ),

                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                        child: fleather_editor.FleatherTheme(
                          data: fleather_editor.FleatherThemeData(
                            bold: TextStyle(fontWeight: FontWeight.bold),
                            italic: TextStyle(fontStyle: FontStyle.italic),
                            underline: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            strikethrough: TextStyle(
                              decoration: TextDecoration.lineThrough,
                            ),
                            link: TextStyle(
                              decoration: TextDecoration.underline,
                            ),

                            // Inline Code Style
                            inlineCode: fleather_editor.InlineCodeThemeData(
                              backgroundColor: Colors.grey[200]!,
                              radius: Radius.circular(defaultRadius),
                              style: TextStyle(fontFamily: 'Courier'),
                            ),

                            // Paragraph (Normal Text)
                            paragraph: fleather_editor.TextBlockTheme(
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                              ),
                              spacing: fleather_editor.VerticalSpacing(
                                // top: kDefaultPadding/2,
                                bottom: kDefaultPadding / 2,
                              ),
                            ),

                            // Heading Styles
                            heading1: fleather_editor.TextBlockTheme(
                              style: TextStyle(
                                fontSize: kHeadlineLarge,
                                fontWeight: FontWeight.bold,
                              ),
                              spacing: fleather_editor.VerticalSpacing(
                                top: 12.0,
                                bottom: 12.0,
                              ),
                            ),
                            heading2: fleather_editor.TextBlockTheme(
                              style: TextStyle(
                                fontSize: kHeadlineMedium,
                                fontWeight: FontWeight.bold,
                              ),
                              spacing: fleather_editor.VerticalSpacing(
                                top: 10.0,
                                bottom: 10.0,
                              ),
                            ),
                            heading3: fleather_editor.TextBlockTheme(
                              style: TextStyle(
                                fontSize: kHeadlineSmall,
                                fontWeight: FontWeight.w600,
                              ),
                              spacing: fleather_editor.VerticalSpacing(
                                top: kDefaultPadding / 2,
                                bottom: kDefaultPadding / 2,
                              ),
                            ),
                            heading4: fleather_editor.TextBlockTheme(
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                              spacing: fleather_editor.VerticalSpacing(
                                top: 6.0,
                                bottom: 6.0,
                              ),
                            ),
                            heading5: fleather_editor.TextBlockTheme(
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                              spacing: fleather_editor.VerticalSpacing(
                                top: 4.0,
                                bottom: 4.0,
                              ),
                            ),
                            heading6: fleather_editor.TextBlockTheme(
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                              spacing: fleather_editor.VerticalSpacing(
                                top: 2.0,
                                bottom: 2.0,
                              ),
                            ),

                            // Quote Style
                            quote: fleather_editor.TextBlockTheme(
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                              spacing: fleather_editor.VerticalSpacing(
                                top: kDefaultPadding / 2,
                                bottom: kDefaultPadding / 2,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.grey,
                                    width: 4.0,
                                  ),
                                ),
                              ),
                            ),

                            // Lists Style
                            lists: fleather_editor.TextBlockTheme(
                              style: TextStyle(fontSize: kBodyMedium),
                              spacing: fleather_editor.VerticalSpacing(
                                top: kDefaultPadding / 2,
                                bottom: kDefaultPadding / 2,
                              ),
                            ),

                            // Code Block Style
                            code: fleather_editor.TextBlockTheme(
                              style: TextStyle(
                                fontFamily: 'Courier',
                                color: Colors.grey,
                              ),
                              spacing: fleather_editor.VerticalSpacing(
                                top: kDefaultPadding / 2,
                                bottom: kDefaultPadding / 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),

                            // Horizontal Rule Style
                            horizontalRule:
                                fleather_editor.HorizontalRuleThemeData(
                                  thickness: 1.5,
                                  color: Colors.black.withValues(alpha: 0.1),
                                  height: 12,
                                ),
                          ),
                          child: fleather_editor.FleatherEditor(
                            controller: _controller,
                            focusNode: _focusNode,
                            scrollController: _scrollController,
                            padding: EdgeInsets.all(kDefaultPadding),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: kDefaultPadding,
                  top: kDefaultPadding / 2,
                ),
                child: Text(
                  state.errorText ?? '',
                  style: TextStyle(color: kErrorColor, fontSize: kBodySmall),
                ),
              ),
          ],
        );
      },
    );
  }
}


// class QuillEditorCustom extends StatefulWidget {
//   const QuillEditorCustom({
//     super.key,
//     this.controller,
//     this.onValidate,
//     this.height = 400.0,
//     this.minimizeToolbar = false,
//   });

//   final QuillController? controller;
//   final String? Function(String)? onValidate;
//   final double height;
//   final bool minimizeToolbar;

//   @override
//   State<QuillEditorCustom> createState() => _QuillEditorCustomState();
// }

// class _QuillEditorCustomState extends State<QuillEditorCustom> {
//   // State lokal untuk mengontrol expand/collapse
//   bool _isMaximized = false;

//   @override
//   Widget build(BuildContext context) {
//     // Tentukan tinggi berdasarkan state
//     double currentHeight = _isMaximized ? widget.height : 150.0;
//     final themeData = Theme.of(context);

//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: themeData.colorScheme.outline,
//           width: outlineWidth,
//         ),
//         borderRadius: BorderRadius.circular(defaultRadius),
//         color: themeData.colorScheme.surfaceContainerHighest,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Tombol Toggle Manual
//               IconButton(
//                 icon: Icon(
//                   _isMaximized ? Icons.fullscreen_exit : Icons.fullscreen,
//                 ),
//                 tooltip: _isMaximized ? "Minimize" : "Maximize",
//                 onPressed: () {
//                   setState(() {
//                     _isMaximized = !_isMaximized;
//                   });
//                 },
//               ),
//             ],
//           ),

//           // Toolbar
//           QuillSimpleToolbar(
//             controller: widget.controller!,
//             config: QuillSimpleToolbarConfig(
//               toolbarIconAlignment: WrapAlignment.start,
//               iconTheme: QuillIconTheme(
//                 iconButtonUnselectedData: IconButtonData(
//                   color: themeData.colorScheme.onSurface,
//                 ),
//                 iconButtonSelectedData: IconButtonData(),
//               ),
//               buttonOptions: const QuillSimpleToolbarButtonOptions(
//                 base: QuillToolbarBaseButtonOptions(iconSize: 12),
//               ),
//               showFontFamily: _isMaximized && !widget.minimizeToolbar,
//               showFontSize: _isMaximized && !widget.minimizeToolbar,
//               showBoldButton: _isMaximized && !widget.minimizeToolbar,
//               showItalicButton: _isMaximized && !widget.minimizeToolbar,
//               showUnderLineButton: _isMaximized && !widget.minimizeToolbar,
//               showListNumbers: _isMaximized && !widget.minimizeToolbar,
//               showListBullets: _isMaximized && !widget.minimizeToolbar,
//               multiRowsDisplay: true,
//             ),
//           ),

//           // Area Editor dengan Animasi Transisi
//           Container(
//             height: currentHeight,
//             padding: EdgeInsets.all(kDefaultPadding / 2),

//             child: QuillEditor.basic(
//               controller: widget.controller!,
//               config: QuillEditorConfig(
//                 // placeholder: 'Tambahkan deskripsi...',
//                 scrollable: true,
//                 autoFocus: false,
//                 customStyles: DefaultStyles(
//                   paragraph: DefaultTextBlockStyle(
//                     TextStyle(
//                       color: themeData.colorScheme.onSurface,
//                       // fontSize:
//                       //     kBodyMedium, // Bootstrap's 1rem (16px) for body text
//                     ),
//                     HorizontalSpacing(8, 8), // Similar to mx-2
//                     VerticalSpacing(8, 8), // Similar to my-2
//                     VerticalSpacing(8, 8),
//                     BoxDecoration(),
//                   ),
//                   h1: DefaultTextBlockStyle(
//                     TextStyle(
//                       color: themeData.colorScheme.onSurface,
//                       fontSize: kHeadlineLarge, // Bootstrap h1: ~2rem (32px)
//                       fontWeight: FontWeight.bold,
//                     ),
//                     HorizontalSpacing(8, 8),
//                     VerticalSpacing(12, 12), // Increased spacing for headers
//                     VerticalSpacing(12, 12),
//                     BoxDecoration(),
//                   ),
//                   h2: DefaultTextBlockStyle(
//                     TextStyle(
//                       color: themeData.colorScheme.onSurface,
//                       fontSize: kHeadlineMedium, // Bootstrap h2: ~1.5rem (24px)
//                       fontWeight: FontWeight.bold,
//                     ),
//                     HorizontalSpacing(8, 8),
//                     VerticalSpacing(10, 10),
//                     VerticalSpacing(10, 10),
//                     BoxDecoration(),
//                   ),

//                   // Add h3, code, or other styles if needed
//                   h3: DefaultTextBlockStyle(
//                     TextStyle(
//                       color: themeData.colorScheme.onSurface,
//                       fontSize: kHeadlineSmall, // Bootstrap h2: ~1.5rem (24px)
//                       fontWeight: FontWeight.bold,
//                     ),
//                     HorizontalSpacing(8, 8),
//                     VerticalSpacing(10, 10),
//                     VerticalSpacing(10, 10),
//                     BoxDecoration(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }