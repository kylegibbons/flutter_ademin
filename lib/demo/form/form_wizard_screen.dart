import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutter_ademin/widgets/form/form_dropdown.dart';
import 'package:flutter_ademin/widgets/form/form_input_mask.dart';
import 'package:flutter_ademin/widgets/form/form_validator.dart';
import 'package:flutter_ademin/widgets/form/form_wizard.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';
import 'package:flutter_ademin/widgets/base_ui/toast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormWizardScreen extends StatefulWidget {
  const FormWizardScreen({super.key});

  @override
  State<FormWizardScreen> createState() => _FormWizardScreenState();
}

class _FormWizardScreenState extends State<FormWizardScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final pageTitle = Lang.of(context).wizard; //update your page tittle here
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
                      lang.wizard.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
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
                          label: lang.wizard,
                          uri: RouteUri.formWizard,
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
                ShowCodeCard(
                  cardTitle: 'Custom Horizontal Wizard Form',
                  uiView: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: HorizontalStepperFormExample(),
                  ),
                  codeView: '''
CustomHorizontalStepper(
  headerColor: kPrimaryColor,
  headerTextColor: themeData.colorScheme.primary,
  headerBgColor: kSecondaryColor,
  headerStyle: HeaderStyle.detailed,
  onFinish: () {},
  steps: [
    StepData(
      title: 'Seller Details',
      content: sellerDetails(),
    ),
    StepData(
      title: 'Company Document',
      content: companyDocument(),
    ),
    StepData(
      title: 'Bank Details',
      content: bankDetailsForm(),
    ),
    StepData(
      title: 'Confirmation',
      content: confirmationForm(),
      ),
    ),
  ],
),

// Due to the complex form usage, please see the example of using this stepper in HorizontalStepperFormExample() in /lib/demo/form/form_wizard_screen.dart''',
                  height: 460,
                ),
                SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Custom Vertical Wizard Form',
                  uiView: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: VerticalStepperFormExample(),
                  ),
                  codeView: '''
CustomVerticalStepper(
  headerColor: kInfoColor,
  headerTextColor: kInfoColor,
  headerBgColor: kInfoColor,
  headerStyle: HeaderStyle.detailed,
  nextButtonColor: kSecondaryColor,
  onFinish: () {},
  steps: [
    StepData(
      title: 'Seller Details',
      content: sellerDetails(),
    ),
    StepData(
      title: 'Company Document',
      content: companyDocument(),
    ),
    StepData(
      title: 'Bank Details',
      content: bankDetailsForm(),
    ),
    StepData(
      title: 'Confirmation',
      content: confirmationForm(),
      ),
    ),
  ],
),

// Due to the complex form usage, please see the example of using this stepper in VerticalStepperFormExample() in /lib/demo/form/form_wizard_screen.dart''',
                  height: 460,
                ),
                SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Custom Vertical 2 Columns Wizard Form',
                  uiView: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: VerticalStepper2ColumnFormExample(),
                  ),
                  codeView: '''
CustomVerticalStepper2Column(
  headerColor: kPrimaryColor,
  headerTextColor: themeData.colorScheme.primary,
  headerBgColor: kSecondaryColor,
  headerStyle: HeaderStyle.detailed,
  onFinish: () {},
  steps: [
    StepData(
      title: 'Seller Details',
      content: sellerDetails(),
    ),
    StepData(
      title: 'Company Document',
      content: companyDocument(),
    ),
    StepData(
      title: 'Bank Details',
      content: bankDetailsForm(),
    ),
    StepData(
      title: 'Confirmation',
      content: confirmationForm(),
      ),
    ),
  ],
),

// Due to the complex form usage, please see the example of using this stepper in VerticalStepper2ColumnFormExample() in /lib/demo/form/form_wizard_screen.dart''',
                  height: 460,
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

// horizontal stepper form example

class HorizontalStepperFormExample extends StatefulWidget {
  const HorizontalStepperFormExample({super.key});

