// Ticket Detail

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/support_ticket/ticket_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/dropdown.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';

class TicketDetailSidebar extends StatefulWidget {
  final TicketDetail ticket;

  const TicketDetailSidebar({super.key, required this.ticket});

  @override
  State<TicketDetailSidebar> createState() => _TicketDetailSidebarState();
}

class _TicketDetailSidebarState extends State<TicketDetailSidebar> {
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM, yyyy');
    final timeAgo = _getTimeAgo(
      widget.ticket.updatedAt ?? widget.ticket.createdAt,
    );
    final themeData = Theme.of(context);
    final labelWidth = 100.0;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(kText: 'Ticket Details'),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ticket id
                _buildRow(
                  'Ticket',
                  '#${widget.ticket.id}',
                  context,
                  labelWidth,
                ),
                const SizedBox(height: kDefaultPadding),

                // client
                _buildRow(
                  'Client',
                  widget.ticket.client.name,
                  context,
                  labelWidth,
                ),
                const SizedBox(height: kDefaultPadding),

                // project name
                if (widget.ticket.project != null)
                  _buildRow(
                    'Project',
                    widget.ticket.project!.name,
                    context,
                    labelWidth,
                  ),
                const SizedBox(height: kDefaultPadding),

                // assignee
                SizedBox(
                  height: mediumHeight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: labelWidth,
                        child: Text(
                          'Assigned To',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      _buildAssignedAvatars(widget.ticket.assignedTo, context),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding),

                // status
                SizedBox(
                  height: mediumHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: labelWidth,
                        child: Text(
                          'Status',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      _buildStatusDropdown(widget.ticket.status, context),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding),

                // priority
                SizedBox(
                  height: mediumHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: labelWidth,
                        child: Text(
                          'Priority',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      _buildPriorityLabel(widget.ticket.priority),
                    ],
                  ),
                ),

                // created date
                const SizedBox(height: kDefaultPadding),
                _buildRow(
                  'Create Date',
                  dateFormat.format(widget.ticket.createdAt),
                  context,
                  labelWidth,
                ),
                const SizedBox(height: kDefaultPadding),

                // due date
                if (widget.ticket.updatedAt != null)
                  _buildRow(
                    'Due Date',
                    dateFormat.format(widget.ticket.updatedAt!),
                    context,
                    labelWidth,
                  ),
                const SizedBox(height: kDefaultPadding),

                // last activity
                _buildRow('Last Activity', timeAgo, context, labelWidth),
                const SizedBox(height: kDefaultPadding),

                // labels
                SizedBox(
                  height: mediumHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: labelWidth,
                        child: Text(
                          'Labels',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.ticket.labels
                            .map(
                              (label) => CustomBadge(
                                kColor: kPrimaryColor,
                                kText: label.replaceAll('#', ''),
                                isSoft: true,
                                isRounded: true,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value,
    BuildContext context,
    double labelWidth,
  ) {
    final themeData = Theme.of(context);

    return SizedBox(
      height: mediumHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: themeData.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedAvatars(List<UserInfo> users, BuildContext context) {
    const maxVisible = 3;
    final visibleUsers = users.take(maxVisible).toList();
    final remaining = users.length - maxVisible;
    final extra = remaining > 0 ? 1 : 0;
    final totalDisplayed =
        visibleUsers.length + extra + 1; // +1 untuk tombol add
    final width = (totalDisplayed * 24.0) + 12;

    return SizedBox(
      height: mediumHeight,
      width: width,
      child: Stack(
        children: [
          ...visibleUsers.asMap().entries.map((entry) {
            final index = entry.key;
            final user = entry.value;
            return Positioned(
              left: index * 24.0,
              child: Tooltip(
                message: user.name,
                preferBelow: false,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage(user.avatarUrl),
                  ),
                ),
              ),
            );
          }),

          if (remaining > 0)
            Positioned(
              left: visibleUsers.length * 24.0,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.surface,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.grey.shade300,
                  child: Text(
                    '+$remaining',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),

          // Always show "Add" button at the end
          Positioned(
            left: (totalDisplayed - 1) * 24.0,
            child: GestureDetector(
              onTap: () {
                // Open assignee picker
              },
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.surface,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.add, size: 16, color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityLabel(String priority) {
    Color color = kErrorColor;
    if (priority.toLowerCase() == 'medium') color = kWarningColor;
    if (priority.toLowerCase() == 'low') color = kSuccessColor;

    return CustomBadge(kColor: color, kText: priority);
  }

  TicketStatus _selectedStatus = TicketStatus.newTicket;

  Widget _buildStatusDropdown(TicketStatus status, BuildContext context) {
    final themeData = Theme.of(context);
    return CustomDropdownButton<TicketStatus>(
      label: 'Status',
      color: themeData.colorScheme.onSurface,
      outlineColor: themeData.colorScheme.outline,
      labelColor: themeData.colorScheme.onSurface,
      bgColor: themeData.colorScheme.surface,
      type: DropdownType.outline,
      alignment: AlignmentDirectional.centerStart,
      items: TicketStatus.values.map((TicketStatus s) {
        return DropdownMenuItem<TicketStatus>(
          value: s,
          child: Text(_getStatusLabel(s)),
        );
      }).toList(),
      value: _selectedStatus,
      onChanged: (TicketStatus? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedStatus = newValue;
          });
        }
      },
    );
  }

  String _getStatusLabel(TicketStatus status) {
    switch (status) {
      case TicketStatus.newTicket:
        return 'New';
      case TicketStatus.open:
        return 'Open';
      case TicketStatus.inProgress:
        return 'In Progress';
      case TicketStatus.closed:
        return 'Closed';
    }
  }

  String _getTimeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hour ago';
    return '${diff.inDays} day ago';
  }
}
