import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/invoice/invoice_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/toast.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CreateInvoiceForm extends StatefulWidget {
  const CreateInvoiceForm({super.key, this.onCreate});

  final ValueChanged<InvoiceData>? onCreate;

  @override
  State<CreateInvoiceForm> createState() => _CreateInvoiceFormState();
}

class _CreateInvoiceFormState extends State<CreateInvoiceForm> {
  final _formKey = GlobalKey<FormState>();
  final _invoiceNoController = TextEditingController();
  final _invoiceDateController = TextEditingController();
  final _companyAddressController = TextEditingController();
  final _companyZipController = TextEditingController();
  final _companyRegistrationController = TextEditingController();
  final _companyEmailController = TextEditingController();
  final _companyWebsiteController = TextEditingController();
  final _companyPhoneController = TextEditingController();
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
  final List<_ProductLineController> _productLines = [_ProductLineController()];

  DateTime? _invoiceDate;
  PaymentStatus? _paymentStatus;

  final _currencyFormat = NumberFormat.simpleCurrency();

  @override
  void dispose() {
    _invoiceNoController.dispose();
    _invoiceDateController.dispose();
    _companyAddressController.dispose();
    _companyZipController.dispose();
    _companyRegistrationController.dispose();
    _companyEmailController.dispose();
    _companyWebsiteController.dispose();
    _companyPhoneController.dispose();
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
    for (final line in _productLines) {
      line.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final horizontalPadding = screenWidth < kScreenWidthMd
        ? kDefaultPadding
        : 2 * kDefaultPadding;
    final verticalPadding = screenWidth < kScreenWidthMd
        ? kDefaultPadding
        : 2 * kDefaultPadding;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: _buildCompanyHeader(context),
          ),
          const Divider(height: 0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: _buildInvoiceSummary(context),
          ),
          const Divider(height: 0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: _buildAddresses(context),
          ),
          const Divider(height: 0),
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: verticalPadding,
              start: horizontalPadding,
              end: horizontalPadding,
            ),
            child: _buildProductSection(context),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: horizontalPadding,
              end: horizontalPadding,
              bottom: verticalPadding,
            ),
            child: _buildSummarySection(context),
          ),
          const Divider(height: 0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: _buildPaymentDetails(context),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              bottom: verticalPadding,
            ),
            child: _buildNotes(context),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              bottom: verticalPadding,
            ),
            child: _buildActions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyHeader(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return ResponsiveWrap(
      columnRatios: [1 / 3, 1 / 3, 1 / 3],
      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 3},
      runSpacing: kDefaultPadding / 2,
      spacing: 0,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo_light.png',
              height: 32,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
            ),
            const SizedBox(height: kDefaultPadding),
            _invoiceField(
              controller: _companyAddressController,
              labelText: 'Company Address',
              hintText: 'Metro City, Indonesia',
              maxLines: 2,
            ),

            const SizedBox(height: kDefaultPadding / 2),
            _invoiceField(
              controller: _companyAddressController,
              labelText: 'Zip-code',
              hintText: '01001-000',
            ),
          ],
        ),

        SizedBox(),

        Column(
          crossAxisAlignment: mediaQueryData.size.width >= kScreenWidthXl
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            _invoiceField(
              controller: _companyRegistrationController,
              labelText: 'Legal Registration No',
              hintText: 'ABC-123-XYZ',
            ),
            const SizedBox(height: kDefaultPadding / 2),

            _invoiceField(
              controller: _companyRegistrationController,
              labelText: 'Email',
              hintText: 'info@flutkit.com',
            ),
            const SizedBox(height: kDefaultPadding / 2),
            _invoiceField(
              controller: _companyRegistrationController,
              labelText: 'Website',
              hintText: 'www.flutkit.com',
            ),
            const SizedBox(height: kDefaultPadding / 2),
            _invoiceField(
              controller: _companyRegistrationController,
              labelText: 'Contact No',
              hintText: '+(55) 11 9876-5432',
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInvoiceSummary(BuildContext context) {
    return ResponsiveWrap(
      columnRatios: [1 / 3, 1 / 3, 1 / 3],
      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 3},
      spacing: kDefaultPadding,
      runSpacing: kDefaultPadding,
      children: [
        // invoice no
        _summaryField(context, 'Invoice No', _invoiceNoController, 'INV-041'),

        // select date
        _dateField(context),

        // payment status
        _paymentStatusField(context),
      ],
    );
  }

  Widget _buildAddresses(BuildContext context) {
    return ResponsiveWrap(
      columnRatios: [0.5, 0.5],
      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
      children: [
        // billing address
        _addressFields(
          context,
          title: 'Billing Address',
          nameController: _billingNameController,
          streetController: _billingStreetController,
          phoneController: _billingPhoneController,
          taxController: _billingTaxController,
          nameHint: 'Dody Tanesia',
          streetHint: '123 Maple Street',
          phoneHint: '+(987) 654-3210',
          taxHint: '98-7654321',
          showTax: true,
        ),

        // Shipping Address
        _addressFields(
          context,
          title: 'Shipping Address',
          nameController: _shippingNameController,
          streetController: _shippingStreetController,
          phoneController: _shippingPhoneController,
          nameHint: 'Dody Tanesia',
          streetHint: 'Unit 5, 45 Elm Avenue',
          phoneHint: '+(987) 654-3210',
        ),
      ],
    );
  }

  Widget _buildProductSection(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PRODUCT ITEMS',
          style: TextStyle(
            color: themeData.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        _buildProductHeaderRow(context),
        ..._productLines.asMap().entries.map(
          (entry) => _buildProductLine(context, entry.key, entry.value),
        ),

        const SizedBox(height: kDefaultPadding),

        CustomOutlinedButton(
          kText: 'Add Item',
          outlineColor: kInfoColor,
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

  Widget _buildSummarySection(BuildContext context) {
    final subtotal = _subtotal;
    final taxPercent = _toDouble(_estimatedTaxController.text);
    final tax = subtotal * (taxPercent / 100);
    final discount = _toDouble(_discountController.text);
    final shipping = _toDouble(_shippingChargeController.text);
    final total = subtotal + tax - discount + shipping;

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: MediaQuery.of(context).size.width <= kScreenWidthSm
            ? double.infinity
            : 360,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _summaryRow(context, 'Sub Total', _currencyFormat.format(subtotal)),
            _summaryInputRow(context, 'Tax (%)', _estimatedTaxController, '10'),
            _summaryRow(context, 'Tax Amount', _currencyFormat.format(tax)),
            _summaryInputRow(
              context,
              'Discount (%)',
              _discountController,
              '20',
            ),
            _summaryInputRow(
              context,
              'Shipping',
              _shippingChargeController,
              '25',
            ),
            const Divider(height: 0),
            _summaryRow(
              context,
              'Total Amount',
              _currencyFormat.format(total),
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PAYMENT DETAILS',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: kDefaultPadding),

        _invoiceField(
          labelText: 'Payment Method',
          controller: _paymentMethodController,
          hintText: 'Visa',
        ),

        const SizedBox(height: kDefaultPadding / 2),

        _invoiceField(
          labelText: 'Card Holder',
          controller: _cardHolderController,
          hintText: 'Dody Tanesia',
        ),
        const SizedBox(height: kDefaultPadding / 2),

        _invoiceField(
          labelText: 'Card Number',
          controller: _cardNumberController,
          hintText: 'xxxx xxxx xxxx 5678',
        ),
      ],
    );
  }

  Widget _buildNotes(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: kInfoColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: kInfoColor, width: 0.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NOTES:',
            style: TextStyle(color: kInfoColor, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: kDefaultPadding / 2),

          TextFormField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Type notes here',
              hintStyle: TextStyle(color: kInfoColor),
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,

              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomOutlinedButton(
          kText: 'Cancel',
          outlineColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            GoRouter.of(context).go(RouteUri.invoiceList);
          },
        ),
        const SizedBox(width: kDefaultPadding),
        FlatButton(
          kText: 'Create Invoice',
          bgColor: kErrorColor,
          kTextColor: Colors.white,
          kLeadingIcon: Icons.add,
          onPressed: _handleSubmit,
        ),
      ],
    );
  }

  Widget _summaryField(
    BuildContext context,
    String title,
    TextEditingController controller,
    String hintText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _summaryTitle(title),
        const SizedBox(height: kDefaultPadding / 2),
        _invoiceField(controller: controller, hintText: hintText),
      ],
    );
  }

  Widget _dateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _summaryTitle('Date'),
        const SizedBox(height: kDefaultPadding / 2),
        CustomTextFormField(
          controller: _invoiceDateController,
          hintText: '03 Jul, 2025',
          suffixIcon: Icons.calendar_today_outlined,
          readOnly: true,
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: _invoiceDate ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2035),
            );

            if (selectedDate == null) return;

            if (!context.mounted) return;

            final value = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
            );

            setState(() {
              _invoiceDate = value;
              _invoiceDateController.text = DateFormat(
                'dd MMM, yyyy',
              ).format(value);
            });
          },
        ),
      ],
    );
  }

  Widget _paymentStatusField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _summaryTitle('Payment Status'),
        const SizedBox(height: kDefaultPadding / 2),
        CustomDropdownFormField<PaymentStatus>(
          initialValue: _paymentStatus,
          hint: 'Select payment status',
          items: PaymentStatus.values
              .map(
                (status) => DropdownMenuItem<PaymentStatus>(
                  value: status,
                  child: Text(status.titleLabel),
                ),
              )
              .toList(),
          onChanged: (status) {
            setState(() {
              _paymentStatus = status;
            });
          },
          // validator: FormBuilderValidators.required(),
          // successMessage: 'Looks Good!',
        ),
      ],
    );
  }

  Widget _addressFields(
    BuildContext context, {
    required String title,
    required TextEditingController nameController,
    required TextEditingController streetController,
    required TextEditingController phoneController,
    TextEditingController? taxController,
    required String nameHint,
    required String streetHint,
    required String phoneHint,
    String? taxHint,
    bool showTax = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: kDefaultPadding / 2),
        _invoiceField(
          labelText: 'Company Name',
          controller: nameController,
          hintText: nameHint,
        ),
        const SizedBox(height: kDefaultPadding / 2),
        _invoiceField(
          labelText: 'Address',
          controller: streetController,
          hintText: streetHint,
        ),
        const SizedBox(height: kDefaultPadding / 2),
        _invoiceField(
          labelText: 'Phone',
          controller: phoneController,
          hintText: phoneHint,
          keyboardType: TextInputType.phone,
        ),
        if (showTax && taxController != null) ...[
          const SizedBox(height: kDefaultPadding / 2),
          _invoiceField(
            labelText: 'Tax',
            controller: taxController,
            hintText: taxHint ?? '98-7654321',
            required: false,
          ),
        ],
      ],
    );
  }

  Widget _buildProductHeaderRow(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: 0.75 * kDefaultPadding,
      ),
      decoration: BoxDecoration(
        color: kTableHeaderColor,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            child: Text(
              '#',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              'Product',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: kDefaultPadding),
          Expanded(
            flex: 2,
            child: Text(
              'Rate',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: kDefaultPadding),
          Expanded(
            child: Text(
              'Qty',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: kDefaultPadding),
          Expanded(
            flex: 2,
            child: Text(
              'Amount',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: mediumHeight),
        ],
      ),
    );
  }

  Widget _buildProductLine(
    BuildContext context,
    int index,
    _ProductLineController line,
  ) {
    final amount = _lineAmount(line);
    final themeData = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: themeData.colorScheme.outline, width: 0.4),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < kScreenWidthMd) {
            return Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding / 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        (index + 1).toString().padLeft(2, '0'),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      if (_productLines.length > 1)
                        CustomIconButton(
                          icon: Icons.close,
                          iconColor: kErrorColor,
                          onTap: () => _removeProductLine(index),
                          shape: ButtonShape.circle,
                        ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  _invoiceField(
                    controller: line.titleController,
                    labelText: 'Product Name',
                    hintText: 'Premium Wireless Headphones',
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  _invoiceField(
                    controller: line.descriptionController,
                    labelText: 'Product Description',
                    hintText: 'Noise-cancelling, over-ear headphones',
                    required: false,
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    children: [
                      Expanded(
                        child: _amountInput(line.rateController, '299.99'),
                      ),
                      const SizedBox(width: kDefaultPadding),
                      Expanded(child: _qtyInput(line.quantityController, '1')),
                      const SizedBox(width: kDefaultPadding),
                      Text(_currencyFormat.format(amount)),
                    ],
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsetsDirectional.only(
              start: kDefaultPadding,
              end: 0,
              top: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 48,
                  child: Text(
                    (index + 1).toString().padLeft(2, '0'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      _invoiceField(
                        controller: line.titleController,
                        labelText: 'Product Name',
                        hintText: 'Premium Wireless Headphones',
                      ),
                      const SizedBox(height: kDefaultPadding / 2),
                      _invoiceField(
                        controller: line.descriptionController,
                        labelText: 'Product Description',
                        hintText: 'Noise-cancelling, over-ear headphones',
                        required: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  flex: 2,
                  child: _amountInput(line.rateController, '99.99'),
                ),
                const SizedBox(width: kDefaultPadding),
                Expanded(child: _qtyInput(line.quantityController, '1')),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: mediumHeight,
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      _currencyFormat.format(amount),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                const SizedBox(width: kDefaultPadding),

                SizedBox(
                  width: mediumHeight,
                  child: _productLines.length > 1
                      ? CustomIconButton(
                          icon: Icons.close,
                          iconColor: kErrorColor,
                          onTap: () => _removeProductLine(index),
                          shape: ButtonShape.circle,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _summaryRow(
    BuildContext context,
    String title,
    String value, {
    bool isBold = false,
  }) {
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: themeData.colorScheme.onSurface,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: themeData.colorScheme.onSurface,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryInputRow(
    BuildContext context,
    String title,
    TextEditingController controller,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          const SizedBox(width: kDefaultPadding),
          SizedBox(
            width: 120,
            child: _amountInput(controller, hintText, required: false),
          ),
        ],
      ),
    );
  }

  Widget _invoiceField({
    required TextEditingController controller,
    String? hintText,
    String? labelText,
    TextInputType? keyboardType,
    bool required = true,
    int maxLines = 1,
  }) {
    return CustomTextFormField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }

  Widget _amountInput(
    TextEditingController controller,
    String hintText, {
    bool required = true,
  }) {
    return CustomTextFormField(
      controller: controller,
      hintText: hintText,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      prefixIcon: Icons.attach_money,
      textAlign: TextAlign.end,
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _qtyInput(TextEditingController controller, String hintText) {
    return CustomTextFormField(
      controller: controller,
      hintText: hintText,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],

      onChanged: (_) => setState(() {}),
    );
  }

  Widget _summaryTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(color: kTextColor, fontWeight: FontWeight.w600),
    );
  }

  void _removeProductLine(int index) {
    setState(() {
      _productLines.removeAt(index).dispose();
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() != true) return;

    if (_paymentStatus == null) {
      Toast.showToast(
        context: context,
        icon: Icons.info_outline,
        message: 'Select payment status first.',
        color: kWarningColor,
        alignment: Alignment.topRight,
        showProgress: true,
        showCloseButton: true,
        // bottomBorder: true,
      );
      return;
    }

    widget.onCreate?.call(
      InvoiceData(
        id: _invoiceNoController.text.trim(),
        customerName: _billingNameController.text.trim(),
        avatarUrl: 'assets/images/avatar_1.jpg',
        email: _companyEmailController.text.trim(),
        country: _companyAddressController.text.trim(),
        date: _invoiceDate ?? DateTime.now(),
        amount: _total,
        status: _paymentStatus!,
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
      // bottomBorder: true,
    );

    GoRouter.of(context).go(RouteUri.invoiceList);
  }

  double get _subtotal {
    return _productLines.fold<double>(
      0,
      (sum, item) => sum + _lineAmount(item),
    );
  }

  double get _total {
    final subtotal = _subtotal;
    final tax = subtotal * (_toDouble(_estimatedTaxController.text) / 100);
    final discount = _toDouble(_discountController.text);
    final shipping = _toDouble(_shippingChargeController.text);
    return subtotal + tax - discount + shipping;
  }

  double _lineAmount(_ProductLineController line) {
    return _toDouble(line.rateController.text) *
        (int.tryParse(line.quantityController.text) ?? 0);
  }

  double _toDouble(String value) {
    return double.tryParse(value) ?? 0;
  }
}

class _ProductLineController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final rateController = TextEditingController();
  final quantityController = TextEditingController();

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    rateController.dispose();
    quantityController.dispose();
  }
}
