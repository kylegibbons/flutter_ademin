import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/crypto/crypto_data.dart';
import 'package:flutter_ademin/demo/app/crypto/crypto_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MarketTable extends StatefulWidget {
  const MarketTable({super.key});

  @override
  State<MarketTable> createState() => _MarketTableState();
}

class _MarketTableState extends State<MarketTable> {
  late MarketDataSource _marketDataSource;
  List<MarketData> _allMarketData = [];
  final int _rowsPerPage = 10; // Number of rows to display per page
  final double dataPagerHeight = 60.0; // Height for the pager

  @override
  void initState() {
    super.initState();
    _allMarketData = marketTableData(); // Get all 30 mock data entries
    _marketDataSource = MarketDataSource(
      allMarketData: _allMarketData,
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
    final GlobalKey<PopupMenuButtonState> popupSearchbar =
        GlobalKey<PopupMenuButtonState>();
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              children: [
                Text(
                  'Markets'.toUpperCase(),
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
                        key: popupSearchbar,
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
                                hintText: 'Search markets',
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
                            popupSearchbar.currentState?.showButtonMenu();
                          },
                          isOutlined: true,
                        ),
                      )
                    : SizedBox(
                        width: 240,
                        child: OutlineSearchBar(hintText: 'Search markets'),
                      ),
                SizedBox(
                  width: isMobile ? kDefaultPadding / 2 : kDefaultPadding,
                ),

                // Filters button
                isMobile
                    ? CustomIconButton(
                        icon: Icons.tune_outlined,
                        iconColor: Colors.white,
                        buttonColor: kSuccessColor,
                        onTap: () {},
                      )
                    : FlatButton(
                        kText: 'Filters',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                        kLeadingIcon: Icons.tune_outlined,
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
                  source: _marketDataSource,
                  verticalScrollPhysics: NeverScrollableScrollPhysics(),
                  shrinkWrapRows: true,
                  allowSorting: isMobile ? false : true,
                  columnWidthMode:
                      MediaQuery.of(context).size.width < kScreenWidthLg
                      ? ColumnWidthMode.none
                      : ColumnWidthMode.fill,
                  gridLinesVisibility: GridLinesVisibility.horizontal,
                  headerGridLinesVisibility: GridLinesVisibility.horizontal,
                  showCheckboxColumn: false,
                  rowHeight: rowHeight,
                  headerRowHeight: headerRowHeight,
                  allowFiltering: isMobile ? false : true,
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
                      columnName: 'price',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Price',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'pairs',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Pairs',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '24high',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '24 High',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: '24low',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '24 Low',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'marketVolume',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Market Volume',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 180,
                    ),
                    GridColumn(
                      columnName: 'volumePercentage',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '%Volume',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'action',
                      allowSorting: false,
                      allowFiltering: false,
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Action',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
                delegate: _marketDataSource,
                itemHeight: 44,
                itemWidth: 44,
                navigationItemHeight: 44,
                navigationItemWidth: 44,
                pageCount: (_allMarketData.isEmpty)
                    ? 1
                    : (_allMarketData.length / _rowsPerPage).ceilToDouble(),
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
class MarketDataSource extends DataGridSource {
  final BuildContext context;
  MarketDataSource(this.context, {required List<MarketData> allMarketData}) {
    _allMarketData = allMarketData;

    _buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];
  List<MarketData> _allMarketData = []; // Holds the complete list of data

  @override
  List<DataGridRow> get rows => _dataGridRows;

  void _buildDataGridRows() {
    _dataGridRows = _allMarketData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'currencyCode',
                value: e.currencyCode,
              ),
              // Removed currencyName from here, it will be derived
              DataGridCell<double>(columnName: 'price', value: e.price),
              DataGridCell<String>(columnName: 'pairs', value: e.pairs),
              DataGridCell<double>(columnName: '24high', value: e.high24),
              DataGridCell<double>(columnName: '24low', value: e.low24),
              DataGridCell<double>(
                columnName: 'marketVolume',
                value: e.marketVolume,
              ),
              DataGridCell<double>(
                columnName: 'volumePercentage',
                value: e.volumePercentage,
              ),
              DataGridCell<String>(columnName: 'action', value: 'Trade Now'),
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
        if (e.columnName == 'action') {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            alignment: Alignment.centerLeft,
            child: SoftButton(
              kText: 'Trade',
              bgColor: kSecondaryColor,
              onPressed: () {},
              size: ButtonSize.small,
            ),
          );
        } else if (e.columnName == 'currencyCode') {
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
              currencyColor = Colors.indigo;
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
              currencyColor = Colors.redAccent;
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
              currencyColor = Colors.green;
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
                const SizedBox(width: kDefaultPadding / 2),
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
        if (e.columnName == 'volumePercentage') {
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
        // Handle other columns as before
        // Apply currency formatting for specific columns
        if (e.columnName == 'price' ||
            e.columnName == '24high' ||
            e.columnName == '24low' ||
            e.columnName == 'marketVolume') {
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
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(e.value.toString()),
        );
      }).toList(),
    );
  }
}
