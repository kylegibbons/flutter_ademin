import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/helper/card_description.dart';
import 'package:flutkit_ademin/widgets/form/form_picker.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:intl/intl.dart';

class FormPickerScreen extends StatefulWidget {
  const FormPickerScreen({super.key});

  @override
  State<FormPickerScreen> createState() => _FormPickerScreenState();
}

class _FormPickerScreenState extends State<FormPickerScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).picker; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          //page title and breadcrumb
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
                //title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lang.picker.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: kBodyMedium,
                      ),
                    ),
                  ],
                ),

                //breadcrumbs
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Breadcrumbs(
                      items: [
                        BreadcrumbItem(
                          label: lang.dashboard,
                          uri: RouteUri.home,
                        ),
                        BreadcrumbItem(label: lang.forms(2), uri: ''),
                        BreadcrumbItem(
                          label: lang.picker,
                          uri: RouteUri.formPicker,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // Date picker demo
                DatePickerDemo(),

                SizedBox(height: kDefaultPadding),

                // time picker demo
                TimePickerDemo(),

                SizedBox(height: kDefaultPadding),

                //color picker
                ColorPickerDemo(),
              ],
            ),
          ),

          //footer
          PortalFooter(),
        ],
      ),
    );
  }
}

// Date Picker Demo

class DatePickerDemo extends StatefulWidget {
  const DatePickerDemo({super.key});

