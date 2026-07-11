import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/chip.dart';
import 'package:flutter_ademin/widgets/base_ui/dialog.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutter_ademin/widgets/form/form_dropdown.dart';
import 'package:flutter_ademin/widgets/form/form_editor.dart';
import 'package:flutter_ademin/widgets/form/form_input_mask.dart';
import 'package:flutter_ademin/widgets/form/form_slider.dart';
import 'package:flutter_ademin/widgets/form/form_validator.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';

class CreateProjectForm extends StatefulWidget {
  const CreateProjectForm({super.key});

  @override
  State<CreateProjectForm> createState() => _CreateProjectFormState();
}

class _CreateProjectFormState extends State<CreateProjectForm> {
  final _createProjectFormKey = GlobalKey<FormState>();

  // Controllers
  final projectNameController = TextEditingController();
  final customerNameController = TextEditingController();
  final rateController = TextEditingController();
  final hoursController = TextEditingController();
  final memberNameController = TextEditingController();
  final startDateController = TextEditingController();
  final dueDateController = TextEditingController();
  final descriptionController = QuillController.basic();

  // Checkbox Status
  bool _calculateProgressTask = true;
  final bool _sendProjectToClient = false;
  bool _allowViewTasks = true;
  bool _allowCreateTasks = true;
  bool _allowEditTasks = true;
  bool _allowComment = true;
  bool _allowViewComments = true;
  bool _allowViewAttachments = true;
  bool _allowViewChecklist = true;
  bool _allowUploadAttachments = true;
  bool _allowViewLoggedTime = true;
  bool _allowViewFinance = true;
  bool _allowUploadFiles = false;
  bool _allowOpenDiscussions = false;
  bool _allowViewMilestones = true;
  bool _allowViewGantt = true;
  bool _allowViewTimesheets = true;
  bool _allowViewActivityLog = true;
  bool _allowViewTeamMembers = true;
  bool _hideProjectTasks = false;

  double _progress = 0;

  // local state for dropdown
  String? _selectedBillingType;
  String? _selectedStatus = 'inProgress';
  String? _startDate;
  List<String>? _projectTags;

  // Customer list
  final List<String> _customers = const [
    'Alice Johnson',
    'Benjamin Carter',
    'Catherine Lopez',
    'Fatimah Az Zahra',
    'David Smith',
    'Uwais Jamerson',
    'Ella Peterson',
    'Franklin Moore',
    'Grace Kim',
    'Henry Lee',
    'Isabella Brown',
    'Jack Wilson',
    'Umar Smith',
    'Katherine Davis',
    'Liam Nguyen',
    'Mia Gonzalez',
    'Noah Anderson',
    'Olivia Martinez',
  ];

  // Members list
  final List<String> _members = const [
    'Aiden Walker',
    'Bianca Rossi',
    'Caleb Johnson',
    'Diana Park',
    'Ethan Carter',
    'Farah Hussein',
    'Gabriel Silva',
    'Hannah Cooper',
    'Ibrahim Khan',
    'Julia Thompson',
    'Kai Nakamura',
    'Layla Robinson',
    'Marcus Allen',
    'Natalie Fernandez',
    'Omar Patel',
    'Priya Desai',
    'Quentin Lewis',
    'Riley Adams',
  ];