  @override
  State<HorizontalStepperFormExample> createState() =>
      _HorizontalStepperFormExampleState();
}

class _HorizontalStepperFormExampleState
    extends State<HorizontalStepperFormExample> {
  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final panCardController = TextEditingController();
  final vatNoController = TextEditingController();
  final cstNoController = TextEditingController();
  final serviceTaxController = TextEditingController();
  final companyUINController = TextEditingController();
  final declarationController = TextEditingController();

  final nameOnCardController = TextEditingController();
  final creditCardTypeController = TextEditingController();
  final creditCardNumberController = TextEditingController();
  final cardVerifNumberController = TextEditingController();
  final expireDateController = TextEditingController();

  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form keys
  final formKeyHorizontal1 = GlobalKey<FormState>();
  final formKeyHorizontal2 = GlobalKey<FormState>();
  final formKeyHorizontal3 = GlobalKey<FormState>();
  final formKeyHorizontal4 = GlobalKey<FormState>();

  bool agreed = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return CustomHorizontalStepper(
      headerColor: kPrimaryColor,
      headerTextColor: themeData.colorScheme.primary,
      headerBgColor: kSecondaryColor,
      headerStyle: HeaderStyle.detailed,
      onFinish: () {
        // Simulate data submission
        debugPrint('Data Submitted:');
        debugPrint('Name: ${firstNameController.text}');
        debugPrint('Email: ${lastNameController.text}');
        debugPrint('City: ${phoneNumberController.text}');
        debugPrint('Name: ${firstNameController.text}');
        debugPrint('Email: ${emailController.text}');
        debugPrint('City: ${addressController.text}');
        debugPrint('Name: ${panCardController.text}');
        debugPrint('Email: ${vatNoController.text}');
        debugPrint('City: ${cstNoController.text}');
        debugPrint('Name: ${serviceTaxController.text}');
        debugPrint('Email: ${companyUINController.text}');
        debugPrint('City: ${cityController.text}');
        debugPrint('Name: ${declarationController.text}');
        debugPrint('Email: ${nameOnCardController.text}');
        debugPrint('City: ${creditCardTypeController.text}');
        debugPrint('Email: ${creditCardNumberController.text}');
        debugPrint('City: ${cardVerifNumberController.text}');
        debugPrint('Email: ${expireDateController.text}');

        // regristration complete success message
        Toast.showToast(
          duration: Duration(seconds: 4),
          context: context,
          icon: Icons.check_circle_outline,
          message: 'Registration Complete!',
          color: kSuccessColor,
          alignment: Alignment.topRight,
          showProgress: true,
          showCloseButton: true, // show close button
        );
      },
      steps: [
        StepData(
          title: 'Seller Details',
          formKey: formKeyHorizontal1,
          content: sellerDetails(
            context,
            formKeyHorizontal1,
            firstNameController,
            lastNameController,
            phoneNumberController,
            emailController,
            addressController,
          ),
        ),
        StepData(
          title: 'Company Document',
          formKey: formKeyHorizontal2,
          content: companyDocument(
            context,
            formKeyHorizontal2,
            panCardController,
            vatNoController,
            cstNoController,
            serviceTaxController,
            companyUINController,
            declarationController,
          ),
        ),
        StepData(
          title: 'Bank Details',
          formKey: formKeyHorizontal3,
          content: bankDetailsForm(
            context,
            formKeyHorizontal3,
            nameOnCardController,
            creditCardTypeController,
            creditCardNumberController,
            cardVerifNumberController,
            expireDateController,
          ),
        ),
        StepData(
          title: 'Confirmation',
          formKey: formKeyHorizontal4,
          content: Center(
            child: confirmationForm(context, formKeyHorizontal4, agreed, (val) {
              setState(() => agreed = val ?? false);
            }),
          ),
        ),
      ],
    );
  }
}

