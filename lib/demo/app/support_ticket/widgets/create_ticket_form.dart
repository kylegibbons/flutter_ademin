import 'package:flutter/material.dart';
import 'package:fleather/fleather.dart' as fleather_editor;
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/support_ticket/ticket_data.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:flutkit_ademin/widgets/form/form_editor.dart';
import 'package:flutkit_ademin/widgets/form/form_validator.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:flutkit_ademin/theme/themes.dart';

class CreateTicketForm extends StatefulWidget {
  final String ticketId;
  final TextEditingController subjectController;
  final String priorityValue;
  final ValueChanged<String?> onPriorityChanged;

  const CreateTicketForm({
    super.key,
    required this.ticketId,
    required this.subjectController,
    required this.priorityValue,
    required this.onPriorityChanged,
  });

  @override
  State<CreateTicketForm> createState() => _CreateTicketFormState();
}

class _CreateTicketFormState extends State<CreateTicketForm> {
  late final fleather_editor.FleatherController _ticketDescriptionController;

  @override
  void initState() {
    super.initState();
    _ticketDescriptionController = fleather_editor.FleatherController(
      document: fleather_editor.ParchmentDocument(),
    );
  }

  @override
  void dispose() {
    _ticketDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ticket number should be auto generated
          CardHeader(kText: 'Create Ticket No #TKT-1001'),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: kDefaultPadding,
              end: kDefaultPadding,
              top: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ticket ID (Auto-generated, read-only)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabel(text: 'Department', showRequired: true),
                    const SizedBox(height: 0.5 * kDefaultPadding),
                    DepartmentSelector(),
                  ],
                ),
                const SizedBox(height: 1.5 * kDefaultPadding),

                // Ticket Details (subject, status, priority, SLA)
                FormLabel(text: 'Ticket Details', showRequired: true),
                const SizedBox(height: kDefaultPadding),

                ResponsiveWrap(
                  breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
                  columnRatios: [1 / 2, 1 / 2],
                  children: [
                    // Subject field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabel(
                          text: 'Subject',
                          fontColor: kTextColor,
                          showRequired: false,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 0.5 * kDefaultPadding),
                        CustomTextFormField(
                          controller: widget.subjectController,
                          hintText: 'Enter ticket subject',
                          validator: (value) =>
                              Validators.requiredField(value, context),
                          successMessage: 'Subject looks good!',
                        ),
                      ],
                    ),

                    // Status field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabel(
                          text: 'Status',
                          fontColor: kTextColor,
                          showRequired: false,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 0.5 * kDefaultPadding),
                        CustomDropdownFormField<String>(
                          items: ticketStatus,
                          initialValue: "open", // set initial value
                        ),
                      ],
                    ),

                    // priority field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabel(
                          text: 'Priority',
                          fontColor: kTextColor,
                          showRequired: false,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 0.5 * kDefaultPadding),
                        CustomDropdownFormField<String>(
                          items: ticketPriorities,
                          initialValue: "low", // set initial value
                        ),
                      ],
                    ),

                    // SLA field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabel(
                          text: 'Service Level Agreement',
                          fontColor: kTextColor,
                          showRequired: false,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 0.5 * kDefaultPadding),
                        CustomDropdownFormField<String>(
                          items: slaOptions,
                          initialValue: "standard", // set initial value
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 1.5 * kDefaultPadding),
                // Ticket Description
                FormLabel(text: 'Ticket Description', showRequired: true),
                const SizedBox(height: 0.5 * kDefaultPadding),
                FleatherEditorCustom(
                  height: 362,
                  controller: _ticketDescriptionController,
                  onValidate: (value) => Validators.requiredField(
                    value,
                    context,
                    customMessage: 'Description is required',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// department selector

class DepartmentSelector extends StatefulWidget {
  const DepartmentSelector({super.key});

  @override
  State<DepartmentSelector> createState() => _DepartmentSelectorState();
}

class _DepartmentSelectorState extends State<DepartmentSelector> {
  final List<String> departments = ['HRD', 'Finance', 'IT', 'Admin'];

  String selectedDepartment = 'IT';

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ResponsiveWrap(
      spacing: kDefaultPadding,
      runSpacing: kDefaultPadding,
      breakpoints: {kScreenWidthSm: 2, kScreenWidthLg: 4},
      columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
      children: departments.map((department) {
        final bool isSelected = selectedDepartment == department;

        return InkWell(
          borderRadius: BorderRadius.circular(defaultRadius),
          onTap: () {
            setState(() {
              selectedDepartment = department;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,

            height: mediumHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? kSecondaryColor
                  : kSecondaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(defaultRadius),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: kSecondaryColor.withValues(alpha: 0.25),
                        blurRadius: defaultRadius,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Text(
              department,
              style: TextStyle(
                fontSize: kBodyMedium,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : themeData.colorScheme.onSurface,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
