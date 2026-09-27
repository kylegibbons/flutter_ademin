import 'package:flutter/material.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/email/email_data.dart';
import 'package:flutkit_ademin/demo/app/email/email_models.dart';
import 'package:flutkit_ademin/demo/app/email/widgets/email_detail_view.dart';
import 'package:flutkit_ademin/demo/app/email/widgets/email_list.dart';
import 'package:flutkit_ademin/demo/app/email/widgets/email_sidebar.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  late final EmailService emailService;
  List<Email> allEmails = [];
  List<Email> emails = [];

  Email? selectedEmail;
  EmailFolder? folderSelected = EmailFolder.inbox;
  EmailCategory? categorySelected;
  late QuillController _quillController;
  late TextEditingController toController;
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final Set<String> selectedEmailIds = {};

  bool _showReplyEditor = false;
  bool _showForwardEditor = false;

  bool get allSelected =>
      emails.every((email) => selectedEmailIds.contains(email.id));
  bool get noneSelected =>
      emails.every((email) => !selectedEmailIds.contains(email.id));
  bool get someSelected => !allSelected && !noneSelected;

  int _currentPage = 0;
  final int _pageSize = 20;
  List<Email> _visibleEmails = [];

  @override
  void initState() {
    super.initState();

    toController = TextEditingController();
    emailService = EmailService(emails: buildDummyEmails());
    allEmails = emailService.getAllEmails();
    emails = emailService.filterByFolder(EmailFolder.inbox);
    _updateVisibleEmails();
    _quillController = QuillController.basic();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final pageTitle = Lang.of(context).email;
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  void _onFolderSelected(EmailFolder folder) {
    setState(() {
      folderSelected = folder;
      categorySelected = null;
      emails = emailService.filterByFolder(folder);
      _currentPage = 0;
      selectedEmail = null;
    });
    _updateVisibleEmails();
  }

  void _onCategorySelected(EmailCategory category) {
    setState(() {
      categorySelected = category;
      folderSelected = null;
      emails = emailService.filterByCategory(category);
      _currentPage = 0;
      selectedEmail = null;
    });
    _updateVisibleEmails();
  }

  void onEmailTap(Email email) {
    setState(() {
      selectedEmail = email;
      _showReplyEditor = false;
      _showForwardEditor = false;
      toController.clear();
      subjectController.clear();
      contentController.clear();
    });
  }

  void _onBackToList() {
    setState(() {
      selectedEmail = null;
    });
  }

  @override
  void dispose() {
    _quillController.dispose();
    _scrollController.dispose();
    toController.dispose();
    subjectController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void toggleSelectAll() {
    setState(() {
      if (allSelected || someSelected) {
        for (final email in emails) {
          selectedEmailIds.remove(email.id);
        }
      } else {
        selectedEmailIds.addAll(emails.map((email) => email.id));
      }
    });
  }

  void toggleSelectOne(String id) {
    setState(() {
      if (selectedEmailIds.contains(id)) {
        selectedEmailIds.remove(id);
      } else {
        selectedEmailIds.add(id);
      }
    });
  }

  void toggleStar(Email email) {
    setState(() {
      if (email.folder == EmailFolder.starred) {
        email.folder = EmailFolder.inbox;
      } else {
        email.folder = EmailFolder.starred;
      }
    });
  }

  void _performBulkAction(EmailFolder targetFolder) {
    setState(() {
      emails = emails.map((email) {
        if (selectedEmailIds.contains(email.id)) {
          return Email(
            id: email.id,
            sender: email.sender,
            senderName: email.senderName,
            subject: email.subject,
            recipient: email.recipient,
            body: email.body,
            timestamp: email.timestamp,
            isRead: email.isRead,
            folder: targetFolder,
            category: email.category,
            cc: email.cc,
            bcc: email.bcc,
          );
        }
        return email;
      }).toList();
      selectedEmailIds.clear();
    });
  }

  void _markSelectedAsRead() {
    setState(() {
      emails = emails.map((email) {
        if (selectedEmailIds.contains(email.id)) {
          return Email(
            id: email.id,
            sender: email.sender,
            senderName: email.senderName,
            subject: email.subject,
            recipient: email.recipient,
            body: email.body,
            timestamp: email.timestamp,
            isRead: true,
            folder: email.folder,
            category: email.category,
            cc: email.cc,
            bcc: email.bcc,
          );
        }
        return email;
      }).toList();

      selectedEmailIds.clear();
    });
  }

  void _updateVisibleEmails() {
    final start = _currentPage * _pageSize;
    final end = start + _pageSize;

    setState(() {
      _visibleEmails = emails.sublist(
        start,
        end > emails.length ? emails.length : end,
      );
    });
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 350), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  String formatFullDateWithRelative(DateTime timestamp) {
    final now = DateTime.now();
    final dateFormat = DateFormat('MMMM d, y, h:mm a');
    final formattedDate = dateFormat.format(timestamp);

    final difference = now.difference(timestamp);

    String relativeTime;
    if (difference.inDays >= 1) {
      relativeTime =
          '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      relativeTime =
          '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 1) {
      relativeTime =
          '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      relativeTime = 'just now';
    }

    return '$formattedDate ($relativeTime)';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= kScreenWidthLg;

    Widget mainContent;

    if (isDesktop) {
      mainContent = Row(
        children: [
          EmailSidebar(
            emailService: emailService,
            folderSelected: folderSelected,
            categorySelected: categorySelected,
            onFolderSelected: _onFolderSelected,
            onCategorySelected: _onCategorySelected,
          ),
          Expanded(
            child: selectedEmail == null
                ? _buildEmailList(context)
                : _buildEmailDetailView(),
          ),
        ],
      );
    } else {
      mainContent = selectedEmail == null
          ? _buildEmailList(context)
          : _buildEmailDetailView();
    }

    return PortalMasterLayout(body: mainContent);
  }

  Widget _buildEmailList(BuildContext context) {
    final totalPages = (emails.length / _pageSize).ceil();
    return EmailListView(
      visibleEmails: _visibleEmails,
      selectedEmailIds: selectedEmailIds,
      allSelected: allSelected,
      someSelected: someSelected,
      emailsLength: emails.length,
      currentPage: _currentPage,
      pageSize: _pageSize,
      onTapEmail: onEmailTap,
      onToggleSelectAll: toggleSelectAll,
      onToggleSelectOne: toggleSelectOne,
      onToggleStar: toggleStar,
      onBulkAction: _performBulkAction,
      onMarkSelectedAsRead: _markSelectedAsRead,
      onPreviousPage: _currentPage > 0
          ? () {
              setState(() {
                _currentPage--;
              });
              _updateVisibleEmails();
            }
          : null,
      onNextPage: (_currentPage + 1) < totalPages
          ? () {
              setState(() {
                _currentPage++;
              });
              _updateVisibleEmails();
            }
          : null,
      mobileSidebarBuilder: (_) => EmailSidebar(
        emailService: emailService,
        folderSelected: folderSelected,
        categorySelected: categorySelected,
        onFolderSelected: _onFolderSelected,
        onCategorySelected: _onCategorySelected,
      ),
    );
  }

  Widget _buildEmailDetailView() {
    return EmailDetailView(
      selectedEmail: selectedEmail!,
      isReplyEditorVisible: _showReplyEditor,
      isForwardEditorVisible: _showForwardEditor,
      quillController: _quillController,
      toController: toController,
      scrollController: _scrollController,
      onBack: _onBackToList,
      onBulkAction: _performBulkAction,
      onMarkSelectedAsRead: _markSelectedAsRead,
      onToggleStar: toggleStar,
      onToggleReplyEditor: () {
        setState(() {
          _showReplyEditor = !_showReplyEditor;
          _showForwardEditor = false;
          toController.text =
              'Reply to: ${selectedEmail!.senderName} <${selectedEmail!.sender}>';
        });
        scrollToBottom();
      },
      onToggleForwardEditor: () {
        setState(() {
          _showForwardEditor = !_showForwardEditor;
          _showReplyEditor = false;
          toController.text = '';
        });
        scrollToBottom();
      },
      formatFullDateWithRelative: formatFullDateWithRelative,
    );
  }
}
