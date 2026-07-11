// Assuming the models are already defined and mockInvoice is passed

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/invoice/invoice_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:url_launcher/url_launcher.dart';

class InvoiceDetails extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceDetails({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final double dynamicHorizontalPadding = screenWidth < kScreenWidthMd
        ? kDefaultPadding
        : 2 * kDefaultPadding;

    final double dynamicVerticalPadding = screenWidth < kScreenWidthMd
        ? kDefaultPadding
        : 2 * kDefaultPadding;
    final currencyFormat = NumberFormat.simpleCurrency();

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicHorizontalPadding,
              vertical: dynamicVerticalPadding,
            ),
            child: _buildCompanyHeader(invoice.companyInfo, context),
          ),

          Divider(height: 0),

          // Invoice Summary
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicHorizontalPadding,
              vertical: dynamicVerticalPadding,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Define breakpoint for responsiveness
                bool isMobile = constraints.maxWidth <= kScreenWidthMd;
                if (isMobile) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSummary(
                            'Invoice No',
                            invoice.invoiceNo,
                            context,
                          ),
                          SizedBox(height: kDefaultPadding),
                          _buildSummary(
                            'Date',
                            DateFormat(
                              'dd MMM, yyyy – hh:mm a',
                            ).format(invoice.dateTime),
                            context,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPaymentStatusSummary(
                            'Payment Status',
                            invoice.paymentStatus,
                          ),
                          SizedBox(height: kDefaultPadding),
                          _buildSummary(
                            'Total Amount',
                            currencyFormat.format(invoice.totalAmount),
                            context,
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSummary('Invoice No', invoice.invoiceNo, context),
                      _buildSummary(
                        'Date',
                        DateFormat(
                          'dd MMM, yyyy – hh:mm a',
                        ).format(invoice.dateTime),
                        context,
                      ),
                      _buildPaymentStatusSummary(
                        'Payment Status',
                        invoice.paymentStatus,
                      ),
                      _buildSummary(
                        'Total Amount',
                        currencyFormat.format(invoice.totalAmount),
                        context,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Divider(height: 0),

          // Address Section
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicHorizontalPadding,
              vertical: dynamicVerticalPadding,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                int numberOfCardsPerRow = getRowAmmount(context);
                return Wrap(
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    SizedBox(
                      width: responsiveWidth(
                        context,
                        constraints,
                        numberOfCardsPerRow,
                      ),
                      child: _buildAddress(
                        'Billing Address',
                        invoice.billingAddress,
                        context,
                      ),
                    ),
                    SizedBox(
                      width: responsiveWidth(
                        context,
                        constraints,
                        numberOfCardsPerRow,
                      ),
                      child: _buildAddress(
                        'Shipping Address',
                        invoice.shippingAddress,
                        context,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          Divider(height: 0),

          // Product Table
          Padding(
            padding: EdgeInsets.only(
              top: dynamicVerticalPadding,
              left: dynamicHorizontalPadding,
              right: dynamicHorizontalPadding,
            ),
            child: _buildSfProductTable(invoice.items, context),
          ),

          // Summary
          Padding(
            padding: EdgeInsets.only(
              left: dynamicHorizontalPadding,
              right: dynamicHorizontalPadding,
              bottom: dynamicVerticalPadding,
            ),
            child: _buildSummarySection(context, invoice, currencyFormat),
          ),
          Divider(height: 0),

          // Payment Details
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicHorizontalPadding,
              vertical: dynamicVerticalPadding,
            ),
            child: _buildPaymentDetails(invoice.paymentDetails, context),
          ),

          // Notes
          Padding(
            padding: EdgeInsets.only(
              left: dynamicHorizontalPadding,
              right: dynamicHorizontalPadding,
              bottom: dynamicVerticalPadding,
            ),
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: kInfoColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: kInfoColor, width: 0.4),
              ),
              child: Text(
                'NOTES:\nAll accounts are to be paid within 7 days from receipt of invoice. '
                'To be paid by cheque or credit card or direct payment online. '
                'If account is not paid within 7 days the credits details supplied as confirmation '
                'of work undertaken will be charged the agreed quoted fee noted above.',
                style: TextStyle(color: kInfoColor),
              ),
            ),
          ),

          // Print & Download buttons
          Padding(
            padding: EdgeInsets.only(
              left: dynamicHorizontalPadding,
              right: dynamicHorizontalPadding,
              bottom: dynamicVerticalPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  kText: 'Print',
                  bgColor: kSuccessColor,
                  kTextColor: Colors.white,
                  onPressed: () {},
                  kLeadingIcon: Icons.print_outlined,
                ),
                SizedBox(width: kDefaultPadding),
                FlatButton(
                  kText: 'Download',
                  bgColor: kPrimaryColor,
                  kTextColor: Colors.white,
                  onPressed: () {},
                  kLeadingIcon: Icons.download_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyHeader(CompanyInfo info, BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        int numberOfCardsPerRow = getRowAmmount(context);
        return Wrap(
          spacing: kDefaultPadding,
          runSpacing: kDefaultPadding,
          children: [
            // Left: Logo and Address
            SizedBox(
              width: responsiveWidth(context, constraints, numberOfCardsPerRow),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    info.logoUrl,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.image_not_supported),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info.address),
                      Text('Zip-code: ${info.zipCode}'),
                    ],
                  ),
                ],
              ),
            ),

            // Right: Legal & Contact Info
            SizedBox(
              width: responsiveWidth(context, constraints, numberOfCardsPerRow),
              child: Column(
                crossAxisAlignment: mediaQueryData.size.width >= kScreenWidthXl
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  _companyDetailLine(
                    'Legal Registration No:',
                    info.legalRegistrationNo,
                    context,
                  ),
                  _companyDetailLine('Email:', info.email, context),
                  _companyDetailLine('Website:', info.website, context),
                  _companyDetailLine('Contact No:', info.contactNo, context),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _companyDetailLine(String label, String value, BuildContext context) {
    final isEmail = label.toLowerCase().contains('email');
    final isWebsite = label.toLowerCase().contains('website');
    final mediaQueryData = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: kDefaultPadding / 4),
      child: Row(
        mainAxisAlignment: mediaQueryData.size.width >= kScreenWidthXl
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: kTextColor)),
          SizedBox(width: kDefaultPadding / 4),
          InkWell(
            onTap: () async {
              final uri = isEmail
                  ? Uri(scheme: 'mailto', path: value)
                  : isWebsite
                  ? Uri.parse(
                      value.startsWith('http') ? value : 'https://$value',
                    )
                  : null;

              if (uri != null && await canLaunchUrl(uri)) {
                await launchUrl(
                  uri,
                  mode: isWebsite
                      ? LaunchMode.externalApplication
                      : LaunchMode.platformDefault,
                );
              } else {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Could not open $value')),
                );
              }
            },
            child: Text(
              value,
              style: TextStyle(
                color: isEmail || isWebsite
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(String title, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: kDefaultPadding / 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentStatusSummary(String title, String value) {
    Color getBadgeColor(String status) {
      switch (status.toLowerCase()) {
        case 'paid':
          return kSuccessColor;
        case 'unpaid':
          return kInfoColor;
        case 'pending':
          return kWarningColor;

        case 'declined':
          return kErrorColor;
        default:
          return Colors.grey.shade300;
      }
    }

    final badgeColor = getBadgeColor(value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: kDefaultPadding / 4),
        CustomBadge(kText: value, kColor: badgeColor, isSoft: true),
      ],
    );
  }

  Widget _buildAddress(String title, Address address, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: kDefaultPadding / 4),
        Text(
          address.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(address.street),
        Text('Phone: ${address.phone}'),
        if (address.tax != null) Text('Tax: ${address.tax}'),
      ],
    );
  }

  Widget _buildSfProductTable(List<ProductItem> items, context) {
    final themeData = Theme.of(context);
    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: SfDataGrid(
        source: ProductItemDataSource(items, context),
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        columns: [
          GridColumn(
            columnName: '#',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              alignment: Alignment.center,
              child: Text(
                '#',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ),
            width: 60,
          ),
          GridColumn(
            columnName: 'ProductDetails',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              alignment: Alignment.centerLeft,
              child: Text(
                'Product',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ),
            minimumWidth: MediaQuery.of(context).size.width < kScreenWidthMd
                ? 180
                : 420,
          ),
          GridColumn(
            columnName: 'Rate',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              alignment: Alignment.center,
              child: Text(
                'Rate',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ),
            minimumWidth: 180,
          ),
          GridColumn(
            columnName: 'Qty',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              alignment: Alignment.center,
              child: Text(
                'Qty',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ),
            minimumWidth: 80,
          ),
          GridColumn(
            columnName: 'Amount',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              alignment: Alignment.centerRight,
              child: Text(
                'Amount',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ),
            minimumWidth: 180,
          ),
        ],
        headerRowHeight: 48.0,
        rowHeight: 64.0,
        columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
            ? ColumnWidthMode.auto
            : ColumnWidthMode.fill,
        // columnWidthMode: ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.none,
        headerGridLinesVisibility: GridLinesVisibility.none,
        shrinkWrapRows: true,
      ),
    );
  }

  Widget _buildSummarySection(
    BuildContext context,
    InvoiceModel invoice,
    NumberFormat currencyFormat,
  ) {
    final subtotal = invoice.items.fold<double>(
      0,
      (sum, item) => sum + item.amount,
    );
    final tax = subtotal * (invoice.estimatedTaxPercent / 100);
    final total =
        subtotal + tax - invoice.discountAmount + invoice.shippingCharge;

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: MediaQuery.of(context).size.width <= kScreenWidthSm
            ? double.infinity
            : 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSummaryRow(
              context,
              'Sub Total',
              currencyFormat.format(subtotal),
            ),
            _buildSummaryRow(
              context,
              'Estimated Tax (${invoice.estimatedTaxPercent}%)',
              currencyFormat.format(tax),
            ),
            _buildSummaryRow(
              context,
              'Discount (FLKT15)',
              '-${currencyFormat.format(invoice.discountAmount)}',
            ),
            _buildSummaryRow(
              context,
              'Shipping Charge',
              currencyFormat.format(invoice.shippingCharge),
            ),
            Divider(height: 0),
            _buildSummaryRow(
              context,
              'Total Amount',
              currencyFormat.format(total),
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    context,
    String title,
    String value, {
    bool isBold = false,
  }) {
    final themeData = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        top: kDefaultPadding,
        bottom: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: isBold
                ? TextStyle(
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  )
                : TextStyle(color: themeData.colorScheme.onSurface),
          ),
          Text(
            value,
            style: isBold
                ? TextStyle(
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  )
                : TextStyle(color: themeData.colorScheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails(PaymentDetails details, BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Details'.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: kDefaultPadding / 2),
        Row(
          children: [
            Text('Payment Method: '),
            Text(
              details.method,
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text('Card Holder: '),
            Text(
              details.cardHolder,
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text('Card Number: '),
            Text(
              details.cardNumber,
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Product item data source

class ProductItemDataSource extends DataGridSource {
  final List<DataGridRow> _rows;
  final BuildContext context;

  ProductItemDataSource(List<ProductItem> items, this.context)
    : _rows = items.asMap().entries.map((entry) {
        final i = entry.key + 1;
        final item = entry.value;
        return DataGridRow(
          cells: [
            DataGridCell<String>(
              columnName: '#',
              value: i.toString().padLeft(2, '0'),
            ),
            DataGridCell<ProductItem>(
              columnName: 'ProductDetails',
              value: item,
            ),
            DataGridCell<double>(columnName: 'Rate', value: item.rate),
            DataGridCell<int>(columnName: 'Qty', value: item.quantity),
            DataGridCell<double>(columnName: 'Amount', value: item.amount),
          ],
        );
      }).toList();

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final currencyFormat = NumberFormat.simpleCurrency();
    final themeData = Theme.of(context);
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        if (cell.columnName == 'ProductDetails') {
          final item = cell.value as ProductItem;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    color: themeData.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(item.description, style: TextStyle(color: kTextColor)),
              ],
            ),
          );
        } else if (cell.columnName == 'Amount') {
          return Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text(
                currencyFormat.format(cell.value),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        } else if (cell.columnName == 'Qty') {
          return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text(
                cell.value.toString(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        } else if (cell.columnName == 'Rate') {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            alignment: Alignment.center,
            child: Text(
              (cell.columnName == 'Rate')
                  ? currencyFormat.format(cell.value)
                  : cell.value.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: themeData.colorScheme.onSurface),
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            alignment: Alignment.center,
            child: Text(
              cell.value.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
      }).toList(),
    );
  }
}

// Responsvie helper for 2 columns

double responsiveWidth(
  BuildContext context,
  BoxConstraints constraints,
  int numberOfCardsPerRow,
) {
  double availableWidth =
      constraints.maxWidth - (numberOfCardsPerRow - 1) * kDefaultPadding;

  return availableWidth / numberOfCardsPerRow;
}

int getRowAmmount(BuildContext context) {
  final mediaQueryData = MediaQuery.of(context);

  if (mediaQueryData.size.width >= kScreenWidthSm) {
    return 2;
  } else {
    return 1;
  }
}
