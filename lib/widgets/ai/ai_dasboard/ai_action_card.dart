import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';

// model

enum ActionPriority { high, medium, low }

class RecommendedAction {
  final String title;
  final ActionPriority priority;
  final VoidCallback? onExecute;

  const RecommendedAction({
    required this.title,
    required this.priority,
    this.onExecute,
  });
}

// priority extension

extension ActionPriorityExtension on ActionPriority {
  String get label {
    switch (this) {
      case ActionPriority.high:
        return 'High';
      case ActionPriority.medium:
        return 'Medium';
      case ActionPriority.low:
        return 'Low';
    }
  }

  Color color(BuildContext context) {
    switch (this) {
      case ActionPriority.high:
        return kErrorColor;
      case ActionPriority.medium:
        return kWarningColor;
      case ActionPriority.low:
        return kSuccessColor;
    }
  }
}

class AIActionsCard extends StatelessWidget {
  final String title;
  final List<RecommendedAction> actions;
  final VoidCallback? onViewAll;
  final Widget? headerACtion;

  const AIActionsCard({
    super.key,
    required this.actions,
    this.onViewAll,
    this.title = 'Recommended Actions',
    this.headerACtion,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Card(
      child: Column(
        children: [
          CardHeader(
            kText: title,
            showDivider: true,
            titleWidget: Padding(
              padding: EdgeInsetsDirectional.only(end: kDefaultPadding / 2),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  gradient: kPurpleGradient,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.auto_awesome, size: 16, color: Colors.white),
              ),
            ),
            kWidget:
                headerACtion ??
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: kDefaultPadding / 2,
                  ),
                  child: FlatButton(
                    kText: 'View All',
                    kTextColor: kSecondaryColor,
                    bgColor: themeData.colorScheme.surface,
                    size: ButtonSize.small,
                    onPressed: onViewAll,
                  ),
                ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: actions.length,
              itemBuilder: (context, index) {
                return _ActionTile(action: actions[index]);
              },
              separatorBuilder: (context, index) => Divider(
                height: 1.5 * kDefaultPadding,
                color: themeData.colorScheme.outline,
                thickness: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final RecommendedAction action;

  const _ActionTile({required this.action});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Row(
      children: [
        CustomBadge(
          kText: action.priority.label,
          kColor: action.priority.color(context),
          isSoft: true,
        ),

        const SizedBox(width: kDefaultPadding / 2),

        Expanded(
          child: Text(
            action.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: themeData.colorScheme.onSurface,),
          ),
        ),

        const SizedBox(width: kDefaultPadding / 2),

        Tooltip(message: 'Execute ${action.title}',
          child: CustomOutlinedButton(
            kText: 'Execute',
            outlineColor: kSecondaryColor,
            size: ButtonSize.small,
            onPressed: action.onExecute,
          ),
        ),
      ],
    );
  }
}
