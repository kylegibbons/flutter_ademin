import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/alert.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:flutkit_ademin/widgets/form/form_file_upload.dart';
import 'package:flutkit_ademin/widgets/helper/card_description.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_validator.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormValidationScreen extends StatefulWidget {
  const FormValidationScreen({super.key});

  @override
  State<FormValidationScreen> createState() => _FormValidationScreenState();
}

class _FormValidationScreenState extends State<FormValidationScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).formValidation; //update your page tittle here
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
            padding: EdgeInsets.symmetric(
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
                  offset: Offset(0, 1),
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
                      lang.formValidation.toUpperCase(),
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
                          label: lang.formValidation,
                          uri: RouteUri.formValidation,
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
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // built in validation
                ShowCodeCard(
                  cardTitle: 'Built In Validation',
                  uiView: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardDescription(
                        content:
                            "To ensure data integrity and a smooth user experience, it's best practice to leverage the built-in validation mechanisms. Utilizing these tools allows you to perform client-side checks—validating user input before it's submitted to the server—which provides instant feedback to the user, catches common errors immediately, and reduces unnecessary network traffic. This approach streamlines the form submission process while making your application more efficient and user-friendly.",
                      ),

                      SizedBox(height: kDefaultPadding),
                      // validators description
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int numberOfCardsPerRow = getNumberOfCardsPerRow_2(
                            context,
                          );
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CardDescription(
                                      content:
                                          '<code>Validators.requiredField()</code> to validates if the field is non-empty.',
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          '<code>Validators.email()</code> to validates if the field is a valid email address.',
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          '<code>Validators.minLength()</code> to validates if the field has a minimum length.',
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          '<code>Validators.maxLength()</code> to validates if the field has a maximum length.',
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          '<code>Validators.numeric()</code> to validates if the field is a valid numeric value.',
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          '<code>Validators.alphanumeric()</code> to validates if the field contains only alphanumeric characters.',
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          '<code>Validators.regex()</code> to validates if the field matches a custom regular expression.',
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          '<code>Validators.phone()</code> to validates if the field is a valid phone number (basic pattern).',
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CardDescription(
                                      content:
                                          '<code>Validators.strongPassword()</code> to validates if the field is a strong password (minimum 8 characters, including uppercase, lowercase, digit, and special character).',
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          '<code>Validators.match()</code> to validates if two values match (useful for password confirmation).',
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          '<code>Validators.url()</code> to validates if the value is a valid URL.',
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          '<code>Validators.fileRequired()</code> to validates if the field is non-empty.',
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          "<code>Validators.fileExtension()</code> to validates a file's extension.",
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          "<code>Validators.fileSize()</code> to validates file's size.",
                                    ),
                                    SizedBox(height: 0.5 * kDefaultPadding),
                                    CardDescription(
                                      content:
                                          'Combining multiple validators by using <code>Validators.combineValidators()</code> and <code>Validators.combineFileValidators()</code>.',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      SizedBox(height: kDefaultPadding),
                      // info alert
                      Alert(
                        htmlContent:
                            "Fill in all fields, then click Submit Form to validate. An error message will appear if the input doesn't meet the validator's criteria (hint). ",
                        kColor: kInfoColor,
                        isOutlined: false,
                      ),

                      SizedBox(height: 2 * kDefaultPadding),

                      // form demo
                      BuiltInValidationExample(),
                    ],
                  ),
                  codeView: '''
// Required Field Validator
CustomTextFormField(
  labelText: 'First Name',
  hintText: 'Your First Name',
  suffixIcon: Icons.person_outline,
  validator: (value) => Validators.requiredField(value, context),
),

// Email Validator
CustomTextFormField(
  labelText: 'Email',
  hintText: 'e.g. johndoe@example.com',
  suffixIcon: Icons.mail_outline,
  // combining required field and email validator
  validator: Validators.combineValidators(
    [
      (value) => Validators.requiredField(value, context),
      (value) => Validators.email(value, context)
    ],
  ),
),

// Minimum Length Validator
CustomTextFormField(
  labelText: 'Username',
  hintText: 'Min 5 chars',
  suffixIcon: Icons.person_outline,

  // combining required field and min length validator
  validator: Validators.combineValidators(
    [
      (value) => Validators.requiredField(value, context),
      (value) => Validators.minLength(value, 5, context),
    ],
  ),
),

  // Maximum Length Validator
CustomTextFormField(
  labelText: 'Nickname',
  hintText: 'Max 10 chars',
  suffixIcon: Icons.person_outline,
  validator: (value) => Validators.maxLength(value, 10, context),
),

  // Numeric Validator
CustomTextFormField(
  labelText: 'Age',
  hintText: 'Number only',
  suffixIcon: Icons.numbers_outlined,
  validator: (value) => Validators.numeric(value, context),
  keyboardType: TextInputType.number,
),

// Alphanumeric Validator
CustomTextFormField(
  labelText: 'Code',
  hintText: 'Alphanumeric only',
  suffixIcon: Icons.pin_outlined,
  validator: (value) => Validators.alphanumeric(value, context),
),

// Regular Expression Validator (Custom Regex)
CustomTextFormField(
  labelText: 'Custom Pattern',
  hintText: 'Only "coupon124" allowed',
  suffixIcon: Icons.abc,
  validator: (value) => Validators.regex(value, RegExp(r'^coupon124\$'), context),
),

// Phone Validator
CustomTextFormField(
  labelText: 'Phone Number',
  hintText: 'e.g. +123456789012345 or 123456789012345',
  validator: (value) => Validators.phone(value, context),
  suffixIcon: Icons.call_outlined,
  keyboardType: TextInputType.number,
),

//Dropdown Field
CustomDropdownFormField<String>(
  items: [
    DropdownMenuItem(
      value: "basic",
      child: Text("Basic Plan"),
    ),
    DropdownMenuItem(
      value: "pro",
      child: Text("Pro Plan"),
    ),
    DropdownMenuItem(
      value: "enterprise",
      child: Text("Enterprise Plan"),
    ),
  ],
  initialValue: null,
  validator: (value) => Validators.requiredField(
      value, context,
      customMessage: 'Plan must be selected',
      ),
),

// Strong Password Validator
CustomTextFormField(
  labelText: 'Input Password',
  hintText: 'Use a strong password',
  isPassword: true,
  controller: _passwordController,

  // combining required field and strong password
  validator: Validators.combineValidators(
    [
      (value) => Validators.requiredField(value, context),
      (value) => Validators.strongPassword(value, context),
    ],
  ),
),

// Match Validator

CustomTextFormField(
  labelText: 'Input Password',
  hintText: 'Use the same password',
  isPassword: true,

  // combining required field and match value validators
  validator: Validators.combineValidators(
    [
      (value) => Validators.requiredField(value, context),
      (value) => Validators.match(value, _passwordController.text, context),
    ],
  ),
),

// URL Validator
CustomTextFormField(
  labelText: 'Website URL',
  hintText: 'e.g. flutter.com',
  suffixIcon: Icons.language_outlined,
  validator: (value) => Validators.url(value, context),
),

// File Required Validator
FileUploadForm(
  validator: (files) => Validators.fileRequired(files, context),
),

// File Required Validator

FileUploadForm(
  // combining required and file extension validators
  validator: Validators.combineFileValidators([
    (files) => Validators.fileRequired(files, context),
    (files) => Validators.fileExtension(
        files,
        ['pdf', 'jpg'],
        context), // pdf, jpg extension only
  ]),
),

// File Size Validator

FileUploadForm(
  validator: (files) => Validators.fileSize(
      files, 1, FileSizeUnit.mb, context), // 1 mb max
),

// Text Area with Required Field Validator

CustomTextFormField(
  hintText: "Type your message...",
  minLines: 6,
  maxLines: 6,
  validator: (value) => Validators.requiredField(value, context),
),

// Checkbox with Required Field Validator
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
''',
                ),
                SizedBox(height: kDefaultPadding),

                // validation with success message
                ShowCodeCard(
                  cardTitle: 'Real-time Validation with Success Message',
                  uiView: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardDescription(
                        content:
                            "Add <code>successMessage</code> argument to set real-time validation with success message.",
                      ),

                      SizedBox(height: kDefaultPadding),
                      // info alert
                      Alert(
                        htmlContent:
                            "Fill in all the fields according to the hints, and a success message will appear in real-time. Finally, you can perform final validation by clicking <b>Validate Form</b>, the error message will only appear after you click this button.",
                        kColor: kInfoColor,
                        isOutlined: false,
                      ),

                      SizedBox(height: 2 * kDefaultPadding),

                      // form demo
                      SuccessMessageValidationExample(),
                    ],
                  ),
                  codeView: '''
// Required Field Validator
CustomTextFormField(
  labelText: 'First Name',
  hintText: 'Your First Name',
  suffixIcon: Icons.person_outline,
  validator: (value) =>
      Validators.requiredField(value, context),
  successMessage: 'Looks Good!', // show success message
),

// Email Validator
CustomTextFormField(
  labelText: 'Email',
  hintText: 'e.g. johndoe@example.com',
  suffixIcon: Icons.mail_outline,
  validator: Validators.combineValidators(
    [
      (value) =>
          Validators.requiredField(value, context),
      (value) => Validators.email(value, context)
    ],
  ),

  successMessage:
      'Email seems valid!', // show success message
),

// Minimum Length Validator
CustomTextFormField(
  labelText: 'Username',
  hintText: 'Min 5 chars',
  suffixIcon: Icons.person_outline,
  validator: Validators.combineValidators(
    [
      (value) =>
          Validators.requiredField(value, context),
      (value) =>
          Validators.minLength(value, 5, context),
    ],
  ),

  successMessage:
      'Nice username!', // show success message
),

// Maximum Length Validator
CustomTextFormField(
  labelText: 'Nickname',
  hintText: 'Max 10 chars',
  suffixIcon: Icons.person_outline,
  validator: (value) =>
      Validators.maxLength(value, 10, context),

  successMessage: 'Good nickname!', // show success message
),

// Numeric Validator
CustomTextFormField(
  labelText: 'Age',
  hintText: 'Number only',
  suffixIcon: Icons.numbers_outlined,
  validator: (value) =>
      Validators.numeric(value, context),
  keyboardType: TextInputType.number,
  successMessage: 'Looks Good!', // show success message
),

// Alphanumeric Validator
CustomTextFormField(
  labelText: 'Code',
  hintText: 'Alphanumeric only',
  suffixIcon: Icons.pin_outlined,
  validator: (value) =>
      Validators.alphanumeric(value, context),
  successMessage: 'Looks Good!', // show success message
),

// Regular Expression Validator (Custom Regex)
CustomTextFormField(
  labelText: 'Custom Pattern',
  hintText: 'Only "coupon124" allowed',
  suffixIcon: Icons.abc,
  validator: (value) => Validators.regex(
      value, RegExp(r'^coupon124\$'), context),
  successMessage:
      'valid coupon code!', // show success message
),

// Phone Validator
CustomTextFormField(
  labelText: 'Phone Number',
  hintText: 'e.g. +123456789012345 or 123456789012345',
  validator: (value) =>
      Validators.phone(value, context),
  suffixIcon: Icons.call_outlined,
  keyboardType: TextInputType.number,
  successMessage: 'Valid phone number!', // show success message
),

//Dropdown Field
CustomDropdownFormField<String>(
  hint: 'Select a Plan',
  items: [
    DropdownMenuItem(
      value: "basic",
      child: Text("Basic Plan"),
    ),
    DropdownMenuItem(
      value: "pro",
      child: Text("Pro Plan"),
    ),
    DropdownMenuItem(
      value: "enterprise",
      child: Text("Enterprise Plan"),
    ),
  ],
  initialValue: null,
  validator: (value) => Validators.requiredField(
      value, context,
      customMessage: 'Plan must be selected'),
  // successMessage: 'Looks Good!', // show success message
  successMessage:
      'Perfect Choice!', // custom succes message
),

// Strong Password Validator
CustomTextFormField(
  labelText: 'Input Password',
  hintText: 'Use a strong password',
  isPassword: true,
  controller: _passwordController,

  // combining required field and strong password
  validator: Validators.combineValidators(
    [
      (value) =>
          Validators.requiredField(value, context),
      (value) =>
          Validators.strongPassword(value, context),
    ],
  ),
  successMessage:
      'Your password is strong!', // show success message
),

// Match Validator
CustomTextFormField(
  labelText: 'Input Password',
  hintText: 'Use the same password',
  isPassword: true,

  // combining required field and match value validators
  validator: Validators.combineValidators(
    [
      (value) =>
          Validators.requiredField(value, context),
      (value) => Validators.match(
          value, _passwordController.text, context),
    ],
  ),
  successMessage:
      'Password match!', // show success message
),

// URL Validator
CustomTextFormField(
  labelText: 'Website URL',
  hintText: 'e.g. flutter.com',
  suffixIcon: Icons.language_outlined,
  validator: (value) => Validators.url(value, context),
  successMessage: 'Looks Good!', // show success message
),

// File Required Validator
FileUploadForm(
  validator: (files) =>
      Validators.fileRequired(files, context),
  successMessage: "The file is correct!",
),

// File Required Validator
FileUploadForm(
  // combining required and file extension validators
  validator: Validators.combineFileValidators([
    (files) => Validators.fileRequired(files, context),
    (files) => Validators.fileExtension(
        files,
        ['pdf', 'jpg', 'png'],
        context), // pdf, jpg, png extension only
  ]),

  successMessage: "The file is correct!",
),

// File Size Validator
FileUploadForm(
  validator: (files) => Validators.fileSize(
      files, 1, FileSizeUnit.mb, context), // 1 mb max

  successMessage: "The file size is correct!",
),

// Text Area with Required Field Validator
CustomTextFormField(
hintText: "Type your message...",
minLines: 6,
maxLines: 6,
validator: (value) => Validators.requiredField(value, context),
successMessage: 'Looks Good!',
),                     
''',
                ),
                SizedBox(height: kDefaultPadding),

                // Form Builder Validators
                ShowCodeCard(
                  cardTitle: 'Form Builder Validators ',
                  uiView: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardDescription(
                        content:
                            "Our Flutter template supports external validators, here is an example using <a href='https://pub.dev/packages/form_builder_validators' target = '_blank'>Form Builder Validators</a> .",
                      ),

                      SizedBox(height: kDefaultPadding),
                      // info alert
                      Alert(
                        htmlContent:
                            "Fill in all the fields according to the hints, and a success message will appear in real time. Finally, you can perform final validation by clicking <b>Validate Form</b>, the error message will only appear after you click this button.",
                        kColor: kInfoColor,
                        isOutlined: false,
                      ),

                      SizedBox(height: 2 * kDefaultPadding),

                      // form demo
                      FormBuilderValidatorsDemo(),
                    ],
                  ),
                  codeView: '''
// Required Field Validator
CustomTextFormField(
  labelText: 'First Name',
  hintText: 'Your First Name',
  suffixIcon: Icons.person_outline,
  validator: FormBuilderValidators.required(),
  successMessage: 'Looks Good!', // show success message
),   

// Email Validator
CustomTextFormField(
  labelText: 'Email',
  hintText: 'e.g. johndoe@example.com',
  suffixIcon: Icons.mail_outline,
  validator: FormBuilderValidators.email(),
  successMessage:
      'Email seems valid!', // show success message
),

// Username Validator
CustomTextFormField(
  labelText: 'Username',
  hintText: 'Min 5 chars',
  suffixIcon: Icons.person_outline,
  validator: FormBuilderValidators.username(
    minLength: 3,
    maxLength: 5,
    allowUnderscore: true,
  ),
  successMessage:
      'Perfect username!', // show success message
),      

// Minimum Length Validator
CustomTextFormField(
  labelText: 'Nickname',
  hintText: 'Max 10 chars',
  suffixIcon: Icons.person_outline,
  validator: FormBuilderValidators.minLength(
    3,
    checkNullOrEmpty: false,
  ),
  successMessage: 'Looks Good!', // show success message
),       

// Maximum Length Validator
CustomTextFormField(
  labelText: 'Nickname',
  hintText: 'Max 10 chars',
  suffixIcon: Icons.person_outline,
  validator: FormBuilderValidators.maxLength(
    10,
    checkNullOrEmpty: false,
  ),
  successMessage: 'Looks Good!', // show success message
), 

  // Numeric Validator
CustomTextFormField(
  labelText: 'Age',
  hintText: 'Number only',
  suffixIcon: Icons.numbers_outlined,
  validator: FormBuilderValidators.numeric(
    checkNullOrEmpty: false,
  ),
  keyboardType: TextInputType.number,
  successMessage: 'Looks Good!', // show success message
),     

// Negative Number Validator
CustomTextFormField(
  labelText: 'Negative Number',
  hintText: 'Negative Number only',
  suffixIcon: Icons.pin_outlined,
  validator: FormBuilderValidators.negativeNumber(
    checkNullOrEmpty: false,
  ),
  successMessage: 'Looks Good!', // show success message
),  

// Negative Number Validator
CustomTextFormField(
  labelText: 'Code',
  hintText: 'Alphanumeric only',
  suffixIcon: Icons.pin_outlined,
  validator: FormBuilderValidators.integer(
    checkNullOrEmpty: false,
  ),
  successMessage: 'Looks Good!', // show success message
), 

// Phone Validator
CustomTextFormField(
  labelText: 'Phone Number',
  hintText: 'e.g. +123456789012345 or 123456789012345',
  validator: FormBuilderValidators.phoneNumber(
    checkNullOrEmpty: false,
  ),
  suffixIcon: Icons.call_outlined,
  keyboardType: TextInputType.number,
  successMessage: 'Looks Good!', // show success message
),


//Dropdown Field
CustomDropdownFormField<String>(
  hint: 'Select a Plan',
  items: [
    DropdownMenuItem(
      value: "basic",
      child: Text("Basic Plan"),
    ),
    DropdownMenuItem(
      value: "pro",
      child: Text("Pro Plan"),
    ),
    DropdownMenuItem(
      value: "enterprise",
      child: Text("Enterprise Plan"),
    ),
  ],
  initialValue: null,
  validator: FormBuilderValidators.phoneNumber(),
  // successMessage: 'Looks Good!', // show success message
  successMessage:
      'Perfect Choice!', // custom succes message
),

// Strong Password Validator
CustomTextFormField(
  labelText: 'Input Password',
  hintText: 'Use a strong password',
  isPassword: true,
  controller: _passwordController,
  validator: FormBuilderValidators
      .password(), // Strong password validator
  successMessage:
      'Your password is strong!', // show success message
),

// URL Validator
CustomTextFormField(
  labelText: 'Website URL',
  hintText: 'e.g. flutter.com',
  suffixIcon: Icons.language_outlined,
  validator: FormBuilderValidators.url(
    checkNullOrEmpty: false,
  ),
  successMessage: 'Looks Good!', // show success message
),

// Credit Card Validator
CustomTextFormField(
  labelText: 'Credit Card',
  hintText: 'e.g. 378282246310005',
  suffixIcon: Icons.credit_card_outlined,
  validator: FormBuilderValidators.creditCard(
    checkNullOrEmpty: false,
  ),
  successMessage: 'Looks Good!', // show success message
),

  // Required Validator
FileUploadForm(
  validator: FormBuilderValidators.required(),
  successMessage: 'Looks Good!',
),

// Text Area with Required Field Validator
CustomTextFormField(
hintText: "Type your message...",
minLines: 6,
maxLines: 6,
validator: FormBuilderValidators.required(),
successMessage: 'Looks Good', // show success message
),
''',
                ),
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

