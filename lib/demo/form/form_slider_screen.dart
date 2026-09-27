import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/helper/card_description.dart';
import 'package:flutkit_ademin/widgets/form/form_slider.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart ' as charts;
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FormSliderScreen extends StatefulWidget {
  const FormSliderScreen({super.key});

  @override
  State<FormSliderScreen> createState() => _FormSliderScreenState();
}

class _FormSliderScreenState extends State<FormSliderScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).slider; //update your page tittle here
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
                      lang.slider.toUpperCase(),
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
                        BreadcrumbItem(label: lang.forms(2), uri: ''),
                        BreadcrumbItem(
                          label: lang.slider,
                          uri: RouteUri.formSlider,
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
                ShowCodeCard(
                  cardTitle: 'Default Slider',
                  description:
                      "Use Flutter's default sliders to create sliders in your app. You can use <code>Slider</code> for simple sliders and <code>RangeSlider</code> for range sliders.",
                  uiView: DefaultSliderDemo(),
                  codeView: '''
// Basic slider
Slider(
  value: _basicSliderValue,
  min: 0,
  max: 100,
  divisions: 100,
  onChanged: (value) => setState(() => _basicSliderValue = value),
),

// Slider with label
Slider(
  value: _labelSliderValue,
  min: 0,
  max: 100,
  divisions: 100,
  label: _labelSliderValue.round().toString(), // add label
  activeColor: kSecondaryColor,
  onChanged: (value) => setState(() => _labelSliderValue = value),
),

// Slider with steps
Slider(
  value: _stepsSliderValue,
  min: 0,
  max: 100,
  divisions: 5, // divide to 5 steps
  label: _stepsSliderValue.round().toString(),
  activeColor: kSuccessColor,
  onChanged: (value) => setState(() => _stepsSliderValue = value),
),

// Disabled slider
Slider(
  value: _disabledSliderValue,
  min: 0,
  max: 100,
  divisions: 100,
  label: _disabledSliderValue.round().toString(),
  onChanged: null, // disabled
),

// Range slider
RangeSlider(
  values: _rangeValues,
  min: 0,
  max: 100,
  divisions: 10,
  labels: RangeLabels(
    _rangeValues.start.round().toString(),
    _rangeValues.end.round().toString(),
  ),
  activeColor: kErrorColor,
  onChanged: (values) => setState(() => _rangeValues = values),
),

// Disabled range slider
RangeSlider(
  values: _rangeDisabledValues,
  min: 0,
  max: 100,
  divisions: 10,
  labels: RangeLabels(
    _rangeDisabledValues.start.round().toString(),
    _rangeDisabledValues.end.round().toString(),
  ),
  onChanged: null, // disabled
),
''',
                ),
                SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Custom Slider',
                  description:
                      "Use <code>SliderTheme</code> as parent, <code>BorderedTrackShape()</code> and <code>RectangularThumbShape()</code> to set a custom slider.",
                  uiView: CustomSliderDemo(),
                  codeView: '''
// Basic Custom Slider
SliderTheme(
  data: SliderTheme.of(context).copyWith(
    trackHeight: 16,
    overlayColor: Colors.transparent,
    activeTrackColor: Colors.transparent,
    inactiveTrackColor: Colors.transparent,
    // custom track
    trackShape: BorderedTrackShape(
      fillColor: Colors.grey.shade100,
      borderColor: Colors.grey.shade300,
      borderRadius: 4,
      borderWidth: 1.0,
    ),
    // custom thumb
    thumbShape: RectangularThumbShape(
      color: kSuccessColor,
      width: 12,
      height: 24,
      borderRadius: 4,
    ),
  ),
  child: Slider(
    value: _basicSliderValue,
    min: 0,
    max: 100,
    divisions: 100,
    onChanged: (value) => setState(() => _basicSliderValue = value),
  ),

  // Slider with label
  SliderTheme(
  data: SliderTheme.of(context).copyWith(
    trackHeight: 16,
    overlayColor: Colors.transparent,
    activeTrackColor: Colors.transparent,
    inactiveTrackColor: Colors.transparent,
    trackShape: BorderedTrackShape(
      fillColor: Colors.grey.shade100,
      borderColor: Colors.grey.shade300,
      borderRadius: 4,
      borderWidth: 1.0,
    ),
    thumbShape: RectangularThumbShape(
      color: kSuccessColor,
      width: 12,
      height: 24,
      borderRadius: 4,
    ),
  ),
  child: Slider(
    value: _labelSliderValue,
    min: 0,
    max: 100,
    divisions: 100,
    label: _labelSliderValue.round().toString(), // add label
    onChanged: (value) => setState(() => _labelSliderValue = value),
  ),
),

// Disabled slider
SliderTheme(
  data: SliderTheme.of(context).copyWith(
    trackHeight: 16,
    overlayColor: Colors.transparent,
    activeTrackColor: Colors.transparent,
    inactiveTrackColor: Colors.transparent,
    trackShape: BorderedTrackShape(
      fillColor: Colors.grey.shade100,
      borderColor: Colors.grey.shade300,
      borderRadius: 4,
      borderWidth: 1.0,
    ),
    thumbShape: RectangularThumbShape(
      color: kSuccessColor,
      width: 12,
      height: 24,
      borderRadius: 4,
    ),
  ),
  child: Slider(
    value: _disabledSliderValue,
    min: 0,
    max: 100,
    divisions: 100,
    label: _disabledSliderValue.round().toString(),
    onChanged: null, //disabled
  ),
),
''',
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Syncfusion Slider',
                  description:
                      "Our templates support <a href='https://pub.dev/packages/syncfusion_flutter_sliders'>Syncfusion sliders</a> by default.",
                  uiView: SyncfusionSliderDemo(),
                  codeView: '''
// Horizontal Slider
SfSlider(
  min: 0.0,
  max: 100.0,
  value: _value1,
  interval: 20,
  showTicks: true,
  showLabels: true,
  enableTooltip: true,
  minorTicksPerInterval: 1,
  activeColor: kPrimaryColor,
  inactiveColor: Colors.blueGrey.shade100,
  thumbShape:
      CustomThumbShape(), // Custom thumb shape for size and splash

  onChanged: (dynamic value) {
    setState(() {
      _value1 = value;
    });
  },
),

//Horizontal Range Slider
SfRangeSlider(
  min: 0.0,
  max: 100.0,
  values: _rangeValuesHorizontal,
  interval: 20,
  showTicks: true,
  showLabels: true,
  enableTooltip: true,
  minorTicksPerInterval: 1,
  activeColor: kInfoColor,
  inactiveColor: Colors.blueGrey.shade100,
  thumbShape:
      CustomThumbShape(), // Custom thumb shape for size and splash
  onChanged: (SfRangeValues values) {
    setState(() {
      _rangeValuesHorizontal = values;
    });
  },
),

//Vertical Slider

SfSlider.vertical(
    min: 0.0,
    max: 100.0,
    value: _value2,
    interval: 20,
    showTicks: true,
    showLabels: true,
    enableTooltip: true,
    minorTicksPerInterval: 1,
    activeColor: kSecondaryColor,
    inactiveColor: Colors.blueGrey.shade100,
    thumbShape:
        CustomThumbShape(), // Custom thumb shape for size and splash

    onChanged: (dynamic value) {
      setState(() {
        _value2 = value;
      });
    },
  ),

  //Vertical Range Slider

  SfRangeSlider.vertical(
    min: 0.0,
    max: 100.0,
    values: _rangeValuesVertical,
    interval: 20,
    showTicks: true,
    showLabels: true,
    enableTooltip: true,
    minorTicksPerInterval: 1,
    activeColor: kSuccessColor,
    inactiveColor: Colors.blueGrey.shade100,
    thumbShape:
        CustomThumbShape(), // Custom thumb shape for size and splash
    onChanged: (SfRangeValues values) {
      setState(() {
        _rangeValuesVertical = values;
      });
    },
  ),
''',
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

class Data {
  final DateTime x;
  final double y;

  Data(this.x, this.y);
}

// Default slider demo
class DefaultSliderDemo extends StatefulWidget {
  const DefaultSliderDemo({super.key});

  @override
  State<DefaultSliderDemo> createState() => _DefaultSliderDemoState();
}

class _DefaultSliderDemoState extends State<DefaultSliderDemo> {
  double _basicSliderValue = 20;
  double _labelSliderValue = 40;
  double _stepsSliderValue = 60;
  final double _disabledSliderValue = 50;

  RangeValues _rangeValues = const RangeValues(20, 80);
  final RangeValues _rangeDisabledValues = const RangeValues(20, 80);
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ResponsiveWrap(
      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
      columnRatios: [0.5, 0.5],
      spacing: kDefaultPadding,
      runSpacing: 2 * kDefaultPadding,
      children: [
        // Basic slider
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Slider',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content: 'Use <code>Slider()</code> to set a slider.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            Slider(
              value: _basicSliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (value) => setState(() => _basicSliderValue = value),
            ),
          ],
        ),

        // Slider with label
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Slider with Label',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Use <code>Slider()</code> and add <code>label</code> argument to set a slider with label.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            Slider(
              value: _labelSliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: _labelSliderValue.round().toString(),
              activeColor: kSecondaryColor,
              onChanged: (value) => setState(() => _labelSliderValue = value),
            ),
          ],
        ),

        // Slider with steps
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Slider with Steps',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Use <code>Slider()</code> and set <code>divisions</code> to set a slider with steps.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            Slider(
              value: _stepsSliderValue,
              min: 0,
              max: 100,
              divisions: 5, // divide to 5 steps
              label: _stepsSliderValue.round().toString(),
              activeColor: kSuccessColor,
              onChanged: (value) => setState(() => _stepsSliderValue = value),
            ),
          ],
        ),

        // Disabled slider
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disabled Slider',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Use <code>Slider()</code> and set <code>onChanged</code> to <code>null</code> to set a disabled slider.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            Slider(
              value: _disabledSliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: _disabledSliderValue.round().toString(),
              onChanged: null, // disabled
            ),
          ],
        ),

        // Range slider
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Range Slider',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content: 'Use <code>RangeSlider()</code> to set a range slider.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            RangeSlider(
              values: _rangeValues,
              min: 0,
              max: 100,
              divisions: 10,
              labels: RangeLabels(
                _rangeValues.start.round().toString(),
                _rangeValues.end.round().toString(),
              ),
              activeColor: kErrorColor,
              onChanged: (values) => setState(() => _rangeValues = values),
            ),
          ],
        ),

        // Disabled range slider
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disabled Range Slider',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Use <code>RangeSlider()</code> and set <code>onChanged</code> to <code>null</code> to set a disabled range slider.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            RangeSlider(
              values: _rangeDisabledValues,
              min: 0,
              max: 100,
              divisions: 10,
              labels: RangeLabels(
                _rangeDisabledValues.start.round().toString(),
                _rangeDisabledValues.end.round().toString(),
              ),
              onChanged: null, // disabled
            ),
          ],
        ),
      ],
    );
  }
}

