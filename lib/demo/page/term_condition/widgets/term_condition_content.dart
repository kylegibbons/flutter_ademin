import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/widgets/base_ui/typography.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class TermConditionContent extends StatefulWidget {
  const TermConditionContent({super.key});

  @override
  State<TermConditionContent> createState() => _TermConditionContentState();
}

class _TermConditionContentState extends State<TermConditionContent> {
  late Future<String> _privacyPolicy;

  @override
  void initState() {
    super.initState();
    _privacyPolicy = rootBundle.loadString(
      'assets/mds/pages/terms_conditions.md', // load data
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2 * kDefaultPadding),
      child: FutureBuilder<String>(
        future: _privacyPolicy,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Failed to load terms and conditions.'));
          }

          return Markdown(
            data: snapshot.data ?? '',
            styleSheet: DocMarkdownStyle.sheet(context),
            padding: const EdgeInsets.all(kDefaultPadding),
            selectable: true,
            shrinkWrap: true,
          );
        },
      ),
    );
  }
}