//Form Builder Validators Demo

class FormBuilderValidatorsDemo extends StatefulWidget {
  const FormBuilderValidatorsDemo({super.key});

  @override
  State<FormBuilderValidatorsDemo> createState() =>
      _FormBuilderValidatorsDemoState();
}

class _FormBuilderValidatorsDemoState extends State<FormBuilderValidatorsDemo> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Form(
      key: _formKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        FormLabel(text: 'First Name'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Required Field Validator
                        CustomTextFormField(
                          labelText: 'First Name',
                          hintText: 'Your First Name',
                          suffixIcon: Icons.person_outline,
                          validator: FormBuilderValidators.required(),
                          successMessage: 'Looks Good!', // show success message
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
                        FormLabel(text: 'Email'),
                        SizedBox(height: 0.5 * kDefaultPadding),
                        // Email Validator
                        CustomTextFormField(
                          labelText: 'Email',
                          hintText: 'e.g. johndoe@example.com',
                          suffixIcon: Icons.mail_outline,
                          validator: FormBuilderValidators.email(),
                          successMessage:
                              'Email seems valid!', // show success message
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
                        FormLabel(text: 'Username'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Username Validator
                        CustomTextFormField(
                          labelText: 'Username',
                          hintText: 'Min 5 chars, max 10 chars',
                          suffixIcon: Icons.person_outline,
                          validator: FormBuilderValidators.username(
                            minLength: 5,
                            maxLength: 10,
                            allowUnderscore: true,
                          ),
                          successMessage:
                              'Perfect username!', // show success message
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
                          'Nickname',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Minimum Length Validator
                        CustomTextFormField(
                          labelText: 'Nickname',
                          hintText: 'Max 10 chars',
                          suffixIcon: Icons.person_outline,
                          validator: FormBuilderValidators.minLength(
                            3,
                            checkNullOrEmpty: false,
                          ),
                          successMessage: 'Looks Good!', // show success message
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
                          'Nickname',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Maximum Length Validator
                        CustomTextFormField(
                          labelText: 'Nickname',
                          hintText: 'Max 10 chars',
                          suffixIcon: Icons.person_outline,
                          validator: FormBuilderValidators.maxLength(
                            10,
                            checkNullOrEmpty: false,
                          ),
                          successMessage: 'Looks Good!', // show success message
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
                        // Numeric Validator
                        Text(
                          'Age',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),
                        // Numeric Validator
                        CustomTextFormField(
                          labelText: 'Age',
                          hintText: 'Number only',
                          suffixIcon: Icons.numbers_outlined,
                          validator: FormBuilderValidators.numeric(
                            checkNullOrEmpty: false,
                          ),
                          keyboardType: TextInputType.number,
                          successMessage: 'Looks Good!', // show success message
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
                          'Negative Number Validator',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Negative Number Validator
                        CustomTextFormField(
                          labelText: 'Negative Number',
                          hintText: 'Negative Number only',
                          suffixIcon: Icons.pin_outlined,
                          validator: FormBuilderValidators.negativeNumber(
                            checkNullOrEmpty: false,
                          ),
                          successMessage: 'Looks Good!', // show success message
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
                          'Code',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Negative Number Validator
                        CustomTextFormField(
                          labelText: 'Code',
                          hintText: 'Alphanumeric only',
                          suffixIcon: Icons.pin_outlined,
                          validator: FormBuilderValidators.integer(
                            checkNullOrEmpty: false,
                          ),
                          successMessage: 'Looks Good!', // show success message
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
                          'Phone Number',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Phone Validator
                        CustomTextFormField(
                          labelText: 'Phone Number',
                          hintText: 'e.g. +123456789012345 or 123456789012345',
                          validator: FormBuilderValidators.phoneNumber(
                            checkNullOrEmpty: false,
                          ),
                          suffixIcon: Icons.call_outlined,
                          keyboardType: TextInputType.number,
                          successMessage: 'Looks Good!', // show success message
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
                        FormLabel(text: 'Select Plan'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        //Dropdown Field
                        CustomDropdownFormField<String>(
                          hint: 'Select a Plan',
                          items: [
                            DropdownMenuItem(
                              value: "basic",
                              child: Text("Basic Plan"),
                            ),
                            DropdownMenuItem(
                              value: "pro",
                              child: Text("Pro Plan"),
                            ),
                            DropdownMenuItem(
                              value: "enterprise",
                              child: Text("Enterprise Plan"),
                            ),
                          ],
                          initialValue: null,
                          validator: FormBuilderValidators.phoneNumber(),
                          // successMessage: 'Looks Good!', // show success message
                          successMessage:
                              'Perfect Choice!', // custom succes message
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
                        FormLabel(text: 'Password'),

                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Strong Password Validator
                        CustomTextFormField(
                          labelText: 'Input Password',
                          hintText: 'Use a strong password',
                          isPassword: true,
                          controller: _passwordController,
                          validator:
                              FormBuilderValidators.password(), // Strong password validator
                          successMessage:
                              'Your password is strong!', // show success message
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
                          'Website URL',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // URL Validator
                        CustomTextFormField(
                          labelText: 'Website URL',
                          hintText: 'e.g. flutter.com',
                          suffixIcon: Icons.language_outlined,
                          validator: FormBuilderValidators.url(
                            checkNullOrEmpty: false,
                          ),
                          successMessage: 'Looks Good!', // show success message
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
                          'Credit Card',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Credit Card Validator
                        CustomTextFormField(
                          labelText: 'Credit Card',
                          hintText: 'e.g. 378282246310005',
                          suffixIcon: Icons.credit_card_outlined,
                          validator: FormBuilderValidators.creditCard(
                            checkNullOrEmpty: false,
                          ),
                          successMessage: 'Looks Good!', // show success message
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
                        FormLabel(text: 'File Upload'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Required Validator
                        FileUploadForm(
                          validator: FormBuilderValidators.required(),
                          successMessage: 'Looks Good!',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: kDefaultPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Text Area'),
              SizedBox(height: 0.5 * kDefaultPadding),

              // Text Area with Required Field Validator
              CustomTextFormField(
                hintText: "Type your message...",
                minLines: 6,
                maxLines: 6,
                validator: FormBuilderValidators.required(),
                successMessage: 'Looks Good', // show success message
              ),
            ],
          ),
          SizedBox(height: 1.5 * kDefaultPadding),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomElevatedButton(
              kText: 'Validate Form',
              bgColor: kSuccessColor,
              kTextColor: Colors.white,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Form submitted')));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Built In validation with success message example

class SuccessMessageValidationExample extends StatefulWidget {
  const SuccessMessageValidationExample({super.key});

  @override
  State<SuccessMessageValidationExample> createState() =>
      _SuccessMessageValidationExampleState();
}

class _SuccessMessageValidationExampleState
    extends State<SuccessMessageValidationExample> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        FormLabel(text: 'First Name'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Required Field Validator
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'First Name',
                          hintText: 'Your First Name',
                          suffixIcon: Icons.person_outline,
                          validator: (value) =>
                              Validators.requiredField(value, context),
                          successMessage: 'Looks Good!', // show success message
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
                        FormLabel(text: 'Email'),
                        SizedBox(height: 0.5 * kDefaultPadding),
                        // Email Validator
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Email',
                          hintText: 'e.g. johndoe@example.com',
                          suffixIcon: Icons.mail_outline,
                          validator: Validators.combineValidators([
                            (value) => Validators.requiredField(value, context),
                            (value) => Validators.email(value, context),
                          ]),

                          successMessage:
                              'Email seems valid!', // show success message
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
                        FormLabel(text: 'Username'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Minimum Length Validator
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Username',
                          hintText: 'Min 5 chars',
                          suffixIcon: Icons.person_outline,
                          validator: Validators.combineValidators([
                            (value) => Validators.requiredField(value, context),
                            (value) => Validators.minLength(value, 5, context),
                          ]),

                          successMessage:
                              'Nice username!', // show success message
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
                          'Nickname',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Maximum Length Validator
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Nickname',
                          hintText: 'Max 10 chars',
                          suffixIcon: Icons.person_outline,
                          validator: (value) =>
                              Validators.maxLength(value, 10, context),

                          successMessage:
                              'Good nickname!', // show success message
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
                        // Numeric Validator
                        Text(
                          'Age',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),
                        // Numeric Validator
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Age',
                          hintText: 'Number only',
                          suffixIcon: Icons.numbers_outlined,
                          validator: (value) =>
                              Validators.numeric(value, context),
                          keyboardType: TextInputType.number,
                          successMessage: 'Looks Good!', // show success message
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
                          'Code',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Alphanumeric Validator
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Code',
                          hintText: 'Alphanumeric only',
                          suffixIcon: Icons.pin_outlined,
                          validator: (value) =>
                              Validators.alphanumeric(value, context),
                          successMessage: 'Looks Good!', // show success message
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
                          'Custom Pattern',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Regular Expression Validator (Custom Regex)
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Custom Pattern',
                          hintText: 'Only "coupon124" allowed',
                          suffixIcon: Icons.abc,
                          validator: (value) => Validators.regex(
                            value,
                            RegExp(r'^coupon124$'),
                            context,
                          ),
                          successMessage:
                              'valid coupon code!', // show success message
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
                          'Phone Number',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Phone Validator
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Phone Number',
                          hintText: 'e.g. +123456789012345 or 123456789012345',
                          validator: (value) =>
                              Validators.phone(value, context),
                          suffixIcon: Icons.call_outlined,
                          keyboardType: TextInputType.number,
                          successMessage:
                              'Valid phone number!', // show success message
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
                        FormLabel(text: 'Select Plan'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        //Dropdown Field
                        CustomDropdownFormField<String>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          hint: 'Select a Plan',
                          items: [
                            DropdownMenuItem(
                              value: "basic",
                              child: Text("Basic Plan"),
                            ),
                            DropdownMenuItem(
                              value: "pro",
                              child: Text("Pro Plan"),
                            ),
                            DropdownMenuItem(
                              value: "enterprise",
                              child: Text("Enterprise Plan"),
                            ),
                          ],
                          initialValue: null,
                          validator: (value) => Validators.requiredField(
                            value,
                            context,
                            customMessage: 'Plan must be selected',
                          ),
                          // successMessage: 'Looks Good!', // show success message
                          successMessage:
                              'Perfect Choice!', // custom succes message
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
                        FormLabel(text: 'Password'),

                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Strong Password Validator
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Input Password',
                          hintText: 'Use a strong password',
                          isPassword: true,
                          controller: _passwordController,

                          // combining required field and strong password
                          validator: Validators.combineValidators([
                            (value) => Validators.requiredField(value, context),
                            (value) =>
                                Validators.strongPassword(value, context),
                          ]),
                          successMessage:
                              'Your password is strong!', // show success message
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
                        FormLabel(text: 'Confirm Password'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Match Validator
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Input Password',
                          hintText: 'Use the same password',
                          isPassword: true,

                          // combining required field and match value validators
                          validator: Validators.combineValidators([
                            (value) => Validators.requiredField(value, context),
                            (value) => Validators.match(
                              value,
                              _passwordController.text,
                              context,
                            ),
                          ]),
                          successMessage:
                              'Password match!', // show success message
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
                          'Website URL',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // URL Validator
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Website URL',
                          hintText: 'e.g. flutter.com',
                          suffixIcon: Icons.language_outlined,
                          validator: (value) => Validators.url(value, context),
                          successMessage: 'Looks Good!', // show success message
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
                        FormLabel(text: 'File Upload'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // File Required Validator
                        FileUploadForm(
                          validator: (files) =>
                              Validators.fileRequired(files, context),
                          successMessage: "The file is correct!",
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
                        FormLabel(text: 'File Upload (pdf, jpg, png)'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // File Required Validator
                        FileUploadForm(
                          // combining required and file extension validators
                          validator: Validators.combineFileValidators([
                            (files) => Validators.fileRequired(files, context),
                            (files) => Validators.fileExtension(files, [
                              'pdf',
                              'jpg',
                              'png',
                            ], context), // pdf, jpg, png extension only
                          ]),

                          successMessage: "The file is correct!",
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
                          'File Upload (1 MB max)',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // File Size Validator
                        FileUploadForm(
                          validator: (files) => Validators.fileSize(
                            files,
                            1,
                            FileSizeUnit.mb,
                            context,
                          ), // 1 mb max

                          successMessage: "The file size is correct!",
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: kDefaultPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Text Area'),
              SizedBox(height: 0.5 * kDefaultPadding),

              // Text Area with Required Field Validator
              CustomTextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hintText: "Type your message...",
                minLines: 6,
                maxLines: 6,
                validator: (value) => Validators.requiredField(value, context),
                successMessage: 'Looks Good!',
              ),
            ],
          ),
          SizedBox(height: 1.5 * kDefaultPadding),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomElevatedButton(
              kText: 'Validate Form',
              bgColor: kSuccessColor,
              kTextColor: Colors.white,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Form submitted')));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Built In validation example

class BuiltInValidationExample extends StatefulWidget {
  const BuiltInValidationExample({super.key});

  @override
  State<BuiltInValidationExample> createState() =>
      _BuiltInValidationExampleState();
}

class _BuiltInValidationExampleState extends State<BuiltInValidationExample> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        FormLabel(text: 'First Name'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Required Field Validator
                        CustomTextFormField(
                          labelText: 'First Name',
                          hintText: 'Your First Name',
                          suffixIcon: Icons.person_outline,
                          validator: (value) =>
                              Validators.requiredField(value, context),
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
                        FormLabel(text: 'Email'),
                        SizedBox(height: 0.5 * kDefaultPadding),
                        // Email Validator
                        CustomTextFormField(
                          labelText: 'Email',
                          hintText: 'e.g. johndoe@example.com',
                          suffixIcon: Icons.mail_outline,
                          // combining required field and email validator
                          validator: Validators.combineValidators([
                            (value) => Validators.requiredField(value, context),
                            (value) => Validators.email(value, context),
                          ]),
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
                        FormLabel(text: 'Username'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Minimum Length Validator
                        CustomTextFormField(
                          labelText: 'Username',
                          hintText: 'Min 5 chars',
                          suffixIcon: Icons.person_outline,

                          // combining required field and min length validator
                          validator: Validators.combineValidators([
                            (value) => Validators.requiredField(value, context),
                            (value) => Validators.minLength(value, 5, context),
                          ]),
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
                          'Nickname',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Maximum Length Validator
                        CustomTextFormField(
                          labelText: 'Nickname',
                          hintText: 'Max 10 chars',
                          suffixIcon: Icons.person_outline,
                          validator: (value) =>
                              Validators.maxLength(value, 10, context),
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
                        // Numeric Validator
                        Text(
                          'Age',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),
                        // Numeric Validator
                        CustomTextFormField(
                          labelText: 'Age',
                          hintText: 'Number only',
                          suffixIcon: Icons.numbers_outlined,
                          validator: (value) =>
                              Validators.numeric(value, context),
                          keyboardType: TextInputType.number,
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
                          'Code',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Alphanumeric Validator
                        CustomTextFormField(
                          labelText: 'Code',
                          hintText: 'Alphanumeric only',
                          suffixIcon: Icons.pin_outlined,
                          validator: (value) =>
                              Validators.alphanumeric(value, context),
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
                          'Custom Pattern',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Regular Expression Validator (Custom Regex)
                        CustomTextFormField(
                          labelText: 'Custom Pattern',
                          hintText: 'Only "coupon124" allowed',
                          suffixIcon: Icons.abc,
                          validator: (value) => Validators.regex(
                            value,
                            RegExp(r'^coupon124$'),
                            context,
                          ),
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
                          'Phone Number',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Phone Validator
                        CustomTextFormField(
                          labelText: 'Phone Number',
                          hintText: 'e.g. +123456789012345 or 123456789012345',
                          validator: (value) =>
                              Validators.phone(value, context),
                          suffixIcon: Icons.call_outlined,
                          keyboardType: TextInputType.number,
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
                        FormLabel(text: 'Select Plan'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        //Dropdown Field
                        CustomDropdownFormField<String>(
                          hint: 'Select a Plan',
                          items: [
                            DropdownMenuItem(
                              value: "basic",
                              child: Text("Basic Plan"),
                            ),
                            DropdownMenuItem(
                              value: "pro",
                              child: Text("Pro Plan"),
                            ),
                            DropdownMenuItem(
                              value: "enterprise",
                              child: Text("Enterprise Plan"),
                            ),
                          ],
                          initialValue: null,
                          validator: (value) => Validators.requiredField(
                            value,
                            context,
                            customMessage: 'Plan must be selected',
                          ),
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
                        FormLabel(text: 'Password'),

                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Strong Password Validator
                        CustomTextFormField(
                          labelText: 'Input Password',
                          hintText: 'Use a strong password',
                          isPassword: true,
                          controller: _passwordController,

                          // combining required field and strong password
                          validator: Validators.combineValidators([
                            (value) => Validators.requiredField(value, context),
                            (value) =>
                                Validators.strongPassword(value, context),
                          ]),
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
                        FormLabel(text: 'Confirm Password'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // Match Validator
                        CustomTextFormField(
                          labelText: 'Input Password',
                          hintText: 'Use the same password',
                          isPassword: true,

                          // combining required field and match value validators
                          validator: Validators.combineValidators([
                            (value) => Validators.requiredField(value, context),
                            (value) => Validators.match(
                              value,
                              _passwordController.text,
                              context,
                            ),
                          ]),
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
                          'Website URL',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // URL Validator
                        CustomTextFormField(
                          labelText: 'Website URL',
                          hintText: 'e.g. flutter.com',
                          suffixIcon: Icons.language_outlined,
                          validator: (value) => Validators.url(value, context),
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
                        FormLabel(text: 'File Upload'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // File Required Validator
                        FileUploadForm(
                          validator: (files) =>
                              Validators.fileRequired(files, context),
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
                        FormLabel(text: 'File Upload (pdf, jpg)'),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // File Required Validator
                        FileUploadForm(
                          // combining required and file extension validators
                          validator: Validators.combineFileValidators([
                            (files) => Validators.fileRequired(files, context),
                            (files) => Validators.fileExtension(files, [
                              'pdf',
                              'jpg',
                            ], context), // pdf, jpg extension only
                          ]),
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
                          'File Upload (1 MB max)',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5 * kDefaultPadding),

                        // File Size Validator
                        FileUploadForm(
                          validator: (files) => Validators.fileSize(
                            files,
                            1,
                            FileSizeUnit.mb,
                            context,
                          ), // 1 mb max
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: kDefaultPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormLabel(text: 'Text Area'),
              SizedBox(height: 0.5 * kDefaultPadding),

              // Text Area with Required Field Validator
              CustomTextFormField(
                hintText: "Type your message...",
                minLines: 6,
                maxLines: 12,
                validator: (value) => Validators.requiredField(value, context),
              ),
            ],
          ),
          SizedBox(height: kDefaultPadding),

          // Checkbox with Required Field Validator
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
          SizedBox(height: 1.5 * kDefaultPadding),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomElevatedButton(
              kText: 'Submit Form',
              bgColor: kPrimaryColor,
              kTextColor: Colors.white,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Form submitted')));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
