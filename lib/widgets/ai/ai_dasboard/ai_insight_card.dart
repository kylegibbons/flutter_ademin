import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_insight_helpers.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';

class AiInsightCard extends StatelessWidget {
  final AIInsight insight;
  final Widget? illustration;

  const AiInsightCard({super.key, required this.insight, this.illustration});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final severityColor = getSeverityColor(insight.severity, themeData);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;

    return Card(
      child: Column(
        children: [
          CardHeader(
            kText: 'Business Insights',
            showDivider: true,
            titleWidget: Padding(
              padding: const EdgeInsetsDirectional.only(
                end: kDefaultPadding / 2,
              ),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  gradient: kPurpleGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
            // Severity badge
            kWidget: Padding(
              padding: const EdgeInsetsDirectional.only(end: kDefaultPadding),
              child: Tooltip(
                message: getSeverityLabel(insight.severity),
                child: Icon(
                  getSeverityIcon(insight.severity),
                  color: severityColor,
                ),
              ),
            ),
          ),

          // Header with severity and time
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
              horizontal: kDefaultPadding,
            ),
            child: Column(
              children: [
                ResponsiveWrap(
                  breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
                  columnRatios: const [0.5, 0.5],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // Title
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          insight.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                            fontSize: kBodyMedium,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: kDefaultPadding / 2),

                        // Summary
                        Text(
                          insight.summary,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: kDefaultPadding),

                        // Impact & Confidence
                        Row(
                          children: [
                            // Impact
                            if (insight.impact != null) ...[
                              Tooltip(
                                message:
                                    insight.impact?.description ??
                                    'No description',
                                constraints: const BoxConstraints(
                                  maxWidth: kScreenWidthSm,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('Impact'),
                                        SizedBox(width: kDefaultPadding / 4),
                                        Icon(
                                          Icons.info_outline_rounded,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: kDefaultPadding / 4),
                                    Text(
                                      getImpactLabel(insight.impact),
                                      style: TextStyle(
                                        color: getImpactColor(
                                          insight.impact?.level,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: kDefaultPadding),
                            ],

                            // Confidence Badge
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Confidence'),
                                Text(
                                  '${insight.confidence.score}%',
                                  style: TextStyle(
                                    color: getConfidenceColor(
                                      insight.confidence.level,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: kDefaultPadding / 2),
                          ],
                        ),
                      ],
                    ),

                    // Why
                    if (insight.why != null &&
                        insight.why!.reasons.isNotEmpty) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            insight.why!.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: themeData.colorScheme.onSurface,
                              fontSize: kBodyMedium,
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding / 2),
                          ...insight.why!.reasons.map((reason) {
                            final whyStyle = getWhyItemStyle(reason);
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: kDefaultPadding / 3,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    whyStyle.icon,
                                    size: 16,
                                    color: whyStyle.color,
                                  ),
                                  SizedBox(width: kDefaultPadding / 2),
                                  Expanded(child: Text(reason)),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: kDefaultPadding),

                // Actions and menu
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: kDefaultPadding / 2,
                        children: insight.actions.take(2).map((action) {
                          if (action.type == AIActionType.primary) {
                            return FlatButton(
                              onPressed: () {},
                              kText: action.label,
                              bgColor: kSecondaryColor,
                              kTextColor: Colors.white,
                              isFullWidth: true,
                            );
                          } else {
                            return CustomOutlinedButton(
                              onPressed: () {},
                              kText: action.label,
                              outlineColor:
                                  action.type == AIActionType.destructive
                                  ? kErrorColor
                                  : kSecondaryColor,
                              isFullWidth: true,
                            );
                          }
                        }).toList(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: kDefaultPadding,
                        children: insight.actions.take(2).map((action) {
                          if (action.type == AIActionType.primary) {
                            return FlatButton(
                              onPressed: () {},
                              kText: action.label,
                              bgColor: kSecondaryColor,
                              kTextColor: Colors.white,
                              isFullWidth: false,
                            );
                          } else {
                            return CustomOutlinedButton(
                              onPressed: () {},
                              kText: action.label,
                              outlineColor:
                                  action.type == AIActionType.destructive
                                  ? kErrorColor
                                  : kSecondaryColor,
                              isFullWidth: false,
                            );
                          }
                        }).toList(),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
