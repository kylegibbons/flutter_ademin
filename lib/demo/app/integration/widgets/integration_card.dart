import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/integration/dialogs/details_integration_form.dart';
import 'package:flutter_ademin/demo/app/integration/dialogs/edit_integration_form.dart';
import 'package:flutter_ademin/demo/app/integration/integration_data.dart';
import 'package:flutter_ademin/demo/app/integration/integration_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/dialog.dart';
import 'package:flutter_ademin/widgets/base_ui/popup_menu.dart';
import 'package:flutter_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutter_svg/svg.dart';

class IntegrationCardGrid extends StatefulWidget {
  const IntegrationCardGrid({super.key});

  @override
  State<IntegrationCardGrid> createState() => _IntegrationCardGridState();
}

class _IntegrationCardGridState extends State<IntegrationCardGrid> {
  // integration edit modal
  void _showEditIntegrationDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: "Integration settings",
      showCloseButton: true, // show close button
      content: EditIntegrationForm(apps: mockupIntegrations),
    );
  }

  // integration details modal
  void _showDetailsIntegrationDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: "Integration details",
      showCloseButton: true, // show close button
      content: DetailsIntegrationForm(apps: mockupIntegrations),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrap(
      breakpoints: {
        kScreenWidthSm: 1, // set breakpoint for 1 column layout,
        kScreenWidthMd: 2, // set breakpoint for 2 column layout
        kScreenWidthLg: 3, // set breakpoint for 3 column layout
      },
      columnRatios: const [1 / 3, 1 / 3, 1 / 3],
      spacing: kDefaultPadding, // spacing
      runSpacing: kDefaultPadding, // run spacing
      children: mockupIntegrationsFullColor.map((item) {
        return buildIntegrationCard(item);
      }).toList(),
    );
  }

  Widget buildIntegrationCard(Integration app) {
    final themeData = Theme.of(context);
    return Card(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      app.logoUrl,
                      width: 28,
                      height: 28,
                      fit: BoxFit
                          .contain, // Ensures the logo maintains aspect ratio
                      placeholderBuilder: (context) => SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    SizedBox(height: 1.5 * kDefaultPadding),
                    Text(
                      app.name,
                      style: TextStyle(
                        fontSize: kBodyLarge,
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 0.8 * kDefaultPadding),
                    Text(app.description),
                  ],
                ),
              ),
              Divider(height: 0, thickness: outlineWidth),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: 0.75 * kDefaultPadding,
                ),
                child: Row(
                  children: [
                    // Settings Button
                    CustomIconButton(
                      icon: Icons.settings_outlined,
                      isOutlined: true,
                      onTap: () {
                        _showEditIntegrationDialog(context);
                      },
                    ),
                    SizedBox(width: kDefaultPadding / 2),

                    // Details Button
                    CustomOutlinedButton(
                      kText: 'Details',
                      textColor: kTextColor,
                      outlineColor: themeData.colorScheme.outline,
                      onPressed: () {
                        _showDetailsIntegrationDialog(context);
                      },
                    ),
                    Spacer(),

                    // Toggle Switch
                    CustomSwitch(
                      value: app.isEnabled,
                      activeColor: kSecondaryColor,
                      onChanged: (val) {
                        setState(() {
                          app.isEnabled = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          Align(
            alignment: AlignmentDirectional.topEnd,
            child: CustomPopupMenu<String>(
              onSelected: (value) => debugPrint('Selected: $value'),
              items: [
                // share menu
                PopupMenuItemData(
                  value: 'export',
                  text: 'Export',
                  icon: Icons.download_outlined,
                ),

                // delete menu
                PopupMenuItemData(
                  value: 'remove',
                  text: 'Remove',
                  icon: Icons.delete_outline,
                  iconColor: kErrorColor,
                  textStyle: TextStyle(color: kErrorColor),
                ),
              ],

              // icon button
              child: CustomIconButton(
                icon: Icons.more_vert,
                tooltipMessage: 'Options',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
