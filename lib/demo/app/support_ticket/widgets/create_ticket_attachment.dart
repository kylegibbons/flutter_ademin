import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:flutkit_ademin/widgets/form/form_file_upload.dart';

class CreateTicketAttachment extends StatefulWidget {
  final Function(List<String>) onFilesChanged;

  const CreateTicketAttachment({super.key, required this.onFilesChanged});

  @override
  State<CreateTicketAttachment> createState() => _CreateTicketAttachmentState();
}

class _CreateTicketAttachmentState extends State<CreateTicketAttachment> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(kText: 'Attachments'),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload Files (Optional)',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                    fontSize: kBodyMedium,
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Text(
                  'Drag and drop files here or click to browse. Supported formats: PDF, DOC, XLS, Images, etc.',
                  style: TextStyle(
                    fontSize: kBodySmall,
                    color: themeData.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: kDefaultPadding),

                // File upload widget
                DragDropUpload(
                  instructionText: 'Drag files here or click to browse',
                  icon: Icons.cloud_upload_outlined,
                  showUploaded: true,
                  onFilesChanged: (fileNames, webFiles) {
                    widget.onFilesChanged(fileNames);
                  },
                  validator: (fileNames, webFiles) {
                    final totalFiles = fileNames.length + webFiles.length;
                    if (totalFiles > 10) {
                      return 'Maximum 10 files allowed';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
