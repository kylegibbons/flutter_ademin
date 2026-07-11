import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/support_ticket/widgets/create_ticket_attachment.dart';
import 'package:flutter_ademin/demo/app/support_ticket/widgets/create_ticket_form.dart';
import 'package:flutter_ademin/demo/app/support_ticket/widgets/create_ticket_client_info.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class TicketCreateScreen extends StatefulWidget {
  const TicketCreateScreen({super.key});

  @override
  State<TicketCreateScreen> createState() => _TicketCreateScreenState();
}

class _TicketCreateScreenState extends State<TicketCreateScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _subjectController;
  late TextEditingController _descriptionController;
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _companyController;

  String _ticketId = '';
  String _selectedPriority = 'medium';
  List<String> _uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _subjectController = TextEditingController();
    _descriptionController = TextEditingController();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _companyController = TextEditingController();

    // Generate auto ticket ID
    _ticketId = _generateTicketId();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = 'Create ${Lang.of(context).ticket(1)}';
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  String _generateTicketId() {
    // Simple ticket ID generation - in production, this would come from the backend
    final timestamp = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(5);
    return 'TKT-${timestamp.substring(0, 6).toUpperCase()}';
  }

  void _submitTicket() {
    if (_formKey.currentState!.validate()) {
      // In production, this would send data to backend
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ticket $_ticketId created successfully! (${_uploadedFiles.length} attachments)',
          ),
          backgroundColor: kSuccessColor,
        ),
      );
    }
  }

  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ticket draft saved successfully!'),
        backgroundColor: kInfoColor,
      ),
    );
  }

  void _cancelCreation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Ticket Creation?'),
        content: const Text('All changes will be lost. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue Editing'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Cancel Ticket'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final lang = Lang.of(context);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;

    return PortalMasterLayout(
      body: ListView(
        children: [
          // header
          PageHeader(
            title: '${Lang.of(context).create} ${Lang.of(context).ticket(1)}'
                .toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(
                label:
                    '${Lang.of(context).create} ${Lang.of(context).ticket(1)}',
                uri: '',
              ),
            ],
          ),
          // form content
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Form(
              key: _formKey,
              child: AdaptiveWrap(
                breakpoints: {kScreenWidthXl: 1, kScreenWidthXxl: 2},
                columnRatios: [0.7, 0.3],
                children: [
                  // main form section
                  Column(
                    children: [
                      // ticket form
                      CreateTicketForm(
                        ticketId: _ticketId,
                        subjectController: _subjectController,
                        priorityValue: _selectedPriority,
                        onPriorityChanged: (value) {
                          setState(() => _selectedPriority = value ?? 'medium');
                        },
                      ),
                    ],
                  ),

                  // sidebar section
                  Column(
                    children: [
                      // client contact information
                      CreateTicketClient(
                        fullNameController: _fullNameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        companyController: _companyController,
                      ),

                      // attachment section
                      CreateTicketAttachment(
                        onFilesChanged: (files) {
                          setState(() => _uploadedFiles = files);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // action buttons
          Container(
            padding: EdgeInsetsDirectional.only(
              start: kDefaultPadding,
              end: kDefaultPadding,
            ),
            child: Row(
              children: [
                // Cancel button
                isMobile
                    ? CustomIconButton(
                        icon: Icons.close,
                        isOutlined: true,
                        outlineColor: kErrorColor,
                        iconColor: kErrorColor,
                        onTap: _cancelCreation,
                      )
                    : CustomOutlinedButton(
                        kText: 'Cancel',
                        outlineColor: kErrorColor,
                        kLeadingIcon: Icons.close,
                        onPressed: _cancelCreation,
                      ),
                Spacer(),

                // Save Draft button
                isMobile
                    ? CustomIconButton(
                        icon: Icons.save_outlined,
                        isOutlined: true,
                        outlineColor: themeData.colorScheme.primary,
                        iconColor: themeData.colorScheme.primary,
                        onTap: _saveDraft,
                      )
                    : CustomOutlinedButton(
                        kText: 'Save Draft',
                        outlineColor: themeData.colorScheme.primary,
                        kLeadingIcon: Icons.save_outlined,
                        onPressed: _saveDraft,
                      ),

                const SizedBox(width: kDefaultPadding),

                // Submit button
                FlatButton(
                  kText: 'Submit Ticket',
                  bgColor: kSuccessColor,
                  kTextColor: Colors.white,
                  kLeadingIcon: Icons.check_circle_outline,
                  onPressed: _submitTicket,
                ),
              ],
            ),
          ),

          SizedBox(height: kDefaultPadding),

          // footer
          const PortalFooter(),
        ],
      ),
    );
  }
}
