// Crypto table
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/crypto/crypto_data.dart';
import 'package:flutter_ademin/demo/app/crypto/crypto_models.dart';
import 'package:flutter_ademin/demo/app/crypto/dialogs/crypto_transaction_deposit_dialog.dart';
import 'package:flutter_ademin/demo/app/crypto/dialogs/crypto_transaction_withdraw_dialog.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/dialog.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransactionTablePage extends StatefulWidget {
  const TransactionTablePage({super.key});

  @override
  State<TransactionTablePage> createState() => _TransactionTablePageState();
}

class _TransactionTablePageState extends State<TransactionTablePage> {
  late TransactionDataSource _dataSource;
  late List<CryptoTransaction> _displayedTransactions;
  final int _rowsPerPage = 20;

  @override
  void initState() {
    super.initState();
    _displayedTransactions = mockTransactions;
    _dataSource = TransactionDataSource(
      context,
      transactions: _displayedTransactions,
    );
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 48.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row
    final mediaQueryData = MediaQuery.of(context);
    final isMobile = mediaQueryData.size.width < kScreenWidthSm;

    final themeData = Theme.of(context);
    final GlobalKey<PopupMenuButtonState> popupTransactionSearchbar =
        GlobalKey<PopupMenuButtonState>();
    return Card(
      child: Column(
        children: [
          // Search Bar, deposit, witdraw
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              children: [
                isMobile
                    ? PopupMenuButton(
                        key: popupTransactionSearchbar,
                        splashRadius: 0.0,
                        tooltip: '',
                        position: PopupMenuPosition.under,
                        color: themeData.colorScheme.surface,
                        constraints: BoxConstraints(
                          maxWidth: mediaQueryData.size.width <= kScreenWidthMd
                              ? mediaQueryData.size.width
                              : 360,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            enabled: false,
                            child: SizedBox(
                              width: double.maxFinite,
                              child: OutlineSearchBar(
                                hintText: 'Search...',
                                autofocus: true,
                              ),
                            ),
                          ),
                        ],
                        child: CustomIconButton(
                          icon: Icons.search,
                          iconColor: kTextColor,
                          buttonColor: themeData.colorScheme.surface,
                          onTap: () {
                            popupTransactionSearchbar.currentState
                                ?.showButtonMenu();
                          },
                          isOutlined: true,
                        ),
                      )
                    : SizedBox(
                        width: 240,
                        child: OutlineSearchBar(hintText: 'Search...'),
                      ),
                Spacer(),
                isMobile
                    ? CustomIconButton(
                        icon: Icons.add,
                        buttonColor: kErrorColor,
                        iconColor: Colors.white,
                        onTap: () {
                          showCustomDialog(
                            context: context,
                            title: "Deposit",
                            showCloseButton: true,
                            width: 640,
                            content: DepositDialog(asset: mockAssets.first),
                          );
                        },
                      )
                    : FlatButton(
                        kText: 'Deposit',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          showCustomDialog(
                            context: context,
                            title: "Deposit",
                            showCloseButton: true,
                            width: 640,
                            content: DepositDialog(asset: mockAssets.first),
                          );
                        },
                      ),
                SizedBox(
                  width: isMobile ? kDefaultPadding / 2 : kDefaultPadding,
                ),
                isMobile
                    ? CustomIconButton(
                        icon: Icons.remove,
                        buttonColor: kInfoColor,
                        iconColor: Colors.white,
                        onTap: () {
                          showCustomDialog(
                            context: context,
                            title: "Witdraw",
                            showCloseButton: true,
                            width: 640,
                            content: WithdrawDialog(asset: mockAssets.first),
                          );
                        },
                      )
                    : FlatButton(
                        kText: 'Witdraw',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          showCustomDialog(
                            context: context,
                            title: "Witdraw",
                            showCloseButton: true,
                            width: 640,
                            content: WithdrawDialog(asset: mockAssets.first),
                          );
                        },
                      ),
              ],
            ),
          ),

          // Data Grid
          SizedBox(
            child: SfDataGridTheme(
              data: TableStyle.dataGridTheme,
              child: ClipRect(
                clipper: CustomLeftClipper(),
                child: SfDataGrid(
                  source: _dataSource,
                  verticalScrollPhysics: NeverScrollableScrollPhysics(),
                  onCellTap: (details) {},
                  shrinkWrapRows: true,
                  allowSorting: isMobile ? false : true,
                  columnWidthMode:
                      MediaQuery.of(context).size.width < kScreenWidthMd
                      ? ColumnWidthMode.none
                      : ColumnWidthMode.fill,
                  gridLinesVisibility: GridLinesVisibility.horizontal,
                  headerGridLinesVisibility: GridLinesVisibility.horizontal,
                  showCheckboxColumn: false,
                  rowHeight: rowHeight,
                  headerRowHeight: headerRowHeight,
                  allowFiltering: true,
                  selectionMode: SelectionMode.multiple,
                  columns: [
                    GridColumn(
                      columnName: 'date',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Timestamp',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 200,
                    ),
                    GridColumn(
                      columnName: 'currency',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Currency',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 160,
                    ),
                    GridColumn(
                      columnName: 'from',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'From',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 200,
                    ),
                    GridColumn(
                      columnName: 'to',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'To',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 200,
                    ),
                    GridColumn(
                      columnName: 'type',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Type',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 120,
                    ),
                    GridColumn(
                      columnName: 'details',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Details',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 200,
                    ),
                    GridColumn(
                      columnName: 'value',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Value',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 120,
                    ),
                    GridColumn(
                      columnName: 'id',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Transaction ID',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 200,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Paginator
          SizedBox(
            height: dataPagerHeight,
            child: SfDataPagerTheme(
              data: SfDataPagerThemeData(
                itemTextStyle: const TextStyle(
                  fontSize: kBodyMedium, // Customize font size
                ),
                selectedItemTextStyle: const TextStyle(
                  fontSize: kBodyMedium,
                  fontWeight: FontWeight.w600, // Bold for active page
                  color: Colors.white, // Customize selected text color
                ),
                selectedItemColor: kPrimaryColor, // Active page background
                itemBorderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: SfDataPager(
                delegate: _dataSource,
                itemHeight: 44,
                itemWidth: 44,
                navigationItemHeight: 44,
                navigationItemWidth: 44,
                pageCount: (_displayedTransactions.isEmpty)
                    ? 1
                    : (_displayedTransactions.length / _rowsPerPage)
                          .ceilToDouble(),
                visibleItemsCount: _rowsPerPage,
                direction: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// table data source

class TransactionDataSource extends DataGridSource {
  final BuildContext context;
  List<DataGridRow> _transactions = [];
  List<CryptoTransaction> _transactionList;

  TransactionDataSource(
    this.context, {
    required List<CryptoTransaction> transactions,
  }) : _transactionList = transactions {
    _transactions = _buildDataGridRows();
  }

  List<DataGridRow> _buildDataGridRows() {
    return _transactionList.map<DataGridRow>((tx) {
      return DataGridRow(
        cells: [
          DataGridCell<DateTime>(columnName: 'date', value: tx.timestamp),
          DataGridCell<String>(columnName: 'currency', value: tx.currency),
          DataGridCell<String>(columnName: 'from', value: tx.from),
          DataGridCell<String>(columnName: 'to', value: tx.to),
          DataGridCell<TransactionType>(columnName: 'type', value: tx.type),
          DataGridCell<String>(columnName: 'details', value: tx.details),
          DataGridCell<CryptoTransaction>(columnName: 'value', value: tx),
          DataGridCell<String>(columnName: 'id', value: tx.transactionId),
        ],
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _transactions;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final themeData = Theme.of(context);
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == 'date') {
          final DateTime timestamp = cell.value as DateTime;
          final String formattedDate = DateFormat(
            'dd MMM yyyy',
          ).format(timestamp);
          final String formattedTime = DateFormat('HH:mm:ss').format(timestamp);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: formattedDate,
                      style: TextStyle(
                        fontWeight: FontWeight.w500, // Date in bold
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: ' $formattedTime', // New line for time
                      style: TextStyle(
                        fontSize: kBodySmall, // Slightly smaller font for time
                        fontWeight: FontWeight.normal,
                        color: kTextColor, // Lighter color for time
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center, // Align text within the cell
              ),
            ),
          );
        } else if (cell.columnName == 'currency') {
          final String currencyCode = cell.value.toString();
          FaIconData? currencyIcon;
          Color? currencyColor;

          switch (currencyCode) {
            case 'BTC':
              currencyIcon = FontAwesomeIcons.btc;
              currencyColor = Colors.amber;
              break;
            case 'ETH':
              currencyIcon = FontAwesomeIcons.ethereum;
              currencyColor = kInfoColor;
              break;
            case 'ADA':
              currencyIcon = FontAwesomeIcons.coins;
              currencyColor = kPrimaryColor;
              break;
            case 'XRP':
              currencyIcon = FontAwesomeIcons.monero;
              currencyColor = Colors.black;
              break;
            case 'DOT':
              currencyIcon = FontAwesomeIcons.circleDot;
              currencyColor = kErrorColor;
              break;
            case 'LTC':
              currencyIcon = FontAwesomeIcons.litecoinSign;
              currencyColor = Colors.amber;
              break;
            case 'SOL':
              currencyIcon = FontAwesomeIcons.socks;
              currencyColor = Colors.amber;
              break;
            case 'USDT':
            case 'USDC':
              currencyIcon = FontAwesomeIcons.dollarSign;
              currencyColor = kSuccessColor;
              break;
            case 'BNB':
              currencyIcon = FontAwesomeIcons.b;
              currencyColor = kSecondaryColor;
              break;
            case 'DOGE':
              currencyIcon = FontAwesomeIcons.dog;
              currencyColor = Colors.blue;
              break;
            default:
              currencyIcon = FontAwesomeIcons.coins;
              currencyColor = Colors.green;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: currencyColor,
                  radius: 12,
                  child: FaIcon(currencyIcon, size: 16, color: Colors.white),
                ),
                const SizedBox(width: kDefaultPadding / 2),
                Text(
                  currencyCode,
                  style: TextStyle(
                    fontSize: kBodyMedium,
                    fontWeight: FontWeight.w500,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          );
        } else if (cell.columnName == 'value') {
          final CryptoTransaction tx = cell.value as CryptoTransaction;
          final String cryptoAmount = tx.amount.toStringAsFixed(
            2,
          ); // Display more decimals for crypto
          final String fiatValue = tx.fiatValue.toStringAsFixed(2);
          final String fiatSymbol = tx.fiatCurrencySymbol;

          // Determine sign and color based on transaction type
          String sign = '';
          Color signColor = themeData.colorScheme.onSurface; // Default color

          switch (tx.type) {
            case TransactionType.received:
            case TransactionType.buy:
            case TransactionType.miningReward:
            case TransactionType.stakingReward:
              sign = '+';
              signColor = kSuccessColor; // Green for positive/gain
              break;
            case TransactionType.sent:
            case TransactionType.sell:
            case TransactionType.fee:
            case TransactionType
                .swap: // Swaps can be neutral or involve a fee/loss
              sign = '-';
              signColor = kErrorColor; // Red for negative/loss/cost
              break;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$sign $cryptoAmount',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: signColor,
                  ),
                ),
                Text(
                  '$fiatSymbol$fiatValue',
                  style: TextStyle(color: kTextColor),
                ),
              ],
            ),
          );
        } else if (cell.columnName == 'type') {
          final TransactionType type = cell.value as TransactionType;
          String badgeText =
              type.name; // Get the enum name (e.g., 'sent', 'received')
          Color badgeColor =
              themeData.colorScheme.onSurface; // Default neutral color

          switch (type) {
            case TransactionType.buy:
              badgeColor = kSuccessColor;
              badgeText = 'Buy';
              break;
            case TransactionType.received:
              badgeColor = kInfoColor;
              badgeText = 'Received';
              break;
            case TransactionType.miningReward:
              badgeColor = Colors.redAccent;
              badgeText = 'Mining Reward';
              break;
            case TransactionType.stakingReward:
              badgeColor = Colors.purple;
              badgeText = 'Staking Reward';
              break;
            case TransactionType.sell:
              badgeColor = kErrorColor;
              badgeText = 'Sell';
              break;
            case TransactionType.sent:
              badgeColor = kWarningColor;
              badgeText = 'Sent';
              break;
            case TransactionType.fee:
              badgeColor = Colors.blueAccent;
              badgeText = 'Fee';
              break;
            case TransactionType.swap:
              badgeColor = themeData.colorScheme.onSurface;
              badgeText = 'Swap';
              break;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Center(
              child: CustomBadge(
                kText: badgeText,
                kColor: badgeColor,
                isRounded: true,
                isOutlined: true,
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(cell.value.toString()),
          );
        }
      }).toList(),
    );
  }

  void updateDataSource(List<CryptoTransaction> updatedList) {
    _transactionList = updatedList;
    _transactions = _buildDataGridRows();
    notifyListeners();
  }
}
