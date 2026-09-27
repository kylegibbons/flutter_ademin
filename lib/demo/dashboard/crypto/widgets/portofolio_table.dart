import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/crypto/data/dashboard_crypto_data.dart';
import 'package:flutkit_ademin/demo/dashboard/crypto/dashboard_crypto_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CryptoPortfolioTable extends StatefulWidget {
  const CryptoPortfolioTable({super.key});

  @override
  State<CryptoPortfolioTable> createState() => _CryptoPortfolioTableState();
}

class _CryptoPortfolioTableState extends State<CryptoPortfolioTable> {
  late MarketDataSource _marketDataSource;
  List<MarketData> _allMarketData = [];

  @override
  void initState() {
    super.initState();
    _allMarketData = generateMockMarketData(); // Get all 30 mock data entries
    _marketDataSource = MarketDataSource(
      allMarketData: _allMarketData,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 48.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row

    return Card(
      child: Column(
        children: [
          CardHeader(
            kText: 'Crypto Portfolio',
            kWidget: Padding(
              padding: EdgeInsetsDirectional.only(end: kDefaultPadding),
              child: SoftButton(
                kText: 'Full Report',
                bgColor: kSecondaryColor,
                size: ButtonSize.small,
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(
            child: SfDataGridTheme(
              data: TableStyle.dataGridTheme,
              child: ClipRect(
                clipper: CustomLeftClipper(),
                child: SfDataGrid(
                  source: _marketDataSource,
                  shrinkWrapRows: true,
                  verticalScrollPhysics: NeverScrollableScrollPhysics(),
                  allowSorting: false,
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
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Currency',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 180,
                    ),
                    GridColumn(
                      columnName: 'price',
                      label: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Price',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 120,
                    ),
                    GridColumn(
                      columnName: 'gainLoss',
                      label: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          '24h Change',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 120,
                    ),
                    GridColumn(
                      columnName: 'totalCoin',
                      label: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Total Coin',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 120,
                    ),
                    GridColumn(
                      columnName: 'totalBalance',
                      label: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Total Balance',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 140,
                    ),
                    GridColumn(
                      columnName: 'action',
                      allowSorting: false,
                      allowFiltering: false,
                      label: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Action',
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
              DataGridCell<double>(columnName: 'gainLoss', value: e.gainLoss),
              DataGridCell<double>(columnName: 'totalCoin', value: e.totalCoin),
              DataGridCell<double>(
                columnName: 'totalBalance',
                value: e.totalBalance,
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
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            alignment: AlignmentDirectional.centerStart,
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
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: currencyColor,
                  radius: 12,
                  child: FaIcon(currencyIcon, size: 16, color: Colors.white),
                ),
                SizedBox(width: kDefaultPadding / 2),
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
        if (e.columnName == 'gainLoss') {
          // Directly check the value of gainLoss
          final double gainLossValue = e.value as double;
          final bool isPositiveChange = gainLossValue >= 0;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            alignment: AlignmentDirectional.centerStart,
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
                  '${gainLossValue.toStringAsFixed(2)}%',
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
        if (e.columnName == 'price' ||
            // e.columnName == 'totalCoin' ||
            e.columnName == 'totalBalance') {
          final NumberFormat currencyFormatter = NumberFormat.currency(
            locale: 'en_US', // Or 'id_ID' for Indonesian Rupiah, etc.
            symbol: '\$',
            decimalDigits: (e.value as double) % 1 == 0
                ? 0
                : 2, // 0 decimal if whole number, 2 if has decimal
          );
          return Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            alignment:
                AlignmentDirectional.centerStart, // Align numbers to the right
            child: Text(currencyFormatter.format(e.value)),
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: AlignmentDirectional.centerStart,
          child: Text(e.value.toString()),
        );
      }).toList(),
    );
  }
}
