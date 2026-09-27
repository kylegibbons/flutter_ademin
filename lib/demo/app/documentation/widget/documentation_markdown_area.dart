import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/documentation/documentation_models.dart';
import 'package:flutkit_ademin/demo/app/documentation/widget/syntaxhighlighter.dart';
import 'package:flutkit_ademin/widgets/base_ui/typography.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class DocumentationMarkdownArea extends StatelessWidget {
  final DocItem? selectedDoc;

  const DocumentationMarkdownArea({
    super.key,
    required this.selectedDoc,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedDoc == null) {
      return const SizedBox();
    }

    return FutureBuilder<String>(
      future: rootBundle.loadString(selectedDoc!.assetPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return SelectionArea(
          child: Markdown(
            data: snapshot.data ?? '',
            padding: const EdgeInsets.all(kDefaultPadding),
            styleSheet: DocMarkdownStyle.sheet(context),
            builders: {
              'pre': HighlightBuilder(
                isDark: Theme.of(context).brightness == Brightness.dark,
              ),
              'code': InlineCodeBuilder(
                Theme.of(context).brightness == Brightness.dark,
              ),
            },
          ),
        );
      },
    );
  }
}