// custom slider demo
class CustomSliderDemo extends StatefulWidget {
  const CustomSliderDemo({super.key});

  @override
  State<CustomSliderDemo> createState() => _CustomSliderDemoState();
}

class _CustomSliderDemoState extends State<CustomSliderDemo> {
  double _basicSliderValue = 20;
  double _labelSliderValue = 60;
  final double _disabledSliderValue = 50;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ResponsiveWrap(
      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
      columnRatios: [0.5, 0.5],
      spacing: kDefaultPadding,
      runSpacing: 2 * kDefaultPadding,
      children: [
        // Basic slider
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Custom Slider',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Use <code>BorderedTrackShape()</code> and <code>RectangularThumbShape()</code> to set a custom slider.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 16,
                overlayColor: Colors.transparent,
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                // custom track
                trackShape: BorderedTrackShape(
                  fillColor: Colors.grey.shade100,
                  borderColor: Colors.grey.shade300,
                  borderRadius: 4,
                  borderWidth: 1.0,
                ),
                // custom thumb
                thumbShape: RectangularThumbShape(
                  color: kSuccessColor,
                  width: 12,
                  height: 24,
                  borderRadius: 4,
                ),
              ),
              child: Slider(
                value: _basicSliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (value) => setState(() => _basicSliderValue = value),
              ),
            ),
          ],
        ),

        // Slider with label
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Slider with Label',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Use <code>label</code> argument to set a slider with label.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 16,
                overlayColor: Colors.transparent,
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                trackShape: BorderedTrackShape(
                  fillColor: Colors.grey.shade100,
                  borderColor: Colors.grey.shade300,
                  borderRadius: 4,
                  borderWidth: 1.0,
                ),
                thumbShape: RectangularThumbShape(
                  color: kSuccessColor,
                  width: 12,
                  height: 24,
                  borderRadius: 4,
                ),
              ),
              child: Slider(
                value: _labelSliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: _labelSliderValue.round().toString(), // add label
                onChanged: (value) => setState(() => _labelSliderValue = value),
              ),
            ),
          ],
        ),

        // Disabled slider
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disabled Slider',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Set <code>onChanged</code> to <code>null</code> set a disabled slider.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 16,
                overlayColor: Colors.transparent,
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                trackShape: BorderedTrackShape(
                  fillColor: Colors.grey.shade100,
                  borderColor: Colors.grey.shade300,
                  borderRadius: 4,
                  borderWidth: 1.0,
                ),
                thumbShape: RectangularThumbShape(
                  color: kSuccessColor,
                  width: 12,
                  height: 24,
                  borderRadius: 4,
                ),
              ),
              child: Slider(
                value: _disabledSliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: _disabledSliderValue.round().toString(),
                onChanged: null, //disabled
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Syncfusion slider demo
class SyncfusionSliderDemo extends StatefulWidget {
  const SyncfusionSliderDemo({super.key});

  @override
  State<SyncfusionSliderDemo> createState() => _SyncfusionSliderDemoState();
}

class _SyncfusionSliderDemoState extends State<SyncfusionSliderDemo> {
  double _value1 = 40.0;
  double _value2 = 20.0;
  SfRangeValues _rangeValuesHorizontal = const SfRangeValues(40.0, 80.0);
  SfRangeValues _rangeValuesVertical = const SfRangeValues(20.0, 70.0);
  final DateTime dateMin = DateTime(2003, 01, 01);
  final DateTime dateMax = DateTime(2010, 01, 01);
  final SfRangeValues dateValues = SfRangeValues(
    DateTime(2005, 01, 01),
    DateTime(2008, 01, 01),
  );
  // Sample data for the chart
  final List<Data> chartData = [
    Data(DateTime(2003, 01, 01), 2),
    Data(DateTime(2004, 01, 01), 3),
    Data(DateTime(2005, 01, 01), 1),
    Data(DateTime(2006, 01, 01), 4),
    Data(DateTime(2007, 01, 01), 2),
    Data(DateTime(2008, 01, 01), 3),
    Data(DateTime(2009, 01, 01), 2),
    Data(DateTime(2010, 01, 01), 1),
  ];
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ResponsiveWrap(
      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
      columnRatios: [0.5, 0.5],
      spacing: kDefaultPadding,
      runSpacing: 2 * kDefaultPadding,
      children: [
        // Horizontal Slider
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Horizontal Slider',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Use <code>SfSlider()</code> to set a horizontal Syncfusion slider.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            SfSlider(
              min: 0.0,
              max: 100.0,
              value: _value1,
              interval: 20,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              activeColor: kPrimaryColor,
              inactiveColor: Colors.blueGrey.shade100,
              thumbShape:
                  CustomThumbShape(), // Custom thumb shape for size and splash

              onChanged: (dynamic value) {
                setState(() {
                  _value1 = value;
                });
              },
            ),
          ],
        ),

        // Horizontal Range Slider
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Horizontal Range Slider',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Use <code>SfRangeSlider()</code> to set a horizontal range Syncfusion slider.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            //Horizontal Range Slider
            SfRangeSlider(
              min: 0.0,
              max: 100.0,
              values: _rangeValuesHorizontal,
              interval: 20,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              activeColor: kInfoColor,
              inactiveColor: Colors.blueGrey.shade100,
              thumbShape:
                  CustomThumbShape(), // Custom thumb shape for size and splash
              onChanged: (SfRangeValues values) {
                setState(() {
                  _rangeValuesHorizontal = values;
                });
              },
            ),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Vertical Slider',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Use <code>SfSlider.vertical()</code> to set a vertical Syncfusion slider.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            //Vertical Slider
            SizedBox(
              height: 280,
              child: SfSlider.vertical(
                min: 0.0,
                max: 100.0,
                value: _value2,
                interval: 20,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                activeColor: kSecondaryColor,
                inactiveColor: Colors.blueGrey.shade100,
                thumbShape:
                    CustomThumbShape(), // Custom thumb shape for size and splash

                onChanged: (dynamic value) {
                  setState(() {
                    _value2 = value;
                  });
                },
              ),
            ),
          ],
        ),

        // Basic slider
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Vertical Range Slider',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Use <code>SfRangeSlider.vertical()</code> to set a vertical range Syncfusion slider.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            //Vertical Range Slider
            SizedBox(
              height: 280,
              child: SfRangeSlider.vertical(
                min: 0.0,
                max: 100.0,
                values: _rangeValuesVertical,
                interval: 20,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                activeColor: kSuccessColor,
                inactiveColor: Colors.blueGrey.shade100,
                thumbShape:
                    CustomThumbShape(), // Custom thumb shape for size and splash
                onChanged: (SfRangeValues values) {
                  setState(() {
                    _rangeValuesVertical = values;
                  });
                },
              ),
            ),
          ],
        ),

        // Basic slider
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Range Selector Slider',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            CardDescription(
              content:
                  'Use <code>SfRangeSelector()</code> and <code>SfCartesianChart()</code>to set chart range slider.',
            ),
            SizedBox(height: 0.5 * kDefaultPadding),
            //Range Chart Selector Slider
            SfRangeSelector(
              min: dateMin,
              max: dateMax,
              initialValues: dateValues,
              labelPlacement: LabelPlacement.betweenTicks,
              interval: 1,
              dateIntervalType: DateIntervalType.years,
              activeColor: kSuccessColor,

              dateFormat: DateFormat.y(),
              thumbShape:
                  CustomThumbShape(), // Custom thumb shape for size and splash
              showTicks: true,
              showLabels: true,
              child: SizedBox(
                height: 200,
                child: charts.SfCartesianChart(
                  margin: const EdgeInsets.all(0),
                  primaryXAxis: charts.DateTimeAxis(
                    minimum: dateMin,
                    maximum: dateMax,
                    isVisible: false,
                  ),
                  primaryYAxis: const charts.NumericAxis(
                    isVisible: false,
                    maximum: 4,
                  ),
                  series: <charts.SplineAreaSeries<Data, DateTime>>[
                    charts.SplineAreaSeries<Data, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (Data sales, int index) => sales.x,
                      yValueMapper: (Data sales, int index) => sales.y,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
