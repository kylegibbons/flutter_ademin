import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/profile/profile_data.dart';
import 'package:flutkit_ademin/demo/page/profile/profile_models.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          CardHeader(kText: 'Personal Information', showDivider: false),

          // info row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: InfoListView(items: userInfoData),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}

class InfoListView extends StatelessWidget {
  final List<InfoItem> items;

  const InfoListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return InfoRow(label: item.label, value: item.value);
      },
    );
  }
}
