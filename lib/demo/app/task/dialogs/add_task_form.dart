import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/project/project_data.dart';
import 'package:flutkit_ademin/demo/app/project/project_models.dart';
import 'package:flutkit_ademin/theme/theme_extensions/app_fleather_theme.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/chip.dart';
import 'package:flutkit_ademin/widgets/base_ui/dialog.dart';
import 'package:flutkit_ademin/widgets/base_ui/progress.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:flutkit_ademin/widgets/form/form_file_upload.dart';
import 'package:flutkit_ademin/widgets/form/form_validator.dart';
import 'package:intl/intl.dart';

class AddTaskDialog extends StatefulWidget {
  final TaskFormData? initialData;

  const AddTaskDialog({super.key, this.initialData});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

// simple model to track checklist entry text and completion status
class _ChecklistItem {
  String text;
  bool done;
  _ChecklistItem(this.text, {this.done = false});
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _addTaskFormKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final startDateController = TextEditingController();
  final dueDateController = TextEditingController();
  // final TextEditingController descController = TextEditingController();
  final TextEditingController assigneesNameController = TextEditingController();
  late FleatherController descController;

  String? _startDate;
  String? _selectedStatus = 'notStarted';
  String? _selectedPriority = 'medium';
  List<String>? _projectTags;
  List<_ChecklistItem> _checklistItems = [];
  List<String> _attachedFiles = []; // just store file names for placeholder
  final TextEditingController _newChecklistController = TextEditingController();

  List<String> resolveAllAssigneeNames() {
    return mockProjectDatas.members.map((m) => m.name).toList();
  }

  late final List<String> _assignees;

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

  // Select Assignees Dialog
  Future<void> _showAssigneesDialog() async {
    final searchAssignessController = TextEditingController();
    // list to accommodate TEMPORARILY selected assignees
    List<String> selectedAssigneesInDialog = List.from(
      assigneesNameController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty),
    );

    List<String> filteredAssigness = List.from(_assignees);
    final themeData = Theme.of(context);

    // Change return type to List<String>?
    final selectedAssignees = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            void filterAssignees(String query) {
              setDialogState(() {
                filteredAssigness = _assignees
                    .where(
                      (assignee) => assignee.toLowerCase().contains(
                        query.toLowerCase().trim(),
                      ),
                    )
                    .toList();
              });
            }

            // Function to manage assignee options
            void toggleAssignessSelection(String assignee) {
              setDialogState(() {
                if (selectedAssigneesInDialog.contains(assignee)) {
                  selectedAssigneesInDialog.remove(assignee);
                } else {
                  selectedAssigneesInDialog.add(assignee);
                }
              });
            }

            // Check if assignee has been selected
            bool isAssigneesSelected(String assignee) {
              return selectedAssigneesInDialog.contains(assignee);
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
                    'Select Assignees',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: kBodyLarge,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: kDefaultPadding),

                  //  Search Field
                  CustomTextField(
                    controller: searchAssignessController,
                    hintText: 'Search assignee...',
                    onChanged: filterAssignees,
                  ),
                  const SizedBox(height: kDefaultPadding),