  @override
  State<DatePickerDemo> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePickerDemo> {
  final TextEditingController intController = TextEditingController();
  final TextEditingController eeeeDateController = TextEditingController();
  final TextEditingController localDateController = TextEditingController();
  final TextEditingController longMonthDateController = TextEditingController();
  final TextEditingController shortMonthDateController =
      TextEditingController();

  final TextEditingController initialDateController = TextEditingController();

  final TextEditingController limitedDateController = TextEditingController();
  final TextEditingController datesingleTimeController =
      TextEditingController();
  final TextEditingController rangeController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController roundedController = TextEditingController();

  // international date picker function
  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      intController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  // EEEE date picker function
  Future<void> pickEEEEDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      eeeeDateController.text = DateFormat('EEEE, dd MMMM yyyy').format(picked);
    }
  }

  // local date picker function
  Future<void> picklocalDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      localDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  // long month date picker function
  Future<void> picklongMonthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      longMonthDateController.text = DateFormat('dd MMMM yyyy').format(picked);
    }
  }

  // short month date picker function
  Future<void> pickShortMonthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      shortMonthDateController.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  // initial date picker function
  Future<void> pickInitialDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      initialDateController.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  // limited date picker function (7 days from today)
  Future<void> pickLimitedDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 7)),
    );

    if (picked != null) {
      limitedDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  // combo date time picker function
  Future<void> pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (!mounted || date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (!mounted || time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    datesingleTimeController.text = DateFormat(
      'yyyy-MM-dd HH:mm',
    ).format(dateTime);
  }

  // range date picker
  Future<void> pickDateRangeDialog() async {
    final result = await showDialog<DateTimeRange>(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 420,
            height: 460,
            child: DateRangePickerDialog(
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),

              // force calendar mode (no pencil crash)
              initialEntryMode: DatePickerEntryMode.calendarOnly,
            ),
          ),
        );
      },
    );

    if (!mounted || result == null) return;

    rangeController.text =
        "${DateFormat('dd/MM/yyyy').format(result.start)} - "
        "${DateFormat('dd/MM/yyyy').format(result.end)}";
  }

  // Age limit
  Future<void> pickBirthDate() async {
    final today = DateTime.now();
    final lastAllowedDate = DateTime(today.year - 18, today.month, today.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: lastAllowedDate,
      firstDate: DateTime(1900),
      lastDate: lastAllowedDate,
    );

    if (picked != null) {
      birthdayController.text = DateFormat('EEEE, dd MMMM yyyy').format(picked);
    }
  }

  // rounded date picker function
  Future<void> pickRoundedDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      roundedController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  @override
  void initState() {
    super.initState();

    // set default value = today
    initialDateController.text = DateFormat(
      'dd MMMM yyyy',
    ).format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return ShowCodeCard(
      cardTitle: 'Date Picker',
      description:
          'Use <code>showDatePicker()</code> to integrate a date picker into <code>CustomTextFormField()</code>.',
      uiView: ResponsiveWrap(
        breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2, kScreenWidthLg: 4},
        columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
        children: [
          // International format picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'International Format', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: intController,
                readOnly: true, // set as read only
                mouseCursor: SystemMouseCursors.click, // set click cursor
                hintText: 'Choose Date',
                suffixIcon: Icons.calendar_today_outlined,
                // initialize custom date picker
                onTap: pickDate,
              ),
            ],
          ),

          // EEEEE Format picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(
                text: 'EEEE Format (dd MMMM yyyy)',
                showRequired: false,
              ),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: eeeeDateController,
                readOnly: true,
                mouseCursor: SystemMouseCursors.click,
                hintText: 'Choose Date',
                suffixIcon: Icons.calendar_today_outlined,
                onTap: pickEEEEDate,
              ),
            ],
          ),

          // Local format picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Local Format (dd/MM/yyyy)', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: localDateController,
                readOnly: true,
                mouseCursor: SystemMouseCursors.click,
                hintText: 'Choose Date',
                suffixIcon: Icons.calendar_today_outlined,
                onTap: picklocalDate,
              ),
            ],
          ),

          // Long Month date format picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(
                text: 'Long Month Format (dd MMMM yyyy)',
                showRequired: false,
              ),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: longMonthDateController,
                readOnly: true,
                mouseCursor: SystemMouseCursors.click,
                hintText: 'Choose Date',
                suffixIcon: Icons.calendar_today_outlined,
                onTap: picklongMonthDate,
              ),
            ],
          ),

          // Short Month date format picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(
                text: 'Short Month Format (dd MMM yyyy)',
                showRequired: false,
              ),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: shortMonthDateController,
                readOnly: true,
                mouseCursor: SystemMouseCursors.click,
                hintText: 'Choose Date',
                suffixIcon: Icons.calendar_today_outlined,
                onTap: pickShortMonthDate,
              ),
            ],
          ),

          // Initial date picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'With Initial Date', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: initialDateController,
                readOnly: true,
                mouseCursor: SystemMouseCursors.click,
                hintText: 'Choose Date',
                suffixIcon: Icons.calendar_today_outlined,
                onTap: pickInitialDate,
              ),
            ],
          ),

          // Limited date Picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Limited Date', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: limitedDateController,
                readOnly: true,
                mouseCursor: SystemMouseCursors.click,
                hintText: 'Choose Date',
                suffixIcon: Icons.calendar_today_outlined,
                onTap: pickLimitedDate,
              ),
            ],
          ),

          // Combo Date Time date Picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Combo Date Time', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: datesingleTimeController,
                readOnly: true,
                mouseCursor: SystemMouseCursors.click,
                hintText: 'Choose Date & Time',
                suffixIcon: Icons.schedule,
                onTap: pickDateTime,
              ),
            ],
          ),

          // range date format
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Range Date', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: rangeController,
                readOnly: true,
                mouseCursor: SystemMouseCursors.click,
                hintText: 'Choose Date',
                suffixIcon: Icons.calendar_today_outlined,
                onTap: pickDateRangeDialog,
              ),
            ],
          ),

          // Age limit date format
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Age Limit (18+ only)', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: birthdayController,
                readOnly: true,
                mouseCursor: SystemMouseCursors.click,
                hintText: 'Choose Date',
                suffixIcon: Icons.calendar_today_outlined,
                onTap: pickBirthDate,
              ),
            ],
          ),

          // Disable
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Disabled', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: initialDateController,
                readOnly: true,
                enabled: false, // disable form
                mouseCursor: SystemMouseCursors.click,
                hintText: 'Choose Date',
                suffixIcon: Icons.calendar_today_outlined,
                onTap: pickInitialDate,
              ),
            ],
          ),

          // Rounded Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Rounded Field', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: roundedController,
                readOnly: true,
                radius: 50, // set rounded
                mouseCursor: SystemMouseCursors.click,
                hintText: 'Choose Date',
                suffixIcon: Icons.calendar_today_outlined,
                onTap: pickRoundedDate,
              ),
            ],
          ),
        ],
      ),
      codeView: '''
// International format picker
CustomTextFormField(
  controller: intController,
  readOnly: true, // set as read only
  mouseCursor: SystemMouseCursors.click, // set click cursor
  hintText: 'Choose Date',
  suffixIcon: Icons.calendar_today_outlined,
  // initialize custom date picker
  onTap: pickDate,
),

// EEEEE Format picker
CustomTextFormField(
  controller: eeeeDateController,
  readOnly: true,
  mouseCursor: SystemMouseCursors.click,
  hintText: 'Choose Date',
  suffixIcon: Icons.calendar_today_outlined,
  onTap: pickEEEEDate,
),

// Local format picker
CustomTextFormField(
  controller: localDateController,
  readOnly: true,
  mouseCursor: SystemMouseCursors.click,
  hintText: 'Choose Date',
  suffixIcon: Icons.calendar_today_outlined,
  onTap: picklocalDate,
),

// Long Month date format picker
CustomTextFormField(
  controller: longMonthDateController,
  readOnly: true,
  mouseCursor: SystemMouseCursors.click,
  hintText: 'Choose Date',
  suffixIcon: Icons.calendar_today_outlined,
  onTap: picklongMonthDate,
),

// Short Month date format picker
CustomTextFormField(
  controller: shortMonthDateController,
  readOnly: true,
  mouseCursor: SystemMouseCursors.click,
  hintText: 'Choose Date',
  suffixIcon: Icons.calendar_today_outlined,
  onTap: pickShortMonthDate,
),

// Initial date picker
CustomTextFormField(
  controller: initialDateController,
  readOnly: true,
  mouseCursor: SystemMouseCursors.click,
  hintText: 'Choose Date',
  suffixIcon: Icons.calendar_today_outlined,
  onTap: pickInitialDate,
),

// Limited date Picker
CustomTextFormField(
  controller: limitedDateController,
  readOnly: true,
  mouseCursor: SystemMouseCursors.click,
  hintText: 'Choose Date',
  suffixIcon: Icons.calendar_today_outlined,
  onTap: pickLimitedDate,
),

// Combo Date Time date Picker
CustomTextFormField(
  controller: datesingleTimeController,
  readOnly: true,
  mouseCursor: SystemMouseCursors.click,
  hintText: 'Choose Date & Time',
  suffixIcon: Icons.schedule,
  onTap: pickDateTime,
),

// range date format
CustomTextFormField(
  controller: rangeController,
  readOnly: true,
  mouseCursor: SystemMouseCursors.click,
  hintText: 'Choose Date',
  suffixIcon: Icons.calendar_today_outlined,
  onTap: pickDateRangeDialog,
),

// Age limit date format
CustomTextFormField(
  controller: birthdayController,
  readOnly: true,
  mouseCursor: SystemMouseCursors.click,
  hintText: 'Choose Date',
  suffixIcon: Icons.calendar_today_outlined,
  onTap: pickBirthDate,
),

// Disable
CustomTextFormField(
  controller: initialDateController,
  readOnly: true,
  enabled: false, // disable form
  mouseCursor: SystemMouseCursors.click,
  hintText: 'Choose Date',
  suffixIcon: Icons.calendar_today_outlined,
  onTap: pickInitialDate,
),

// Rounded Field
CustomTextFormField(
  controller: roundedController,
  readOnly: true,
  radius: 50, // set rounded
  mouseCursor: SystemMouseCursors.click,
  hintText: 'Choose Date',
  suffixIcon: Icons.calendar_today_outlined,
  onTap: pickRoundedDate,
),

final TextEditingController intController = TextEditingController();
final TextEditingController eeeeDateController = TextEditingController();
final TextEditingController localDateController = TextEditingController();
final TextEditingController longMonthDateController = TextEditingController();
final TextEditingController shortMonthDateController = TextEditingController();
final TextEditingController initialDateController = TextEditingController();
final TextEditingController limitedDateController = TextEditingController();
final TextEditingController datesingleTimeController = TextEditingController();
final TextEditingController rangeController = TextEditingController();
final TextEditingController birthdayController = TextEditingController();
final TextEditingController roundedController = TextEditingController();

// international date picker function
Future<void> pickDate() async {
  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    intController.text = DateFormat('yyyy-MM-dd').format(picked);
  }
}

// EEEE date picker function
Future<void> pickEEEEDate() async {
  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    eeeeDateController.text = DateFormat('EEEE, dd MMMM yyyy').format(picked);
  }
}

// local date picker function
Future<void> picklocalDate() async {
  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    localDateController.text = DateFormat('dd/MM/yyyy').format(picked);
  }
}

// long month date picker function
Future<void> picklongMonthDate() async {
  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    longMonthDateController.text = DateFormat('dd MMMM yyyy').format(picked);
  }
}

// short month date picker function
Future<void> pickShortMonthDate() async {
  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    shortMonthDateController.text = DateFormat('dd MMM yyyy').format(picked);
  }
}

// initial date picker function
Future<void> pickInitialDate() async {
  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    initialDateController.text = DateFormat('dd MMM yyyy').format(picked);
  }
}

// limited date picker function (7 days from today)
Future<void> pickLimitedDate() async {
  final now = DateTime.now();

  final picked = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: now,
    lastDate: now.add(const Duration(days: 7)),
  );

  if (picked != null) {
    limitedDateController.text = DateFormat('dd/MM/yyyy').format(picked);
  }
}

// combo date time picker function
Future<void> pickDateTime() async {
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
  );

  if (!mounted || date == null) return;

  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (!mounted || time == null) return;

  final dateTime = DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );

  datesingleTimeController.text = DateFormat(
    'yyyy-MM-dd HH:mm',
  ).format(dateTime);
}

// range date picker
Future<void> pickDateRangeDialog() async {
  final result = await showDialog<DateTimeRange>(
    context: context,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          width: 420,
          height: 460,
          child: DateRangePickerDialog(
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),

            // force calendar mode (no pencil crash)
            initialEntryMode: DatePickerEntryMode.calendarOnly,
          ),
        ),
      );
    },
  );

  if (!mounted || result == null) return;

  rangeController.text =
      "\${DateFormat('dd/MM/yyyy').format(result.start)} - "
      "\${DateFormat('dd/MM/yyyy').format(result.end)}";
}

// Age limit
Future<void> pickBirthDate() async {
  final today = DateTime.now();
  final lastAllowedDate = DateTime(today.year - 18, today.month, today.day);

  final picked = await showDatePicker(
    context: context,
    initialDate: lastAllowedDate,
    firstDate: DateTime(1900),
    lastDate: lastAllowedDate,
  );

  if (picked != null) {
    birthdayController.text = DateFormat('EEEE, dd MMMM yyyy').format(picked);
  }
}

// rounded date picker function
Future<void> pickRoundedDate() async {
  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    roundedController.text = DateFormat('yyyy-MM-dd').format(picked);
  }
}
''',
    );
  }
}

