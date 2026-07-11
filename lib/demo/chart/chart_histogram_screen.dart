import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/chart/chart.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartHistogramScreen extends StatefulWidget {
  const ChartHistogramScreen({super.key});

  @override
  State<ChartHistogramScreen> createState() => _ChartHistogramScreenState();
}

class _ChartHistogramScreenState extends State<ChartHistogramScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).histogramChart; //update your page tittle here
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
                      lang.histogramChart.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
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
                        BreadcrumbItem(label: lang.chart, uri: ''),
                        BreadcrumbItem(
                          label: lang.histogramChart,
                          uri: RouteUri.chartBubble,
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
                LayoutBuilder(
                  builder: (context, constraints) {
                    int numberOfCardsPerRow = getNumberOfCardsPerRow_2(context);
                    return Wrap(
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        // Basic Histogram Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Basic Histogram Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: HistogramChartExample(),
                            ),
                            codeView:
                                '''HistogramChartExample() source code can be found in the lib/demo/chart/chart_histogram_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // histogram with normal distribution curve
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle:
                                'Histogram with Normal Distribution Curve',
                            uiView: SizedBox(
                              height: 440,
                              child: BoltWeightHistogram(),
                            ),
                            codeView:
                                '''BoltWeightHistogram() source code can be found in the lib/demo/chart/chart_histogram_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // multiple histogram with normal distribution curve
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Multiple Histogram',
                            uiView: SizedBox(
                              height: 440,
                              child: MultipleHistogramChart(),
                            ),
                            codeView:
                                '''MultipleHistogramChart() source code can be found in the lib/demo/chart/chart_histogram_screen.dart file.''',
                            height: 440,
                          ),
                        ),
                      ],
                    );
                  },
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

// HISTROGRAM CHART //

// basic histogram chart

class HistogramChartExample extends StatelessWidget {
  final List<ScoreData> _chartData = [
    ScoreData(55),
    ScoreData(60),
    ScoreData(63),
    ScoreData(67),
    ScoreData(68),
    ScoreData(70),
    ScoreData(72),
    ScoreData(75),
    ScoreData(78),
    ScoreData(79),
    ScoreData(80),
    ScoreData(83),
    ScoreData(85),
    ScoreData(86),
    ScoreData(90),
    ScoreData(92),
    ScoreData(95),
    ScoreData(98),
  ];

  HistogramChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Histogram of Student Exam Scores',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Scores', textStyle: chartAxisLabelStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Frequency', textStyle: chartAxisLabelStyle),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <HistogramSeries<ScoreData, num>>[
        HistogramSeries<ScoreData, num>(
          dataSource: _chartData,
          yValueMapper: (ScoreData data, _) => data.score,
          binInterval: 10, // Defines the bin size (score range per bar)
          color: kSecondaryColor,
          showNormalDistributionCurve:
              false, // Shows a curve for normal distribution
          curveColor: kErrorColor,
        ),
      ],
    );
  }
}

class ScoreData {
  ScoreData(this.score);
  final double score;
}

// histogram with normal distribution curve

class BoltWeightHistogram extends StatelessWidget {
  final List<BoltWeightData> _chartData = [
    BoltWeightData(47),
    BoltWeightData(48),
    BoltWeightData(49),
    BoltWeightData(49),
    BoltWeightData(50),
    BoltWeightData(50),
    BoltWeightData(50),
    BoltWeightData(51),
    BoltWeightData(51),
    BoltWeightData(52),
    BoltWeightData(52),
    BoltWeightData(53),
    BoltWeightData(54),
    BoltWeightData(55),
  ];

  BoltWeightHistogram({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Histogram of Bolt Weights (grams)',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(
          text: 'Bolt Weight (grams)',
          textStyle: chartAxisLabelStyle,
        ),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Frequency', textStyle: chartAxisLabelStyle),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <HistogramSeries<BoltWeightData, num>>[
        HistogramSeries<BoltWeightData, num>(
          dataSource: _chartData,
          yValueMapper: (BoltWeightData data, _) => data.weight,
          binInterval: 2, // Groups bolt weights into 2g intervals
          color: kSuccessColor,
          showNormalDistributionCurve: true, // Shows normal distribution curve
          curveColor: kErrorColor,
        ),
      ],
    );
  }
}

class BoltWeightData {
  BoltWeightData(this.weight);
  final double weight;
}

// multiple histogram chart

class MultipleHistogramChart extends StatelessWidget {
  final List<StudentScoreData> classAData = [
    StudentScoreData(55),
    StudentScoreData(60),
    StudentScoreData(62),
    StudentScoreData(65),
    StudentScoreData(68),
    StudentScoreData(70),
    StudentScoreData(72),
    StudentScoreData(75),
    StudentScoreData(78),
    StudentScoreData(80),
    StudentScoreData(85),
    StudentScoreData(88),
    StudentScoreData(90),
    StudentScoreData(92),
    StudentScoreData(95),
  ];

  final List<StudentScoreData> classBData = [
    StudentScoreData(50),
    StudentScoreData(55),
    StudentScoreData(58),
    StudentScoreData(60),
    StudentScoreData(63),
    StudentScoreData(65),
    StudentScoreData(68),
    StudentScoreData(70),
    StudentScoreData(73),
    StudentScoreData(75),
    StudentScoreData(78),
    StudentScoreData(80),
    StudentScoreData(82),
    StudentScoreData(85),
    StudentScoreData(90),
  ];

  MultipleHistogramChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Histogram Comparison of Student Exam Scores',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Exam Score', textStyle: chartAxisLabelStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Number of Students',
          textStyle: chartAxisLabelStyle,
        ),
        maximum: 2.7,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <HistogramSeries<StudentScoreData, num>>[
        HistogramSeries<StudentScoreData, num>(
          dataSource: classAData,
          yValueMapper: (StudentScoreData data, _) => data.score,
          binInterval: 5, // Grouping scores into 5-point bins
          color: kInfoColor.withValues(alpha: 0.8),
          name: 'Class A',
          showNormalDistributionCurve: true, // Shows normal distribution curve
          curveColor: kInfoColor,
          borderWidth: 3.0,
        ),
        HistogramSeries<StudentScoreData, num>(
          dataSource: classBData,
          yValueMapper: (StudentScoreData data, _) => data.score,
          binInterval: 5,
          color: kErrorColor.withValues(alpha: 0.8),
          name: 'Class B',
          showNormalDistributionCurve: true, // Shows normal distribution curve
          curveColor: kErrorColor,
          borderWidth: 3.0,
        ),
      ],
    );
  }
}

class StudentScoreData {
  StudentScoreData(this.score);
  final double score;
}