/// Step 1 - Seller Details
Widget sellerDetails(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController firstNameController,
  TextEditingController lastNameController,
  TextEditingController phoneNumberController,
  TextEditingController emailController,
  TextEditingController addressController,
) {
  final themeData = Theme.of(context);
  return Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seller Details',
          style: TextStyle(
            color: themeData.colorScheme.onSurface,
            fontSize: kBodyLarge,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: kDefaultPadding / 4),
        Text('Fill all information below'),
        SizedBox(height: kDefaultPadding),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormLabel(text: 'First Name', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: firstNameController,
                        labelText: 'First Name',
                        hintText: 'Your First Name',
                        suffixIcon: Icons.person_outline,
                        validator: (value) =>
                            Validators.requiredField(value, context),
                        successMessage: 'Looks Good!',
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
                      FormLabel(text: 'Last Name', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: lastNameController,
                        labelText: 'Last Name',
                        hintText: 'Your Last Name',
                        suffixIcon: Icons.person_outline,
                        validator: (value) =>
                            Validators.requiredField(value, context),
                        successMessage: 'Looks Good!',
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
                      FormLabel(text: 'Phone Number', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
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
                      FormLabel(text: 'Email', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
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
                        successMessage: 'Email seems valid!',
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
            FormLabel(text: 'Address', showRequired: false),
            const SizedBox(height: 0.5 * kDefaultPadding),

            // Address with Required Field Validator
            CustomTextFormField(
              controller: addressController,
              hintText: "Enter your address",
              minLines: 3,
              maxLines: 6,
              validator: (value) => Validators.requiredField(value, context),
              successMessage: 'Looks Good!',
            ),
          ],
        ),
      ],
    ),
  );
}

