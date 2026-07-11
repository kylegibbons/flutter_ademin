import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/dialog.dart';
import 'package:flutter_ademin/widgets/form/form_file_upload.dart';

void uploadFilesDialog(BuildContext context, ThemeData themeData) {
  // store local variable
  List selectedFiles = [];
  StateSetter? updateActions;

  showCustomDialog(
    context: context,
    title: "Upload Files",
    showCloseButton: true,
    content: StatefulBuilder(
      builder: (context, setContentState) {
        return DragDropUpload(
          instructionText: "Drag and drop files here or click to browse",
          icon: Icons.cloud_upload_outlined,
          onFilesChanged: (names, metadata) {
            // Update state internal (untuk variabel)
            selectedFiles = names;
            // Panggil updater milik actions jika sudah terpasang
            if (updateActions != null) {
              updateActions!(() {});
            }
          },
        );
      },
    ),
    actions:
        // Actions
        StatefulBuilder(
          builder: (context, setActionsState) {
            updateActions = setActionsState;
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SoftButton(
                  kText: 'Cancel',
                  bgColor: themeData.colorScheme.onSurface,
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: kDefaultPadding),
                FlatButton(
                  kText: 'Upload ${selectedFiles.length} Files',
                  // button disable if no file uploaded
                  bgColor: selectedFiles.isEmpty
                      ? themeData.disabledColor
                      : kSuccessColor,
                  kTextColor: Colors.white,
                  onPressed: selectedFiles.isEmpty
                      ? null
                      : () {
                          // Handle Upload for (selectedFiles);
                          Navigator.pop(context);
                        },
                ),
              ],
            );
          },
        ),
  );
}
