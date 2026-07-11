import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/nft/dashboard_nft_data.dart';
import 'package:flutter_ademin/demo/dashboard/nft/dashboard_nft_models.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TopBiddersTable extends StatelessWidget {
  const TopBiddersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = TopBiddersDataSource(topBidders, context);
    double rowHeight = 48.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row
    final themeData = Theme.of(context);

    return Card(
      child: Column(
        children: [
          CardHeader(
            kText: 'Top Bidders',
            kWidget: Padding(
              padding: const EdgeInsetsDirectional.only(end: kDefaultPadding),
              child: SoftButton(
                kText: 'Full Report',
                bgColor: themeData.colorScheme.primary,
                size: ButtonSize.small,
                onPressed: () {},
              ),
            ),
          ),
          SfDataGridTheme(
            data: TableStyle.dataGridTheme,
            child: SfDataGrid(
              source: dataSource,
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
              columns: [
                GridColumn(
                  columnName: 'no',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '#',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  width: 62,
                ),
                GridColumn(
                  columnName: 'user',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'User',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  minimumWidth: 180,
                ),
                GridColumn(
                  columnName: 'bids',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Total Bids',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  minimumWidth: 100,
                ),
                GridColumn(
                  columnName: 'volume',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Volume (ETH)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  minimumWidth: 120,
                ),
                GridColumn(
                  columnName: 'lastBid',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Last Bid',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  minimumWidth: 140,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// data source

class TopBiddersDataSource extends DataGridSource {
  final List<TopBidder> bidders;
  late List<DataGridRow> _rows;
  final BuildContext context;

  TopBiddersDataSource(this.bidders, this.context) {
    _rows = List.generate(bidders.length, (index) {
      final bidder = bidders[index];
      return DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'no', value: index + 1),
          DataGridCell<TopBidder>(columnName: 'user', value: bidder),
          DataGridCell<int>(columnName: 'bids', value: bidder.totalBids),
          DataGridCell<double>(columnName: 'volume', value: bidder.totalVolume),
          DataGridCell<String>(
            columnName: 'lastBid',
            value: DateFormat.yMMMMd().format(bidder.lastBid),
          ),
        ],
      );
    });
  }

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final bidder = row.getCells()[1].value as TopBidder;
    final themeData = Theme.of(context);

    return DataGridRowAdapter(
      cells: [
        // rank number
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.center,
          child: Text(
            '#${row.getCells()[0].value}',
            style: TextStyle(
              color: themeData.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // user
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: AlignmentDirectional.centerStart,
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(bidder.avatar),
              ),
              const SizedBox(width: kDefaultPadding / 2),
              Text(bidder.username),
            ],
          ),
        ),

        // total bids
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.center,
          child: Text('${row.getCells()[2].value}'),
        ),

        // volume
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.center,
          child: Text('${row.getCells()[3].value.toStringAsFixed(2)} ETH'),
        ),

        // date
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.center,
          child: Text(row.getCells()[4].value),
        ),
      ],
    );
  }
}
