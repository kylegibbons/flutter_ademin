import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/data/dashboard_nft_data.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/dashboard_nft_models.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TopSellingArtistsTable extends StatelessWidget {
  const TopSellingArtistsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = TopArtistsDataSource(topArtists, context);
    double rowHeight = 48.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row
    final themeData = Theme.of(context);
    return Card(
      child: Column(
        children: [
          CardHeader(
            kText: 'Top Selling Artists',
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
                  columnName: 'artist',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Artist',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  minimumWidth: 180,
                ),
                GridColumn(
                  columnName: 'sales',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Total Sales',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  minimumWidth: 100,
                ),
                GridColumn(
                  columnName: 'nfts',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'NFTs Sold',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  minimumWidth: 120,
                ),
                GridColumn(
                  columnName: 'avg',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Avg. Price',
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

class TopArtistsDataSource extends DataGridSource {
  final List<TopArtist> artists;
  late final List<DataGridRow> _rows;
  final BuildContext context;

  TopArtistsDataSource(this.artists, this.context) {
    _rows = List.generate(artists.length, (index) {
      final artist = artists[index];
      return DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'no', value: index + 1),
          DataGridCell<TopArtist>(columnName: 'artist', value: artist),
          DataGridCell<int>(columnName: 'sales', value: artist.totalSales),
          DataGridCell<int>(columnName: 'nfts', value: artist.nftCount),
          DataGridCell<double>(columnName: 'avg', value: artist.averagePrice),
        ],
      );
    });
  }

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final artist = row.getCells()[1].value as TopArtist;
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

        // artist
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: AlignmentDirectional.centerStart,
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(artist.avatar),
              ),
              const SizedBox(width: kDefaultPadding / 2),
              Text(artist.name),
            ],
          ),
        ),

        // total sales
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.center,
          child: Text('${row.getCells()[2].value} ETH'),
        ),

        // nft sales
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.center,
          child: Text('${row.getCells()[3].value}'),
        ),

        // avg. sales
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.center,
          child: Text('${row.getCells()[4].value.toStringAsFixed(2)} ETH'),
        ),
      ],
    );
  }
}
