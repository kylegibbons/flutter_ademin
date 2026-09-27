import 'dart:async';
import 'dart:io';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/widgets/form/platform_file.dart';
export 'package:flutkit_ademin/widgets/form/platform_file.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'dart:math' as math;

Future<int> _getFileLength(File file) async {
  try {
    if (await file.exists()) {
      return await file.length();
    }
  } catch (e) {
    // ignore errors and return 0
  }
  return 0;
}

Future<PlatformFile> _convertXFileToPlatformFile(XFile xFile) async {
  final bytes = await xFile.readAsBytes();
  final name = xFile.name;
  final extension = p.extension(name).replaceFirst('.', '').toLowerCase();

  return PlatformFile(
    name: name,
    size: bytes.length,
    bytes: bytes,
    path: kIsWeb ? null : xFile.path,
    extension: extension,
  );
}

// Drag and drop file upload widget
// This widget allows users to drag and drop files or click to upload files

class DragDropUpload extends StatefulWidget {
  const DragDropUpload({
    super.key,
    this.onFilesChanged,
    this.instructionText,
    this.icon,
    this.showUploaded = true,
    this.validator,
    this.initialFiles,
  });

  final void Function(
    List<String> fileNames,
    List<Map<String, dynamic>> webFiles,
  )?
  onFilesChanged;
  final String? instructionText;
  final IconData? icon;
  final bool? showUploaded;
  final String? Function(
    List<String> fileNames,
    List<Map<String, dynamic>> webFiles,
  )?
  validator;
  final List<String>? initialFiles;

  @override
  State<DragDropUpload> createState() => _DragDropUploadState();
}

class _DragDropUploadState extends State<DragDropUpload> {
  bool _dragging = false;
  // String message = 'Drop files here or click to upload';

