import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_data.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/theme/theme_extensions/app_fleather_theme.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/image.dart';
import 'package:flutter_ademin/widgets/base_ui/popup_menu.dart';
import 'package:flutter_ademin/widgets/base_ui/progress.dart';
import 'package:flutter_ademin/demo/app/task/dialogs/add_task_form.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutter_ademin/widgets/form/form_file_upload.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewTaskDialog extends StatefulWidget {
  final TaskFormData taskData;

  const ViewTaskDialog({super.key, required this.taskData});

  @override
  State<ViewTaskDialog> createState() => _ViewTaskDialogState();
}

// simple helper for checklist items used in both add & view dialog
class _ChecklistItem {
  String text;
  bool done;
  _ChecklistItem(this.text, {this.done = false});
}

// log entry combining comments and activities with a timestamp
class _LogItem {
  final String text;
  final DateTime time;
  final String memberName;
  final String memberAvatarUrl;
  final bool isActivity;

  _LogItem(
    this.text,
    this.time, {
    required this.memberName,
    required this.memberAvatarUrl,
    required this.isActivity,
  });
}

class _ViewTaskDialogState extends State<ViewTaskDialog> {
  late TaskFormData _taskData;
  late TextEditingController _descController;
  bool isEditing = false;
  final TextEditingController _newChecklistController = TextEditingController();

  // state for interactive checklist
  List<_ChecklistItem> _checklistItems = [];

  // comment input controller
  final TextEditingController _commentController = TextEditingController();
  final List<_LogItem> _logs = [];
  List<String> _visibleAttachments = [];

  @override
  void initState() {
    super.initState();
    _taskData = widget.taskData;
    _descController = TextEditingController(text: _taskData.description);
    _visibleAttachments = List<String>.from(_taskData.attachments ?? []);

    // prepare checklist items for toggling
    _checklistItems = _taskData.checklist != null
        ? _taskData.checklist!
              .map((e) => _ChecklistItem(e.title, done: e.isDone))
              .toList()
        : [];

    // merge activities and discussions into a single time-sorted log list
    if (_taskData.activityEntries != null) {
      for (final entry in _taskData.activityEntries!) {
        _logs.add(
          _LogItem(
            entry.text,
            entry.timestamp,
            memberName: entry.memberName,
            memberAvatarUrl: entry.memberAvatarUrl,
            isActivity: true,
          ),
        );
      }
    }
    if (_taskData.discussionEntries != null) {
      for (final entry in _taskData.discussionEntries!) {
        _logs.add(
          _LogItem(
            entry.text,
            entry.timestamp,
            memberName: entry.memberName,
            memberAvatarUrl: entry.memberAvatarUrl,
            isActivity: false,
          ),
        );
      }
    }

    final hasStructuredLogs =
        (_taskData.activityEntries?.isNotEmpty ?? false) ||
        (_taskData.discussionEntries?.isNotEmpty ?? false);
    if (!hasStructuredLogs) {
      final now = DateTime.now();
      int offset = 0;
      if (_taskData.activities != null) {
        for (final act in _taskData.activities!) {
          offset += 5;
          _logs.add(
            _LogItem(
              act,
              now.subtract(Duration(minutes: offset)),
              memberName: 'Activity',
              memberAvatarUrl: '',
              isActivity: true,
            ),
          );
        }
      }
      if (_taskData.discussions != null) {
        for (final d in _taskData.discussions!) {
          offset += 3;
          _logs.add(
            _LogItem(
              d,
              now.subtract(Duration(minutes: offset)),
              memberName: 'Comment',
              memberAvatarUrl: '',
              isActivity: false,
            ),
          );
        }
      }
    }
    _logs.sort((a, b) => b.time.compareTo(a.time));
  }

