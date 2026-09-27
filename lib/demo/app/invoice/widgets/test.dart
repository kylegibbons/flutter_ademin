import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/invoice/invoice_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/toast.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:flutkit_ademin/widgets/form/form_wizard.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CreateInvoiceForm extends StatefulWidget {
  const CreateInvoiceForm({super.key, this.onCreate});

  final ValueChanged<InvoiceData>? onCreate;

  @override
  State<CreateInvoiceForm> createState() => _CreateInvoiceFormState();
}

class _CreateInvoiceFormState extends State<CreateInvoiceForm> {
  final _companyFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final _itemsFormKey = GlobalKey<FormState>();
  final _paymentFormKey = GlobalKey<FormState>();
  final _invoiceNoController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _companyRegistrationController = TextEditingController();
  final _companyEmailController = TextEditingController();
  final _companyWebsiteController = TextEditingController();
  final _companyPhoneController = TextEditingController();
  final _companyAddressController = TextEditingController();
  final _companyZipController = TextEditingController();
  final _billingNameController = TextEditingController();
  final _billingStreetController = TextEditingController();
  final _billingPhoneController = TextEditingController();
  final _billingTaxController = TextEditingController();
  final _shippingNameController = TextEditingController();
  final _shippingStreetController = TextEditingController();
  final _shippingPhoneController = TextEditingController();
  final _estimatedTaxController = TextEditingController();
  final _discountController = TextEditingController();
  final _shippingChargeController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _notesController = TextEditingController();
  final _invoiceDateController = TextEditingController();
  final List<_ProductLineController> _productLines = [_ProductLineController()];

  DateTime _invoiceDate = DateTime.now();
  String? _paymentStatus = 'Paid';

  @override
  void initState() {
    super.initState();
    _invoiceDateController.text = DateFormat(
      'dd MMM, yyyy',
    ).format(_invoiceDate);
  }