// Time Picker Demo

class TimePickerDemo extends StatefulWidget {
  const TimePickerDemo({super.key});

  @override
  State<TimePickerDemo> createState() => _TimePickerDemoState();
}

class _TimePickerDemoState extends State<TimePickerDemo> {
  final TextEditingController timeAmPmController = TextEditingController();
  final TextEditingController time24HController = TextEditingController();
  final TextEditingController timeRangeController = TextEditingController();
  final TextEditingController timeInitialController = TextEditingController();
  final TextEditingController timeRoundedController = TextEditingController();

  // AM PM time picker function
  Future<void> pickTimeAmPm() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(alwaysUse24HourFormat: false), // force AM/PM
          child: child!,
        );
      },
    );

    if (!mounted || picked == null) return;

    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      picked.hour,
      picked.minute,
    );

    // Format AM/PM
    timeAmPmController.text = DateFormat('hh:mm a').format(dateTime);
  }

  // 24 Hour format time picker
  Future<void> pickTime24h() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(alwaysUse24HourFormat: true), // force 24 h format
          child: child!,
        );
      },
    );

    if (!mounted || picked == null) return;

    time24HController.text =
        "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
  }

  // range time picker function
  Future<void> pickTimeRange() async {
    final start = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );

    if (!mounted || start == null) return;

    final end = await showTimePicker(context: context, initialTime: start);

    if (!mounted || end == null) return;

    final isInvalid =
        end.hour < start.hour ||
        (end.hour == start.hour && end.minute <= start.minute);

    if (isInvalid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Jam akhir harus setelah jam mulai")),
      );
      return;
    }

    timeRangeController.text =
        "${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')} - "
        "${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}";
  }

  // initial time picker function
  Future<void> pickTimeInitial() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(alwaysUse24HourFormat: false), // force AM/PM
          child: child!,
        );
      },
    );

    if (!mounted || picked == null) return;

    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      picked.hour,
      picked.minute,
    );

    // Format AM/PM
    timeInitialController.text = DateFormat('hh:mm a').format(dateTime);
  }

  // Rounded time picker function

  Future<void> pickTimeRounded() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(alwaysUse24HourFormat: false), // force AM/PM
          child: child!,
        );
      },
    );

    if (!mounted || picked == null) return;

    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      picked.hour,
      picked.minute,
    );

    // Format AM/PM
    timeRoundedController.text = DateFormat('hh:mm a').format(dateTime);
  }

  @override
  void initState() {
    super.initState();
    timeInitialController.text = DateFormat(
      'HH:mm',
      'id_ID',
    ).format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return ShowCodeCard(
      cardTitle: 'Time Picker',
      description:
          'Use <code>showTimePicker()</code> to integrate a time picker into <code>CustomTextFormField()</code>.',
      uiView: ResponsiveWrap(
        breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2, kScreenWidthLg: 4},
        columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
        children: [
          // AM PM time picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'AM PM Format', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: timeAmPmController,
                labelText: "Choose Time",
                readOnly: true,
                suffixIcon: Icons.access_time,
                onTap: pickTimeAmPm,
              ),
            ],
          ),

          // 24 hour time picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: '24H Format', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: time24HController,
                labelText: "Choose Time",
                readOnly: true,
                suffixIcon: Icons.access_time,
                onTap: pickTime24h,
              ),
            ],
          ),

          // range time picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Range Time Picker', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: timeRangeController,
                labelText: "Choose Time",
                readOnly: true,
                suffixIcon: Icons.more_time,
                onTap: pickTimeRange,
              ),
            ],
          ),

          // initial time picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'With Initial Time', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: timeInitialController,
                labelText: "Choose Time",
                readOnly: true,
                suffixIcon: Icons.access_time,
                onTap: pickTimeInitial,
              ),
            ],
          ),

          // disabled time picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'With Initial Time', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: timeInitialController,
                labelText: "Choose Time",
                readOnly: true,
                enabled: false, // disable field
                suffixIcon: Icons.access_time,
                onTap: pickTimeInitial,
              ),
            ],
          ),

          // rounded time picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Rounded Field', showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: timeRoundedController,
                labelText: "Choose Time",
                readOnly: true,
                radius: 50, // set rounded
                suffixIcon: Icons.access_time,
                onTap: pickTimeRounded,
              ),
            ],
          ),
        ],
      ),

      codeView: '''
// AM PM time picker
CustomTextFormField(
  controller: timeAmPmController,
  labelText: "Choose Time",
  readOnly: true,
  suffixIcon: Icons.access_time,
  onTap: pickTimeAmPm,
),

// 24 hour time picker
CustomTextFormField(
  controller: time24HController,
  labelText: "Choose Time",
  readOnly: true,
  suffixIcon: Icons.access_time,
  onTap: pickTime24h,
),

// range time picker
CustomTextFormField(
  controller: timeRangeController,
  labelText: "Choose Time",
  readOnly: true,
  suffixIcon: Icons.more_time,
  onTap: pickTimeRange,
),

// initial time picker
CustomTextFormField(
  controller: timeInitialController,
  labelText: "Choose Time",
  readOnly: true,
  suffixIcon: Icons.access_time,
  onTap: pickTimeInitial,
),

// disabled time picker
CustomTextFormField(
  controller: timeInitialController,
  labelText: "Choose Time",
  readOnly: true,
  enabled: false, // disable field
  suffixIcon: Icons.access_time,
  onTap: pickTimeInitial,
),

// rounded time picker
CustomTextFormField(
  controller: timeRoundedController,
  labelText: "Choose Time",
  readOnly: true,
  radius: 50, // set rounded
  suffixIcon: Icons.access_time,
  onTap: pickTimeRounded,
),

final TextEditingController timeAmPmController = TextEditingController();
final TextEditingController time24HController = TextEditingController();
final TextEditingController timeRangeController = TextEditingController();
final TextEditingController timeInitialController = TextEditingController();
final TextEditingController timeRoundedController = TextEditingController();

// AM PM time picker function
Future<void> pickTimeAmPm() async {
  final picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(alwaysUse24HourFormat: false), // force AM/PM
        child: child!,
      );
    },
  );

  if (!mounted || picked == null) return;

  final now = DateTime.now();
  final dateTime = DateTime(
    now.year,
    now.month,
    now.day,
    picked.hour,
    picked.minute,
  );

  // Format AM/PM
  timeAmPmController.text = DateFormat('hh:mm a').format(dateTime);
}

// 24 Hour format time picker
Future<void> pickTime24h() async {
  final picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(alwaysUse24HourFormat: true), // force 24 h format
        child: child!,
      );
    },
  );

  if (!mounted || picked == null) return;

  time24HController.text =
      "\${picked.hour.toString().padLeft(2, '0')}:\${picked.minute.toString().padLeft(2, '0')}";
}

// range time picker function
Future<void> pickTimeRange() async {
  final start = await showTimePicker(
    context: context,
    initialTime: const TimeOfDay(hour: 9, minute: 0),
  );

  if (!mounted || start == null) return;

  final end = await showTimePicker(context: context, initialTime: start);

  if (!mounted || end == null) return;

  final isInvalid =
      end.hour < start.hour ||
      (end.hour == start.hour && end.minute <= start.minute);

  if (isInvalid) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Jam akhir harus setelah jam mulai")),
    );
    return;
  }

  timeRangeController.text =
      "\${start.hour.toString().padLeft(2, '0')}:\${start.minute.toString().padLeft(2, '0')} - "
      "\${end.hour.toString().padLeft(2, '0')}:\${end.minute.toString().padLeft(2, '0')}";
}

// initial time picker function
Future<void> pickTimeInitial() async {
  final picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(alwaysUse24HourFormat: false), // force AM/PM
        child: child!,
      );
    },
  );

  if (!mounted || picked == null) return;

  final now = DateTime.now();
  final dateTime = DateTime(
    now.year,
    now.month,
    now.day,
    picked.hour,
    picked.minute,
  );

  // Format AM/PM
  timeInitialController.text = DateFormat('hh:mm a').format(dateTime);
}

// Rounded time picker function
Future<void> pickTimeRounded() async {
  final picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(alwaysUse24HourFormat: false), // force AM/PM
        child: child!,
      );
    },
  );

  if (!mounted || picked == null) return;

  final now = DateTime.now();
  final dateTime = DateTime(
    now.year,
    now.month,
    now.day,
    picked.hour,
    picked.minute,
  );

  // Format AM/PM
  timeRoundedController.text = DateFormat('hh:mm a').format(dateTime);
}
''',
    );
  }
}

