// Documents Content

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/profile/widgets/profile_documents_table.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';

class DocumentsContent extends StatelessWidget {
  const DocumentsContent({super.key, required this.themeData});

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CardHeader(
            kText: 'Documents',
            showDivider: false,
            kWidget: Padding(
              padding: const EdgeInsetsDirectional.only(end: kDefaultPadding),
              child: FancyIconButton(
                kText: 'Upload File',
                bgColor: kErrorColor,
                kTextColor: Colors.white,
                onPressed: () {},
                kLeadingIcon: Icons.cloud_upload_outlined,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: DocumentsTable(),
          ),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
