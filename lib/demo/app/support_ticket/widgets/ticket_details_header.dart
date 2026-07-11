import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/support_ticket/ticket_models.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:intl/intl.dart';

class TicketDetailsHeader extends StatelessWidget {
  final TicketDetail ticket;
  final bool isMobile;

  const TicketDetailsHeader({
    super.key,
    required this.ticket,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final content = _HeaderContent(
      ticket: ticket,
      isMobile: isMobile,
      themeData: themeData,
    );

    return Row(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        _ClientAvatar(ticket: ticket),
        const SizedBox(width: kDefaultPadding),
        Expanded(child: content),
        const SizedBox(width: kDefaultPadding),
        _HeaderActions(),
      ],
    );
  }
}

class _ClientAvatar extends StatelessWidget {
  final TicketDetail ticket;
  final double? radius;

  // ignore: unused_element_parameter
  const _ClientAvatar({required this.ticket, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 50,
      backgroundImage: AssetImage(ticket.client.avatarUrl),
    );
  }
}

class _HeaderContent extends StatelessWidget {
  final TicketDetail ticket;
  final bool isMobile;
  final ThemeData themeData;

  const _HeaderContent({
    required this.ticket,
    required this.isMobile,
    required this.themeData,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM, yyyy');
    final statusInfo = getStatusInfo(ticket.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '#${ticket.id} - ${ticket.subject}',
          maxLines: isMobile ? 3 : 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isMobile ? kTitleMedium : kTitleLarge,
            color: themeData.colorScheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: kDefaultPadding / 2),
        Wrap(
          spacing: kDefaultPadding,
          runSpacing: kDefaultPadding / 2,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _MetaItem(icon: Icons.person_outline, label: ticket.client.name),
            _MetaItem(
              icon: Icons.calendar_today_outlined,
              label: 'Created ${dateFormat.format(ticket.createdAt)}',
            ),
            if (ticket.updatedAt != null)
              _MetaItem(
                icon: Icons.event_available_outlined,
                label: 'Due ${dateFormat.format(ticket.updatedAt!)}',
              ),
            CustomBadge(
              kText: statusInfo.label.toUpperCase(),
              kColor: statusInfo.color,
              isRounded: true,
              isSoft: true,
            ),
            CustomBadge(
              kText: ticket.priority.toUpperCase(),
              kColor: getPriorityColor(_getTicketPriority(ticket.priority)),
              isRounded: true,
            ),
          ],
        ),
      ],
    );
  }

  TicketPriority _getTicketPriority(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return TicketPriority.low;
      case 'medium':
        return TicketPriority.medium;
      case 'high':
        return TicketPriority.high;
      default:
        return TicketPriority.low;
    }
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 220),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: themeData.colorScheme.onSurfaceVariant),
          const SizedBox(width: kDefaultPadding / 4),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: kBodyMedium,
                color: themeData.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderActions extends StatelessWidget {
  const _HeaderActions();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;

    final actions = [
      _ActionButton(icon: Icons.star_border, tooltip: 'Favorite'),
      _ActionButton(icon: Icons.share_outlined, tooltip: 'Share'),
      _ActionButton(icon: Icons.outlined_flag, tooltip: 'Flag'),
    ];

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: actions
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: e,
              ),
            )
            .toList(),
      );
    }

    return Wrap(
      spacing: kDefaultPadding / 2,
      runSpacing: kDefaultPadding / 2,
      children: actions,
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;

  const _ActionButton({required this.icon, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return CustomIconButton(
      icon: icon,
      tooltipMessage: tooltip,
      iconColor: themeData.colorScheme.onSurface,
      buttonColor: themeData.colorScheme.surface,
      outlineColor: themeData.colorScheme.outline,
      isOutlined: true,
      onTap: () {},
    );
  }
}
