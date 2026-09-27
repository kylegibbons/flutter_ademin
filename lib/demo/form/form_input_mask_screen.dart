import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/helper/card_description.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_input_mask.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';

class FormInputMaskScreen extends StatefulWidget {
  const FormInputMaskScreen({super.key});

  @override
  State<FormInputMaskScreen> createState() => _FormInputMaskScreenState();
}

class _FormInputMaskScreenState extends State<FormInputMaskScreen> {
  final TextEditingController currencyController = TextEditingController();
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).inputMask; //update your page tittle here
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
                      lang.inputMask.toUpperCase(),
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
                          label: lang.inputMask,
                          uri: RouteUri.inputMask,
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
                //Custom Input Masking
                ShowCodeCard(
                  cardTitle: 'Custom Formatting',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_2(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Credit Card',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      'Use <code>InputMask.creditCard()</code> to set a credit card formatter.',
                                ),
                                const SizedBox(height: kDefaultPadding),
                                // Credit Card
                                CustomTextFormField(
                                  labelText: 'xxxx xxxx xxxx xxxx',
                                  inputFormatters: [InputMask.creditCard()],
                                  suffixIcon: Icons.credit_card_outlined,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delimiter',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      "Use <code>InputMask.delimiter()</code> to set a delimiter formatter.",
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //Delimiter
                                CustomTextFormField(
                                  labelText: 'xxx-xxx-xxx',
                                  inputFormatters: [InputMask.delimiter()],
                                  suffixIcon: Icons.numbers_outlined,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Custom Delimiter',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      "Use <code>InputMask.delimiter(pattern: '###.###.###-####')</code> to set a custom delimiter formatter.",
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //Custom Delimiter
                                CustomTextFormField(
                                  labelText: 'xxx.xxx.xxx-xxxx',
                                  inputFormatters: [
                                    InputMask.delimiter(
                                      pattern: '###.###.###-####',
                                    ),
                                  ],
                                  suffixIcon: Icons.numbers_outlined,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone Format',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      "Use <code>InputMask.phone()</code> to set a phone formatter.",
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //Phone Format
                                CustomTextFormField(
                                  labelText: 'Phone (xxx) xxx-xxxx',
                                  inputFormatters: [InputMask.phone()],
                                  suffixIcon: Icons.phone_enabled_outlined,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
// Credit Card
CustomTextFormField(
  labelText: 'xxxx xxxx xxxx xxxx',
  inputFormatters: [
    InputMask.creditCard(),
  ],
  suffixIcon: Icons.credit_card_outlined,
),

//Delimiter
CustomTextFormField(
  labelText: 'xxx-xxx-xxx',
  inputFormatters: [
    InputMask.delimiter(),
  ],
  suffixIcon: Icons.numbers_outlined,
),

//Custom Delimiter
CustomTextFormField(
  labelText: 'xxx.xxx.xxx-xxxx',
  inputFormatters: [
    InputMask.delimiter(
      pattern: '###.###.###-####',
    )
  ],
  suffixIcon: Icons.numbers_outlined,
),

//Phone Format
CustomTextFormField(
  labelText: 'Phone (xxx) xxx-xxxx',
  inputFormatters: [
    InputMask.phone(),
  ],
  suffixIcon: Icons.phone_enabled_outlined,
),
''',
                ),
                const SizedBox(height: kDefaultPadding),

                ShowCodeCard(
                  cardTitle: 'Currency Formatting',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_2(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'US Dollar (USD)',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      'Use <code>InputMask.currency(currencyCode: "USD")</code> to set a currency formatter.',
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //US Dollar (USD)
                                CustomTextFormField(
                                  labelText: 'Enter Amount',
                                  controller: currencyController,
                                  keyboardType: TextInputType.number,
                                  suffixIcon: Icons.attach_money,
                                  inputFormatters: [
                                    InputMask.currency(currencyCode: 'USD'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Euro (EUR)',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      'Use <code>InputMask.currency(currencyCode: "EUR")</code> to set a currency formatter.',
                                ),
                                const SizedBox(height: kDefaultPadding),
                                //Euro (EUR)
                                CustomTextFormField(
                                  labelText: 'Enter Amount',
                                  keyboardType: TextInputType.number,
                                  suffixIcon: Icons.euro,
                                  inputFormatters: [
                                    InputMask.currency(
                                      currencyCode: 'EUR',
                                      locale: 'de_DE',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rupiah (IDR)',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      'Use <code>InputMask.currency(currencyCode: "IDR")</code> to set a currency formatter.',
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //Rupiah (IDR)
                                CustomTextFormField(
                                  labelText: 'Enter Amount',
                                  keyboardType: TextInputType.number,
                                  suffixIcon: Icons.payment_outlined,
                                  inputFormatters: [
                                    InputMask.currency(
                                      currencyCode: 'IDR',
                                      locale: 'id_ID',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CFA Franc BCEAO (XOF)',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      'Use <code>InputMask.currency(currencyCode: "XOF")</code> to set a currency formatter.',
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //CFA Franc BCEAO (XOF)
                                CustomTextFormField(
                                  labelText: 'Enter Amount',
                                  keyboardType: TextInputType.number,
                                  suffixIcon: Icons.payment_outlined,
                                  inputFormatters: [
                                    InputMask.currency(
                                      currencyCode: 'XOF',
                                      locale: 'fr-CI',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
//US Dollar (USD)
CustomTextFormField(
  labelText: 'Enter Amount',
  controller: currencyController,
  keyboardType: TextInputType.number,
  suffixIcon: Icons.attach_money,
  inputFormatters: [
    InputMask.currency(
      currencyCode: 'USD',
    ),
  ],
),

//Euro (EUR)
CustomTextFormField(
  labelText: 'Enter Amount',
  keyboardType: TextInputType.number,
  suffixIcon: Icons.euro,
  inputFormatters: [
    InputMask.currency(
      currencyCode: 'EUR',
      locale: 'de_DE',
    ),
  ],
),

//Rupiah (IDR)
CustomTextFormField(
  labelText: 'Enter Amount',
  keyboardType: TextInputType.number,
  suffixIcon: Icons.payment_outlined,
  inputFormatters: [
    InputMask.currency(
      currencyCode: 'IDR',
      locale: 'id_ID',
    ),
  ],
),

//CFA Franc BCEAO (XOF)
CustomTextFormField(
  labelText: 'Enter Amount',
  keyboardType: TextInputType.number,
  suffixIcon: Icons.payment_outlined,
  inputFormatters: [
    InputMask.currency(
      currencyCode: 'XOF',
      locale: 'fr-CI',
    ),
  ],
),
''',
                ),
                const SizedBox(height: kDefaultPadding),

                //Date Time Input Masking
                ShowCodeCard(
                  cardTitle: 'Date Time Formatting',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_2(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'USA Format Date (MM/DD/YYYY)',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      'Use <code>InputMask.date()</code> to set a date formatter.',
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //USA Format Date (MM/DD/YYYY)
                                CustomTextFormField(
                                  labelText: 'Date (MM/DD/YYYY)',
                                  suffixIcon: Icons.calendar_month_outlined,
                                  inputFormatters: [
                                    InputMask.date(dateFormat: '##/##/####'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ISO JIS Date Format (YYYY-MM-DD)',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      "Use <code>InputMask.date(pattern: '####-##-##')</code> to set a date formatter.",
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //ISO JIS Date Format (YYYY-MM-DD)
                                CustomTextFormField(
                                  labelText: 'Date (YYYY-MM-DD)',
                                  suffixIcon: Icons.calendar_month_outlined,
                                  inputFormatters: [
                                    InputMask.date(dateFormat: '####-##-##'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'EUR Date Format (DD.MM.YYYY)',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      "Use <code>InputMask.date(pattern: '##.##.####')</code> to set a date formatter.",
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //EUR Date Format (DD.MM.YYYY)
                                CustomTextFormField(
                                  labelText: 'Date (DD.MM.YYYY)',
                                  suffixIcon: Icons.calendar_month_outlined,
                                  inputFormatters: [
                                    InputMask.date(dateFormat: '##.##.####'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Custom Date Format MM-DD-YYYY',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      "Use <code>InputMask.date(pattern: '##-##-####')</code> to set a date formatter.",
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //Custom Date Format MM-DD-YYYY
                                CustomTextFormField(
                                  labelText: 'Date (MM-DD-YYYY)',
                                  suffixIcon: Icons.calendar_month_outlined,
                                  inputFormatters: [
                                    InputMask.date(dateFormat: '##-##-####'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time Format HH:mm:ss',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      "Use <code>InputMask.time()</code> to set a time formatter.",
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //Time Format HH:mm:ss
                                CustomTextFormField(
                                  labelText: 'Time (HH:mm:ss)',
                                  suffixIcon: Icons.alarm_on_outlined,
                                  inputFormatters: [InputMask.time()],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time Format HH:mm',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const CardDescription(
                                  content:
                                      "Use <code>InputMask.time(pattern: 'HH:mm')</code> to set a time formatter.",
                                ),
                                const SizedBox(height: kDefaultPadding),

                                //Time Format HH:mm
                                CustomTextFormField(
                                  labelText: 'Time (HH:mm)',
                                  suffixIcon: Icons.alarm_on_outlined,
                                  inputFormatters: [
                                    InputMask.time(timeFormat: '##:##'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
//USA Format Date (MM/DD/YYYY)
CustomTextFormField(
  labelText: 'Date (MM/DD/YYYY)',
  suffixIcon: Icons.calendar_month_outlined,
  inputFormatters: [
    InputMask.date(dateFormat: '##/##/####')
  ],
),

//ISO JIS Date Format (YYYY-MM-DD)
CustomTextFormField(
  labelText: 'Date (YYYY-MM-DD)',
  suffixIcon: Icons.calendar_month_outlined,
  inputFormatters: [
    InputMask.date(dateFormat: '####-##-##')
  ],
),

//EUR Date Format (DD.MM.YYYY)
CustomTextFormField(
  labelText: 'Date (DD.MM.YYYY)',
  suffixIcon: Icons.calendar_month_outlined,
  inputFormatters: [
    InputMask.date(dateFormat: '##.##.####')
  ],
),

//Custom Date Format MM-DD-YYYY
CustomTextFormField(
  labelText: 'Date (MM-DD-YYYY)',
  suffixIcon: Icons.calendar_month_outlined,
  inputFormatters: [
    InputMask.date(dateFormat: '##-##-####')
  ],
),

//Time Format HH:mm:ss
CustomTextFormField(
  labelText: 'Time (HH:mm:ss)',
  suffixIcon: Icons.alarm_on_outlined,
  inputFormatters: [InputMask.time()],
),

//Time Format HH:mm
CustomTextFormField(
  labelText: 'Time (HH:mm)',
  suffixIcon: Icons.alarm_on_outlined,
  inputFormatters: [
    InputMask.time(timeFormat: '##:##')
  ],
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