                  // Display the selected assignees
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    child: Text(
                      'Selected: ${selectedAssigneesInDialog.isEmpty ? 'None' : selectedAssigneesInDialog.join(', ')}',
                      style: TextStyle(
                        fontSize: kBodyMedium,
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  const Divider(height: 0),

                  // team member List
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: filteredAssigness.length,
                      separatorBuilder: (_, _) =>
                          const Divider(height: 0, thickness: outlineWidth),
                      itemBuilder: (context, index) {
                        final assignee = filteredAssigness[index];
                        final isSelected = isAssigneesSelected(assignee);
                        return InkWell(
                          // Options are changed to toggle (add/remove)
                          onTap: () => toggleAssignessSelection(assignee),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    assignee,
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
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
                                    color: kInfoColor,
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
                        Navigator.pop(context, selectedAssigneesInDialog),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (selectedAssignees != null) {
      setState(() {
        // Concatenate the selected assignee list into a string with commas
        assigneesNameController.text = selectedAssignees.join(', ');
      });
    }
  }
  // The setup for your controllers and state (not included here, but assumed to be the same)
  // ...

  @override
  void initState() {
    super.initState();
    _assignees = resolveAllAssigneeNames();

    // Always initialize description controller so build/save can safely access it.
    final initialDescription = widget.initialData?.description ?? '';
    final descriptionDocument = ParchmentDocument.fromJson([
      {"insert": "$initialDescription\n"},
    ]);
    descController = FleatherController(document: descriptionDocument);

    // if editing, fill with provided data
    if (widget.initialData != null) {
      final data = widget.initialData!;
      titleController.text = data.title;
      // descController.text = data.description;

      startDateController.text = data.startDate;
      dueDateController.text = data.dueDate;
      _startDate = data.startDate;
      _selectedPriority = data.priority;
      _selectedStatus = data.status;
      assigneesNameController.text = data.assignees.join(', ');
      _projectTags = data.tags;
      // convert existing checklist items into local editable state
      _checklistItems = data.checklist != null
          ? data.checklist!
                .map((e) => _ChecklistItem(e.title, done: e.isDone))
                .toList()
          : [];
      _attachedFiles = data.attachments != null
          ? List.from(data.attachments!)
          : [];
    } else {
      // Initial _startDate value for new task
      _startDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
      startDateController.text = _startDate!;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;
    return Dialog(
      constraints: BoxConstraints(maxWidth: 640),
      insetPadding: isMobile
          ? EdgeInsets
                .zero // fullscreen (mobile)
          : const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding,
            ),
      child: Form(
        key: _addTaskFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                color: kSuccessColor.withValues(alpha: 0.1),
              ),
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: kDefaultPadding,
                      ),
                      child: Text(
                        widget.initialData == null ? 'Add Task' : 'Edit Task',
                        style: TextStyle(
                          fontSize: kBodyLarge,
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: kDefaultPadding / 4,
                    ),
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
            ),

            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Task title
                      FormLabel(text: 'Task Title'),
                      SizedBox(height: kDefaultPadding / 2),
                      CustomTextFormField(
                        controller: titleController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hintText: 'Type task title',
                        suffixIcon: Icons.person_outline,
                        validator: (value) => Validators.requiredField(
                          value,
                          context,
                          customMessage: 'Task title is required',
                        ),
                        originalValue: titleController.text,
                        successMessage: 'Title looks good!',
                      ),
                      SizedBox(height: kDefaultPadding),

                      ResponsiveWrap(
                        breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
                        columnRatios: [1 / 2, 1 / 2],
                        children: [
                          // Start Date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormLabel(
                                text: 'Start Date',
                                showRequired: false,
                              ),
                              SizedBox(height: kDefaultPadding / 2),
                              CustomTextFormField(
                                controller: startDateController,
                                readOnly: true, // set as read only
                                mouseCursor: SystemMouseCursors
                                    .click, // set click cursor
                                hintText: 'Select Start Date',
                                suffixIcon: Icons.calendar_today_outlined,
                                // initialize custom date picker
                                onTap: pickStartDate,
                              ),
                            ],
                          ),

                          // Due date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormLabel(text: 'Due Date', showRequired: false),
                              SizedBox(height: kDefaultPadding / 2),
                              CustomTextFormField(
                                controller: dueDateController,
                                readOnly: true, // set as read only
                                mouseCursor: SystemMouseCursors
                                    .click, // set click cursor
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

                      ResponsiveWrap(
                        breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
                        columnRatios: [1 / 2, 1 / 2],
                        children: [
                          // Priority
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormLabel(text: 'Priority', showRequired: false),
                              SizedBox(height: kDefaultPadding / 2),
                              CustomDropdownFormField<String>(
                                hint: 'Choose Priority',
                                items: [
                                  DropdownMenuItem(
                                    value: "low",
                                    child: Text(
                                      "Low",
                                      style: TextStyle(
                                        color: themeData.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "medium",
                                    child: Text(
                                      "Medium",
                                      style: TextStyle(
                                        color: themeData.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "high",
                                    child: Text(
                                      "High",
                                      style: TextStyle(
                                        color: themeData.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                ],
                                initialValue: _selectedPriority,
                                onChanged: (value) =>
                                    setState(() => _selectedPriority = value),
                                validator: (value) => Validators.requiredField(
                                  value,
                                  context,
                                  customMessage: 'Priority must be selected',
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
                                hint: 'Choose Task Status',
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
                                    value: "testing",
                                    child: Text(
                                      "Testing",
                                      style: TextStyle(
                                        color: themeData.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "awaitFeedback",
                                    child: Text(
                                      "Awaiting feedback",
                                      style: TextStyle(
                                        color: themeData.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "completed",
                                    child: Text(
                                      "Completed",
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

                      // Assignees
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabel(text: 'Assignees', showRequired: true),
                          SizedBox(height: kDefaultPadding / 2),

                          CustomTextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: assigneesNameController,
                            readOnly: true,
                            suffixIcon: Icons.keyboard_arrow_down,
                            validator: (value) => Validators.requiredField(
                              value,
                              context,
                              customMessage: 'Assignees must be selected',
                            ),
                            originalValue: assigneesNameController.text,
                            successMessage: 'Looks Good!',
                            onTap: _showAssigneesDialog,
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
                        initialTags: _projectTags ?? [],
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
                        onChanged: (tags) =>
                            setState(() => _projectTags = tags),
                      ),
                      SizedBox(height: kDefaultPadding),

                      // Task Description
                      FormLabel(text: 'Description'),
                      SizedBox(height: kDefaultPadding / 2),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeData.colorScheme.outline,
                            width: outlineWidth,
                          ),
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        child: Column(
                          children: [
                            FleatherToolbar.basic(controller: descController),
                            Divider(
                              color: themeData.colorScheme.outline,
                              height: 0,
                              thickness: outlineWidth,
                            ),
                            FleatherTheme(
                              data: context
                                  .fleatherTheme, // use FleatherThemeData
                              child: Container(
                                decoration: BoxDecoration(
                                  color: themeData
                                      .colorScheme
                                      .surfaceContainerHighest,
                                ),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 200,
                                    maxHeight: 600,
                                  ),
                                  child: FleatherEditor(
                                    controller: descController,
                                    expands: false,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                      vertical: kDefaultPadding / 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: kDefaultPadding),

                      // Checklist
                      FormLabel(text: 'Checklist', showRequired: false),
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
                                      fillColor: themeData.colorScheme.surface,
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
                                      _checklistItems.add(_ChecklistItem(text));
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

                      // Attachments
                      FormLabel(text: 'Attachments', showRequired: false),
                      SizedBox(height: kDefaultPadding / 2),
                      DragDropUpload(
                        initialFiles: _attachedFiles,

                        onFilesChanged: (fileNames, webFiles) {
                          setState(() {
                            _attachedFiles = fileNames;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // action button
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: kDefaultPadding,
                start: kDefaultPadding,
                end: kDefaultPadding,
                bottom: kDefaultPadding,
              ),
              child: Row(
                children: [
                  // draft
                  isMobile
                      ? CustomIconButton(
                          icon: Icons.drafts_outlined,
                          isOutlined: true,
                          iconColor: themeData.colorScheme.primary,
                          onTap: () {
                            // draft event function here
                            Navigator.of(context).pop();
                          },
                        )
                      : CustomOutlinedButton(
                          kText: 'Draft',
                          outlineColor: themeData.colorScheme.primary,
                          kLeadingIcon: Icons.drafts_outlined,
                          onPressed: () {
                            // draft event function here
                            Navigator.of(context).pop();
                          },
                        ),

                  Spacer(),

                  // cancel
                  // isMobile
                  //     ? CustomIconButton(
                  //         icon: Icons.close,
                  //         iconColor: themeData.colorScheme.primary,
                  //         onTap: () {
                  //           Navigator.of(context).pop();
                  //         },
                  //       )
                  //     :
                  SoftButton(
                    kText: 'Cancel',
                    bgColor: themeData.colorScheme.onSurface,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: kDefaultPadding),

                  // Save
                  // isMobile
                  //     ? CustomIconButton(
                  //         icon: Icons.save,
                  //         iconColor: Colors.white,
                  //         buttonColor: kSuccessColor,
                  //         onTap: () {
                  //           if (_addTaskFormKey.currentState!.validate()) {
                  //             // Create TaskFormData object with data inputed by user
                  //             final taskData = TaskFormData(
                  //               title: titleController.text,
                  //               description: descController.document
                  //                   .toPlainText(),
                  //               startDate: startDateController.text,
                  //               dueDate: dueDateController.text,
                  //               priority: _selectedPriority ?? 'medium',
                  //               status: _selectedStatus ?? 'inProgress',
                  //               assignees: assigneesNameController.text
                  //                   .split(',')
                  //                   .map((e) => e.trim())
                  //                   .toList(),
                  //               tags: _projectTags,
                  //               checklist: _checklistItems
                  //                   .map(
                  //                     (e) => TaskChecklistItemData(
                  //                       title: e.text,
                  //                       isDone: e.done,
                  //                     ),
                  //                   )
                  //                   .toList(),
                  //               attachments: _attachedFiles,
                  //               activities: widget.initialData?.activities,
                  //               discussions: widget.initialData?.discussions,
                  //             );
                  //             // Return new/updated data to caller
                  //             Navigator.of(context).pop(taskData);
                  //           }
                  //         },
                  //       )
                  //     :
                  FlatButton(
                    kText: 'Save',
                    bgColor: kSuccessColor,
                    kTextColor: Colors.white,
                    kLeadingIcon: Icons.save,
                    onPressed: () {
                      if (_addTaskFormKey.currentState!.validate()) {
                        // Create TaskFormData object with data inputed by user
                        final taskData = TaskFormData(
                          title: titleController.text,
                          description: descController.document.toPlainText(),
                          startDate: startDateController.text,
                          dueDate: dueDateController.text,
                          priority: _selectedPriority ?? 'medium',
                          status: _selectedStatus ?? 'inProgress',
                          assignees: assigneesNameController.text
                              .split(',')
                              .map((e) => e.trim())
                              .toList(),
                          tags: _projectTags,
                          checklist: _checklistItems
                              .map(
                                (e) => TaskChecklistItemData(
                                  title: e.text,
                                  isDone: e.done,
                                ),
                              )
                              .toList(),
                          attachments: _attachedFiles,
                          activities: widget.initialData?.activities,
                          discussions: widget.initialData?.discussions,
                        );
                        // Return new/updated data to caller
                        Navigator.of(context).pop(taskData);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
