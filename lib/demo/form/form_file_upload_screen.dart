import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/form/form_file_upload.dart';
import 'package:flutter_ademin/widgets/helper/card_description.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).fileUpload; // Update your page title here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // String message = 'Drop files here or click to upload';

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          // Page title and breadcrumb
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding * 0.8,
            ),
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface,
              border: Border(
                top: BorderSide(color: kTextColor.withValues(alpha: 0.1)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Wrap(
              spacing: kDefaultPadding,
              runSpacing: kDefaultPadding * 0.5,
              alignment: WrapAlignment.spaceBetween,
              children: [
                // Title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lang.fileUpload.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: kBodyMedium,
                      ),
                    ),
                  ],
                ),

                // Breadcrumbs
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Breadcrumbs(
                      items: [
                        BreadcrumbItem(
                          label: lang.dashboard,
                          uri: RouteUri.home,
                        ),
                        BreadcrumbItem(label: lang.forms(1), uri: ''),
                        BreadcrumbItem(
                          label: lang.fileUpload,
                          uri: RouteUri.starterpage,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                ShowCodeCard(
                  cardTitle: 'Files Upload Box',
                  description:
                      "Use <code>DragDropUpload()</code> to set drag and drop upload box / zone, users can either drag and drop them onto the designated area or click the upload area. A list of uploaded files will be displayed, allowing users to delete them if necessary.",
                  uiView: DragDropUpload(
                    onFilesChanged: (fileNames, webFiles) {},
                  ),
                  codeView: '''
DragDropUpload(
  onFilesChanged: (fileNames, webFiles) {},
)
                  ''',
                  height: 200,
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Files Upload Box with Validator',
                  description:
                      "Use <code>DragDropUpload()</code> with <code>validator</code> to validate uploaded files. The validator function receives file names and web files, and returns an error message if validation fails.",
                  uiView: DragDropUpload(
                    validator: (fileNames, webFiles) {
                      final totalFiles = fileNames.length + webFiles.length;
                      if (totalFiles > 5) {
                        return 'Maximum 5 files allowed';
                      }
                      if (totalFiles == 0) {
                        return null; // No error
                      }
                      // Check if all files are images
                      final allFiles = [
                        ...fileNames,
                        ...webFiles.map((f) => f['name'] as String),
                      ];
                      final imageExtensions = [
                        'jpg',
                        'jpeg',
                        'png',
                        'gif',
                        'bmp',
                      ];
                      for (var fileName in allFiles) {
                        final extension = fileName
                            .split('.')
                            .last
                            .toLowerCase();
                        if (!imageExtensions.contains(extension)) {
                          return 'Only image files are allowed (JPG, PNG, GIF, BMP)';
                        }
                      }
                      return null; // No error
                    },
                    onFilesChanged: (fileNames, webFiles) {
                      // Handle files
                    },
                  ),
                  codeView: '''
DragDropUpload(
  validator: (fileNames, webFiles) {
    final totalFiles = fileNames.length + webFiles.length;
    if (totalFiles > 5) {
      return 'Maximum 5 files allowed';
    }
    if (totalFiles == 0) {
      return null; // No error
    }
    // Check if all files are images
    final allFiles = [...fileNames, ...webFiles.map((f) => f['name'] as String)];
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
    for (var fileName in allFiles) {
      final extension = fileName.split('.').last.toLowerCase();
      if (!imageExtensions.contains(extension)) {
        return 'Only image files are allowed (JPG, PNG, GIF, BMP)';
      }
    }
    return null; // No error
  },
  onFilesChanged: (fileNames, webFiles) {
    // Handle files
  },
)
                  ''',
                  height: 200,
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'File Upload Form',
                  description:
                      'Use <code>FileUploadForm()</code> to set basic file upload form, allow multiple flies upload using <code>allowMultiple: true</code>.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_3(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // single upload
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Single File Upload',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                                CardDescription(
                                  content:
                                      'By default File Upload Form supports single file upload.',
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                // Single File Upload
                                FileUploadForm(
                                  onFilesSelected: (files) {
                                    for (var file in files) {
                                      debugPrint('Selected file: ${file.name}');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),

                          // multiple upload
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Multiple Files Upload',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                                CardDescription(
                                  content:
                                      'Add <code>allowMultiple: true</code> to support multiple files upload.',
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                // Multiple Files Upload
                                FileUploadForm(
                                  allowMultiple:
                                      true, // set to support multiple files upload
                                  onFilesSelected: (files) {
                                    for (var file in files) {
                                      debugPrint('Selected file: ${file.name}');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),

                          // custom upload
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Custom Text File Upload',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                                CardDescription(
                                  content:
                                      'Add <code>buttonText</code> and <code>fieldText</code> to customize texts.',
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                // Custom Text File Upload
                                FileUploadForm(
                                  buttonText: 'Upload File', // button text
                                  fieldText: 'Select document', // fiedl text
                                  onFilesSelected: (files) {
                                    for (var file in files) {
                                      debugPrint('Selected file: ${file.name}');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),

                          // disable upload
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Disabled File Upload Form',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                                CardDescription(
                                  content:
                                      'Add <code>enabled: false</code> to disable upload.',
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                // Disabled File Upload Form
                                FileUploadForm(
                                  enabled: false, // disable the button
                                  onFilesSelected: (files) {
                                    for (var file in files) {
                                      debugPrint('Selected file: ${file.name}');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
// Single File Upload
FileUploadForm(
  onFilesSelected: (files) {
    for (var file in files) {
    // do something with files
    }
  },
),

// Multiple Files Upload
FileUploadForm(
  allowMultiple: true, // set to support multiple files upload
  onFilesSelected: (files) {
    for (var file in files) {}
  },
), 

// Custom Text File Upload
FileUploadForm(
  buttonText: 'Upload File', // button text
  fieldText: 'Select document', // fiedl text
  onFilesSelected: (files) {
    for (var file in files) {
    // do something with files
    }
  },
),

// Disabled File Upload Form
FileUploadForm(
  enabled: false, // disable the button
  onFilesSelected: (files) {
    for (var file in files) {
    // do something with files
    }
  },
),                                     
''',
                  height: 480,
                ),

                SizedBox(height: kDefaultPadding),

                ShowCodeCard(
                  cardTitle: 'File Upload Form Size',
                  description:
                      'Use <code>FileUploadForm()</code> to set basic file upload form, use <code>size</code> argument to set form size.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_3(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // File upload small
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: FileUploadForm(
                              allowMultiple: false,
                              enabled: true,
                              size: FormSize.small,
                              onFilesSelected: (files) {
                                for (var file in files) {
                                  debugPrint('Selected file: ${file.name}');
                                }
                              },
                            ),
                          ),

                          // File upload medium
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: FileUploadForm(
                              allowMultiple: false,
                              enabled: true,
                              size: FormSize.medium,
                              onFilesSelected: (files) {
                                for (var file in files) {
                                  debugPrint('Selected file: ${file.name}');
                                }
                              },
                            ),
                          ),

                          // File upload large
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: FileUploadForm(
                              allowMultiple: false,
                              enabled: true,
                              size: FormSize.large,
                              onFilesSelected: (files) {
                                for (var file in files) {
                                  debugPrint('Selected file: ${file.name}');
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
//File upload small
FileUploadForm(
  allowMultiple: false,
  enabled: true,
  size: FormSize.small,
  onFilesSelected: (files) {},
),

// File upload medium
FileUploadForm(
  allowMultiple: false,
  enabled: true,
  size: FormSize.medium,
  onFilesSelected: (files) {},
),

// File upload large
FileUploadForm(
  allowMultiple: false,
  enabled: true,
  size: FormSize.large,
  onFilesSelected: (files) {},
),
''',
                  height: 480,
                ),

                SizedBox(height: kDefaultPadding),

                // Upload with Preview & Avatar Upload
                LayoutBuilder(
                  builder: (context, constraints) {
                    int numberOfCardsPerRow = getNumberOfCardsPerRow_2(context);
                    return Wrap(
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: Column(
                            children: [
                              ShowCodeCard(
                                cardTitle: 'Upload with Preview Zone',
                                description:
                                    'Use <code>UploadPreview()</code> for file uploads with image previews.',
                                uiView: UploadPreview(
                                  onFilesChanged: (fileNames, webFiles) {
                                    // do something with your files
                                  },
                                ),
                                codeView: '''
UploadPreview(
  onFilesChanged: (fileNames, webFiles) {
    // do something with your files
  },
),
''',
                                height: 200,
                              ),
                              SizedBox(height: kDefaultPadding),
                              ShowCodeCard(
                                cardTitle:
                                    'Upload with Preview Zone (with validation)',
                                description:
                                    'Use <code>UploadPreview()</code> with <code>validator</code> to validate uploaded files. The validator function receives file names and web files, and returns an error message if validation fails.',
                                uiView: UploadPreview(
                                  validator: (fileNames, webFiles) {
                                    final totalFiles =
                                        fileNames.length + webFiles.length;
                                    if (totalFiles > 3) {
                                      return 'Maximum 3 files allowed';
                                    }
                                    if (totalFiles == 0) {
                                      return null; // No error
                                    }
                                    // Check file size (max 5MB per file)
                                    const maxSizeBytes = 5 * 1024 * 1024; // 5MB
                                    for (var file in webFiles) {
                                      if (file['bytes'] != null &&
                                          file['bytes'].length > maxSizeBytes) {
                                        return 'File size must be less than 5MB';
                                      }
                                    }
                                    // Check if all files are images or documents
                                    final allFiles = [
                                      ...fileNames,
                                      ...webFiles.map(
                                        (f) => f['name'] as String,
                                      ),
                                    ];
                                    final allowedExtensions = [
                                      'jpg',
                                      'jpeg',
                                      'png',
                                      'gif',
                                      'bmp',
                                      'pdf',
                                      'doc',
                                      'docx',
                                    ];
                                    for (var fileName in allFiles) {
                                      final extension = fileName
                                          .split('.')
                                          .last
                                          .toLowerCase();
                                      if (!allowedExtensions.contains(
                                        extension,
                                      )) {
                                        return 'Only images (JPG, PNG, GIF, BMP) and documents (PDF, DOC, DOCX) are allowed';
                                      }
                                    }
                                    return null; // No error
                                  },
                                  onFilesChanged: (fileNames, webFiles) {
                                    // Handle validated files
                                    debugPrint(
                                      'Files uploaded: ${fileNames.length + webFiles.length}',
                                    );
                                  },
                                ),
                                codeView: '''
UploadPreview(
  validator: (fileNames, webFiles) {
    final totalFiles = fileNames.length + webFiles.length;
    if (totalFiles > 3) {
      return 'Maximum 3 files allowed';
    }
    if (totalFiles == 0) {
      return null; // No error
    }
    // Check file size (max 5MB per file)
    const maxSizeBytes = 5 * 1024 * 1024; // 5MB
    for (var file in webFiles) {
      if (file['bytes'] != null && file['bytes'].length > maxSizeBytes) {
        return 'File size must be less than 5MB';
      }
    }
    // Check if all files are images or documents
    final allFiles = [...fileNames, ...webFiles.map((f) => f['name'] as String)];
    final allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'pdf', 'doc', 'docx'];
    for (var fileName in allFiles) {
      final extension = fileName.split('.').last.toLowerCase();
      if (!allowedExtensions.contains(extension)) {
        return 'Only images (JPG, PNG, GIF, BMP) and documents (PDF, DOC, DOCX) are allowed';
      }
    }
    return null; // No error
  },
  onFilesChanged: (fileNames, webFiles) {
    // Handle validated files
    debugPrint('Files uploaded: \${fileNames.length + webFiles.length}');
  },
),
''',
                                height: 420,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Avatar Upload',
                            description:
                                'Use <code>AvatarUpload()</code> or <code>AvatarUploadDotted()</code> for profile picture (avatar) uploader.',
                            uiView: Row(
                              children: [
                                AvatarUpload(
                                  maxSizeBytes: 2 * 1024 * 1024, // 2 MB
                                  allowedExtensions: ['jpg', 'jpeg', 'png'],
                                  radius: 60,
                                  enabled: true,
                                  onChanged: (file) {
                                    if (file != null) {
                                      debugPrint("Selected file: ${file.name}");
                                    } else {
                                      debugPrint("File removed");
                                    }
                                  },
                                ),
                                SizedBox(width: kDefaultPadding),
                                AvatarUploadDotted(
                                  instructionText:
                                      "Drop or browse image (JPG, PNG)",
                                  maxSizeBytes: 2 * 1024 * 1024, // 2 MB
                                  allowedExtensions: ['jpg', 'jpeg', 'png'],
                                  radius: 60,
                                  enabled: true,
                                  onChanged: (file) {
                                    if (file != null) {
                                      debugPrint("Selected file: ${file.name}");
                                    } else {
                                      debugPrint("File removed");
                                    }
                                  },
                                ),
                              ],
                            ),
                            codeView: '''
AvatarUpload(
  maxSizeBytes: 2 * 1024 * 1024, // 2 MB
  allowedExtensions: ['jpg', 'jpeg', 'png'],
  radius: 60,
  enabled: true,
  onChanged: (){},
),

AvatarUploadDotted(
  instructionText:
      "Drop or browse image (JPG, PNG)",
  maxSizeBytes: 2 * 1024 * 1024, // 2 MB
  allowedExtensions: ['jpg', 'jpeg', 'png'],
  radius: 60,
  enabled: true,
  onChanged: (){},
),
''',
                            height: 400,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // Footer
          const PortalFooter(),
        ],
      ),
    );
  }
}