/// Step 2 - Company Documents
Widget companyDocument(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController panCardController,
  TextEditingController vatNoController,
  TextEditingController cstNoController,
  TextEditingController serviceTaxController,
  TextEditingController companyUINController,
  TextEditingController declarationController,
) {
  final themeData = Theme.of(context);
  return Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Company Document',
          style: TextStyle(
            color: themeData.colorScheme.onSurface,
            fontSize: kBodyLarge,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: kDefaultPadding / 4),
        Text('Fill all information below'),
        SizedBox(height: kDefaultPadding),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormLabel(text: 'PAN Card', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: panCardController,
                        labelText: 'Enter your PAN No.',
                        hintText: 'ABCDE1234F',
                        suffixIcon: Icons.credit_card_outlined,
                        validator: (value) =>
                            Validators.requiredField(value, context),
                        successMessage: 'Looks Good!',
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
                      FormLabel(text: 'VAT/TIN No.', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: vatNoController,
                        labelText: 'Enter your VAT/TIN No.',
                        hintText: '29AXXXXX0000X',
                        suffixIcon: Icons.credit_card_outlined,
                        validator: (value) =>
                            Validators.requiredField(value, context),
                        successMessage: 'Looks Good!',
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
                      FormLabel(text: 'CST No.', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: cstNoController,
                        labelText: 'Enter your CST No.',
                        hintText: 'C1234567',
                        suffixIcon: Icons.credit_card_outlined,
                        validator: (value) =>
                            Validators.requiredField(value, context),
                        successMessage: 'Looks Good!',
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
                      FormLabel(text: 'Service Tax No.', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: serviceTaxController,
                        labelText: 'Enter your Service Tax No.',
                        hintText: 'AABBCCDDEES001',
                        suffixIcon: Icons.credit_card_outlined,
                        validator: (value) =>
                            Validators.requiredField(value, context),
                        successMessage: 'Looks Good!',
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
                      FormLabel(text: 'Company UIN', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: companyUINController,
                        labelText: 'Enter your Company UIN',
                        hintText: 'U12345MH2020PTC123456',
                        suffixIcon: Icons.credit_card_outlined,
                        validator: (value) =>
                            Validators.requiredField(value, context),
                        successMessage: 'Looks Good!',
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
                      FormLabel(text: 'Declaration', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: declarationController,
                        labelText: 'Declaration Details',
                        hintText: 'Your Declaration.',
                        suffixIcon: Icons.credit_card_outlined,
                        validator: (value) =>
                            Validators.requiredField(value, context),
                        successMessage: 'Looks Good!',
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
  );
}

/// Step 3 - Bank Details
Widget bankDetailsForm(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController nameOnCardController,
  TextEditingController creditCardTypeController,
  TextEditingController creditCardNumberController,
  TextEditingController cardVerifNumberController,
  TextEditingController expireDateController,
) {
  final themeData = Theme.of(context);
  return Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bank Details',
          style: TextStyle(
            color: themeData.colorScheme.onSurface,
            fontSize: kBodyLarge,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: kDefaultPadding / 4),
        Text('Fill all information below'),
        SizedBox(height: kDefaultPadding),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormLabel(text: 'Name on Card', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: nameOnCardController,
                        labelText: 'Enter your Name on Card',
                        hintText: 'Jhon Doe',
                        suffixIcon: Icons.person_outline,
                        validator: (value) =>
                            Validators.requiredField(value, context),
                        successMessage: 'Looks Good!',
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
                      FormLabel(text: 'Credit Card Type', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomDropdownFormField<String>(
                        hint: 'Select Card Type',
                        items: const [
                          DropdownMenuItem(
                            value: "americanExpress",
                            child: Text("American Express"),
                          ),
                          DropdownMenuItem(value: "visa", child: Text("Visa")),
                          DropdownMenuItem(
                            value: "masterCard",
                            child: Text("Master Card"),
                          ),
                          DropdownMenuItem(
                            value: "discover",
                            child: Text("Discover"),
                          ),
                        ],
                        initialValue: null,
                        validator: (value) => Validators.requiredField(
                          value,
                          context,
                          customMessage: 'Type must be selected',
                        ),

                        successMessage: 'Perfect!', // custom succes message
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
                      FormLabel(
                        text: 'Credit Card Number',
                        showRequired: false,
                      ),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: creditCardNumberController,
                        labelText: 'Enter your Credit Card Number',
                        hintText: '4111 1111 1111 1111',
                        suffixIcon: Icons.credit_card_outlined,
                        validator: FormBuilderValidators.creditCard(),
                        successMessage: 'Looks Good!',
                        inputFormatters: [InputMask.creditCard()],
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
                      FormLabel(
                        text: 'Card Verification Number',
                        showRequired: false,
                      ),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: cardVerifNumberController,
                        labelText: 'Enter your Card Verification Number',
                        hintText: '123',
                        suffixIcon: Icons.verified_outlined,
                        validator: FormBuilderValidators.creditCardCVC(),
                        successMessage: 'Looks Good!',
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
                      FormLabel(text: 'Expiration Date', showRequired: false),
                      const SizedBox(height: 0.5 * kDefaultPadding),
                      CustomTextFormField(
                        controller: expireDateController,
                        labelText: 'Enter your Card Expiration Date',
                        hintText: '12/28',
                        suffixIcon: Icons.date_range,
                        validator:
                            FormBuilderValidators.creditCardExpirationDate(),
                        successMessage: 'Looks Good!',
                        inputFormatters: [InputMask.date(dateFormat: '##/##')],
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
  );
}

/// Step 4 - Confirmation
Widget confirmationForm(
  BuildContext context,
  GlobalKey<FormState> formKey,
  bool agreed,
  void Function(bool?) onChanged,
) {
  final themeData = Theme.of(context);
  return Form(
    key: formKey,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 3 * kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Please review your details before submitting, and agree to our terms and conditions.',
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
          const SizedBox(height: kDefaultPadding),
          CustomCheckbox(
            label: 'I agree to the terms and conditions',
            value: agreed,
            onChanged: onChanged,
            validator: (val) => Validators.requiredField(
              val == true ? 'checked' : null,
              context,
              customMessage: "You must agree to the terms & conditions",
            ),
          ),
        ],
      ),
    ),
  );
}

// vertical stepper example

class VerticalStepperFormExample extends StatefulWidget {
  const VerticalStepperFormExample({super.key});

  @override
  State<VerticalStepperFormExample> createState() =>
      _VerticalStepperFormExampleState();
}

class _VerticalStepperFormExampleState
    extends State<VerticalStepperFormExample> {
  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final panCardController = TextEditingController();
  final vatNoController = TextEditingController();
  final cstNoController = TextEditingController();
  final serviceTaxController = TextEditingController();
  final companyUINController = TextEditingController();
  final declarationController = TextEditingController();

  final nameOnCardController = TextEditingController();
  final creditCardTypeController = TextEditingController();
  final creditCardNumberController = TextEditingController();
  final cardVerifNumberController = TextEditingController();
  final expireDateController = TextEditingController();

  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form keys
  final formKeyVertical1 = GlobalKey<FormState>();
  final formKeyVertical2 = GlobalKey<FormState>();
  final formKeyVertical3 = GlobalKey<FormState>();
  final formKeyVertical4 = GlobalKey<FormState>();

  bool agreed = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomVerticalStepper(
      headerColor: kInfoColor,
      headerTextColor: kInfoColor,
      headerBgColor: kInfoColor,
      headerStyle: HeaderStyle.detailed,
      nextButtonColor: kSecondaryColor,
      onFinish: () {
        // Simulate data submission
        debugPrint('Data Submitted:');
        debugPrint('Name: ${firstNameController.text}');
        debugPrint('Email: ${lastNameController.text}');
        debugPrint('City: ${phoneNumberController.text}');
        debugPrint('Name: ${firstNameController.text}');
        debugPrint('Email: ${emailController.text}');
        debugPrint('City: ${addressController.text}');
        debugPrint('Name: ${panCardController.text}');
        debugPrint('Email: ${vatNoController.text}');
        debugPrint('City: ${cstNoController.text}');
        debugPrint('Name: ${serviceTaxController.text}');
        debugPrint('Email: ${companyUINController.text}');
        debugPrint('City: ${cityController.text}');
        debugPrint('Name: ${declarationController.text}');
        debugPrint('Email: ${nameOnCardController.text}');
        debugPrint('City: ${creditCardTypeController.text}');
        debugPrint('Email: ${creditCardNumberController.text}');
        debugPrint('City: ${cardVerifNumberController.text}');
        debugPrint('Email: ${expireDateController.text}');

        Toast.showToast(
          duration: Duration(seconds: 4),
          context: context,
          icon: Icons.check_circle_outline,
          message: 'Registration Complete!',
          color: kSuccessColor,
          alignment: Alignment.topRight,
          showProgress: true,
          showCloseButton: true,
        );
      },
      steps: [
        StepData(
          title: 'Seller Details',
          formKey: formKeyVertical1,
          content: sellerDetails(
            context,
            formKeyVertical1,
            firstNameController,
            lastNameController,
            phoneNumberController,
            emailController,
            addressController,
          ),
        ),
        StepData(
          title: 'Company Document',
          formKey: formKeyVertical2,
          content: companyDocument(
            context,
            formKeyVertical2,
            panCardController,
            vatNoController,
            cstNoController,
            serviceTaxController,
            companyUINController,
            declarationController,
          ),
        ),
        StepData(
          title: 'Bank Details',
          formKey: formKeyVertical3,
          content: bankDetailsForm(
            context,
            formKeyVertical3,
            nameOnCardController,
            creditCardTypeController,
            creditCardNumberController,
            cardVerifNumberController,
            expireDateController,
          ),
        ),
        StepData(
          title: 'Confirmation',
          formKey: formKeyVertical4,
          content: Center(
            child: confirmationForm(context, formKeyVertical4, agreed, (val) {
              setState(() => agreed = val ?? false);
            }),
          ),
        ),
      ],
    );
  }
}

// Vertical Stepper 2 Column Form Example

class VerticalStepper2ColumnFormExample extends StatefulWidget {
  const VerticalStepper2ColumnFormExample({super.key});

  @override
  State<VerticalStepper2ColumnFormExample> createState() =>
      _VerticalStepper2ColumnFormExampleState();
}

class _VerticalStepper2ColumnFormExampleState
    extends State<VerticalStepper2ColumnFormExample> {
  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final panCardController = TextEditingController();
  final vatNoController = TextEditingController();
  final cstNoController = TextEditingController();
  final serviceTaxController = TextEditingController();
  final companyUINController = TextEditingController();
  final declarationController = TextEditingController();

  final nameOnCardController = TextEditingController();
  final creditCardTypeController = TextEditingController();
  final creditCardNumberController = TextEditingController();
  final cardVerifNumberController = TextEditingController();
  final expireDateController = TextEditingController();

  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form keys
  final formKeyVertical1 = GlobalKey<FormState>();
  final formKeyVertical2 = GlobalKey<FormState>();
  final formKeyVertical3 = GlobalKey<FormState>();
  final formKeyVertical4 = GlobalKey<FormState>();

  bool agreed = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return CustomVerticalStepper2Column(
      headerColor: kPrimaryColor,
      headerTextColor: themeData.colorScheme.primary,
      headerBgColor: kSecondaryColor,
      headerStyle: HeaderStyle.detailed,
      onFinish: () {
        // Simulate data submission
        debugPrint('Data Submitted:');
        debugPrint('Name: ${firstNameController.text}');
        debugPrint('Email: ${lastNameController.text}');
        debugPrint('City: ${phoneNumberController.text}');
        debugPrint('Name: ${firstNameController.text}');
        debugPrint('Email: ${emailController.text}');
        debugPrint('City: ${addressController.text}');
        debugPrint('Name: ${panCardController.text}');
        debugPrint('Email: ${vatNoController.text}');
        debugPrint('City: ${cstNoController.text}');
        debugPrint('Name: ${serviceTaxController.text}');
        debugPrint('Email: ${companyUINController.text}');
        debugPrint('City: ${cityController.text}');
        debugPrint('Name: ${declarationController.text}');
        debugPrint('Email: ${nameOnCardController.text}');
        debugPrint('City: ${creditCardTypeController.text}');
        debugPrint('Email: ${creditCardNumberController.text}');
        debugPrint('City: ${cardVerifNumberController.text}');
        debugPrint('Email: ${expireDateController.text}');

        Toast.showToast(
          duration: Duration(seconds: 4),
          context: context,
          icon: Icons.check_circle_outline,
          message: 'Registration Complete!',
          color: kSuccessColor,
          alignment: Alignment.topRight,
          showProgress: true,
          showCloseButton: true,
        );
      },
      steps: [
        StepData(
          title: 'Seller Details',
          formKey: formKeyVertical1,
          content: sellerDetails(
            context,
            formKeyVertical1,
            firstNameController,
            lastNameController,
            phoneNumberController,
            emailController,
            addressController,
          ),
        ),
        StepData(
          title: 'Company Document',
          formKey: formKeyVertical2,
          content: companyDocument(
            context,
            formKeyVertical2,
            panCardController,
            vatNoController,
            cstNoController,
            serviceTaxController,
            companyUINController,
            declarationController,
          ),
        ),
        StepData(
          title: 'Bank Details',
          formKey: formKeyVertical3,
          content: bankDetailsForm(
            context,
            formKeyVertical3,
            nameOnCardController,
            creditCardTypeController,
            creditCardNumberController,
            cardVerifNumberController,
            expireDateController,
          ),
        ),
        StepData(
          title: 'Confirmation',
          formKey: formKeyVertical4,
          content: Center(
            child: confirmationForm(context, formKeyVertical4, agreed, (val) {
              setState(() => agreed = val ?? false);
            }),
          ),
        ),
      ],
    );
  }
}
