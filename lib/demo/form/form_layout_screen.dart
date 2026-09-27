import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:flutkit_ademin/widgets/form/form_file_upload.dart';
import 'package:flutkit_ademin/widgets/form/form_validator.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/base_ui/toast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormLayoutScreen extends StatefulWidget {
  const FormLayoutScreen({super.key});

  @override
  State<FormLayoutScreen> createState() => _FormLayoutScreenState();
}

class _FormLayoutScreenState extends State<FormLayoutScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).formLayout; //update your page tittle here
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
    final mediaQueryData = MediaQuery.of(context);

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
                      lang.formLayout.toUpperCase(),
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
                          label: lang.formLayout,
                          uri: RouteUri.starterpage,
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
                // grid layout
                ShowCodeCard(
                  cardTitle: 'Grid Form Layout',
                  description:
                      'Example of implementing a grid form layout. Due to the complexity of the form implementation, you can directly see the code in <code>GridFormLayout()</code> in <code>/lib/demo/form/form_layout_screen.dart</code>',
                  uiView: GridFormLayout(),
                  codeView: '''
GridFormLayout()''',
                  height: 200,
                ),

                SizedBox(height: kDefaultPadding),

                // horizontal & vertical layout
                LayoutBuilder(
                  builder: (context, constraints) {
                    double availableWidth =
                        constraints.maxWidth - kDefaultPadding;
                    return Wrap(
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: const ShowCodeCard(
                            cardTitle: 'Horizontal Form Layout',
                            description:
                                'Example of implementing a horizontal form layout, labels on the start and input fields on the end. Due to the complexity of the form implementation, you can directly see the code in <code>HorizontalFormLayout()</code> in <code>/lib/demo/form/form_layout_screen.dart</code>',
                            uiView: Padding(
                              padding: EdgeInsets.only(
                                top: kDefaultPadding / 2,
                              ),
                              child: HorizontalFormLayout(),
                            ),
                            codeView: '''
HorizontalFormLayout()''',
                            height: 200,
                          ),
                        ),
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: const ShowCodeCard(
                            cardTitle: 'Vertical Form Layout',
                            description:
                                'Example of implementing a vertical form layout, labels and input fields are stacked vertically. Due to the complexity of the form implementation, you can directly see the code in <code>VerticalFormLayout()</code> in <code>/lib/demo/form/form_layout_screen.dart</code>',
                            uiView: Padding(
                              padding: EdgeInsets.only(
                                top: kDefaultPadding / 2,
                              ),
                              child: VerticalFormLayout(),
                            ),
                            codeView: '''VerticalFormLayout()''',
                            height: 200,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

// Grid Form Layout

class GridFormLayout extends StatefulWidget {
  const GridFormLayout({super.key});

  @override
  State<GridFormLayout> createState() => _GridFormLayoutState();
}

class _GridFormLayoutState extends State<GridFormLayout> {
  final _gridFormKey = GlobalKey<FormState>();

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  // final departmentController = TextEditingController();
  final evidenceController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final descriptionController = TextEditingController();

  // local state for dropdown / files / checkbox
  String? _selectedDept;
  String? _selectedState;
  List<PlatformFile>? _evidenceFiles;
  final bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Form(
      key: _gridFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveWrap(
            breakpoints: {
              kScreenWidthSm: 1, // set breakpoint for 1 column layout,
              kScreenWidthMd: 2, // set breakpoint for 2 column layout
            },
            columnRatios: const [
              0.5, // set column A as 50% width
              0.5, // set column B as 50% width
            ],
            spacing: kDefaultPadding, // spacing
            runSpacing: kDefaultPadding, // run spacing
            children: [
              // first name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(text: 'First Name', showRequired: false),
                  SizedBox(height: kDefaultPadding / 2),
                  CustomTextFormField(
                    controller: firstNameController,
                    hintText: 'Your First Name',
                    suffixIcon: Icons.person_outline,
                    validator: (value) =>
                        Validators.requiredField(value, context),
                    successMessage: 'Looks Good!',
                  ),
                ],
              ),

              // last name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(text: 'Last Name', showRequired: false),
                  SizedBox(height: kDefaultPadding / 2),
                  CustomTextFormField(
                    controller: lastNameController,
                    hintText: 'Your Last Name',
                    suffixIcon: Icons.person_outline,
                    validator: (value) =>
                        Validators.requiredField(value, context),
                    successMessage: 'Looks Good!',
                  ),
                ],
              ),

              // email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(text: 'Email', showRequired: false),
                  SizedBox(height: kDefaultPadding / 2),
                  CustomTextFormField(
                    controller: emailController,

                    hintText: 'e.g. johndoe@example.com',
                    suffixIcon: Icons.mail_outline,
                    // combining required field and email validator
                    validator: Validators.combineValidators([
                      (value) => Validators.requiredField(value, context),
                      (value) => Validators.email(value, context),
                    ]),
                    successMessage: 'Looks Good!',
                  ),
                ],
              ),

              // phone
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(text: 'Phone Number', showRequired: false),
                  SizedBox(height: kDefaultPadding / 2),
                  CustomTextFormField(
                    controller: phoneNumberController,
                    hintText: 'e.g. +123456789012345 or 123456789012345',
                    validator: Validators.combineValidators([
                      (value) => Validators.requiredField(value, context),
                      (value) => Validators.phone(value, context),
                    ]),
                    suffixIcon: Icons.call_outlined,
                    keyboardType: TextInputType.number,
                    successMessage: 'Looks Good!',
                  ),
                ],
              ),

              // Division
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(text: 'Department', showRequired: false),
                  SizedBox(height: kDefaultPadding / 2),
                  CustomDropdownFormField<String>(
                    hint: 'Choose Department',
                    items: [
                      DropdownMenuItem(
                        value: "hrd",
                        child: Text(
                          "HRD",
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "it",
                        child: Text(
                          "IT",
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "marketing",
                        child: Text(
                          "Marketing",
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                    initialValue: _selectedDept,
                    onChanged: (value) => setState(() => _selectedDept = value),
                    validator: (value) => Validators.requiredField(
                      value,
                      context,
                      customMessage: 'Dept must be selected',
                    ),
                  ),
                ],
              ),

              // Evidence
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(text: 'Evidence', showRequired: false),
                  SizedBox(height: kDefaultPadding / 2),
                  FileUploadForm(
                    // combining required and file extension validators
                    onFilesSelected: (files) =>
                        setState(() => _evidenceFiles = files),
                    validator: Validators.combineFileValidators([
                      (files) => Validators.fileRequired(files, context),
                      (files) => Validators.fileExtension(files, [
                        'pdf',
                        'jpg',
                      ], context), // pdf, jpg extension only
                    ]),
                    successMessage: 'Looks Good!',
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: kDefaultPadding),

          ResponsiveWrap(
            breakpoints: {
              kScreenWidthSm: 1, // set breakpoint for 1 column layout,
              kScreenWidthMd: 3, // set breakpoint for 3 column layout
            },
            columnRatios: const [
              1 / 3, // set column A as 1/3 width
              1 / 3, // set column B as 1/3 width
              1 / 3, // set column C as 1/3 width
            ],
            spacing: kDefaultPadding, // spacing
            runSpacing: kDefaultPadding, // run spacing
            children: [
              // City
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(text: 'City', showRequired: false),
                  SizedBox(height: kDefaultPadding / 2),
                  CustomTextFormField(
                    controller: cityController,
                    hintText: 'Your City',
                    suffixIcon: Icons.location_city_outlined,
                    validator: (value) =>
                        Validators.requiredField(value, context),
                    successMessage: 'Looks Good!',
                  ),
                ],
              ),

              // State
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(text: 'State', showRequired: false),
                  SizedBox(height: kDefaultPadding / 2),
                  CustomDropdownFormField<String>(
                    hint: 'Choose State',
                    items: const [
                      DropdownMenuItem(
                        value: "california",
                        child: Text("California"),
                      ),
                      DropdownMenuItem(
                        value: "florida",
                        child: Text("Florida"),
                      ),
                      DropdownMenuItem(value: "texas", child: Text("Texas")),
                    ],
                    initialValue: _selectedState,
                    onChanged: (val) => setState(() => _selectedState = val),
                    validator: (value) => Validators.requiredField(
                      value,
                      context,
                      customMessage: 'State must be selected',
                    ),
                  ),
                ],
              ),

              // zip code
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(text: 'Zip Code', showRequired: false),
                  SizedBox(height: kDefaultPadding / 2),
                  CustomTextFormField(
                    controller: zipController,
                    hintText: 'e.g. 90210',
                    validator: FormBuilderValidators.zipCode(),
                    suffixIcon: Icons.location_history_outlined,
                    keyboardType: TextInputType.number,
                    successMessage: 'Looks Good!',
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: kDefaultPadding),

          // Description
          FormLabel(text: 'Description', showRequired: false),
          SizedBox(height: kDefaultPadding / 2),
          CustomTextFormField(
            controller: descriptionController,
            hintText: "Type your message...",
            minLines: 6,
            maxLines: 6,
            validator: (value) => Validators.requiredField(value, context),
            successMessage: 'Looks Good!',
          ),
          SizedBox(height: kDefaultPadding),

          // checkbox
          CustomCheckbox(
            label: "I agree to terms and conditions",
            value: false,
            onChanged: (val) {},
            validator: (val) => Validators.requiredField(
              val == true ? 'checked' : null,
              context,
              customMessage: "You must agree to the terms & conditions",
            ),
          ),

          SizedBox(height: kDefaultPadding),

          // submit button
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: FlatButton(
              kText: 'Submit',
              bgColor: kSuccessColor,
              kTextColor: Colors.white,
              onPressed: () {
                if (_gridFormKey.currentState!.validate()) {
                  // simulate send to server
                  final data = {
                    'firstName': firstNameController.text,
                    'lastName': lastNameController.text,
                    'email': emailController.text,
                    'phone': phoneNumberController.text,
                    'department': _selectedDept,
                    'description': descriptionController.text,
                    'agreed': _agreed,
                    'evidenceFiles':
                        _evidenceFiles
                            ?.map((f) => {'name': f.name, 'size': f.size})
                            .toList() ??
                        [],
                    'city': cityController,
                    'state': _selectedState,
                    'zip': zipController,
                  };

                  debugPrint('=== Submitting form (simulated) ===');
                  debugPrint(data.toString());

                  // Submission complete success message
                  Toast.showToast(
                    duration: Duration(seconds: 4),
                    context: context,
                    icon: Icons.check_circle_outline,
                    message: 'Submission Complete!',
                    color: kSuccessColor,
                    alignment: Alignment.topRight,
                    showProgress: true,
                    showCloseButton: true, // show close button
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Vertical Form Layout

class VerticalFormLayout extends StatefulWidget {
  const VerticalFormLayout({super.key});

  @override
  State<VerticalFormLayout> createState() => _VerticalFormLayoutState();
}

class _VerticalFormLayoutState extends State<VerticalFormLayout> {
  final _verticalFormKey = GlobalKey<FormState>();

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final departmentController = TextEditingController();
  final evidenceController = TextEditingController();
  final descriptionController = TextEditingController();

  // local state for dropdown / files / checkbox
  String? _selectedDept;
  List<PlatformFile>? _evidenceFiles;
  final bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Form(
      key: _verticalFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // first name
          FormLabel(text: 'First Name', showRequired: false),
          SizedBox(height: kDefaultPadding / 2),
          CustomTextFormField(
            controller: firstNameController,
            labelText: 'First Name',
            hintText: 'Your First Name',
            suffixIcon: Icons.person_outline,
            validator: (value) => Validators.requiredField(value, context),
            successMessage: 'Looks Good!',
          ),
          SizedBox(height: kDefaultPadding),

          // last name
          FormLabel(text: 'Last Name', showRequired: false),
          SizedBox(height: kDefaultPadding / 2),
          CustomTextFormField(
            controller: lastNameController,
            labelText: 'Last Name',
            hintText: 'Your Last Name',
            suffixIcon: Icons.person_outline,
            validator: (value) => Validators.requiredField(value, context),
            successMessage: 'Looks Good!',
          ),
          SizedBox(height: kDefaultPadding),

          // email
          FormLabel(text: 'Email', showRequired: false),
          SizedBox(height: kDefaultPadding / 2),
          CustomTextFormField(
            controller: emailController,
            labelText: 'Email',
            hintText: 'e.g. johndoe@example.com',
            suffixIcon: Icons.mail_outline,
            // combining required field and email validator
            validator: Validators.combineValidators([
              (value) => Validators.requiredField(value, context),
              (value) => Validators.email(value, context),
            ]),
            successMessage: 'Looks Good!',
          ),
          SizedBox(height: kDefaultPadding),

          // phone
          FormLabel(text: 'Phone Number', showRequired: false),
          SizedBox(height: kDefaultPadding / 2),
          CustomTextFormField(
            controller: phoneNumberController,
            labelText: 'Phone Number',
            hintText: 'e.g. +123456789012345 or 123456789012345',
            validator: Validators.combineValidators([
              (value) => Validators.requiredField(value, context),
              (value) => Validators.phone(value, context),
            ]),
            suffixIcon: Icons.call_outlined,
            keyboardType: TextInputType.number,
            successMessage: 'Looks Good!',
          ),
          SizedBox(height: kDefaultPadding),

          // Division
          FormLabel(text: 'Department', showRequired: false),
          SizedBox(height: kDefaultPadding / 2),
          CustomDropdownFormField<String>(
            hint: 'Choose Department',
            items: [
              DropdownMenuItem(
                value: "hrd",
                child: Text(
                  "HRD",
                  style: TextStyle(color: themeData.colorScheme.onSurface),
                ),
              ),
              DropdownMenuItem(
                value: "it",
                child: Text(
                  "IT",
                  style: TextStyle(color: themeData.colorScheme.onSurface),
                ),
              ),
              DropdownMenuItem(
                value: "marketing",
                child: Text(
                  "Marketing",
                  style: TextStyle(color: themeData.colorScheme.onSurface),
                ),
              ),
            ],
            initialValue: _selectedDept,
            onChanged: (val) => setState(() => _selectedDept = val),
            validator: (value) => Validators.requiredField(
              value,
              context,
              customMessage: 'Dept must be selected',
            ),
          ),
          SizedBox(height: kDefaultPadding),

          // Evidence
          FormLabel(text: 'Evidence', showRequired: false),
          SizedBox(height: kDefaultPadding / 2),
          FileUploadForm(
            // combining required and file extension validators
            onFilesSelected: (files) => setState(() => _evidenceFiles = files),
            validator: Validators.combineFileValidators([
              (files) => Validators.fileRequired(files, context),
              (files) => Validators.fileExtension(files, [
                'pdf',
                'jpg',
              ], context), // pdf, jpg extension only
            ]),
            successMessage: 'Looks Good!',
          ),
          SizedBox(height: kDefaultPadding),

          // Description
          FormLabel(text: 'Description', showRequired: false),
          SizedBox(height: kDefaultPadding / 2),
          CustomTextFormField(
            controller: descriptionController,
            hintText: "Type your message...",
            minLines: 6,
            maxLines: 6,
            validator: (value) => Validators.requiredField(value, context),
            successMessage: 'Looks Good!',
          ),
          SizedBox(height: kDefaultPadding),

          // checkbox
          CustomCheckbox(
            label: "I agree to terms and conditions",
            value: false,
            onChanged: (val) {},
            validator: (val) => Validators.requiredField(
              val == true ? 'checked' : null,
              context,
              customMessage: "You must agree to the terms & conditions",
            ),
          ),

          SizedBox(height: kDefaultPadding),

          // submit button
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: FlatButton(
              kText: 'Submit',
              bgColor: kSuccessColor,
              kTextColor: Colors.white,
              onPressed: () {
                if (_verticalFormKey.currentState!.validate()) {
                  // simulate send to server
                  final data = {
                    'firstName': firstNameController.text,
                    'lastName': lastNameController.text,
                    'email': emailController.text,
                    'phone': phoneNumberController.text,
                    'department': _selectedDept,
                    'description': descriptionController.text,
                    'agreed': _agreed,
                    'evidenceFiles':
                        _evidenceFiles
                            ?.map((f) => {'name': f.name, 'size': f.size})
                            .toList() ??
                        [],
                  };

                  debugPrint('=== Submitting form (simulated) ===');
                  debugPrint(data.toString());

                  // Submission complete success message
                  Toast.showToast(
                    duration: Duration(seconds: 4),
                    context: context,
                    icon: Icons.check_circle_outline,
                    message: 'Submission Complete!',
                    color: kSuccessColor,
                    alignment: Alignment.topRight,
                    showProgress: true,
                    showCloseButton: true, // show close button
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Horizontal Form Layout

class HorizontalFormLayout extends StatefulWidget {
  const HorizontalFormLayout({super.key});

  @override
  State<HorizontalFormLayout> createState() => _HorizontalFormLayoutState();
}

class _HorizontalFormLayoutState extends State<HorizontalFormLayout> {
  final _horizontalFormKey = GlobalKey<FormState>();

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final departmentController = TextEditingController();
  final evidenceController = TextEditingController();
  final descriptionController = TextEditingController();

  // local state for dropdown / files / checkbox
  String? _selectedDept;
  List<PlatformFile>? _evidenceFiles;
  final bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Form(
      key: _horizontalFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveWrap(
            spacing: kDefaultPadding,
            runSpacing: kDefaultPadding / 2,
            columnRatios: [0.25, 0.75],
            breakpoints: {520: 1, kScreenWidthMd: 2},
            children: [
              // first name
              FormLabel(text: 'First Name', showRequired: false),
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: CustomTextFormField(
                  controller: firstNameController,
                  labelText: 'First Name',
                  hintText: 'Your First Name',
                  suffixIcon: Icons.person_outline,
                  validator: (value) =>
                      Validators.requiredField(value, context),
                  successMessage: 'Looks Good!',
                ),
              ),

              // last name
              FormLabel(text: 'Last Name', showRequired: false),
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: CustomTextFormField(
                  controller: lastNameController,
                  labelText: 'Last Name',
                  hintText: 'Your Last Name',
                  suffixIcon: Icons.person_outline,
                  validator: (value) =>
                      Validators.requiredField(value, context),
                  successMessage: 'Looks Good!',
                ),
              ),

              // email
              FormLabel(text: 'Email', showRequired: false),
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: CustomTextFormField(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'e.g. johndoe@example.com',
                  suffixIcon: Icons.mail_outline,
                  // combining required field and email validator
                  validator: Validators.combineValidators([
                    (value) => Validators.requiredField(value, context),
                    (value) => Validators.email(value, context),
                  ]),
                  successMessage: 'Looks Good!',
                ),
              ),

              // phone
              FormLabel(text: 'Phone Number', showRequired: false),
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: CustomTextFormField(
                  controller: phoneNumberController,
                  labelText: 'Phone Number',
                  hintText: 'e.g. +123456789012345 or 123456789012345',
                  validator: Validators.combineValidators([
                    (value) => Validators.requiredField(value, context),
                    (value) => Validators.phone(value, context),
                  ]),
                  suffixIcon: Icons.call_outlined,
                  keyboardType: TextInputType.number,
                  successMessage: 'Looks Good!',
                ),
              ),

              // Division
              FormLabel(text: 'Department', showRequired: false),
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: CustomDropdownFormField<String>(
                  hint: 'Choose Department',
                  items: [
                    DropdownMenuItem(
                      value: "hrd",
                      child: Text(
                        "HRD",
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "it",
                      child: Text(
                        "IT",
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "marketing",
                      child: Text(
                        "Marketing",
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                  initialValue: _selectedDept,
                  onChanged: (val) => setState(() => _selectedDept = val),
                  validator: (value) => Validators.requiredField(
                    value,
                    context,
                    customMessage: 'Dept must be selected',
                  ),
                ),
              ),

              // Evidence
              FormLabel(text: 'Evidence', showRequired: false),
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: FileUploadForm(
                  // combining required and file extension validators
                  onFilesSelected: (files) =>
                      setState(() => _evidenceFiles = files),
                  validator: Validators.combineFileValidators([
                    (files) => Validators.fileRequired(files, context),
                    (files) => Validators.fileExtension(files, [
                      'pdf',
                      'jpg',
                    ], context), // pdf, jpg extension only
                  ]),
                  successMessage: 'Looks Good!',
                ),
              ),

              // Description
              FormLabel(text: 'Description', showRequired: false),
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: CustomTextFormField(
                  controller: descriptionController,
                  hintText: "Type your message...",
                  minLines: 6,
                  maxLines: 6,
                  validator: (value) =>
                      Validators.requiredField(value, context),
                  successMessage: 'Looks Good!',
                ),
              ),

              // checkbox
              SizedBox(),
              CustomCheckbox(
                label: "I agree to terms and conditions",
                value: false,
                onChanged: (val) {},
                validator: (val) => Validators.requiredField(
                  val == true ? 'checked' : null,
                  context,
                  customMessage: "You must agree to the terms & conditions",
                ),
              ),
            ],
          ),

          SizedBox(height: kDefaultPadding),

          // submit button
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: FlatButton(
              kText: 'Submit',
              bgColor: kSuccessColor,
              kTextColor: Colors.white,
              onPressed: () {
                if (_horizontalFormKey.currentState!.validate()) {
                  // simulate send to server
                  final data = {
                    'firstName': firstNameController.text,
                    'lastName': lastNameController.text,
                    'email': emailController.text,
                    'phone': phoneNumberController.text,
                    'department': _selectedDept,
                    'description': descriptionController.text,
                    'agreed': _agreed,
                    'evidenceFiles':
                        _evidenceFiles
                            ?.map((f) => {'name': f.name, 'size': f.size})
                            .toList() ??
                        [],
                  };

                  debugPrint('=== Submitting form (simulated) ===');
                  debugPrint(data.toString());

                  // Submission complete success message
                  Toast.showToast(
                    duration: Duration(seconds: 4),
                    context: context,
                    icon: Icons.check_circle_outline,
                    message: 'Submission Complete!',
                    color: kSuccessColor,
                    alignment: Alignment.topRight,
                    showProgress: true,
                    showCloseButton: true, // show close button
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