  // Select Customer Dialog
  Future<void> _showCustomerDialog() async {
    final searchController = TextEditingController();
    List<String> filteredCustomers = List.from(_customers);
    final themeData = Theme.of(context);
    final selectedCustomer = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            void filterCustomers(String query) {
              setDialogState(() {
                filteredCustomers = _customers
                    .where(
                      (customer) => customer.toLowerCase().contains(
                        query.toLowerCase().trim(),
                      ),
                    )
                    .toList();
              });
            }

            return CustomDialog(
              showCloseButton: true,
              animation: DialogAnimation.flip,
              contentPadding: EdgeInsets.only(
                top: kDefaultPadding,
                right: kDefaultPadding,
                left: kDefaultFontSize,
                bottom: kDefaultPadding,
              ),
              content: Column(
                children: [
                  // Title
                  Text(
                    'Choose Customer',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: kBodyLarge,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: kDefaultPadding),

                  //  Search Field
                  CustomTextField(
                    controller: searchController,
                    hintText: 'Search customer...',
                    onChanged: filterCustomers,
                  ),
                  const SizedBox(height: kDefaultPadding),

                  //  Customer List
                  Expanded(
                    child: SingleChildScrollView(
                      child: filteredCustomers.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Text(
                                'No customers found',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: filteredCustomers.length,
                              separatorBuilder: (_, _) => const Divider(
                                height: 0,
                                thickness: outlineWidth,
                              ),
                              itemBuilder: (context, index) {
                                final customer = filteredCustomers[index];
                                return InkWell(
                                  onTap: () => Navigator.pop(context, customer),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                      vertical: kDefaultPadding,
                                    ),
                                    child: Text(
                                      customer,
                                      style: TextStyle(
                                        color: themeData.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (selectedCustomer != null && selectedCustomer.isNotEmpty) {
      setState(() {
        customerNameController.text = selectedCustomer;
      });

      debugPrint('Selected customer: $selectedCustomer');
      debugPrint('Controller value: ${customerNameController.text}');
    }
  }

  // Select Member Dialog
  Future<void> _showMemberDialog() async {
    final searchMemberController = TextEditingController();
    // list to accommodate TEMPORARILY selected members
    List<String> selectedMembersInDialog = List.from(
      memberNameController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty),
    );

    List<String> filteredMembers = List.from(_members);
    final themeData = Theme.of(context);

    // Change return type to List<String>?
    final selectedMembers = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            void filterCustomers(String query) {
              setDialogState(() {
                filteredMembers = _members
                    .where(
                      (member) => member.toLowerCase().contains(
                        query.toLowerCase().trim(),
                      ),
                    )
                    .toList();
              });
            }

            // Function to manage member options
            void toggleMemberSelection(String member) {
              setDialogState(() {
                if (selectedMembersInDialog.contains(member)) {
                  selectedMembersInDialog.remove(member);
                } else {
                  selectedMembersInDialog.add(member);
                }
              });
            }

            // Check if member has been selected
            bool isMemberSelected(String member) {
              return selectedMembersInDialog.contains(member);
            }

            return CustomDialog(
              showCloseButton: true,
              animation: DialogAnimation.flip,
              contentPadding: EdgeInsets.only(
                top: kDefaultPadding / 2,
                right: kDefaultPadding,
                left: kDefaultFontSize,
                bottom: kDefaultPadding,
              ),
              content: Column(
                children: [
                  // Title
                  Text(
                    'Select Members',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: kBodyLarge,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: kDefaultPadding),

                  //  Search Field
                  CustomTextField(
                    controller: searchMemberController,
                    hintText: 'Search member...',
                    onChanged: filterCustomers,
                  ),
                  const SizedBox(height: kDefaultPadding),

                  // Display the selected members
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    child: Text(
                      'Selected: ${selectedMembersInDialog.isEmpty ? 'None' : selectedMembersInDialog.join(', ')}',
                      style: TextStyle(
                        fontSize: kBodyMedium,
                        color: kSecondaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  const Divider(height: 0),

                  //  Customer List
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: filteredMembers.length,
                      separatorBuilder: (_, _) =>
                          const Divider(height: 0, thickness: outlineWidth),
                      itemBuilder: (context, index) {
                        final member = filteredMembers[index];
                        final isSelected = isMemberSelected(member);
                        return InkWell(
                          // Options are changed to toggle (add/remove)
                          onTap: () => toggleMemberSelection(member),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    member,
                                    style: TextStyle(
                                      color: isSelected
                                          ? kSecondaryColor
                                          : themeData.colorScheme.onSurface,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                                // Show check icon if selected
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: kSecondaryColor,
                                    size: 18,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: kDefaultPadding),

                  // Confirmation Button (Select/Done)
                  CustomElevatedButton(
                    kText: 'Done',
                    bgColor: kSuccessColor,
                    kTextColor: Colors.white,
                    isFullWidth: true,
                    onPressed: () =>
                        Navigator.pop(context, selectedMembersInDialog),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (selectedMembers != null) {
      setState(() {
        // Concatenate the selected member list into a string with commas
        memberNameController.text = selectedMembers.join(', ');
      });
    }
  }
  // The setup for your controllers and state (not included here, but assumed to be the same)
  // ...

  void _createProject() {
    // 1. Form Validation
    // IMPORTANT: Always validate the form state first.
    if (_createProjectFormKey.currentState!.validate()) {
      // Retrieve content from the QuillController
      final delta = descriptionController.document.toDelta();
      // Get the JSON/Delta format (required for storing rich text formatting)
      final jsonDescription = delta.toJson();
      // Get the plain text version (useful for previews or search indexing)
      final plainTextDescription = descriptionController.document
          .toPlainText()
          .trim();

      // 2. Aggregate All Data into a Map/Object
      final projectData = {
        // Data from TextEditingControllers
        'projectName': projectNameController.text,
        'customerName': customerNameController.text,
        'rate': rateController
            .text, // Should be converted to double/int before final storage
        'hours': hoursController
            .text, // Should be converted to double/int before final storage
        'memberName': memberNameController.text,

        // Data from QuillController (Description)
        'description_json': jsonDescription,
        'description_plainText': plainTextDescription,

        // Data from Local State (Dropdown, Date, Tags)
        'billingType': _selectedBillingType,
        'status': _selectedStatus,
        'startDate': startDateController.text,
        'dueDate': dueDateController.text,
        'projectTags': _projectTags, // List<String>
        // Data from Progress
        'progress': _progress,

        // Data from Checkbox Status (Project Permissions)
        'permissions': {
          'calculateProgressTask': _calculateProgressTask,
          'sendProjectToClient': _sendProjectToClient,
          'allowViewTasks': _allowViewTasks,
          'allowCreateTasks': _allowCreateTasks,
          'allowEditTasks': _allowEditTasks,
          'allowComment': _allowComment,
          'allowViewComments': _allowViewComments,
          'allowViewAttachments': _allowViewAttachments,
          'allowViewChecklist': _allowViewChecklist,
          'allowUploadAttachments': _allowUploadAttachments,
          'allowViewLoggedTime': _allowViewLoggedTime,
          'allowViewFinance': _allowViewFinance,
          'allowUploadFiles': _allowUploadFiles,
          'allowOpenDiscussions': _allowOpenDiscussions,
          'allowViewMilestones': _allowViewMilestones,
          'allowViewGantt': _allowViewGantt,
          'allowViewTimesheets': _allowViewTimesheets,
          'allowViewActivityLog': _allowViewActivityLog,
          'allowViewTeamMembers': _allowViewTeamMembers,
          'hideProjectTasks': _hideProjectTasks,
        },
      };

      // 3. Display Data Using debugPrint
      debugPrint('--- 🚀 DATA SUBMITTED START ---');
      debugPrint('Project Data:');

      // Print main data in a readable format
      projectData.forEach((key, value) {
        if (key != 'description_json' && key != 'permissions') {
          debugPrint('  $key: $value');
        }
      });

      // Print Description JSON (for database storage)
      debugPrint('\n--- Description (JSON Delta) ---');
      debugPrint(jsonDescription.toString());

      // Print Permissions/Checkboxes
      debugPrint('\n--- Permissions/Checkbox Status ---');
      (projectData['permissions'] as Map).forEach((key, value) {
        debugPrint('  $key: $value');
      });

      debugPrint('--- 🏁 DATA SUBMITTED END ---');

      // This is where you would call your service/repository to send 'projectData' to the API.
    } else {
      // Validation failed
      debugPrint('Form is invalid. Please check all required fields.');
    }
  }

  // start date picker function
  Future<void> pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      startDateController.text = DateFormat('EEEE, d MMMM yyyy').format(picked);
    }
  }

  // due date picker function
  Future<void> pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dueDateController.text = DateFormat('EEEE, d MMMM yyyy').format(picked);
    }
  }

  @override
  void initState() {
    super.initState();
    // Initial _startDate value
    _startDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    startDateController.text = _startDate!;
  }

  @override
  void dispose() {
    startDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Form(
        key: _createProjectFormKey,
        child: AdaptiveWrap(
          breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
          columnRatios: [0.65, 0.35],
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PROJECT DETAILS

                    // project name
                    FormLabel(text: 'Project Name'),
                    SizedBox(height: kDefaultPadding / 2),
                    CustomTextFormField(
                      controller: projectNameController,
                      hintText: 'Type Project Name',
                      suffixIcon: Icons.person_outline,
                      validator: (value) => Validators.requiredField(
                        value,
                        context,
                        customMessage: 'Project Name is required',
                      ),
                    ),
                    SizedBox(height: kDefaultPadding),

                    // customer
                    FormLabel(text: 'Customer'),
                    SizedBox(height: kDefaultPadding / 2),

                    ConstrainedBox(
                      constraints: BoxConstraints(minHeight: mediumHeight),
                      child: TextFormField(
                        controller: customerNameController,
                        readOnly: true,
                        mouseCursor: SystemMouseCursors.click,
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Select Customer',
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                        ),
                        validator: (value) => Validators.requiredField(
                          value,
                          context,
                          customMessage: 'Customer must be selected',
                        ),
                        onTap: _showCustomerDialog,
                      ),
                    ),

                    SizedBox(height: kDefaultPadding),

                    // progress
                    CustomCheckbox(
                      value: _calculateProgressTask,
                      label: 'Calculate progress through tasks',
                      onChanged: (value) {
                        setState(() {
                          _calculateProgressTask = value ?? false;
                          if (_calculateProgressTask) {
                            _progress = 0; // reset ke 0%
                          }
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    //  Progress Text
                    FormLabel(
                      text: 'Progress: ${_progress.toInt()}%',
                      showRequired: false,
                    ),

                    SizedBox(height: kDefaultPadding),

                    // Progress slider
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: mediumHeight * 0.6,
                        overlayColor: Colors.transparent,
                        activeTrackColor: Colors.transparent,
                        inactiveTrackColor: Colors.transparent,
                        // custom track
                        trackShape: BorderedTrackShape(
                          fillColor:
                              themeData.colorScheme.surfaceContainerHighest,
                          borderColor: themeData.colorScheme.outline,
                          borderRadius: defaultRadius / 2,
                          borderWidth: outlineWidth,
                        ),
                        // custom thumb
                        thumbShape: RectangularThumbShape(
                          color: kSuccessColor,
                          width: 12,
                          height: mediumHeight,
                          borderRadius: defaultRadius / 2,
                        ),
                      ),
                      child: Slider(
                        value: _progress,
                        min: 0,
                        max: 100,
                        onChanged: _calculateProgressTask
                            ? null // disable if checkbox active
                            : (value) {
                                setState(() {
                                  _progress = value;
                                });
                              },
                      ),
                    ),
                    SizedBox(height: kDefaultPadding),

                    AdaptiveWrap(
                      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
                      columnRatios: [1 / 2, 1 / 2],
                      children: [
                        // Billing Type
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormLabel(text: 'Billing Type'),
                            SizedBox(height: kDefaultPadding / 2),
                            CustomDropdownFormField<String>(
                              hint: 'Choose Billing Type',
                              items: [
                                DropdownMenuItem(
                                  value: "fixedRate",
                                  child: Text(
                                    "Fixed Rate",
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "projectHours",
                                  child: Text(
                                    "Project Hours",
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "taskHours",
                                  child: Text(
                                    "Task Hours",
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                              initialValue: _selectedBillingType,
                              onChanged: (value) =>
                                  setState(() => _selectedBillingType = value),
                              validator: (value) => Validators.requiredField(
                                value,
                                context,
                                customMessage: 'Billing type must be selected',
                              ),
                            ),
                          ],
                        ),

                        // Status
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormLabel(text: 'Status', showRequired: false),
                            SizedBox(height: kDefaultPadding / 2),
                            CustomDropdownFormField<String>(
                              hint: 'Choose Project Status',
                              items: [
                                DropdownMenuItem(
                                  value: "notStarted",
                                  child: Text(
                                    "Not Started",
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "inProgress",
                                  child: Text(
                                    "In Progress",
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "onHold",
                                  child: Text(
                                    "On Hold",
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "cancelled",
                                  child: Text(
                                    "Cancelled",
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "finished",
                                  child: Text(
                                    "Finished",
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                              initialValue: _selectedStatus,
                              onChanged: (value) =>
                                  setState(() => _selectedStatus = value),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: kDefaultPadding),

                    //Rate Per Hours
                    FormLabel(text: 'Rate Per Hours', showRequired: false),
                    SizedBox(height: kDefaultPadding / 2),

                    CustomTextFormField(
                      hintText: 'Enter Rate',
                      controller: rateController,
                      keyboardType: TextInputType.number,
                      suffixIcon: Icons.attach_money,
                      inputFormatters: [
                        InputMask.currency(
                          currencyCode: 'USD',
                          showCent: false,
                        ),
                      ],
                    ),

                    SizedBox(height: kDefaultPadding),

                    AdaptiveWrap(
                      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
                      columnRatios: [1 / 2, 1 / 2],
                      children: [
                        // estimated hours
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormLabel(
                              text: 'Estimated Hours',
                              showRequired: false,
                            ),
                            SizedBox(height: kDefaultPadding / 2),
                            CustomTextFormField(
                              hintText: 'Enter Hours',
                              controller: hoursController,
                              keyboardType: TextInputType.number,
                              suffixIcon: Icons.timer_outlined,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ],
                        ),

                        // members
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormLabel(text: 'Members', showRequired: true),
                            SizedBox(height: kDefaultPadding / 2),
                            TextFormField(
                              controller: memberNameController,
                              readOnly: true,
                              mouseCursor: SystemMouseCursors.click,
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Select Members',
                                suffixIcon: Icon(Icons.keyboard_arrow_down),
                              ),
                              validator: (value) => Validators.requiredField(
                                value,
                                context,
                                customMessage: 'Member must be selected',
                              ),
                              onTap: _showMemberDialog,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: kDefaultPadding),

                    AdaptiveWrap(
                      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
                      columnRatios: [1 / 2, 1 / 2],
                      children: [
                        // Start Date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormLabel(text: 'Start Date', showRequired: false),
                            SizedBox(height: kDefaultPadding / 2),
                            CustomTextFormField(
                              controller: startDateController,
                              readOnly: true, // set as read only
                              mouseCursor:
                                  SystemMouseCursors.click, // set click cursor
                              hintText: 'Select Start Date',
                              suffixIcon: Icons.calendar_today_outlined,
                              // initialize custom date picker
                              onTap: pickStartDate,
                            ),
                          ],
                        ),

                        // Deadline
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormLabel(text: 'Due Date', showRequired: false),
                            SizedBox(height: kDefaultPadding / 2),
                            CustomTextFormField(
                              controller: dueDateController,
                              readOnly: true, // set as read only
                              mouseCursor:
                                  SystemMouseCursors.click, // set click cursor
                              hintText: 'Select Due Date',
                              suffixIcon: Icons.calendar_today_outlined,
                              // initialize custom date picker
                              onTap: pickDueDate,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: kDefaultPadding),

                    // Tag input field
                    Row(
                      children: [
                        Icon(
                          Icons.sell,
                          color: themeData.colorScheme.onSurface,
                          size: 16,
                        ),
                        SizedBox(width: kDefaultPadding / 4),
                        FormLabel(text: 'Tags', showRequired: false),
                      ],
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    ChipInputField(
                      initialTags: ['bug', 'important'],
                      suggestions: [
                        'bug',
                        'follow up',
                        'important',
                        'logo',
                        'review',
                        'todo',
                        'tomorrow',
                        'wordpress',
                      ],
                      onChanged: (tags) => setState(() => _projectTags = tags),
                    ),

                    SizedBox(height: kDefaultPadding),

                    // Description
                    FormLabel(text: 'Description', showRequired: false),
                    SizedBox(height: kDefaultPadding / 2),

                    QuillEditorCustom(
                      controller: descriptionController,
                      height: 400,
                    ),

                    SizedBox(height: kDefaultPadding),

                    // Send email to client
                    CustomCheckbox(
                      value: _sendProjectToClient,
                      label: 'Send project created email',
                      onChanged: (value) {},
                    ),

                    SizedBox(height: kDefaultPadding),

                    // Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Delete
                        CustomElevatedButton(
                          kText: 'Delete',
                          bgColor: kErrorColor,
                          kTextColor: Colors.white,
                          onPressed: () {},
                        ),

                        SizedBox(width: kDefaultPadding / 2),

                        // Draft
                        CustomElevatedButton(
                          kText: 'Draft',
                          bgColor: kInfoColor,
                          kTextColor: Colors.white,
                          onPressed: () {},
                        ),
                        SizedBox(width: kDefaultPadding / 2),

                        // Create
                        CustomElevatedButton(
                          kText: 'Create',
                          bgColor: kSuccessColor,
                          kTextColor: Colors.white,
                          onPressed: () {
                            _createProject();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // PROJECT SETTINGS
            Card(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 1: Allow customer to view tasks
                    CustomCheckbox(
                      value: _allowViewTasks,
                      label: 'Allow customer to view tasks',
                      onChanged: (value) {
                        setState(() {
                          _allowViewTasks = value ?? false;
                        });
                      },
                    ),

                    SizedBox(height: kDefaultPadding),
                    // 2: Allow customer to create tasks
                    CustomCheckbox(
                      value: _allowCreateTasks,
                      label: 'Allow customer to create tasks',
                      onChanged: (value) {
                        setState(() {
                          _allowCreateTasks = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 3: Allow customer to edit tasks...
                    CustomCheckbox(
                      value: _allowEditTasks,
                      label:
                          'Allow customer to edit tasks (only edit tasks created from contact)',
                      onChanged: (value) {
                        setState(() {
                          _allowEditTasks = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 4: Allow customer to comment on project tasks
                    CustomCheckbox(
                      value: _allowComment,
                      label: 'Allow customer to comment on project tasks',
                      onChanged: (value) {
                        setState(() {
                          _allowComment = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 5: Allow customer to view task comments
                    CustomCheckbox(
                      value: _allowViewComments,
                      label: 'Allow customer to view task comments',
                      onChanged: (value) {
                        setState(() {
                          _allowViewComments = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 6: Allow customer to view task attachments
                    CustomCheckbox(
                      value: _allowViewAttachments,
                      label: 'Allow customer to view task attachments',
                      onChanged: (value) {
                        setState(() {
                          _allowViewAttachments = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 7: Allow customer to view task checklist items
                    CustomCheckbox(
                      value: _allowViewChecklist,
                      label: 'Allow customer to view task checklist items',
                      onChanged: (value) {
                        setState(() {
                          _allowViewChecklist = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 8: Allow customer to upload attachments on tasks
                    CustomCheckbox(
                      value: _allowUploadAttachments,
                      label: 'Allow customer to upload attachments on tasks',
                      onChanged: (value) {
                        setState(() {
                          _allowUploadAttachments = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 9: Allow customer to view task total logged time
                    CustomCheckbox(
                      value: _allowViewLoggedTime,
                      label: 'Allow customer to view task total logged time',
                      onChanged: (value) {
                        setState(() {
                          _allowViewLoggedTime = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 10: Allow customer to view finance overview
                    CustomCheckbox(
                      value: _allowViewFinance,
                      label: 'Allow customer to view finance overview',
                      onChanged: (value) {
                        setState(() {
                          _allowViewFinance = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 11: Allow customer to upload files (TIDAK dicentang)
                    CustomCheckbox(
                      value: _allowUploadFiles,
                      label: 'Allow customer to upload files',
                      onChanged: (value) {
                        setState(() {
                          _allowUploadFiles = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 12: Allow customer to open discussions (TIDAK dicentang)
                    CustomCheckbox(
                      value: _allowOpenDiscussions,
                      label: 'Allow customer to open discussions',
                      onChanged: (value) {
                        setState(() {
                          _allowOpenDiscussions = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 13: Allow customer to view milestones
                    CustomCheckbox(
                      value: _allowViewMilestones,
                      label: 'Allow customer to view milestones',
                      onChanged: (value) {
                        setState(() {
                          _allowViewMilestones = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 14: Allow customer to view Gantt
                    CustomCheckbox(
                      value: _allowViewGantt,
                      label: 'Allow customer to view Gantt',
                      onChanged: (value) {
                        setState(() {
                          _allowViewGantt = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 15: Allow customer to view timesheets
                    CustomCheckbox(
                      value: _allowViewTimesheets,
                      label: 'Allow customer to view timesheets',
                      onChanged: (value) {
                        setState(() {
                          _allowViewTimesheets = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 16: Allow customer to view activity log
                    CustomCheckbox(
                      value: _allowViewActivityLog,
                      label: 'Allow customer to view activity log',
                      onChanged: (value) {
                        setState(() {
                          _allowViewActivityLog = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 17: Allow customer to view team members
                    CustomCheckbox(
                      value: _allowViewTeamMembers,
                      label: 'Allow customer to view team members',
                      onChanged: (value) {
                        setState(() {
                          _allowViewTeamMembers = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: kDefaultPadding),

                    // 18: Hide project tasks on main tasks table (admin area) (TIDAK dicentang)
                    CustomCheckbox(
                      value: _hideProjectTasks,
                      label:
                          'Hide project tasks on main tasks table (admin area)',
                      onChanged: (value) {
                        setState(() {
                          _hideProjectTasks = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
