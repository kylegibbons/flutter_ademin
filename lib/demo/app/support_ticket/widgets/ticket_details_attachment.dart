// attachment sidebar
import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/support_ticket/ticket_data.dart';
import 'package:flutkit_ademin/demo/app/support_ticket/ticket_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AttachmentSidebar extends StatelessWidget {
  const AttachmentSidebar({super.key});

  FileIconInfo getFileIconInfo(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'zip':
      case 'rar':
        return FileIconInfo(FontAwesomeIcons.fileZipper, kSecondaryColor);
      case 'ppt':
      case 'pptx':
        return FileIconInfo(FontAwesomeIcons.filePowerpoint, kErrorColor);
      case 'doc':
      case 'docx':
        return FileIconInfo(FontAwesomeIcons.fileWord, kInfoColor);
      case 'xls':
      case 'xlsx':
        return FileIconInfo(FontAwesomeIcons.fileExcel, kSuccessColor);
      case 'pdf':
        return FileIconInfo(FontAwesomeIcons.filePdf, kErrorColor);
      case 'jpg':
      case 'jpeg':
      case 'png':
        return FileIconInfo(FontAwesomeIcons.fileImage, Colors.purple);
      case 'txt':
        return FileIconInfo(FontAwesomeIcons.fileLines, Colors.black);
      default:
        return FileIconInfo(FontAwesomeIcons.file, kTextColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(kText: 'Attachments'),

          // attachment list
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: List.generate(dummyTicketDetail.attachments.length, (
                index,
              ) {
                final a = dummyTicketDetail.attachments[index];
                final bool isLast =
                    index == dummyTicketDetail.attachments.length - 1;

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : kDefaultPadding / 2,
                  ),
                  child: buildTicketAttachmentTile(a, context),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTicketAttachmentTile(
    TicketAttachment attachment,
    BuildContext context,
  ) {
    final themeData = Theme.of(context);
    final fileInfo = getFileIconInfo(attachment.fileName);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 2,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: themeData.colorScheme.outline, width: 0.4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          // file icon
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              color: kTableHeaderColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FaIcon(fileInfo.icon, color: fileInfo.color, size: 28),
          ),
          const SizedBox(width: kDefaultPadding),

          // file name and size
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment.fileName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Text(
                  '${attachment.fileSize} MB',
                  style: TextStyle(fontSize: kBodyMedium, color: kTextColor),
                ),
              ],
            ),
          ),

          const SizedBox(width: kDefaultPadding / 2),

          // download button
          CustomIconButton(icon: Icons.download_outlined, onTap: () {}),

          // delete button
          CustomIconButton(icon: Icons.delete_outline, onTap: () {}),
        ],
      ),
    );
  }
}
