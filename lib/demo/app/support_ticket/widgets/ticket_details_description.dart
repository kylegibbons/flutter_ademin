import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/documentation/widget/syntaxhighlighter.dart';
import 'package:flutter_ademin/demo/app/support_ticket/ticket_data.dart';
import 'package:flutter_ademin/demo/app/support_ticket/ticket_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/typography.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:intl/intl.dart';

class TicketDetailsDescription extends StatelessWidget {
  final TicketDetail ticket;
  const TicketDetailsDescription({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // description
          CardHeader(kText: 'Ticket Description'),

          const SizedBox(height: kDefaultPadding),

          // description markdown area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: SelectionArea(
              child: MarkdownBody(
                data: ticket.description,
                styleSheet: DocMarkdownStyle.sheet(context),
                builders: {
                  'pre': HighlightBuilder(
                    isDark: Theme.of(context).brightness == Brightness.dark,
                  ),
                  'code': InlineCodeBuilder(
                    Theme.of(context).brightness == Brightness.dark,
                  ),
                },
              ),
            ),
          ),

          const SizedBox(height: kDefaultPadding),

          // comment list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              'Comments'.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
                fontSize: kBodyMedium,
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: SizedBox(
              height: 460,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: dummyTicketDetail.comments
                      .map((comment) => buildCommentTree(comment, userMap))
                      .toList(),
                ),
              ),
            ),
          ),

          const SizedBox(height: kDefaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: CommentInputForm(onPost: (message) {}),
          ),

          const SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }

  Widget buildCommentTree(
    TicketComment comment,
    Map<String, UserInfo> userMap, {
    double indent = 0,
  }) {
    final user = userMap[comment.userId]!;

    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TicketCommentCard(comment: comment, user: user, onReply: () {}),
          ...comment.replies.map(
            (reply) => buildCommentTree(reply, userMap, indent: indent + 24),
          ),
        ],
      ),
    );
  }
}

// comment card widget

class TicketCommentCard extends StatelessWidget {
  final TicketComment comment;
  final UserInfo user;
  final VoidCallback? onReply;

  const TicketCommentCard({
    super.key,
    required this.comment,
    required this.user,
    this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat(
      'dd MMM yyyy – hh:mma',
    ).format(comment.timestamp);
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(radius: 16, backgroundImage: AssetImage(user.avatarUrl)),
          const SizedBox(width: kDefaultPadding / 2),

          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name & timestamp
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: user.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      const TextSpan(text: '  '),
                      TextSpan(
                        text: dateFormatted,
                        style: const TextStyle(fontSize: kBodySmall),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 4),

                // Comment text
                Text(comment.message),

                const SizedBox(height: kDefaultPadding / 2),

                // Reply Button
                TextButton(
                  onPressed: onReply,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blueGrey.withValues(alpha: 0.1),
                    padding: const EdgeInsets.only(
                      top: 4,
                      left: 6,
                      bottom: 4,
                      right: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.reply_outlined, size: 10, color: kTextColor),
                      SizedBox(width: kDefaultPadding / 4),
                      Text(
                        'Reply',
                        style: TextStyle(
                          fontSize: kBodySmall,
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                        ),
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
}

// comment input form

class CommentInputForm extends StatefulWidget {
  final void Function(String message) onPost;

  const CommentInputForm({super.key, required this.onPost});

  @override
  State<CommentInputForm> createState() => _CommentInputFormState();
}

class _CommentInputFormState extends State<CommentInputForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leave a Comment',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeData.colorScheme.onSurface,
            fontSize: kBodyMedium,
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        TextField(
          controller: _controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Enter your comment...',
            filled: true,
            fillColor: kTableHeaderColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(kDefaultPadding),
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        Align(
          alignment: Alignment.bottomRight,
          child: FlatButton(
            kText: 'Post comments',
            bgColor: kSuccessColor,
            kTextColor: Colors.white,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
