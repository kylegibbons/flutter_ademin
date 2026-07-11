import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_checkbox_radio.dart';

enum CancelReason { tooExpensive, notUsing, missingFeatures, switching, other }

class CancelSubscriptionDialog extends StatefulWidget {
  final DateTime expiryDate;
  final VoidCallback onCancelConfirmed;

  const CancelSubscriptionDialog({
    super.key,
    required this.expiryDate,
    required this.onCancelConfirmed,
  });

  @override
  State<CancelSubscriptionDialog> createState() =>
      _CancelSubscriptionDialogState();
}

class _CancelSubscriptionDialogState extends State<CancelSubscriptionDialog> {
  CancelReason? selectedReason;
  bool showRetentionOffer = true;

  String get formattedDate {
    return "${widget.expiryDate.day} "
        "${_month(widget.expiryDate.month)} "
        "${widget.expiryDate.year}";
  }

  String _month(int m) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Description
          Text(
            "Your subscription will remain active until $formattedDate. "
            "After that, you will lose access to premium features.",
            style: TextStyle(
              color: themeData.colorScheme.onSurface,
              // fontSize: kBodyLarge,
            ),
          ),

          const SizedBox(height: kDefaultPadding),

          /// Retention Offer
          if (showRetentionOffer) ...[
            Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: kSuccessColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Special Offer 🎉",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  const Text("Get 30% off for the next 3 months if you stay."),
                  const SizedBox(height: kDefaultPadding),
                  Row(
                    children: [
                      // apply button
                      FlatButton(
                        kText: 'Apply Discount',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        size: ButtonSize.small,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: kDefaultPadding),

                      // reject button
                      FlatButton(
                        kText: 'No thanks',
                        bgColor: Colors.transparent,
                        kTextColor: themeData.colorScheme.primary,
                        size: ButtonSize.small,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: kDefaultPadding),

          /// Reason Selection
          Text(
            "Why are you cancelling?",
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
          const SizedBox(height: kDefaultPadding),

          ...CancelReason.values.map((reason) {
            final isSelected = selectedReason == reason;

            return Padding(
              padding: const EdgeInsetsDirectional.only(
                start: kDefaultPadding / 2,
                bottom: kDefaultPadding,
              ),
              child: CustomRadioButton(
                label: _label(reason),
                value: isSelected,
                activeColor: kSecondaryColor,
                labelStyle: TextStyle(fontWeight: FontWeight.w500),
                onChanged: (_) {
                  setState(() {
                    selectedReason = reason;
                  });
                },
              ),
            );
          }),

          const SizedBox(height: kDefaultPadding),

          /// Actions
          AdaptiveWrap(
            spacing: kDefaultPadding,
            runSpacing: kDefaultPadding / 2,
            breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
            columnRatios: [0.5, 0.5],
            children: [
              CustomOutlinedButton(
                kText: 'Keep Subscription',
                outlineColor: themeData.colorScheme.primary,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              FlatButton(
                kText: "Cancel Anyway",
                bgColor: kErrorColor,
                kTextColor: Colors.white,
                onPressed: () {
                  widget.onCancelConfirmed();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _label(CancelReason reason) {
    switch (reason) {
      case CancelReason.tooExpensive:
        return "Too expensive";
      case CancelReason.notUsing:
        return "Not using it enough";
      case CancelReason.missingFeatures:
        return "Missing features";
      case CancelReason.switching:
        return "Switching to another tool";
      case CancelReason.other:
        return "Other";
    }
  }
}
