import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_data.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PortfolioTable extends StatefulWidget {
  const PortfolioTable({super.key});

  @override
  State<PortfolioTable> createState() => _PortfolioTableState();
}

class _PortfolioTableState extends State<PortfolioTable> {
  late PortfolioDataSource _portofolioDataSource;
  List<PortfolioItem> _allPortfolioItem = [];
  final int _rowsPerPage = 10; // Number of rows to display per page
  final double dataPagerHeight = 60.0; // Height for the pager

  @override
  void initState() {
    super.initState();
    _allPortfolioItem = mockPortfolioTable; // Get all 30 mock data entries
    _portofolioDataSource = PortfolioDataSource(
      allPortofioItem: _allPortfolioItem,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 48.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final isMobile = mediaQueryData.size.width < kScreenWidthSm;
    final GlobalKey<PopupMenuButtonState> popupWalletSearchbar =
        GlobalKey<PopupMenuButtonState>();
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              children: [
                Text(
                  'Portfolio Status'.toUpperCase(),
                  style: TextStyle(
                    fontSize: kBodyMedium,
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                Spacer(),

                // search bar
                isMobile
                    ? PopupMenuButton(
                        key: popupWalletSearchbar,
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
                                hintText: 'Search portofolio',
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
                            popupWalletSearchbar.currentState?.showButtonMenu();
                          },
                          isOutlined: true,
                        ),
                      )
                    : SizedBox(
                        width: 240,
                        child: OutlineSearchBar(hintText: 'Search portofolio'),
                      ),
              ],
            ),
          ),
          SizedBox(
            child: SfDataGridTheme(
              data: TableStyle.dataGridTheme,
              child: ClipRect(
                clipper: CustomLeftClipper(),
                child: SfDataGrid(
                  source: _portofolioDataSource,
                  shrinkWrapRows: true,
                  verticalScrollPhysics: NeverScrollableScrollPhysics(),
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
                  allowFiltering: false,
                  selectionMode: SelectionMode.multiple,
                  columns: <GridColumn>[
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
                      minimumWidth: 220,
                    ),
                    GridColumn(
                      columnName: 'quantity',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Quantity',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'averagePrice',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Avg. Price',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'currentValue',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Current Value',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'returns',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Returns',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'returnsPercentage',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Returns %',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      width: 120,
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
                delegate: _portofolioDataSource,
                itemHeight: 44,
                itemWidth: 44,
                navigationItemHeight: 44,
                navigationItemWidth: 44,
                pageCount: (_allPortfolioItem.isEmpty)
                    ? 1
                    : (_allPortfolioItem.length / _rowsPerPage).ceilToDouble(),
                visibleItemsCount:
                    _rowsPerPage, // Correctly use _rowsPerPage here
                direction: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A custom DataGridSource for MarketData.
class PortfolioDataSource extends DataGridSource {
  final BuildContext context;
  PortfolioDataSource(
    this.context, {
    required List<PortfolioItem> allPortofioItem,
  }) {
    _allPortfolioItem = allPortofioItem;

    _buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];
  List<PortfolioItem> _allPortfolioItem = []; // Holds the complete list of data

  @override
  List<DataGridRow> get rows => _dataGridRows;

  void _buildDataGridRows() {
    _dataGridRows = _allPortfolioItem
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'currencyCode',
                value: e.currencyCode,
              ),
              DataGridCell<double>(columnName: 'quantity', value: e.quantity),
              DataGridCell<double>(
                columnName: 'averagePrice',
                value: e.averagePrice,
              ),
              DataGridCell<double>(
                columnName: 'currentValue',
                value: e.currentValue,
              ),
              DataGridCell<double>(columnName: 'returns', value: e.returns),
              DataGridCell<double>(
                columnName: 'returnsPercentage',
                value: e.returnsPercentage,
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final themeData = Theme.of(context);
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'currencyCode') {
          // This column handles the display for 'Currency'
          final String currencyCode = e.value
              .toString(); // The currency code itself
          String currencyName = ''; // Initialize currencyName here

          FaIconData? currencyIcon;
          Color? currencyColor;

          switch (currencyCode) {
            case 'BTC':
              currencyIcon = FontAwesomeIcons.btc;
              currencyColor = Colors.amber;
              currencyName = 'Bitcoin';
              break;
            case 'ETH':
              currencyIcon = FontAwesomeIcons.ethereum;
              currencyColor = kInfoColor;
              currencyName = 'Ethereum';
              break;
            case 'ADA':
              currencyIcon = FontAwesomeIcons.coins;
              currencyColor = kPrimaryColor;
              currencyName = 'Cardano';
              break;
            case 'XRP':
              currencyIcon = FontAwesomeIcons.dollarSign;
              currencyColor = Colors.blueGrey;
              currencyName = 'Ripple';
              break;
            case 'DOT':
              currencyIcon = FontAwesomeIcons.circleDot;
              currencyColor = kErrorColor;
              currencyName = 'Polkadot';
              break;
            case 'LTC':
              currencyIcon = FontAwesomeIcons.litecoinSign;
              currencyColor = Colors.blueGrey[400];
              currencyName = 'Litecoin';
              break;
            case 'SOL':
              currencyIcon = FontAwesomeIcons.solidStar;
              currencyColor = Colors.deepPurple;
              currencyName = 'Solana';
              break;
            case 'USDT':
              currencyIcon = FontAwesomeIcons.dollarSign;
              currencyColor = kSuccessColor;
              currencyName = 'Tether USD';
              break;
            case 'USDC':
              currencyIcon = FontAwesomeIcons.dollarSign;
              currencyColor = kSuccessColor;
              currencyName = 'USD Coin';
              break;
            case 'BNB':
              currencyIcon = FontAwesomeIcons.b;
              currencyColor = kSecondaryColor;
              currencyName = 'Binance Coin';
              break;
            case 'DOGE':
              currencyIcon = FontAwesomeIcons.dog;
              currencyColor = Colors.orange;
              currencyName = 'Dogecoin';
              break;
            case 'XMR': // Added Monero
              currencyIcon = FontAwesomeIcons.monero;
              currencyColor = Colors.orangeAccent;
              currencyName = 'Monero';
              break;
            case 'ANT': // Added Aragon
              currencyIcon = FontAwesomeIcons.spider; // Placeholder icon
              currencyColor = kPrimaryColor;
              currencyName = 'Aragon';
              break;
            case 'FIL': // Added Filecoin
              currencyIcon = FontAwesomeIcons.file;
              currencyColor = Colors.blueGrey;
              currencyName = 'Filecoin';
              break;
            case 'AAVE': // Added Aave
              currencyIcon = FontAwesomeIcons.a; // Placeholder icon
              currencyColor = Colors.deepPurpleAccent;
              currencyName = 'Aave';
              break;
            case 'LINK': // Added Chainlink
              currencyIcon = FontAwesomeIcons.link;
              currencyColor = Colors.blueAccent;
              currencyName = 'Chainlink';
              break;
            case 'UNI': // Added Uniswap
              currencyIcon = FontAwesomeIcons.retweet; // Placeholder icon
              currencyColor = Colors.pinkAccent;
              currencyName = 'Uniswap';
              break;
            case 'TRX': // Added TRON
              currencyIcon = FontAwesomeIcons.atom; // Placeholder icon
              currencyColor = kErrorColor.withValues(alpha: 0.5);
              currencyName = 'TRON';
              break;
            case 'XLM': // Added Stellar
              currencyIcon = FontAwesomeIcons.star;
              currencyColor = Colors.lightBlueAccent;
              currencyName = 'Stellar';
              break;
            case 'VET': // Added VeChain
              currencyIcon = FontAwesomeIcons.v;
              currencyColor = Colors.lightGreen;
              currencyName = 'VeChain';
              break;
            case 'MIOTA': // Added IOTA
              currencyIcon = FontAwesomeIcons.i; // Placeholder icon
              currencyColor = Colors.grey;
              currencyName = 'IOTA';
              break;
            case 'EOS': // Added EOS
              currencyIcon = FontAwesomeIcons.e; // Placeholder icon
              currencyColor = Colors.black;
              currencyName = 'EOS';
              break;
            case 'NEO': // Added Neo
              currencyIcon = FontAwesomeIcons.n; // Placeholder icon
              currencyColor = Colors.lightGreenAccent;
              currencyName = 'Neo';
              break;
            case 'DASH': // Added Dash
              currencyIcon = FontAwesomeIcons.dharmachakra; // Placeholder icon
              currencyColor = Colors.cyan;
              currencyName = 'Dash';
              break;
            case 'ZEC': // Added Zcash
              currencyIcon = FontAwesomeIcons.z; // Placeholder icon
              currencyColor = Colors.brown;
              currencyName = 'Zcash';
              break;
            case 'ETC': // Added Ethereum Classic
              currencyIcon = FontAwesomeIcons.ethereum;
              currencyColor = Colors.teal;
              currencyName = 'Ethereum Classic';
              break;
            case 'ALGO': // Added Algorand
              currencyIcon = FontAwesomeIcons.a; // Placeholder icon
              currencyColor = Colors.orangeAccent;
              currencyName = 'Algorand';
              break;
            case 'ATOM': // Added Cosmos
              currencyIcon = FontAwesomeIcons.atom;
              currencyColor = Colors.deepOrange;
              currencyName = 'Cosmos';
              break;
            case 'XTZ': // Added Tezos
              currencyIcon = FontAwesomeIcons.x; // Placeholder icon
              currencyColor = Colors.lightBlue;
              currencyName = 'Tezos';
              break;
            default:
              currencyIcon = FontAwesomeIcons.coins;
              currencyColor = kSuccessColor;
              currencyName = 'Unknown Currency'; // Default currency name
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
                const SizedBox(width: kDefaultPadding),
                Text(
                  '$currencyName ($currencyCode)', // Display full currency name from switch
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: themeData.colorScheme.primary,
                  ),
                ),
              ],
            ),
          );
        }
        if (e.columnName == 'returnsPercentage') {
          // Directly check the value of volumePercentage
          final double volumePercentageValue = e.value as double;
          final bool isPositiveChange = volumePercentageValue >= 0;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPositiveChange ? Icons.trending_up : Icons.trending_down,
                  color: isPositiveChange ? kSuccessColor : kErrorColor,
                  size: 16, // Adjust icon size
                ),
                SizedBox(width: kDefaultPadding / 4),
                Text(
                  '${volumePercentageValue.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: isPositiveChange ? kSuccessColor : kErrorColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }
        // Handle other columns as before
        // Apply currency formatting for specific columns
        if (e.columnName == 'averagePrice' ||
            e.columnName == 'currentValue' ||
            e.columnName == 'returns') {
          final NumberFormat currencyFormatter = NumberFormat.currency(
            locale: 'en_US', // Or 'id_ID' for Indonesian Rupiah, etc.
            symbol: '\$',
            decimalDigits: (e.value as double) % 1 == 0
                ? 0
                : 2, // 0 decimal if whole number, 2 if has decimal
          );
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            alignment: Alignment.centerLeft, // Align numbers to the right
            child: Text(currencyFormatter.format(e.value)),
          );
        }
        if (e.columnName == 'quantity') {
          final numberFormat = NumberFormat('#,##0.##');
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            alignment: Alignment.centerLeft, // Align numbers to the right
            child: Text(numberFormat.format(e.value)),
          );
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(e.value.toString()),
        );
      }).toList(),
    );
  }
}