  @override
  void dispose() {
    _descController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  // attachment
  String _fileExtension(String attachment) {
    final normalized = attachment.trim();
    if (normalized.isEmpty) return '';

    final uri = Uri.tryParse(normalized);
    final path = (uri != null && uri.path.isNotEmpty) ? uri.path : normalized;
    final dotIndex = path.lastIndexOf('.');
    if (dotIndex < 0 || dotIndex == path.length - 1) return '';
    return path.substring(dotIndex + 1).toLowerCase();
  }

  IconData _attachmentIcon(String attachment) {
    final metaType = _resolveAttachmentMeta(attachment)?.fileType.toLowerCase();
    final type = (metaType != null && metaType.isNotEmpty)
        ? metaType
        : _fileExtension(attachment);

    switch (type) {
      case 'pdf':
        return Icons.picture_as_pdf_outlined;
      case 'doc':
      case 'docx':
      case 'rtf':
      case 'odt':
        return Icons.description_outlined;
      case 'xls':
      case 'xlsx':
      case 'csv':
        return Icons.table_chart_outlined;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow_outlined;
      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'gif':
      case 'webp':
      case 'svg':
        return Icons.image_outlined;
      case 'mp4':
      case 'mov':
      case 'avi':
      case 'mkv':
      case 'webm':
        return Icons.video_file_outlined;
      case 'mp3':
      case 'wav':
      case 'ogg':
      case 'm4a':
        return Icons.audio_file_outlined;
      case 'zip':
      case 'rar':
      case '7z':
      case 'tar':
      case 'gz':
        return Icons.folder_zip_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  ProjectAttachment? _resolveAttachmentMeta(String attachment) {
    final value = attachment.trim();
    if (value.isEmpty) return null;

    final uri = Uri.tryParse(value);
    final basename = (uri != null && uri.pathSegments.isNotEmpty)
        ? uri.pathSegments.last
        : value;

    try {
      return mockProjectDatas.attachments.firstWhere(
        (a) =>
            a.name.toLowerCase() == value.toLowerCase() ||
            a.name.toLowerCase() == basename.toLowerCase() ||
            a.url.toLowerCase() == value.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  String _attachmentDisplayName(String attachment) {
    final meta = _resolveAttachmentMeta(attachment);
    if (meta != null) return meta.name;

    final uri = Uri.tryParse(attachment);
    if (uri != null && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.last;
    }

    return attachment;
  }

  String _formatFileSize(double fileSizeInKb) {
    if (fileSizeInKb >= 1024) {
      return '${(fileSizeInKb / 1024).toStringAsFixed(1)} MB';
    }
    return '${fileSizeInKb.toStringAsFixed(0)} KB';
  }

  String _attachmentMetaText(String attachment) {
    final meta = _resolveAttachmentMeta(attachment);
    if (meta == null) {
      final now = DateTime.now();
      return 'Uploaded ${DateFormat('dd MMM yyyy, HH:mm').format(now)}';
    }

    final uploadedAt = DateFormat('dd MMM yyyy, HH:mm').format(meta.uploadedAt);
    return '${_formatFileSize(meta.fileSize)} | $uploadedAt';
  }

  ImageProvider? _avatarProvider(String avatarUrl) {
    final value = avatarUrl.trim();
    if (value.isEmpty) return null;
    if (value.startsWith('assets/')) {
      return AssetImage(value);
    }
    return NetworkImage(value);
  }

  Uri? _attachmentUri(String attachment) {
    final value = attachment.trim();
    if (value.isEmpty) return null;

    final parsed = Uri.tryParse(value);
    if (parsed != null && parsed.hasScheme) {
      return parsed;
    }

    // Simple support for absolute Windows file path.
    final isWindowsAbsPath = RegExp(r'^[a-zA-Z]:\\').hasMatch(value);
    if (isWindowsAbsPath) {
      return Uri.file(value);
    }

    // Fallback for task data that stores only file name.
    final meta = _resolveAttachmentMeta(value);
    if (meta != null) {
      final fallback = Uri.tryParse(meta.url);
      if (fallback != null && fallback.hasScheme) {
        return fallback;
      }
    }

    return null;
  }

  Future<void> _openAttachment(String attachment) async {
    final uri = _attachmentUri(attachment);
    if (uri == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Link untuk "$attachment" belum tersedia.')),
      );
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membuka attachment: $attachment')),
      );
    }
  }

  Future<void> _downloadAttachment(String attachment) async {
    final uri = _attachmentUri(attachment);
    if (uri == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Link download untuk "$attachment" tidak ada.')),
      );
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal download attachment: $attachment')),
      );
    }
  }

  void _removeAttachmentFromView(String attachment) {
    setState(() {
      _visibleAttachments.remove(attachment);
    });
  }

  void _handleUploadedFiles(
    List<String> fileNames,
    List<Map<String, dynamic>> webFiles,
  ) {
    final uploadedNames = <String>[
      ...fileNames,
      ...webFiles
          .map((f) => (f['name'] ?? '').toString().trim())
          .where((name) => name.isNotEmpty),
    ];
    if (uploadedNames.isEmpty) return;

    setState(() {
      for (final name in uploadedNames) {
        if (!_visibleAttachments.contains(name)) {
          _visibleAttachments.add(name);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;

    return Dialog(
      constraints: BoxConstraints(maxWidth: 960),
      insetPadding: isMobile
          ? EdgeInsets
                .zero // fullscreen (mobile)
          : const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding,
            ), // desktop/tablet
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Stack(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                  start: kDefaultPadding,
                  top: kDefaultPadding,
                  bottom: kDefaultPadding,
                  end: kDefaultPadding * 3,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: themeData.colorScheme.outline,
                      width: outlineWidth,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // task title
                    Flexible(
                      child: Text(
                        _taskData.title,
                        style: TextStyle(
                          fontSize: kBodyLarge + 3,
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(width: kDefaultPadding),

                    // Status
                    CustomBadge(
                      kText: _formatStatus(_taskData.status),
                      kColor: _getStatusColor(_taskData.status),
                      kFontSize: kBodyMedium,
                      isOutlined: true,
                    ),
                  ],
                ),
              ),

              // close button
              PositionedDirectional(
                top: kDefaultPadding / 2,
                end: kDefaultPadding / 2,
                child: CustomIconButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icons.close,
                  shape: ButtonShape.circle,
                ),
              ),
            ],
          ),

          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: AdaptiveWrap(
                  breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
                  columnRatios: [0.7, 0.3],
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description block
                        DescriptionInlineEditor(
                          description: _taskData.description,
                        ),

                        SizedBox(height: kDefaultPadding),

                        // Checklist
                        Text(
                          'Checklists',
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 2),

                        // show progress bar when there are items
                        if (_checklistItems.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: kDefaultPadding / 2,
                            ),
                            child: LinearProgress(
                              value:
                                  _checklistItems.where((i) => i.done).length /
                                  _checklistItems.length,
                              color: kPrimaryColor,
                              height: 18,
                              showPercentage: true,
                              isAnimated: true,
                              animationDuration: Duration(milliseconds: 400),
                            ),
                          ),

                        Column(
                          children: [
                            ..._checklistItems.map(
                              (item) => Row(
                                children: [
                                  // checkbox
                                  CustomCheckbox(
                                    value: item.done,
                                    onChanged: (v) {
                                      setState(() {
                                        item.done = v ?? false;
                                      });
                                    },
                                    activeColor: kSuccessColor,
                                  ),
                                  SizedBox(width: kDefaultPadding / 2),

                                  // checklist text
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: item.text,
                                      style: TextStyle(
                                        color: themeData.colorScheme.onSurface,
                                        decoration: item.done
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: kDefaultPadding / 2,
                                        ),
                                        isDense: true,
                                        fillColor:
                                            themeData.colorScheme.surface,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          item.text = value;
                                        });
                                      },
                                    ),
                                  ),

                                  // remove button
                                  CustomIconButton(
                                    icon: Icons.close,
                                    iconColor: themeData.colorScheme.onSurface,
                                    onTap: () {
                                      setState(() {
                                        _checklistItems.remove(item);
                                      });
                                    },
                                    shape: ButtonShape.circle,
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              children: [
                                IgnorePointer(
                                  child: CustomCheckbox(
                                    value: false,
                                    onChanged: null,
                                  ),
                                ),

                                SizedBox(width: 0.5 * kDefaultPadding),

                                // new checklist field
                                Expanded(
                                  child: TextField(
                                    controller: _newChecklistController,
                                    decoration: InputDecoration(
                                      hintText: 'Add checklist item',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: themeData.colorScheme.outline,
                                          width: outlineWidth,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: themeData.colorScheme.primary,
                                          width: outlineWidth,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: kDefaultPadding / 2,
                                      ),
                                      isDense: true,
                                      fillColor: themeData.colorScheme.surface,
                                    ),
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (value) {
                                      final text = value.trim();
                                      if (text.isNotEmpty) {
                                        setState(() {
                                          _checklistItems.add(
                                            _ChecklistItem(text),
                                          );
                                          _newChecklistController.clear();
                                        });
                                      }
                                    },
                                  ),
                                ),

                                // add button
                                CustomIconButton(
                                  icon: Icons.add,
                                  iconColor: themeData.colorScheme.onSurface,
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    final text = _newChecklistController.text
                                        .trim();
                                    if (text.isNotEmpty) {
                                      setState(() {
                                        _checklistItems.add(
                                          _ChecklistItem(text),
                                        );
                                        _newChecklistController.clear();
                                      });
                                    }
                                  },
                                  shape: ButtonShape.circle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: kDefaultPadding),

                        // Attachments list
                        if (_visibleAttachments.isNotEmpty) ...[
                          Text(
                            'Attachments',
                            style: TextStyle(
                              fontSize: kBodyLarge,
                              color: themeData.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding / 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _visibleAttachments
                                .map(
                                  (f) => Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: kDefaultPadding / 2,
                                    ),
                                    child: InkWell(
                                      onTap: () => _openAttachment(f),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: kTableHeaderColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    defaultRadius,
                                                  ),
                                            ),
                                            padding: EdgeInsets.all(
                                              kDefaultPadding,
                                            ),
                                            child: Icon(
                                              _attachmentIcon(f),
                                              size: 20,
                                              color: themeData
                                                  .colorScheme
                                                  .primary
                                                  .withValues(alpha: 0.7),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: kDefaultPadding / 2,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _attachmentDisplayName(f),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: themeData
                                                        .colorScheme
                                                        .primary,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  _attachmentMetaText(f),
                                                  style: TextStyle(
                                                    fontSize: kBodySmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: kDefaultPadding / 2,
                                          ),

                                          // attachment popup menu
                                          CustomPopupMenu<String>(
                                            onSelected: (value) {
                                              switch (value) {
                                                case 'comment':
                                                  debugPrint('Comment action');
                                                  break;
                                                case 'download':
                                                  _downloadAttachment(f);
                                                  break;
                                                case 'remove':
                                                  _removeAttachmentFromView(f);
                                                  break;
                                                default:
                                                  debugPrint('Unknown action');
                                              }
                                            },
                                            items: [
                                              // edit menu
                                              PopupMenuItemData(
                                                value: 'comment',
                                                text: 'Comment',
                                                icon: Icons.comment,
                                              ),

                                              // share menu
                                              PopupMenuItemData(
                                                value: 'download',
                                                text: 'Download',
                                                icon: Icons.download_outlined,
                                              ),

                                              // delete menu
                                              PopupMenuItemData(
                                                value: 'remove',
                                                text: 'Remove',
                                                icon: Icons.delete_outline,
                                                iconColor: kErrorColor,
                                                textStyle: TextStyle(
                                                  color: kErrorColor,
                                                ),
                                              ),
                                            ],

                                            // icon
                                            icon: Icons.more_horiz,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(height: kDefaultPadding),
                        ],

                        // Comments / activities
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Comments & Activities',
                              style: TextStyle(
                                fontSize: kBodyLarge,
                                color: themeData.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            // comment field area
                            CustomTextFormField(
                              controller: _commentController,
                              hintText: "Add comment...",
                              minLines: 5,
                              maxLines: 5,
                            ),
                            const SizedBox(height: kDefaultPadding / 2),
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: FlatButton(
                                kText: 'Save',
                                bgColor: kSuccessColor,
                                kTextColor: Colors.white,
                                onPressed: () {
                                  final text = _commentController.text.trim();
                                  if (text.isNotEmpty) {
                                    setState(() {
                                      final now = DateTime.now();
                                      _logs.insert(
                                        0,
                                        _LogItem(
                                          text,
                                          now,
                                          memberName: 'You',
                                          memberAvatarUrl: '',
                                          isActivity: false,
                                        ),
                                      );
                                    });
                                    _commentController.clear();
                                  }
                                },
                              ),
                            ),

                            const SizedBox(height: kDefaultPadding),
                            ..._logs.map((log) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: kDefaultPadding,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // user avatar
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: themeData
                                          .colorScheme
                                          .primaryContainer,
                                      backgroundImage: _avatarProvider(
                                        log.memberAvatarUrl,
                                      ),
                                      child:
                                          _avatarProvider(
                                                log.memberAvatarUrl,
                                              ) ==
                                              null
                                          ? Text(
                                              log.memberName.isEmpty
                                                  ? '?'
                                                  : log.memberName[0]
                                                        .toUpperCase(),
                                              style: TextStyle(
                                                fontSize: kBodySmall,
                                                color: themeData
                                                    .colorScheme
                                                    .onPrimaryContainer,
                                              ),
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: kDefaultPadding / 2),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // user name
                                              Text(
                                                log.memberName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: themeData
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                              ),

                                              SizedBox(
                                                width: kDefaultPadding / 2,
                                              ),

                                              // comments/activities text
                                              CustomBadge(
                                                kText: log.isActivity
                                                    ? 'Activity'
                                                    : 'Comment',
                                                kColor: log.isActivity
                                                    ? kErrorColor
                                                    : kInfoColor,
                                                isRounded: true,
                                                isSoft: true,
                                              ),
                                            ],
                                          ),

                                          Text(
                                            log.text,
                                            style: TextStyle(
                                              color: log.isActivity
                                                  ? themeData
                                                        .colorScheme
                                                        .primary
                                                  : themeData
                                                        .colorScheme
                                                        .onSurface,
                                              fontStyle: log.isActivity
                                                  ? FontStyle.italic
                                                  : FontStyle.normal,
                                              fontWeight: log.isActivity
                                                  ? FontWeight.w500
                                                  : FontWeight.w400,
                                            ),
                                          ),

                                          // meta date and time
                                          Text(
                                            DateFormat(
                                              'yyyy-MM-dd HH:mm',
                                            ).format(log.time),
                                            style: TextStyle(
                                              fontSize: kBodySmall,
                                              color: kTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // task info (dates, priority, status)
                        _buildDetailCard(
                          context,
                          label: 'Start Date',

                          content: Text(
                            _taskData.startDate,
                            style: TextStyle(
                              fontSize: kBodyMedium,
                              color: themeData.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        SizedBox(height: kDefaultPadding),
                        _buildDetailCard(
                          context,
                          label: 'Due Date',
                          content: Text(
                            _taskData.dueDate,
                            style: TextStyle(
                              fontSize: kBodyMedium,
                              color: themeData.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),

                        // Priority
                        _buildDetailCard(
                          context,
                          label: 'Priority',
                          content: CustomBadge(
                            kText: _formatPriority(_taskData.priority),
                            kColor: _getPriorityColor(_taskData.priority),
                            kFontSize: kBodyMedium,
                            isOutlined: true,
                          ),
                        ),

                        SizedBox(height: kDefaultPadding),

                        // Status
                        _buildDetailCard(
                          context,
                          label: 'Status',
                          content: CustomBadge(
                            kText: _formatStatus(_taskData.status),
                            kColor: _getStatusColor(_taskData.status),
                            kFontSize: kBodyMedium,
                            isOutlined: true,
                          ),
                        ),

                        SizedBox(height: kDefaultPadding),

                        // assignees
                        _buildAssigneesCard(context),
                        SizedBox(height: kDefaultPadding),

                        // tags
                        if (_taskData.tags != null &&
                            _taskData.tags!.isNotEmpty)
                          _buildDetailCard(
                            context,
                            label: 'Tags',
                            content: Wrap(
                              spacing: kDefaultPadding / 2,
                              runSpacing: kDefaultPadding / 2,
                              children: _taskData.tags!
                                  .map(
                                    (tag) => Chip(
                                      label: Text(
                                        tag,
                                        style: TextStyle(
                                          color:
                                              themeData.colorScheme.onPrimary,
                                          fontSize: kBodyMedium,
                                        ),
                                      ),
                                      backgroundColor: kPrimaryColor.withValues(
                                        alpha: 0.8,
                                      ),
                                      side: BorderSide.none,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),

                        if (_taskData.tags != null &&
                            _taskData.tags!.isNotEmpty)
                          SizedBox(height: kDefaultPadding),

                        // upload placeholder
                        DragDropUpload(
                          showUploaded: false,
                          onFilesChanged: _handleUploadedFiles,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              children: [
                CustomOutlinedButton(
                  kText: 'Edit',
                  outlineColor: themeData.colorScheme.primary,
                  kLeadingIcon: Icons.edit_outlined,
                  onPressed: () async {
                    // Close current view dialog
                    // Navigator.of(context).pop();

                    // Open AddTaskDialog prefilled with current data
                    final updated = await showDialog<TaskFormData>(
                      context: context,
                      builder: (ctx) => AddTaskDialog(initialData: _taskData),
                    );

                    if (updated != null) {
                      // if user saved changes, show updated view
                      setState(() {
                        _taskData = updated;
                      });

                      showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (ctx) => ViewTaskDialog(taskData: updated),
                      );
                    }
                  },
                ),
                const Spacer(),
                SoftButton(
                  kText: 'Close',
                  bgColor: themeData.colorScheme.onSurface,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
    BuildContext context, {
    required String label,
    required Widget content,
  }) {
    final themeData = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: themeData.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // label
          Text(
            label,
            style: TextStyle(
              fontSize: kBodySmall,
              color: kTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),

          // content
          content,
        ],
      ),
    );
  }

  Widget _buildAssigneesCard(BuildContext context) {
    final themeData = Theme.of(context);

    final assigneeMembers = _taskData.assignees.map((assigneeName) {
      return mockProjectDatas.members.firstWhere(
        (m) => m.name == assigneeName,

        orElse: () =>
            Member(id: '', name: assigneeName, role: '', avatarUrl: ''),
      );
    }).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: themeData.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assignees',
            style: TextStyle(
              fontSize: kBodySmall,
              color: kTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),

          if (_taskData.assignees.isEmpty)
            Text(
              'No assignees',
              style: TextStyle(
                fontSize: kBodyMedium,
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            )
          else
            GroupAvatar(
              imageUrls: assigneeMembers.map((m) => m.avatarUrl).toList(),
              labels: assigneeMembers.map((m) => m.name).toList(),
              showLabel: true,
              avatarSize: 36,
              overlapOffset: 32,
              maxAvatars: 6,
            ),
        ],
      ),
    );
  }

  String _formatPriority(String priority) {
    switch (priority) {
      case 'low':
        return 'Low';
      case 'medium':
        return 'Medium';
      case 'high':
        return 'High';
      default:
        return priority;
    }
  }

  String _formatStatus(String status) {
    switch (status) {
      case 'notStarted':
        return 'Not Started';
      case 'inProgress':
        return 'In Progress';
      case 'testing':
        return 'Testing';
      case 'awaitFeedback':
        return 'Awaiting Feedback';
      case 'completed':
        return 'Completed';
      default:
        return status;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'low':
        return kInfoColor;
      case 'medium':
        return kWarningColor;
      case 'high':
        return kErrorColor;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'notStarted':
        return kInfoColor;
      case 'inProgress':
        return Theme.of(context).colorScheme.primary;
      case 'testing':
        return kWarningColor;
      case 'awaitFeedback':
        return kErrorColor;
      case 'completed':
        return kSuccessColor;
      default:
        return kTextColor;
    }
  }
}

class DescriptionInlineEditor extends StatefulWidget {
  final String description;

  const DescriptionInlineEditor({super.key, required this.description});

  @override
  State<DescriptionInlineEditor> createState() =>
      _DescriptionInlineEditorState();
}

class _DescriptionInlineEditorState extends State<DescriptionInlineEditor> {
  late FleatherController _controller;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    final document = ParchmentDocument.fromJson([
      {"insert": "${widget.description}\n"},
    ]);

    _controller = FleatherController(document: document);
  }

  void _startEdit() {
    /// set snapshot before edit
    setState(() {
      isEditing = true;
    });
  }

  void _finishEdit() {
    // save to backend / model
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER: Edit button
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: TextStyle(
                fontSize: kBodyLarge,
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (!isEditing)
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: kDefaultPadding,
                ),
                child: InkWell(
                  onTap: _startEdit,
                  child: Icon(Icons.edit, size: 14),
                ),
              ),
          ],
        ),

        SizedBox(height: kDefaultPadding / 2),

        // TOOLBAR only appears when editing
        if (isEditing)
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: kInfoColor),
                left: BorderSide(color: kInfoColor),
                right: BorderSide(color: kInfoColor),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(defaultRadius),
                topRight: Radius.circular(defaultRadius),
              ),
            ),
            child: FleatherToolbar.basic(controller: _controller),
          ),
        GestureDetector(
          onTap: () {
            if (!isEditing) {
              setState(() {
                isEditing = true;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.only(
              top: isEditing ? kDefaultPadding : 0,
              left: isEditing ? kDefaultPadding : 0,
              right: isEditing ? kDefaultPadding : 0,
              bottom: isEditing ? kDefaultPadding : 0,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isEditing ? kInfoColor : Colors.transparent,
                ),
                left: BorderSide(
                  color: isEditing ? kInfoColor : Colors.transparent,
                ),
                right: BorderSide(
                  color: isEditing ? kInfoColor : Colors.transparent,
                ),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(defaultRadius),
                bottomRight: Radius.circular(defaultRadius),
              ),
            ),
            child: IgnorePointer(
              ignoring: !isEditing,
              child: FleatherTheme(
                data: context.fleatherTheme, // use FleatherThemeData
                child: FleatherEditor(
                  controller: _controller,
                  readOnly: !isEditing,
                  expands: false,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),

        /// ACTION BUTTONS
        if (isEditing)
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // cancel button
                FlatButton(
                  kText: 'Cancel',
                  bgColor: themeData.colorScheme.surface,
                  kTextColor: themeData.colorScheme.primary,
                  onPressed: _finishEdit,
                ),
                const SizedBox(width: kDefaultPadding / 2),

                // save button
                FlatButton(
                  kText: 'Save',
                  bgColor: kSuccessColor,
                  kTextColor: Colors.white,
                  onPressed: _finishEdit,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
