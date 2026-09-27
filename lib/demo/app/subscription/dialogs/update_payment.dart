import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/subscription/dialogs/add_edit_credit_card_form.dart';
import 'package:flutkit_ademin/demo/app/subscription/subscription_data.dart';
import 'package:flutkit_ademin/demo/app/subscription/subscription_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/dialog.dart';
import 'package:flutkit_ademin/widgets/base_ui/popup_menu.dart';

class UpdatePaymentDialog extends StatefulWidget {
  final BuildContext parentContext;

  const UpdatePaymentDialog({super.key, required this.parentContext});

  @override
  State<UpdatePaymentDialog> createState() => _UpdatePaymentDialogState();
}

class _UpdatePaymentDialogState extends State<UpdatePaymentDialog> {
  late List<PaymentMethod> methods;

  @override
  void initState() {
    super.initState();
    methods = List<PaymentMethod>.from(existingPaymentMethods);
  }

  void _openAddEditCardForm({PaymentMethod? method, int? index}) {
    showCustomDialog(
      context: widget.parentContext,
      title: method == null ? "Add Card" : "Edit Card",
      showCloseButton: true,
      width: 640,
      content: AddEditCardFormDialog(
        method: method,
        onSaved: (savedMethod) {
          setState(() {
            if (index != null) {
              methods[index] = savedMethod.copyWith(
                isDefault: methods[index].isDefault,
              );
              return;
            }

            methods.add(
              savedMethod.copyWith(
                isDefault: methods.every((item) => !item.isDefault),
              ),
            );
          });
        },
      ),
    );
  }

  void _handleAction(PaymentMethodAction action, int index) {
    switch (action) {
      case PaymentMethodAction.setDefault:
        setState(() {
          methods = methods
              .asMap()
              .entries
              .map(
                (entry) => entry.value.copyWith(isDefault: entry.key == index),
              )
              .toList();
        });
        break;
      case PaymentMethodAction.edit:
        _openAddEditCardForm(method: methods[index], index: index);
        break;
      case PaymentMethodAction.remove:
        setState(() {
          final removedWasDefault = methods[index].isDefault;
          methods.removeAt(index);

          if (removedWasDefault && methods.isNotEmpty) {
            methods[0] = methods[0].copyWith(isDefault: true);
          }
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select a payment method for your next subscription renewal.",
            style: TextStyle(color: themeData.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: kDefaultPadding),
          Column(
            children: List.generate(methods.length, (index) {
              final item = methods[index];

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == methods.length - 1 ? 0 : kDefaultPadding,
                ),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        border: Border.all(
                          color: item.isDefault
                              ? kSecondaryColor.withValues(alpha: 0.25)
                              : themeData.colorScheme.outline,
                          width: outlineWidth,
                        ),
                        color: item.isDefault
                            ? kSecondaryColor.withValues(alpha: 0.04)
                            : Colors.transparent,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // card logo
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(
                                defaultRadius,
                              ),
                            ),
                            padding: const EdgeInsets.all(kDefaultPadding / 2),
                            child: Image.asset(item.icon, fit: BoxFit.contain),
                          ),
                          const SizedBox(width: kDefaultPadding),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // card & numnber name
                                    Text(
                                      "${item.brand} ending in ${item.last4}",
                                      style: TextStyle(
                                        color: themeData.colorScheme.onSurface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: kDefaultPadding),
                                    // default badge
                                    if (item.isDefault)
                                      CustomBadge(
                                        kText: "Default",
                                        kColor: kSuccessColor,
                                        isRounded: true,
                                        isOutlined: true,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: kDefaultPadding / 4),

                                // card holder
                                Text(item.holderName),
                                const SizedBox(height: kDefaultPadding / 4),

                                // expires
                                Text("Expires ${item.expiry}"),
                              ],
                            ),
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                        ],
                      ),
                    ),

                    /// pop up menu option
                    PositionedDirectional(
                      end: 0,
                      top: 0,
                      child: CustomPopupMenu<PaymentMethodAction>(
                        icon: Icons.more_vert,
                        items: [
                          PopupMenuItemData(
                            value: PaymentMethodAction.setDefault,
                            text: "Set as default",
                            icon: Icons.check_circle_outline,
                            enabled: !item.isDefault,
                          ),
                          PopupMenuItemData(
                            value: PaymentMethodAction.edit,
                            text: "Edit",
                            icon: Icons.edit_outlined,
                          ),
                          PopupMenuItemData(
                            value: PaymentMethodAction.remove,
                            text: "Remove",
                            icon: Icons.delete_outline,
                            iconColor: kErrorColor,
                            textStyle: TextStyle(color: kErrorColor),
                          ),
                        ],
                        onSelected: (action) => _handleAction(action, index),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: kDefaultPadding),
          ResponsiveWrap(
            spacing: kDefaultPadding,
            runSpacing: kDefaultPadding / 2,
            breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
            columnRatios: [0.5, 0.5],
            children: [
              // add payment method button
              FlatButton(
                kText: "Add Card",
                bgColor: kSecondaryColor,
                kTextColor: Colors.white,
                onPressed: () {
                  _openAddEditCardForm();
                },
              ),

              // done button
              CustomOutlinedButton(
                kText: 'Done',
                outlineColor: themeData.colorScheme.primary,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