// Color Picker Demo

class ColorPickerDemo extends StatelessWidget {
  const ColorPickerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ShowCodeCard(
      cardTitle: 'Color Picker',
      uiView: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardDescription(
            content:
                'Use <code>ColorPickerField()</code> to set a color picker form field.',
          ),
          SizedBox(height: kDefaultPadding),
          LayoutBuilder(
            builder: (context, constraints) {
              int numberOfCardsPerRow = getNumberOfCardsPerRow_4(context);
              return Wrap(
                spacing: kDefaultPadding,
                runSpacing: kDefaultPadding,
                children: [
                  SizedBox(
                    width: calculateCardWidth_4(
                      context,
                      constraints,
                      numberOfCardsPerRow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Default Color Picker Field',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const CardDescription(
                          content:
                              'Use <code>ColorPickerField()</code> to set a color picker. By default it uses flutter_colorpicker',
                        ),
                        const SizedBox(height: kDefaultPadding / 2),

                        //Default Color Picker Field
                        ColorPickerField(
                          labelText: 'Pick a Color',
                          onColorSelected: (color) => debugPrint(color),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: calculateCardWidth_4(
                      context,
                      constraints,
                      numberOfCardsPerRow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Color Picker Field with Initial Color',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const CardDescription(
                          content:
                              'Add <code>initialColor()</code> argument to set inital color.',
                        ),
                        const SizedBox(height: kDefaultPadding / 2),

                        //Color Picker Field with Initial Color
                        ColorPickerField(
                          labelText: 'Pick a Color',
                          initialColor: kSecondaryColor, // initial color
                          onColorSelected: (color) => debugPrint(color),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: calculateCardWidth_4(
                      context,
                      constraints,
                      numberOfCardsPerRow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Flex Color Picker Field',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const CardDescription(
                          content:
                              'Add <code>pickerType: ColorPickerType.flex</code> to use flex_color_picker',
                        ),
                        const SizedBox(height: kDefaultPadding / 2),

                        //Flex Color Picker Field
                        ColorPickerField(
                          labelText: 'Pick a Color',
                          pickerType:
                              ColorPickerType.flex, // set flex_color_picker
                          initialColor: kInfoColor,
                          onColorSelected: (color) => debugPrint(color),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: calculateCardWidth_4(
                      context,
                      constraints,
                      numberOfCardsPerRow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rounded Color Picker',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const CardDescription(
                          content:
                              'Add <code> radius: 50()</code> argument to set a rounded color picker field.',
                        ),
                        const SizedBox(height: kDefaultPadding / 2),

                        //Rounded Color Picker
                        ColorPickerField(
                          labelText: 'Pick a Color',
                          pickerType: ColorPickerType.flex,
                          radius: 50, // set rounded
                          initialColor: kErrorColor,
                          onColorSelected: (color) => debugPrint(color),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: kDefaultPadding),
          CardDescription(
            content:
                'Use <code>ColorPickerField()</code>, and add <code>size</code> argument to set size for color picker form field.',
          ),
          SizedBox(height: kDefaultPadding),
          LayoutBuilder(
            builder: (context, constraints) {
              int numberOfCardsPerRow = getNumberOfCardsPerRow_3(context);
              return Wrap(
                spacing: kDefaultPadding,
                runSpacing: kDefaultPadding,
                children: [
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
                          'Small Size',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 2),
                        // Small Size
                        ColorPickerField(
                          labelText: 'Pick a Color',
                          size: FormSize.small, // set small size
                          onColorSelected: (color) => debugPrint(color),
                        ),
                      ],
                    ),
                  ),
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
                          'Medium Size',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 2),
                        // Medium Size
                        ColorPickerField(
                          labelText: 'Pick a Color',
                          size: FormSize.medium, // set medium size
                          initialColor: kSecondaryColor,
                          onColorSelected: (color) => debugPrint(color),
                        ),
                      ],
                    ),
                  ),
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
                          'Large Size',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 2),
                        // Large Size
                        ColorPickerField(
                          labelText: 'Pick a Color',
                          size: FormSize.large, // set large size
                          radius: 50,
                          pickerType: ColorPickerType.flex,
                          initialColor: kInfoColor,
                          onColorSelected: (color) => debugPrint(color),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      codeView: '''
//Default Color Picker Field
ColorPickerField(
  labelText: 'Pick a Color',
  onColorSelected: (color) => debugPrint(color),
),

//Color Picker Field with Initial Color
ColorPickerField(
  labelText: 'Pick a Color',
  initialColor: kSecondaryColor, // initial color
  onColorSelected: (color) => debugPrint(color),
),

//Flex Color Picker Field
ColorPickerField(
  labelText: 'Pick a Color',
  pickerType: ColorPickerType.flex, // set flex_color_picker
  initialColor: kInfoColor,
  onColorSelected: (color) => debugPrint(color),
),

//Rounded Color Picker
ColorPickerField(
  labelText: 'Pick a Color',
  pickerType: ColorPickerType.flex,
  radius: 50, // set rounded
  initialColor: kErrorColor,
  onColorSelected: (color) => debugPrint(color),
),

// Small Size
ColorPickerField(
  labelText: 'Pick a Color',
  size: FormSize.small, // set small size
  onColorSelected: (color) => debugPrint(color),
),

// Medium Size
ColorPickerField(
  labelText: 'Pick a Color',
  size: FormSize.medium, // set medium size
  initialColor: kSecondaryColor,
  onColorSelected: (color) => debugPrint(color),
),

// Large Size
ColorPickerField(
  labelText: 'Pick a Color',
  size: FormSize.large, // set large size
  radius: 50,
  pickerType: ColorPickerType.flex,
  initialColor: kInfoColor,
  onColorSelected: (color) => debugPrint(color),
),
''',
    );
  }
}