  // Store both file names and bytes for web
  final List<Map<String, dynamic>> _webDroppedFiles = [];
  final List<String> _droppedFilesNames = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    // Initialize with existing files if provided
    if (widget.initialFiles != null && widget.initialFiles!.isNotEmpty) {
      _droppedFilesNames.addAll(widget.initialFiles!);
    }
  }

  Future<void> _pickFile() async {
    final selectedFiles = await openFiles();

    if (selectedFiles.isNotEmpty) {
      // Temporarily add files to validate
      final tempFileNames = List<String>.from(_droppedFilesNames);
      final tempWebFiles = List<Map<String, dynamic>>.from(_webDroppedFiles);

      if (kIsWeb) {
        for (var file in selectedFiles) {
          final bytes = await file.readAsBytes();
          tempWebFiles.add({'name': file.name, 'bytes': bytes});
        }
      } else {
        for (var file in selectedFiles) {
          tempFileNames.add(file.path);
        }
      }

      final validationError = widget.validator?.call(
        tempFileNames,
        tempWebFiles,
      );

      setState(() {
        if (validationError == null) {
          // Validation passed, add files
          if (kIsWeb) {
            _webDroppedFiles.addAll(
              tempWebFiles.sublist(_webDroppedFiles.length),
            );
          } else {
            _droppedFilesNames.addAll(
              tempFileNames.sublist(_droppedFilesNames.length),
            );
          }
        }
        _error = validationError;
      });

      if (validationError == null && widget.onFilesChanged != null) {
        widget.onFilesChanged!(_droppedFilesNames, _webDroppedFiles);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final lang = Lang.of(context);
    return Column(
      children: [
        DropTarget(
          onDragEntered: (details) {
            setState(() {
              _dragging = true;
            });
          },
          onDragExited: (details) {
            setState(() {
              _dragging = false;
            });
          },
          onDragDone: (detail) async {
            final selectedFiles = await Future.wait(
              detail.files.map(_convertXFileToPlatformFile),
            );
            final files = selectedFiles.toList();
            if (files.isEmpty) return;

            final tempFileNames = List<String>.from(_droppedFilesNames);
            final tempWebFiles = List<Map<String, dynamic>>.from(
              _webDroppedFiles,
            );

            if (kIsWeb) {
              for (var file in files) {
                tempWebFiles.add({'name': file.name, 'bytes': file.bytes});
              }
            } else {
              for (var file in files) {
                tempFileNames.add(file.path ?? file.name);
              }
            }

            final validationError = widget.validator?.call(
              tempFileNames,
              tempWebFiles,
            );

            setState(() {
              _dragging = false;
              if (validationError == null) {
                if (kIsWeb) {
                  _webDroppedFiles.addAll(
                    tempWebFiles.sublist(_webDroppedFiles.length),
                  );
                } else {
                  _droppedFilesNames.addAll(
                    tempFileNames.sublist(_droppedFilesNames.length),
                  );
                }
                if (widget.onFilesChanged != null) {
                  widget.onFilesChanged!(_droppedFilesNames, _webDroppedFiles);
                }
              }
              _error = validationError;
            });
          },

          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _pickFile,
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  color: _error != null
                      ? kErrorColor
                      : themeData.colorScheme.outline, // Color of the border
                  strokeWidth: outlineWidth, // Thickness of the border
                  dashPattern: const [6, 3], // Dash and gap pattern
                  radius: Radius.circular(defaultRadius),
                  padding: EdgeInsets.all(1),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding * 3,
                  ),
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.surfaceContainerHighest,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // icon
                        Icon(
                          widget.icon ?? Icons.cloud_upload,
                          size: 64,
                          color: _error != null
                              ? kErrorColor
                              : (_dragging
                                    ? kTextColor.withValues(alpha: 0.7)
                                    : kTextColor),
                        ),
                        const SizedBox(height: kDefaultPadding / 2),

                        // instruction text
                        Text(
                          _error ?? widget.instructionText ?? lang.dropFiles,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            color: _error != null
                                ? kErrorColor
                                : (_dragging
                                      ? themeData.colorScheme.onSurface
                                            .withValues(alpha: 0.7)
                                      : themeData.colorScheme.onSurface),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        //list uploaded files
        if (widget.showUploaded! &&
            (_droppedFilesNames.isNotEmpty || _webDroppedFiles.isNotEmpty))
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding / 2),
            child: Column(
              children: [
                if (_droppedFilesNames.isNotEmpty)
                  ..._droppedFilesNames.map((file) {
                    return Row(
                      children: [
                        // icon
                        Icon(
                          Icons.insert_drive_file,
                          color: themeData.colorScheme.onSurface,
                        ),

                        SizedBox(width: kDefaultPadding / 2),

                        // title
                        Expanded(
                          child: Text(
                            file,
                            style: TextStyle(
                              color: themeData.colorScheme.onSurface,
                              fontSize: kBodyMedium,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // delete button
                        CustomIconButton(
                          icon: Icons.delete_outline,
                          iconColor: kErrorColor,
                          onTap: () {
                            setState(() {
                              _droppedFilesNames.remove(
                                file,
                              ); // Remove file from the list
                              _error = widget.validator?.call(
                                _droppedFilesNames,
                                _webDroppedFiles,
                              );
                            });
                          },
                        ),
                      ],
                    );
                  }),
                if (_webDroppedFiles.isNotEmpty)
                  ..._webDroppedFiles.map((file) {
                    return Row(
                      children: [
                        // icon
                        Icon(
                          Icons.insert_drive_file,
                          color: themeData.colorScheme.onSurface,
                        ),
                        SizedBox(width: kDefaultPadding / 2),

                        // title
                        Expanded(
                          child: Text(
                            file['name'],
                            style: TextStyle(
                              color: themeData.colorScheme.onSurface,
                              fontSize: kBodyMedium,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // delete button
                        CustomIconButton(
                          icon: Icons.delete_outline,
                          iconColor: kErrorColor,
                          onTap: () {
                            setState(() {
                              _webDroppedFiles.remove(
                                file,
                              ); // Remove file from the list
                              _error = widget.validator?.call(
                                _droppedFilesNames,
                                _webDroppedFiles,
                              );
                            });
                          },
                        ),
                      ],
                    );
                  }),
              ],
            ),
          ),
      ],
    );
  }
}

//basic file upload

class FileUploadForm extends FormField<List<PlatformFile>> {
  final String? successMessage;
  final List<String>? initialFiles;

  FileUploadForm({
    super.key,
    bool allowMultiple = false,
    bool enabled = true,
    FormSize size = FormSize.medium,
    String? buttonText,
    String? fieldText,
    super.validator,
    super.onSaved,
    Function(List<PlatformFile>)? onFilesSelected,
    this.initialFiles,
    this.successMessage,
  }) : super(
         initialValue: [],
         builder: (FormFieldState<List<PlatformFile>> state) {
           final themeData = Theme.of(state.context);
           final FormConfig config = getFormConfig(size);
           final lang = Lang.of(state.context);
           final selectedFiles = state.value ?? [];
           final initialFileNames = state.widget is FileUploadForm
               ? (state.widget as FileUploadForm).initialFiles ?? []
               : [];

           Future<void> pickFiles() async {
             if (!enabled) return;

             try {
               final List<XFile> selectedFiles;
               if (allowMultiple) {
                 selectedFiles = await openFiles();
               } else {
                 final file = await openFile();
                 selectedFiles = file == null ? <XFile>[] : [file];
               }

               if (selectedFiles.isNotEmpty) {
                 final files = await Future.wait(
                   selectedFiles.map(_convertXFileToPlatformFile),
                 );
                 state.didChange(files);
                 onFilesSelected?.call(files);
               }
             } catch (e) {
               // Handle error silently
             }
           }

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               InkWell(
                 onTap: enabled ? pickFiles : null,
                 borderRadius: BorderRadius.circular(defaultRadius),
                 child: Row(
                   children: [
                     // button
                     Container(
                       height: config.formHeight,
                       alignment: Alignment.center,
                       padding: const EdgeInsets.symmetric(
                         horizontal: kDefaultPadding,
                       ),
                       decoration: BoxDecoration(
                         color: Colors.blueGrey.withValues(alpha: 0.1),
                         border: Border.all(
                           width: outlineWidth,
                           color: !enabled
                               ? Colors.blueGrey.withValues(alpha: 0.3)
                               : state.hasError
                               ? kErrorColor
                               : successMessage != null &&
                                     state.isValid &&
                                     (selectedFiles.isNotEmpty ||
                                         initialFileNames.isNotEmpty)
                               ? kSuccessColor
                               : themeData.colorScheme.outline,
                         ),
                         borderRadius: const BorderRadiusDirectional.only(
                           topStart: Radius.circular(defaultRadius),
                           bottomStart: Radius.circular(defaultRadius),
                         ),
                       ),
                       child: Text(
                         buttonText ??
                             (allowMultiple
                                 ? lang.chooseFile(2)
                                 : lang.chooseFile(1)),
                         style: TextStyle(
                           color: enabled
                               ? themeData.colorScheme.onSurface
                               : themeData.disabledColor,
                           fontSize: config.fontSize,
                         ),
                       ),
                     ),

                     // field
                     Expanded(
                       child: Container(
                         height: config.formHeight,
                         alignment: Alignment.center,
                         padding: const EdgeInsets.symmetric(
                           horizontal: kDefaultPadding,
                         ),
                         decoration: BoxDecoration(
                           color: themeData.colorScheme.surfaceContainerHighest,
                           border: BorderDirectional(
                             top: BorderSide(
                               width: outlineWidth,
                               color: !enabled
                                   ? Colors.blueGrey.withValues(alpha: 0.3)
                                   : state.hasError
                                   ? kErrorColor
                                   : successMessage != null &&
                                         state.isValid &&
                                         (selectedFiles.isNotEmpty ||
                                             initialFileNames.isNotEmpty)
                                   ? kSuccessColor
                                   : themeData.colorScheme.outline,
                             ),
                             bottom: BorderSide(
                               width: outlineWidth,
                               color: !enabled
                                   ? Colors.blueGrey.withValues(alpha: 0.3)
                                   : state.hasError
                                   ? kErrorColor
                                   : successMessage != null &&
                                         state.isValid &&
                                         (selectedFiles.isNotEmpty ||
                                             initialFileNames.isNotEmpty)
                                   ? kSuccessColor
                                   : themeData.colorScheme.outline,
                             ),
                             end: BorderSide(
                               width: outlineWidth,
                               color: !enabled
                                   ? Colors.blueGrey.withValues(alpha: 0.3)
                                   : state.hasError
                                   ? kErrorColor
                                   : successMessage != null &&
                                         state.isValid &&
                                         (selectedFiles.isNotEmpty ||
                                             initialFileNames.isNotEmpty)
                                   ? kSuccessColor
                                   : themeData.colorScheme.outline,
                             ),
                           ),
                           borderRadius: const BorderRadiusDirectional.only(
                             topEnd: Radius.circular(defaultRadius),
                             bottomEnd: Radius.circular(defaultRadius),
                           ),
                         ),
                         child:
                             (selectedFiles.isNotEmpty ||
                                 initialFileNames.isNotEmpty)
                             ? Text(
                                 fieldText ??
                                     (allowMultiple
                                         ? '${initialFileNames.length + selectedFiles.length} ${lang.filesSelected(2)}'
                                         : (selectedFiles.isNotEmpty
                                               ? selectedFiles.first.name
                                               : initialFileNames.first)),
                                 style: TextStyle(
                                   color: enabled
                                       ? themeData.colorScheme.onSurface
                                       : themeData.disabledColor,
                                   fontSize: config.fontSize,
                                 ),
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                               )
                             : Text(
                                 fieldText ??
                                     (allowMultiple
                                         ? lang.noFilesSelected(2)
                                         : lang.noFilesSelected(1)),
                                 style: TextStyle(
                                   color: enabled
                                       ? themeData.colorScheme.onSurface
                                       : themeData.disabledColor,
                                   fontSize: config.fontSize,
                                 ),
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                               ),
                       ),
                     ),
                   ],
                 ),
               ),

               // Validation message
               if (state.hasError)
                 Padding(
                   padding: EdgeInsetsDirectional.only(
                     start: config.horizontalPadding,
                     top: config.verticalPadding / 2,
                   ),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyle(
                       color: kErrorColor,
                       fontSize: config.assitiveFontSize,
                     ),
                   ),
                 )
               else if (successMessage != null &&
                   state.isValid &&
                   (selectedFiles.isNotEmpty || initialFileNames.isNotEmpty))
                 Padding(
                   padding: EdgeInsetsDirectional.only(
                     start: config.horizontalPadding,
                     top: config.verticalPadding / 2,
                   ),
                   child: Text(
                     successMessage,
                     style: TextStyle(
                       color: kSuccessColor,
                       fontSize: config.assitiveFontSize,
                     ),
                   ),
                 ),
             ],
           );
         },
       );
}

// MultifileUploader with image preview

class UploadPreview extends StatefulWidget {
  const UploadPreview({
    super.key,
    this.onFilesChanged,
    this.instructionText,
    this.icon,
    this.validator,
    this.initialFiles,
  });

  final void Function(
    List<String> fileNames,
    List<Map<String, dynamic>> webFiles,
  )?
  onFilesChanged;

  final String? instructionText;
  final IconData? icon;
  final String? Function(
    List<String> fileNames,
    List<Map<String, dynamic>> webFiles,
  )?
  validator;
  final List<String>? initialFiles;

  @override
  State<UploadPreview> createState() => _UploadPreviewState();
}

class _UploadPreviewState extends State<UploadPreview> {
  bool _dragging = false;
  // String message = 'Drop your files or Browse';

  // Store both file names and bytes for web
  final List<Map<String, dynamic>> _webDroppedFiles = [];
  final List<String> _droppedFilesNames = [];
  final List<PlatformFile> _droppedPlatformFiles = [];
  String? _error;

  void _removeDroppedFile(String file) {
    _droppedFilesNames.remove(file);
    _droppedPlatformFiles.removeWhere(
      (pf) =>
          pf.path == file || p.basename(pf.path ?? pf.name) == p.basename(file),
    );
  }

  PlatformFile? _findDroppedPlatformFile(String file) {
    for (final pf in _droppedPlatformFiles) {
      if (pf.path == file ||
          p.basename(pf.path ?? pf.name) == p.basename(file)) {
        return pf;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    // Initialize with existing files if provided
    if (widget.initialFiles != null && widget.initialFiles!.isNotEmpty) {
      _droppedFilesNames.addAll(widget.initialFiles!);
    }
  }

  bool _isImageFile(String fileName) {
    final mimeType = lookupMimeType(fileName);
    return mimeType != null && mimeType.startsWith('image/');
  }

  String formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    final i = (bytes != 0) ? (math.log(bytes) / math.log(1024)).floor() : 0;
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  Future<void> _pickFile() async {
    final selectedFiles = await openFiles();

    if (selectedFiles.isNotEmpty) {
      // Temporarily add files to validate
      final tempFileNames = List<String>.from(_droppedFilesNames);
      final tempWebFiles = List<Map<String, dynamic>>.from(_webDroppedFiles);
      final tempDroppedPlatformFiles = <PlatformFile>[];

      if (kIsWeb) {
        for (var file in selectedFiles) {
          final bytes = await file.readAsBytes();
          tempWebFiles.add({'name': file.name, 'bytes': bytes});
        }
      } else {
        for (var file in selectedFiles) {
          final platformFile = await _convertXFileToPlatformFile(file);
          tempFileNames.add(platformFile.path ?? platformFile.name);
          tempDroppedPlatformFiles.add(platformFile);
        }
      }

      final validationError = widget.validator?.call(
        tempFileNames,
        tempWebFiles,
      );

      setState(() {
        if (validationError == null) {
          // Validation passed, add files
          if (kIsWeb) {
            _webDroppedFiles.addAll(
              tempWebFiles.sublist(_webDroppedFiles.length),
            );
          } else {
            _droppedFilesNames.addAll(
              tempFileNames.sublist(_droppedFilesNames.length),
            );
            _droppedPlatformFiles.addAll(tempDroppedPlatformFiles);
          }
        }
        _error = validationError;
      });

      if (validationError == null && widget.onFilesChanged != null) {
        widget.onFilesChanged!(_droppedFilesNames, _webDroppedFiles);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final lang = Lang.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _pickFile,
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            color: _error != null
                ? kErrorColor
                : themeData.colorScheme.outline, // Color of the border
            strokeWidth: outlineWidth, // Thickness of the border
            dashPattern: const [6, 3], // Dash and gap pattern
            radius: Radius.circular(defaultRadius),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              color: themeData.colorScheme.surfaceContainer,
            ),
            child: Column(
              children: [
                DropTarget(
                  onDragEntered: (details) {
                    setState(() {
                      _dragging = true;
                    });
                  },
                  onDragExited: (details) {
                    setState(() {
                      _dragging = false;
                    });
                  },
                  onDragDone: (detail) async {
                    final selectedFiles = await Future.wait(
                      detail.files.map(_convertXFileToPlatformFile),
                    );
                    final files = selectedFiles.toList();
                    if (files.isEmpty) return;

                    final tempFileNames = List<String>.from(_droppedFilesNames);
                    final tempWebFiles = List<Map<String, dynamic>>.from(
                      _webDroppedFiles,
                    );
                    final tempDroppedPlatformFiles = <PlatformFile>[];

                    if (kIsWeb) {
                      for (var file in files) {
                        tempWebFiles.add({
                          'name': file.name,
                          'bytes': file.bytes,
                        });
                      }
                    } else {
                      for (var file in files) {
                        tempFileNames.add(file.path ?? file.name);
                        tempDroppedPlatformFiles.add(file);
                      }
                    }

                    final validationError = widget.validator?.call(
                      tempFileNames,
                      tempWebFiles,
                    );

                    setState(() {
                      _dragging = false;
                      if (validationError == null) {
                        if (kIsWeb) {
                          _webDroppedFiles.addAll(
                            tempWebFiles.sublist(_webDroppedFiles.length),
                          );
                        } else {
                          _droppedFilesNames.addAll(
                            tempFileNames.sublist(_droppedFilesNames.length),
                          );
                          _droppedPlatformFiles.addAll(
                            tempDroppedPlatformFiles,
                          );
                        }
                        if (widget.onFilesChanged != null) {
                          widget.onFilesChanged!(
                            _droppedFilesNames,
                            _webDroppedFiles,
                          );
                        }
                      }
                      _error = validationError;
                    });
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kDefaultPadding,
                        horizontal: kDefaultPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // icon
                          Icon(
                            widget.icon ?? Icons.folder_outlined,
                            size: 24,
                            color: _error != null
                                ? kErrorColor
                                : (_dragging
                                      ? themeData.colorScheme.onSurface
                                            .withValues(alpha: 0.7)
                                      : themeData.colorScheme.onSurface),
                          ),

                          SizedBox(width: kDefaultPadding / 2),

                          // instruction text
                          Flexible(
                            child: Text(
                              _error ??
                                  widget.instructionText ??
                                  lang.dropFiles,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: kBodyLarge,
                                fontWeight: FontWeight.w500,
                                color: _error != null
                                    ? kErrorColor
                                    : (_dragging
                                          ? themeData.colorScheme.onSurface
                                                .withValues(alpha: 0.7)
                                          : themeData.colorScheme.onSurface),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //list uploaded files
                if (_droppedFilesNames.isNotEmpty ||
                    _webDroppedFiles.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: kDefaultPadding / 2),
                    child: Column(
                      children: [
                        // Desktop/mobile files
                        if (_droppedFilesNames.isNotEmpty)
                          ..._droppedFilesNames.reversed.map((file) {
                            final isImage = _isImageFile(file);
                            final fileObj = File(file);
                            return FutureBuilder<int>(
                              future: _getFileLength(fileObj),
                              builder: (context, snapshot) {
                                final fileSizeStr = snapshot.hasData
                                    ? formatBytes(snapshot.data!)
                                    : '';
                                final previewFile = _findDroppedPlatformFile(
                                  file,
                                );
                                final useMemoryPreview =
                                    previewFile?.bytes != null;
                                return isImage
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          top: kDefaultPadding / 2,
                                        ),
                                        child: Stack(
                                          children: [
                                            // image preview
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    defaultRadius,
                                                  ),
                                              child: useMemoryPreview
                                                  ? Image.memory(
                                                      previewFile!.bytes!,
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => Icon(
                                                            Icons.broken_image,
                                                            color: kErrorColor,
                                                          ),
                                                    )
                                                  : Image.file(
                                                      fileObj,
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => Icon(
                                                            Icons.broken_image,
                                                            color: kErrorColor,
                                                          ),
                                                    ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(
                                                kDefaultPadding / 2,
                                              ),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.black.withValues(
                                                      alpha: 0.6,
                                                    ),
                                                    Colors.black.withValues(
                                                      alpha: 0.3,
                                                    ),
                                                    Colors.transparent,
                                                  ],
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  // delete button
                                                  CustomIconButton(
                                                    icon: Icons.close,
                                                    iconColor: Colors.white,
                                                    shape: ButtonShape.circle,
                                                    buttonColor: Colors.white
                                                        .withValues(alpha: 0.1),
                                                    hoverColor: Colors.white
                                                        .withValues(alpha: 0.4),
                                                    onTap: () {
                                                      setState(() {
                                                        _removeDroppedFile(
                                                          file,
                                                        );
                                                      });
                                                    },
                                                  ),

                                                  SizedBox(
                                                    width: kDefaultPadding / 2,
                                                  ),

                                                  // title
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          p.basename(file),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                kBodyMedium,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          fileSizeStr,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                kBodySmall,
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
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius: BorderRadius.circular(
                                            defaultRadius,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(
                                          kDefaultPadding / 2,
                                        ),
                                        margin: const EdgeInsets.only(
                                          top: kDefaultPadding / 2,
                                        ),
                                        child: Row(
                                          children: [
                                            // delete button
                                            CustomIconButton(
                                              icon: Icons.close,
                                              iconColor: Colors.white,
                                              shape: ButtonShape.circle,
                                              buttonColor: Colors.white
                                                  .withValues(alpha: 0.1),
                                              hoverColor: Colors.white
                                                  .withValues(alpha: 0.4),
                                              onTap: () {
                                                setState(() {
                                                  _removeDroppedFile(file);
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: kDefaultPadding / 2,
                                            ),

                                            // title
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    p.basename(file),
                                                    style: TextStyle(
                                                      color: themeData
                                                          .colorScheme
                                                          .onSurface,
                                                      fontSize: kBodyMedium,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    fileSizeStr,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: kBodySmall,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                              },
                            );
                          }),
                        // Web files
                        if (_webDroppedFiles.isNotEmpty)
                          ..._webDroppedFiles.reversed.map((file) {
                            final isImage = _isImageFile(file['name']);
                            final fileSizeStr = file['bytes'] != null
                                ? formatBytes(file['bytes'].length)
                                : '';
                            return isImage && file['bytes'] != null
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      top: kDefaultPadding / 2,
                                    ),
                                    child: Stack(
                                      children: [
                                        // image preview
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            defaultRadius,
                                          ),
                                          child: Image.memory(
                                            width: double.infinity,
                                            file['bytes'],
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Icon(
                                                      Icons.broken_image,
                                                      color: kErrorColor,
                                                    ),
                                          ),
                                        ),

                                        Container(
                                          padding: const EdgeInsets.all(
                                            kDefaultPadding / 2,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.black.withValues(
                                                  alpha: 0.6,
                                                ),
                                                Colors.black.withValues(
                                                  alpha: 0.3,
                                                ),
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              // delete button
                                              CustomIconButton(
                                                icon: Icons.close,
                                                iconColor: Colors.white,
                                                shape: ButtonShape.circle,
                                                buttonColor: Colors.white
                                                    .withValues(alpha: 0.1),
                                                hoverColor: Colors.white
                                                    .withValues(alpha: 0.4),
                                                onTap: () {
                                                  setState(() {
                                                    _webDroppedFiles.remove(
                                                      file,
                                                    );
                                                  });
                                                },
                                              ),

                                              SizedBox(
                                                width: kDefaultPadding / 2,
                                              ),

                                              // title
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      file['name'],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      fileSizeStr,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: kBodySmall,
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
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(
                                        defaultRadius,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(
                                      kDefaultPadding / 2,
                                    ),
                                    margin: const EdgeInsets.only(
                                      top: kDefaultPadding / 2,
                                    ),
                                    child: Row(
                                      children: [
                                        // delete button
                                        CustomIconButton(
                                          icon: Icons.close,
                                          iconColor: Colors.white,
                                          shape: ButtonShape.circle,
                                          buttonColor: Colors.white.withValues(
                                            alpha: 0.1,
                                          ),
                                          hoverColor: Colors.white.withValues(
                                            alpha: 0.4,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _webDroppedFiles.remove(file);
                                            });
                                          },
                                        ),

                                        SizedBox(width: kDefaultPadding / 2),
                                        // title
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                file['name'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                fileSizeStr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: kBodySmall,
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
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// profile picture uploader

class AvatarUpload extends StatefulWidget {
  final double maxSizeBytes;
  final List<String> allowedExtensions;
  final void Function(PlatformFile?) onChanged;
  final String? disableText;
  final bool enabled;
  final double radius;
  final ImageProvider? initialUrl;

  const AvatarUpload({
    super.key,
    required this.maxSizeBytes,
    required this.allowedExtensions,
    required this.onChanged,
    this.disableText,
    this.enabled = true,
    this.radius = 60,
    this.initialUrl,
  });

  @override
  State<AvatarUpload> createState() => _AvatarUploadState();
}

class _AvatarUploadState extends State<AvatarUpload> {
  PlatformFile? _selectedFile;
  Uint8List? _fileBytes;
  // ignore: unused_field
  bool _isDragging = false;
  String? _error;

  bool get isImage {
    final mime = lookupMimeType(
      _selectedFile?.name ?? '',
      headerBytes: _fileBytes,
    );
    return mime?.startsWith('image/') ?? false;
  }

  Future<void> _pickFile() async {
    final acceptedTypeGroups = <XTypeGroup>[];
    if (widget.allowedExtensions.isNotEmpty) {
      acceptedTypeGroups.add(
        XTypeGroup(
          label: 'Allowed files',
          extensions: widget.allowedExtensions,
        ),
      );
    }

    final file = await openFile(acceptedTypeGroups: acceptedTypeGroups);

    if (file != null) {
      final platformFile = await _convertXFileToPlatformFile(file);
      _validateAndSetFile(platformFile);
    }
  }

  void _validateAndSetFile(PlatformFile file) {
    final ext = file.extension?.toLowerCase() ?? '';

    if (!widget.allowedExtensions.contains(ext)) {
      setState(() {
        _error = 'Invalid file type: .$ext';
      });
      return;
    }

    if (file.size > widget.maxSizeBytes) {
      setState(() {
        _error = 'File too large. Max ${widget.maxSizeBytes ~/ 1024} KB';
      });
      return;
    }

    setState(() {
      _selectedFile = file;
      _fileBytes = file.bytes;
      _error = null;
    });

    widget.onChanged(file);
  }

  Widget _buildPreview() {
    final themeData = Theme.of(context);
    if (_selectedFile == null) {
      return Column(
        children: [
          (widget.initialUrl != null)
              ? Container(
                  width: 2 * widget.radius,
                  height: 2 * widget.radius,
                  padding: EdgeInsets.all(kDefaultPadding / 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: outlineWidth,
                      color: _error != null
                          ? kErrorColor
                          : themeData.colorScheme.outline,
                    ),
                    image: DecorationImage(image: widget.initialUrl!),
                  ),
                )
              : Container(
                  width: 2 * widget.radius,
                  height: 2 * widget.radius,
                  padding: EdgeInsets.all(kDefaultPadding / 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: outlineWidth,
                      color: _error != null
                          ? kErrorColor
                          : themeData.colorScheme.outline,
                    ),
                  ),
                  child: ClipOval(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Icon(
                        Icons.person,
                        color: _error != null
                            ? kErrorColor.withValues(alpha: 0.4)
                            : themeData.colorScheme.primary.withValues(
                                alpha: 0.4,
                              ),
                      ),
                    ),
                  ),
                ),

          if (_error != null) ...[
            SizedBox(height: kDefaultPadding / 4),
            Text(
              // error message
              _error!,
              style: TextStyle(color: kErrorColor),
              textAlign: TextAlign.center,
            ),
          ],

          if (widget.enabled == false) ...[
            SizedBox(height: kDefaultPadding / 4),
            Text(
              // disable text
              widget.disableText ?? 'Upload disabled',
              style: TextStyle(color: kTextColor),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      );
    }

    if (isImage && _fileBytes != null) {
      return ClipOval(
        child: Image.memory(
          _fileBytes!,
          width: 2 * widget.radius,
          height: 2 * widget.radius,
          fit: BoxFit.cover,
        ),
      );
    }

    return Icon(Icons.insert_drive_file, size: 48);
  }

  @override
  Widget build(BuildContext context) {
    final dropTarget = DropTarget(
      onDragEntered: (details) => setState(() => _isDragging = true),
      onDragExited: (details) => setState(() => _isDragging = false),
      onDragDone: (detail) async {
        final selectedFiles = await Future.wait(
          detail.files.map(_convertXFileToPlatformFile),
        );
        final files = selectedFiles.toList();
        if (files.isEmpty) return;

        _validateAndSetFile(files.first);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.enabled ? _pickFile : null,
          child: Stack(
            children: [
              // image preview
              _buildPreview(),

              // camera icon
              if (widget.enabled == true)
                PositionedDirectional(
                  top: kDefaultPadding / 2,
                  end: 0,
                  child: CustomIconButton(
                    icon: Icons.photo_camera_outlined,
                    iconColor: kTextColor,
                    buttonColor: Colors.blueGrey.shade50,
                    shape: ButtonShape.circle,
                    size: ButtonSize.small,
                    onTap: widget.enabled ? _pickFile : null,
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    return kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS
        ? dropTarget
        : GestureDetector(
            onTap: widget.enabled ? _pickFile : null,
            child: dropTarget.child,
          );
  }
}

// Avatar Upload Dotted

class AvatarUploadDotted extends StatefulWidget {
  final double maxSizeBytes;
  final List<String> allowedExtensions;
  final void Function(PlatformFile?) onChanged;
  final String? instructionText;
  final String? disableText;
  final bool enabled;
  final double radius;

  const AvatarUploadDotted({
    super.key,
    required this.maxSizeBytes,
    required this.allowedExtensions,
    required this.onChanged,
    this.instructionText,
    this.disableText,
    this.enabled = true,
    this.radius = 60,
  });

  @override
  State<AvatarUploadDotted> createState() => _AvatarUploadDottedState();
}

class _AvatarUploadDottedState extends State<AvatarUploadDotted> {
  PlatformFile? _selectedFile;
  Uint8List? _fileBytes;
  // ignore: unused_field
  bool _isDragging = false;
  String? _error;

  bool get isImage {
    final mime = lookupMimeType(
      _selectedFile?.name ?? '',
      headerBytes: _fileBytes,
    );
    return mime?.startsWith('image/') ?? false;
  }

  Future<void> _pickFile() async {
    final acceptedTypeGroups = <XTypeGroup>[];
    if (widget.allowedExtensions.isNotEmpty) {
      acceptedTypeGroups.add(
        XTypeGroup(
          label: 'Allowed files',
          extensions: widget.allowedExtensions,
        ),
      );
    }

    final file = await openFile(acceptedTypeGroups: acceptedTypeGroups);

    if (file != null) {
      final platformFile = await _convertXFileToPlatformFile(file);
      _validateAndSetFile(platformFile);
    }
  }

  void _validateAndSetFile(PlatformFile file) {
    final ext = file.extension?.toLowerCase() ?? '';

    if (!widget.allowedExtensions.contains(ext)) {
      setState(() {
        _error = 'Invalid file type: .$ext';
      });
      return;
    }

    if (file.size > widget.maxSizeBytes) {
      setState(() {
        _error = 'File too large. Max ${widget.maxSizeBytes ~/ 1024} KB';
      });
      return;
    }

    setState(() {
      _selectedFile = file;
      _fileBytes = file.bytes;
      _error = null;
    });

    widget.onChanged(file);
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
      _fileBytes = null;
      _error = null;
    });

    widget.onChanged(null);
  }

  Widget _buildPreview() {
    final themeData = Theme.of(context);
    if (_selectedFile == null) {
      return DottedBorder(
        options: CircularDottedBorderOptions(
          color: _error != null
              ? kErrorColor
              : themeData.colorScheme.outline, // Color of the border
          strokeWidth: outlineWidth, // Thickness of the border
          dashPattern: const [6, 3], // Dash and gap pattern
        ),
        child: Container(
          width: 2 * widget.radius,
          height: 2 * widget.radius,
          padding: EdgeInsets.all(kDefaultPadding),
          child: Center(
            child: _error != null
                ? Text(
                    // error message
                    _error!,
                    style: TextStyle(
                      color: kErrorColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  )
                : widget.enabled
                ? Text(
                    // initial text
                    widget.instructionText ?? 'Drag & drop or click to upload',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.close,
                        color: kErrorColor.withValues(alpha: 0.8),
                        size: 20,
                      ),
                      Text(
                        // disable text
                        widget.disableText ?? 'Upload disabled',
                        style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }

    if (isImage && _fileBytes != null) {
      return ClipOval(
        child: Image.memory(
          _fileBytes!,
          width: 2 * widget.radius,
          height: 2 * widget.radius,
          fit: BoxFit.cover,
        ),
      );
    }

    return Icon(Icons.insert_drive_file, size: 48);
  }

  @override
  Widget build(BuildContext context) {
    final dropTarget = DropTarget(
      onDragEntered: (details) => setState(() => _isDragging = true),
      onDragExited: (details) => setState(() => _isDragging = false),
      onDragDone: (detail) async {
        final selectedFiles = await Future.wait(
          detail.files.map(_convertXFileToPlatformFile),
        );
        final files = selectedFiles.toList();
        if (files.isEmpty) return;

        _validateAndSetFile(files.first);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.enabled ? _pickFile : null,
          child: Stack(
            children: [
              // image preview
              _buildPreview(),

              // remove button
              if (_selectedFile != null)
                PositionedDirectional(
                  top: kDefaultPadding / 2,
                  end: 0,
                  child: CustomIconButton(
                    icon: Icons.close,
                    iconColor: Colors.white,
                    buttonColor: Colors.black.withValues(alpha: 0.6),
                    shape: ButtonShape.circle,
                    size: ButtonSize.small,
                    onTap: widget.enabled ? _removeFile : null,
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    return kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS
        ? dropTarget
        : GestureDetector(
            onTap: widget.enabled ? _pickFile : null,
            child: dropTarget.child,
          );
  }
}
