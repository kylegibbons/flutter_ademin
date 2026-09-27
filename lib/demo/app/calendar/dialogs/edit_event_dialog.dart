import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/calendar/calendar_data.dart';
import 'package:flutkit_ademin/demo/app/calendar/calendar_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:intl/intl.dart';

void showEditDialog(BuildContext context, {required Meeting meeting}) {
  DateTime selectedFrom = meeting.from;
  DateTime selectedTo = meeting.to;
  Color selectedColor = meeting.background;
  bool isAllDay = meeting.isAllDay;

  String selectedType = eventTypes.keys.firstWhere(
    (key) => eventTypes[key] == selectedColor,
    orElse: () => 'Work',
  );

  final eventNameController = TextEditingController(text: meeting.eventName);
  final startDateController = TextEditingController(
    text: DateFormat('MMMM dd, yyyy').format(selectedFrom),
  );
  final endDateController = TextEditingController(
    text: DateFormat('MMMM dd, yyyy').format(selectedTo),
  );
  final startTimeController = TextEditingController(
    text: DateFormat('hh:mm a').format(selectedFrom),
  );
  final endTimeController = TextEditingController(
    text: DateFormat('hh:mm a').format(selectedTo),
  );
  final descController = TextEditingController(text: meeting.description);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      final themeData = Theme.of(context);
      final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;

      return StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            constraints: const BoxConstraints(maxWidth: 560),
            insetPadding: isMobile
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding,
                  ),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kSuccessColor.withValues(alpha: 0.1),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 4,
                    ),
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
                              'Edit Event',
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
                            onTap: () => Navigator.of(context).pop(),
                            icon: Icons.close,
                            shape: ButtonShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FormLabel(
                              text: 'Event Type',
                              showRequired: false,
                            ),
                            const SizedBox(height: kDefaultPadding / 2),
                            CustomDropdownFormField<String>(
                              initialValue: selectedType,
                              hint: 'Event Type',
                              items: eventTypes.keys.map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: eventTypes[type],
                                        radius: 8,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(type),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setDialogState(() {
                                  selectedType = newValue!;
                                  selectedColor = eventTypes[newValue]!;
                                });
                              },
                            ),
                            const SizedBox(height: kDefaultPadding),
                            const FormLabel(
                              text: 'Event Name',
                              showRequired: false,
                            ),
                            const SizedBox(height: kDefaultPadding / 2),
                            CustomTextFormField(
                              controller: eventNameController,
                              hintText: 'Event Name',
                              suffixIcon: Icons.event_outlined,
                            ),
                            const SizedBox(height: kDefaultPadding),
                            ResponsiveWrap(
                              breakpoints: {
                                kScreenWidthSm / 2: 1,
                                kScreenWidthSm: 2,
                              },
                              columnRatios: const [1 / 2, 1 / 2],
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const FormLabel(
                                      text: 'Start Date',
                                      showRequired: false,
                                    ),
                                    const SizedBox(height: kDefaultPadding / 2),
                                    CustomTextFormField(
                                      controller: startDateController,
                                      readOnly: true,
                                      mouseCursor: SystemMouseCursors.click,
                                      hintText: 'Choose Date',
                                      suffixIcon: Icons.calendar_today_outlined,
                                      onTap: () async {
                                        final picked = await showDatePicker(
                                          context: context,
                                          initialDate: selectedFrom,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2030),
                                        );

                                        if (picked != null) {
                                          setDialogState(() {
                                            selectedFrom = DateTime(
                                              picked.year,
                                              picked.month,
                                              picked.day,
                                              selectedFrom.hour,
                                              selectedFrom.minute,
                                            );
                                            startDateController.text =
                                                DateFormat(
                                                  'MMMM dd, yyyy',
                                                ).format(selectedFrom);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const FormLabel(
                                      text: 'End Date',
                                      showRequired: false,
                                    ),
                                    const SizedBox(height: kDefaultPadding / 2),
                                    CustomTextFormField(
                                      controller: endDateController,
                                      readOnly: true,
                                      mouseCursor: SystemMouseCursors.click,
                                      hintText: 'Choose End Date',
                                      suffixIcon:
                                          Icons.event_available_outlined,
                                      onTap: () async {
                                        final picked = await showDatePicker(
                                          context: context,
                                          initialDate: selectedTo,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2030),
                                        );

                                        if (picked != null) {
                                          setDialogState(() {
                                            selectedTo = DateTime(
                                              picked.year,
                                              picked.month,
                                              picked.day,
                                              selectedTo.hour,
                                              selectedTo.minute,
                                            );
                                            endDateController.text = DateFormat(
                                              'MMMM dd, yyyy',
                                            ).format(selectedTo);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: kDefaultPadding),
                            if (!isAllDay)
                              ResponsiveWrap(
                                breakpoints: {
                                  kScreenWidthSm / 2: 1,
                                  kScreenWidthSm: 2,
                                },
                                columnRatios: const [1 / 2, 1 / 2],
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const FormLabel(
                                        text: 'Start Time',
                                        showRequired: false,
                                      ),
                                      const SizedBox(
                                        height: kDefaultPadding / 2,
                                      ),
                                      CustomTextFormField(
                                        controller: startTimeController,
                                        readOnly: true,
                                        mouseCursor: SystemMouseCursors.click,
                                        hintText: 'Choose Start Time',
                                        suffixIcon: Icons.access_time_outlined,
                                        onTap: () async {
                                          final picked = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                              selectedFrom,
                                            ),
                                          );

                                          if (picked != null) {
                                            setDialogState(() {
                                              selectedFrom = DateTime(
                                                selectedFrom.year,
                                                selectedFrom.month,
                                                selectedFrom.day,
                                                picked.hour,
                                                picked.minute,
                                              );
                                              startTimeController.text =
                                                  DateFormat(
                                                    'hh:mm a',
                                                  ).format(selectedFrom);
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const FormLabel(
                                        text: 'End Time',
                                        showRequired: false,
                                      ),
                                      const SizedBox(
                                        height: kDefaultPadding / 2,
                                      ),
                                      CustomTextFormField(
                                        controller: endTimeController,
                                        readOnly: true,
                                        mouseCursor: SystemMouseCursors.click,
                                        hintText: 'Choose End Time',
                                        suffixIcon: Icons.timer_outlined,
                                        onTap: () async {
                                          final picked = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                              selectedTo,
                                            ),
                                          );

                                          if (picked != null) {
                                            setDialogState(() {
                                              selectedTo = DateTime(
                                                selectedTo.year,
                                                selectedTo.month,
                                                selectedTo.day,
                                                picked.hour,
                                                picked.minute,
                                              );
                                              endTimeController.text =
                                                  DateFormat(
                                                    'hh:mm a',
                                                  ).format(selectedTo);
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            if (!isAllDay)
                              const SizedBox(height: kDefaultPadding / 2),
                            CustomCheckbox(
                              value: isAllDay,
                              label: 'All Day',
                              onChanged: (bool? value) {
                                setDialogState(() {
                                  isAllDay = value ?? false;
                                });
                              },
                            ),
                            const SizedBox(height: kDefaultPadding),
                            const FormLabel(
                              text: 'Description',
                              showRequired: false,
                            ),
                            const SizedBox(height: kDefaultPadding / 2),
                            CustomTextFormField(
                              controller: descController,
                              hintText: 'Type event description...',
                              minLines: 6,
                              maxLines: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: kDefaultPadding,
                      end: kDefaultPadding,
                      bottom: kDefaultPadding,
                    ),
                    child: Row(
                      children: [
                        isMobile
                            ? CustomIconButton(
                                icon: Icons.delete_outline,
                                isOutlined: true,
                                outlineColor: kErrorColor,
                                iconColor: kErrorColor,
                                onTap: () => Navigator.of(context).pop(),
                              )
                            : CustomOutlinedButton(
                                kText: 'Delete',
                                outlineColor: kErrorColor,
                                kLeadingIcon: Icons.delete_outline,
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                        const Spacer(),
                        // isMobile
                        //     ? CustomIconButton(
                        //         icon: Icons.close,
                        //         iconColor: themeData.colorScheme.onSurface,
                        //         buttonColor: themeData.colorScheme.onSurface
                        //             .withValues(alpha: 0.1),
                        //         onTap: () => Navigator.of(context).pop(),
                        //       )
                        //     :
                        SoftButton(
                          kText: 'Cancel',
                          bgColor: themeData.colorScheme.onSurface,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: kDefaultPadding),
                        // isMobile
                        //     ? CustomIconButton(
                        //         icon: Icons.save,
                        //         iconColor: Colors.white,
                        //         buttonColor: kSuccessColor,
                        //         onTap: () => Navigator.of(context).pop(),
                        //       )
                        //     :
                        FlatButton(
                          kText: 'Save',
                          bgColor: kSuccessColor,
                          kTextColor: Colors.white,
                          kLeadingIcon: Icons.save,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