  @override
  void dispose() {
    _invoiceNoController.dispose();
    _companyNameController.dispose();
    _companyRegistrationController.dispose();
    _companyEmailController.dispose();
    _companyWebsiteController.dispose();
    _companyPhoneController.dispose();
    _companyAddressController.dispose();
    _companyZipController.dispose();
    _billingNameController.dispose();
    _billingStreetController.dispose();
    _billingPhoneController.dispose();
    _billingTaxController.dispose();
    _shippingNameController.dispose();
    _shippingStreetController.dispose();
    _shippingPhoneController.dispose();
    _estimatedTaxController.dispose();
    _discountController.dispose();
    _shippingChargeController.dispose();
    _paymentMethodController.dispose();
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _notesController.dispose();
    _invoiceDateController.dispose();
    for (final line in _productLines) {
      line.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 920),
      padding: EdgeInsets.all(2 * kDefaultPadding),
      child: CustomVerticalStepper2Column(
        headerColor: themeData.colorScheme.primary,
        headerStyle: HeaderStyle.detailed,
        nextButtonColor: kErrorColor,
        prevButtonColor: kTableHeaderColor,
        onFinish: _handleSubmit,
        actionBuilder: _buildWizardActions,
        steps: [
          StepData(
            title: 'Company',
            formKey: _companyFormKey,
            content: Form(
              key: _companyFormKey,
              child: Column(
                key: const ValueKey('invoice-company-step'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Company Info'),
                  _buildResponsiveFields(
                    context,
                    children: [
                      _buildTextField(
                        label: 'Company Name',
                        controller: _companyNameController,
                        hintText: 'Bisdig Home Corp.',
                        icon: Icons.business_outlined,
                      ),
                      _buildTextField(
                        label: 'Legal Registration No',
                        controller: _companyRegistrationController,
                        hintText: 'ABC-123-XYZ',
                        icon: Icons.badge_outlined,
                      ),
                      _buildTextField(
                        label: 'Email',
                        controller: _companyEmailController,
                        hintText: 'info@bisdig.com',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                      _buildTextField(
                        label: 'Website',
                        controller: _companyWebsiteController,
                        hintText: 'www.bisdig.com',
                        icon: Icons.language_outlined,
                      ),
                      _buildTextField(
                        label: 'Contact No',
                        controller: _companyPhoneController,
                        hintText: '+(55) 11 9876-5432',
                        icon: Icons.call_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                        label: 'Zip Code',
                        controller: _companyZipController,
                        hintText: '01001-000',
                        icon: Icons.pin_drop_outlined,
                      ),
                      _buildTextField(
                        label: 'Company Address',
                        controller: _companyAddressController,
                        hintText: 'Metro City, Indonesia',
                        icon: Icons.location_city_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          StepData(
            title: 'Invoice & Address',
            formKey: _addressFormKey,
            content: Form(
              key: _addressFormKey,
              child: Column(
                key: const ValueKey('invoice-address-step'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Invoice Summary'),
                  _buildResponsiveFields(
                    context,
                    children: [
                      _buildTextField(
                        label: 'Invoice No',
                        controller: _invoiceNoController,
                        hintText: 'INV-041',
                        icon: Icons.receipt_long_outlined,
                      ),
                      _buildDateField(context),
                      _buildStatusField(),
                      _buildTextField(
                        label: 'Payment Method',
                        controller: _paymentMethodController,
                        hintText: 'Visa',
                        icon: Icons.payments_outlined,
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),
                  _buildSectionTitle(context, 'Billing Address'),
                  _buildResponsiveFields(
                    context,
                    children: [
                      _buildTextField(
                        label: 'Customer Name',
                        controller: _billingNameController,
                        hintText: 'Eleanor Vance',
                        icon: Icons.person_outline,
                      ),
                      _buildTextField(
                        label: 'Phone',
                        controller: _billingPhoneController,
                        hintText: '+(987) 654-3210',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                        label: 'Tax',
                        controller: _billingTaxController,
                        hintText: '98-7654321',
                        icon: Icons.confirmation_number_outlined,
                        isRequired: false,
                      ),
                    ],
                  ),
                  _buildTextField(
                    label: 'Billing Street',
                    controller: _billingStreetController,
                    hintText: '123 Maple Street',
                    icon: Icons.home_outlined,
                  ),
                  const SizedBox(height: kDefaultPadding),
                  _buildSectionTitle(context, 'Shipping Address'),
                  _buildResponsiveFields(
                    context,
                    children: [
                      _buildTextField(
                        label: 'Recipient Name',
                        controller: _shippingNameController,
                        hintText: 'Eleanor Vance',
                        icon: Icons.person_pin_circle_outlined,
                      ),
                      _buildTextField(
                        label: 'Phone',
                        controller: _shippingPhoneController,
                        hintText: '+(987) 654-3210',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                  _buildTextField(
                    label: 'Shipping Street',
                    controller: _shippingStreetController,
                    hintText: 'Unit 5, 45 Elm Avenue',
                    icon: Icons.local_shipping_outlined,
                  ),
                ],
              ),
            ),
          ),
          StepData(
            title: 'Items & Totals',
            formKey: _itemsFormKey,
            content: Form(
              key: _itemsFormKey,
              child: Column(
                key: const ValueKey('invoice-items-step'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductHeader(context),
                  ..._productLines.asMap().entries.map(
                    (entry) => _ProductLineFields(
                      index: entry.key,
                      controller: entry.value,
                      canRemove: _productLines.length > 1,
                      onRemove: () {
                        setState(() {
                          _productLines.removeAt(entry.key).dispose();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  _buildSectionTitle(context, 'Invoice Totals'),
                  _buildResponsiveFields(
                    context,
                    children: [
                      _buildAmountField(
                        label: 'Estimated Tax (%)',
                        controller: _estimatedTaxController,
                        hintText: '8',
                      ),
                      _buildAmountField(
                        label: 'Discount Amount',
                        controller: _discountController,
                        hintText: '75',
                      ),
                      _buildAmountField(
                        label: 'Shipping Charge',
                        controller: _shippingChargeController,
                        hintText: '25',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          StepData(
            title: 'Payment',
            formKey: _paymentFormKey,
            content: Form(
              key: _paymentFormKey,
              child: Column(
                key: const ValueKey('invoice-payment-step'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Payment Details'),
                  _buildResponsiveFields(
                    context,
                    children: [
                      _buildTextField(
                        label: 'Card Holder',
                        controller: _cardHolderController,
                        hintText: 'Eleanor Vance',
                        icon: Icons.account_circle_outlined,
                      ),
                      _buildTextField(
                        label: 'Card Number',
                        controller: _cardNumberController,
                        hintText: 'xxxx xxxx xxxx 5678',
                        icon: Icons.credit_card_outlined,
                      ),
                    ],
                  ),
                  _buildTextField(
                    label: 'Notes',
                    controller: _notesController,
                    hintText:
                        'Payment terms, delivery notes, or internal remarks',
                    icon: Icons.notes_outlined,
                    maxLines: 3,
                    isRequired: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWizardActions(
    BuildContext context,
    int currentStep,
    VoidCallback nextStep,
    VoidCallback prevStep,
  ) {
    final isLast = currentStep == 3;
    final themeData = Theme.of(context);

    return Row(
      children: [
        CustomOutlinedButton(
          kText: 'Cancel',
          outlineColor: themeData.colorScheme.primary,
          onPressed: () {
            GoRouter.of(context).go(RouteUri.invoiceList);
          },
        ),
        const Spacer(),
        if (currentStep > 0) ...[
          CustomOutlinedButton(
            kText: 'Back',
            outlineColor: themeData.colorScheme.outline,
            kLeadingIcon: Icons.arrow_back,
            onPressed: prevStep,
          ),
          const SizedBox(width: kDefaultPadding),
        ],
        FlatButton(
          kText: isLast ? 'Create Invoice' : 'Next',
          bgColor: kErrorColor,
          kTextColor: Colors.white,
          kLeadingIcon: isLast ? Icons.add : null,
          kTrailingIcon: isLast ? null : Icons.arrow_forward,
          onPressed: nextStep,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildResponsiveFields(
    BuildContext context, {
    required List<Widget> children,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= kScreenWidthMd ? 2 : 1;
        final width =
            (constraints.maxWidth - ((columns - 1) * kDefaultPadding)) /
            columns;

        return Wrap(
          spacing: kDefaultPadding,
          runSpacing: kDefaultPadding,
          children: children
              .map((child) => SizedBox(width: width, child: child))
              .toList(),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    IconData? icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(text: label, showRequired: isRequired),
        const SizedBox(height: kDefaultPadding / 2),
        CustomTextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          hintText: hintText,
          suffixIcon: icon,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: isRequired
              ? validator ?? FormBuilderValidators.required()
              : validator,
          successMessage: 'Looks Good!',
        ),
      ],
    );
  }

  Widget _buildAmountField({
    required String label,
    required TextEditingController controller,
    required String hintText,
  }) {
    return _buildTextField(
      label: label,
      controller: controller,
      hintText: hintText,
      icon: Icons.attach_money,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.numeric(),
      ]),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel(text: 'Date'),
        const SizedBox(height: kDefaultPadding / 2),
        CustomTextFormField(
          controller: _invoiceDateController,
          hintText: 'Select date',
          suffixIcon: Icons.calendar_today_outlined,
          readOnly: true,
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: _invoiceDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2035),
            );

            if (selectedDate != null) {
              setState(() {
                _invoiceDate = selectedDate;
                _invoiceDateController.text = DateFormat(
                  'dd MMM, yyyy',
                ).format(selectedDate);
              });
            }
          },
          validator: FormBuilderValidators.required(),
          successMessage: 'Looks Good!',
        ),
      ],
    );
  }

  Widget _buildStatusField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel(text: 'Payment Status'),
        const SizedBox(height: kDefaultPadding / 2),
        CustomDropdownFormField<String>(
          initialValue: _paymentStatus,
          hint: 'Select payment status',
          prefixIcon: Icons.verified_outlined,
          items: const [
            DropdownMenuItem(value: 'Paid', child: Text('Paid')),
            DropdownMenuItem(value: 'Unpaid', child: Text('Unpaid')),
            DropdownMenuItem(value: 'Refund', child: Text('Refund')),
            DropdownMenuItem(value: 'Cancel', child: Text('Cancel')),
          ],
          onChanged: (value) {
            setState(() {
              _paymentStatus = value;
            });
          },
          validator: FormBuilderValidators.required(),
          successMessage: 'Looks Good!',
        ),
      ],
    );
  }

  Widget _buildProductHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildSectionTitle(context, 'Product Items')),
        CustomOutlinedButton(
          kText: 'Add Item',
          outlineColor: Theme.of(context).colorScheme.primary,
          kLeadingIcon: Icons.add,
          onPressed: () {
            setState(() {
              _productLines.add(_ProductLineController());
            });
          },
        ),
      ],
    );
  }

  void _handleSubmit() {
    if (_paymentFormKey.currentState?.validate() != true) return;

    widget.onCreate?.call(
      InvoiceData(
        id: _invoiceNoController.text.trim(),
        customerName: _billingNameController.text.trim(),
        avatarUrl: 'assets/images/avatar_1.jpg',
        email: _companyEmailController.text.trim(),
        country: _companyAddressController.text.trim(),
        date: _invoiceDate,
        amount: _calculateTotalAmount(),
        status: _mapPaymentStatus(_paymentStatus),
      ),
    );

    Toast.showToast(
      context: context,
      icon: Icons.check_circle_outline,
      message: 'Invoice Created!',
      color: kSuccessColor,
      alignment: Alignment.topRight,
      showProgress: true,
      showCloseButton: true,
      bottomBorder: true,
    );

    GoRouter.of(context).go(RouteUri.invoiceList);
  }

  double _calculateTotalAmount() {
    final subtotal = _productLines.fold<double>(
      0,
      (sum, item) =>
          sum +
          ((double.tryParse(item.rateController.text) ?? 0) *
              (int.tryParse(item.quantityController.text) ?? 0)),
    );
    final tax =
        subtotal * ((double.tryParse(_estimatedTaxController.text) ?? 0) / 100);
    final discount = double.tryParse(_discountController.text) ?? 0;
    final shipping = double.tryParse(_shippingChargeController.text) ?? 0;

    return subtotal + tax - discount + shipping;
  }

  PaymentStatus _mapPaymentStatus(String? status) {
    switch (status) {
      case 'Paid':
        return PaymentStatus.paid;
      case 'Refund':
        return PaymentStatus.refund;
      case 'Cancel':
        return PaymentStatus.cancel;
      case 'Unpaid':
      default:
        return PaymentStatus.unpaid;
    }
  }
}

class _ProductLineFields extends StatelessWidget {
  const _ProductLineFields({
    required this.index,
    required this.controller,
    required this.canRemove,
    required this.onRemove,
  });

  final int index;
  final _ProductLineController controller;
  final bool canRemove;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Item ${index + 1}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (canRemove)
                CustomIconButton(
                  icon: Icons.delete_outline,
                  iconColor: kErrorColor,
                  onTap: onRemove,
                  isOutlined: true,
                ),
            ],
          ),
          const SizedBox(height: kDefaultPadding),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= kScreenWidthMd ? 2 : 1;
              final width =
                  (constraints.maxWidth - ((columns - 1) * kDefaultPadding)) /
                  columns;

              return Wrap(
                spacing: kDefaultPadding,
                runSpacing: kDefaultPadding,
                children: [
                  SizedBox(
                    width: width,
                    child: _ProductTextField(
                      label: 'Product',
                      controller: controller.titleController,
                      hintText: 'Premium Wireless Headphones',
                      icon: Icons.inventory_2_outlined,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _ProductTextField(
                      label: 'Description',
                      controller: controller.descriptionController,
                      hintText: 'Noise-cancelling, over-ear headphones',
                      icon: Icons.description_outlined,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _ProductTextField(
                      label: 'Rate',
                      controller: controller.rateController,
                      hintText: '299.99',
                      icon: Icons.attach_money,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _ProductTextField(
                      label: 'Qty',
                      controller: controller.quantityController,
                      hintText: '1',
                      icon: Icons.numbers_outlined,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.integer(),
                      ]),
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
}

class _ProductTextField extends StatelessWidget {
  const _ProductTextField({
    required this.label,
    required this.controller,
    required this.hintText,
    this.icon,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(text: label),
        const SizedBox(height: kDefaultPadding / 2),
        CustomTextFormField(
          controller: controller,
          hintText: hintText,
          suffixIcon: icon,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator ?? FormBuilderValidators.required(),
          successMessage: 'Looks Good!',
        ),
      ],
    );
  }
}

class _ProductLineController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final rateController = TextEditingController();
  final quantityController = TextEditingController(text: '1');

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    rateController.dispose();
    quantityController.dispose();
  }
}
