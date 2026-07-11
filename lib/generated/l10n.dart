// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Lang {
  Lang();

  static Lang? _current;

  static Lang get current {
    assert(
      _current != null,
      'No instance of Lang was loaded. Try to initialize the Lang delegate before accessing Lang.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Lang> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Lang();
      Lang._current = instance;

      return instance;
    });
  }

  static Lang of(BuildContext context) {
    final instance = Lang.maybeOf(context);
    assert(
      instance != null,
      'No instance of Lang present in the widget tree. Did you add Lang.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static Lang? maybeOf(BuildContext context) {
    return Localizations.of<Lang>(context, Lang);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Admin Portal Login`
  String get adminPortalLogin {
    return Intl.message(
      'Admin Portal Login',
      name: 'adminPortalLogin',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Button Emphasis`
  String get buttonEmphasis {
    return Intl.message(
      'Button Emphasis',
      name: 'buttonEmphasis',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Button} other{Buttons}}`
  String buttons(num count) {
    return Intl.plural(
      count,
      one: 'Button',
      other: 'Buttons',
      name: 'buttons',
      desc: '',
      args: [count],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Close Navigation Menu`
  String get closeNavigationMenu {
    return Intl.message(
      'Close Navigation Menu',
      name: 'closeNavigationMenu',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Color} other{Colors}}`
  String colors(num count) {
    return Intl.plural(
      count,
      one: 'Color',
      other: 'Colors',
      name: 'colors',
      desc: '',
      args: [count],
    );
  }

  /// `Color Palette`
  String get colorPalette {
    return Intl.message(
      'Color Palette',
      name: 'colorPalette',
      desc: '',
      args: [],
    );
  }

  /// `Color Scheme`
  String get colorScheme {
    return Intl.message(
      'Color Scheme',
      name: 'colorScheme',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete this record?`
  String get confirmDeleteRecord {
    return Intl.message(
      'Confirm delete this record?',
      name: 'confirmDeleteRecord',
      desc: '',
      args: [],
    );
  }

  /// `Confirm submit this record?`
  String get confirmSubmitRecord {
    return Intl.message(
      'Confirm submit this record?',
      name: 'confirmSubmitRecord',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `This field requires a valid credit card number.`
  String get creditCardErrorText {
    return Intl.message(
      'This field requires a valid credit card number.',
      name: 'creditCardErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get crudBack {
    return Intl.message('Back', name: 'crudBack', desc: '', args: []);
  }

  /// `Delete`
  String get crudDelete {
    return Intl.message('Delete', name: 'crudDelete', desc: '', args: []);
  }

  /// `Detail`
  String get crudDetail {
    return Intl.message('Detail', name: 'crudDetail', desc: '', args: []);
  }

  /// `New`
  String get crudNew {
    return Intl.message('New', name: 'crudNew', desc: '', args: []);
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message('Dark Theme', name: 'darkTheme', desc: '', args: []);
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `This field requires a valid date string.`
  String get dateStringErrorText {
    return Intl.message(
      'This field requires a valid date string.',
      name: 'dateStringErrorText',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Dialog} other{Dialogs}}`
  String dialogs(num count) {
    return Intl.plural(
      count,
      one: 'Dialog',
      other: 'Dialogs',
      name: 'dialogs',
      desc: '',
      args: [count],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `This field requires a valid email address.`
  String get emailErrorText {
    return Intl.message(
      'This field requires a valid email address.',
      name: 'emailErrorText',
      desc: '',
      args: [],
    );
  }

  /// `This field value must be equal to {value}.`
  String equalErrorText(Object value) {
    return Intl.message(
      'This field value must be equal to $value.',
      name: 'equalErrorText',
      desc: '',
      args: [value],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Error 404`
  String get error404 {
    return Intl.message('Error 404', name: 'error404', desc: '', args: []);
  }

  /// `Error 500`
  String get error500 {
    return Intl.message('Error 500', name: 'error500', desc: '', args: []);
  }

  /// `Error 503`
  String get error503 {
    return Intl.message('Error 503', name: 'error503', desc: '', args: []);
  }

  /// `Sorry, the page you are looking for has been removed or not exists.`
  String get error404Message {
    return Intl.message(
      'Sorry, the page you are looking for has been removed or not exists.',
      name: 'error404Message',
      desc: '',
      args: [],
    );
  }

  /// `Page not found`
  String get error404Title {
    return Intl.message(
      'Page not found',
      name: 'error404Title',
      desc: '',
      args: [],
    );
  }

  /// `Example`
  String get example {
    return Intl.message('Example', name: 'example', desc: '', args: []);
  }

  /// `{count, plural, one{Extension} other{Extensions}}`
  String extensions(num count) {
    return Intl.plural(
      count,
      one: 'Extension',
      other: 'Extensions',
      name: 'extensions',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{Form} other{Forms}}`
  String forms(num count) {
    return Intl.plural(
      count,
      one: 'Form',
      other: 'Forms',
      name: 'forms',
      desc: '',
      args: [count],
    );
  }

  /// `General UI`
  String get generalUi {
    return Intl.message('General UI', name: 'generalUi', desc: '', args: []);
  }

  /// `Hi`
  String get hi {
    return Intl.message('Hi', name: 'hi', desc: '', args: []);
  }

  /// `Home`
  String get homePage {
    return Intl.message('Home', name: 'homePage', desc: '', args: []);
  }

  /// `IFrame Demo`
  String get iframeDemo {
    return Intl.message('IFrame Demo', name: 'iframeDemo', desc: '', args: []);
  }

  /// `This field requires a valid integer.`
  String get integerErrorText {
    return Intl.message(
      'This field requires a valid integer.',
      name: 'integerErrorText',
      desc: '',
      args: [],
    );
  }

  /// `This field requires a valid IP.`
  String get ipErrorText {
    return Intl.message(
      'This field requires a valid IP.',
      name: 'ipErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Light Theme`
  String get lightTheme {
    return Intl.message('Light Theme', name: 'lightTheme', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Login now!`
  String get loginNow {
    return Intl.message('Login now!', name: 'loginNow', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Lorem ipsum dolor sit amet, consectetur adipiscing elit`
  String get loremIpsum {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      name: 'loremIpsum',
      desc: '',
      args: [],
    );
  }

  /// `Value does not match pattern.`
  String get matchErrorText {
    return Intl.message(
      'Value does not match pattern.',
      name: 'matchErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Value must be less than or equal to {max}`
  String maxErrorText(Object max) {
    return Intl.message(
      'Value must be less than or equal to $max',
      name: 'maxErrorText',
      desc: '',
      args: [max],
    );
  }

  /// `Value must have a length less than or equal to {maxLength}`
  String maxLengthErrorText(Object maxLength) {
    return Intl.message(
      'Value must have a length less than or equal to $maxLength',
      name: 'maxLengthErrorText',
      desc: '',
      args: [maxLength],
    );
  }

  /// `Value must be greater than or equal to {min}.`
  String minErrorText(Object min) {
    return Intl.message(
      'Value must be greater than or equal to $min.',
      name: 'minErrorText',
      desc: '',
      args: [min],
    );
  }

  /// `Value must have a length greater than or equal to {minLength}`
  String minLengthErrorText(Object minLength) {
    return Intl.message(
      'Value must have a length greater than or equal to $minLength',
      name: 'minLengthErrorText',
      desc: '',
      args: [minLength],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message('My Profile', name: 'myProfile', desc: '', args: []);
  }

  /// `{count, plural, one{New Order} other{New Orders}}`
  String newOrders(num count) {
    return Intl.plural(
      count,
      one: 'New Order',
      other: 'New Orders',
      name: 'newOrders',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{New User} other{New Users}}`
  String newUsers(num count) {
    return Intl.plural(
      count,
      one: 'New User',
      other: 'New Users',
      name: 'newUsers',
      desc: '',
      args: [count],
    );
  }

  /// `This field value must not be equal to {value}.`
  String notEqualErrorText(Object value) {
    return Intl.message(
      'This field value must not be equal to $value.',
      name: 'notEqualErrorText',
      desc: '',
      args: [value],
    );
  }

  /// `Value must be numeric.`
  String get numericErrorText {
    return Intl.message(
      'Value must be numeric.',
      name: 'numericErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Open in new tab`
  String get openInNewTab {
    return Intl.message(
      'Open in new tab',
      name: 'openInNewTab',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Page} other{Pages}}`
  String pages(num count) {
    return Intl.plural(
      count,
      one: 'Page',
      other: 'Pages',
      name: 'pages',
      desc: '',
      args: [count],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `* 6 - 18 characters`
  String get passwordHelperText {
    return Intl.message(
      '* 6 - 18 characters',
      name: 'passwordHelperText',
      desc: '',
      args: [],
    );
  }

  /// `Password not match.`
  String get passwordNotMatch {
    return Intl.message(
      'Password not match.',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Pending Issue} other{Pending Issues}}`
  String pendingIssues(num count) {
    return Intl.plural(
      count,
      one: 'Pending Issue',
      other: 'Pending Issues',
      name: 'pendingIssues',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{Recent Order} other{Recent Orders}}`
  String recentOrders(num count) {
    return Intl.plural(
      count,
      one: 'Recent Order',
      other: 'Recent Orders',
      name: 'recentOrders',
      desc: '',
      args: [count],
    );
  }

  /// `Record deleted successfully.`
  String get recordDeletedSuccessfully {
    return Intl.message(
      'Record deleted successfully.',
      name: 'recordDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Record saved successfully.`
  String get recordSavedSuccessfully {
    return Intl.message(
      'Record saved successfully.',
      name: 'recordSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Record submitted successfully.`
  String get recordSubmittedSuccessfully {
    return Intl.message(
      'Record submitted successfully.',
      name: 'recordSubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Register a new account`
  String get registerANewAccount {
    return Intl.message(
      'Register a new account',
      name: 'registerANewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register now!`
  String get registerNow {
    return Intl.message(
      'Register now!',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `This field cannot be empty.`
  String get requiredErrorText {
    return Intl.message(
      'This field cannot be empty.',
      name: 'requiredErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Retype Password`
  String get retypePassword {
    return Intl.message(
      'Retype Password',
      name: 'retypePassword',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Text`
  String get text {
    return Intl.message('Text', name: 'text', desc: '', args: []);
  }

  /// `Text Emphasis`
  String get textEmphasis {
    return Intl.message(
      'Text Emphasis',
      name: 'textEmphasis',
      desc: '',
      args: [],
    );
  }

  /// `Text Theme`
  String get textTheme {
    return Intl.message('Text Theme', name: 'textTheme', desc: '', args: []);
  }

  /// `Today Sales`
  String get todaySales {
    return Intl.message('Today Sales', name: 'todaySales', desc: '', args: []);
  }

  /// `Typography`
  String get typography {
    return Intl.message('Typography', name: 'typography', desc: '', args: []);
  }

  /// `{count, plural, one{UI Element} other{UI Elements}}`
  String uiElements(num count) {
    return Intl.plural(
      count,
      one: 'UI Element',
      other: 'UI Elements',
      name: 'uiElements',
      desc: '',
      args: [count],
    );
  }

  /// `This field requires a valid URL address.`
  String get urlErrorText {
    return Intl.message(
      'This field requires a valid URL address.',
      name: 'urlErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `Tables`
  String get tables {
    return Intl.message('Tables', name: 'tables', desc: '', args: []);
  }

  /// `{count, plural, one{Project} other{Projects}}`
  String project(num count) {
    return Intl.plural(
      count,
      one: 'Project',
      other: 'Projects',
      name: 'project',
      desc: '',
      args: [count],
    );
  }

  /// `Starter Page`
  String get starterPage {
    return Intl.message(
      'Starter Page',
      name: 'starterPage',
      desc: '',
      args: [],
    );
  }

  /// `File Upload`
  String get fileUpload {
    return Intl.message('File Upload', name: 'fileUpload', desc: '', args: []);
  }

  /// `Form Layout`
  String get formLayout {
    return Intl.message('Form Layout', name: 'formLayout', desc: '', args: []);
  }

  /// `Editors`
  String get formEditor {
    return Intl.message('Editors', name: 'formEditor', desc: '', args: []);
  }

  /// `Badges`
  String get badge {
    return Intl.message('Badges', name: 'badge', desc: '', args: []);
  }

  /// `Base UI`
  String get baseUI {
    return Intl.message('Base UI', name: 'baseUI', desc: '', args: []);
  }

  /// `Alerts`
  String get alerts {
    return Intl.message('Alerts', name: 'alerts', desc: '', args: []);
  }

  /// `Cards`
  String get cards {
    return Intl.message('Cards', name: 'cards', desc: '', args: []);
  }

  /// `Carousels`
  String get carousels {
    return Intl.message('Carousels', name: 'carousels', desc: '', args: []);
  }

  /// `Dropdowns`
  String get dropdown {
    return Intl.message('Dropdowns', name: 'dropdown', desc: '', args: []);
  }

  /// `Images`
  String get image {
    return Intl.message('Images', name: 'image', desc: '', args: []);
  }

  /// `Tabs`
  String get tab {
    return Intl.message('Tabs', name: 'tab', desc: '', args: []);
  }

  /// `Accordions`
  String get accordion {
    return Intl.message('Accordions', name: 'accordion', desc: '', args: []);
  }

  /// `Dialogs`
  String get dialog {
    return Intl.message('Dialogs', name: 'dialog', desc: '', args: []);
  }

  /// `Slidings`
  String get sliding {
    return Intl.message('Slidings', name: 'sliding', desc: '', args: []);
  }

  /// `Progress`
  String get progress {
    return Intl.message('Progress', name: 'progress', desc: '', args: []);
  }

  /// `Toasts`
  String get toast {
    return Intl.message('Toasts', name: 'toast', desc: '', args: []);
  }

  /// `Embed`
  String get embed {
    return Intl.message('Embed', name: 'embed', desc: '', args: []);
  }

  /// `List`
  String get list {
    return Intl.message('List', name: 'list', desc: '', args: []);
  }

  /// `Ribbons`
  String get ribbon {
    return Intl.message('Ribbons', name: 'ribbon', desc: '', args: []);
  }

  /// `Basic Form`
  String get basicElement {
    return Intl.message('Basic Form', name: 'basicElement', desc: '', args: []);
  }

  /// `Form Select`
  String get formSelect {
    return Intl.message('Form Select', name: 'formSelect', desc: '', args: []);
  }

  /// `Checkboxes & Radios`
  String get checkboxRadio {
    return Intl.message(
      'Checkboxes & Radios',
      name: 'checkboxRadio',
      desc: '',
      args: [],
    );
  }

  /// `Pickers`
  String get picker {
    return Intl.message('Pickers', name: 'picker', desc: '', args: []);
  }

  /// `Input Masks`
  String get inputMask {
    return Intl.message('Input Masks', name: 'inputMask', desc: '', args: []);
  }

  /// `Slider`
  String get slider {
    return Intl.message('Slider', name: 'slider', desc: '', args: []);
  }

  /// `Validations`
  String get validation {
    return Intl.message('Validations', name: 'validation', desc: '', args: []);
  }

  /// `Form Validations`
  String get formValidation {
    return Intl.message(
      'Form Validations',
      name: 'formValidation',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get requiredField {
    return Intl.message(
      'This field is required',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an email`
  String get enterEmail {
    return Intl.message(
      'Please enter an email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least {minLength} characters long`
  String minLength(Object minLength) {
    return Intl.message(
      'Must be at least $minLength characters long',
      name: 'minLength',
      desc: '',
      args: [minLength],
    );
  }

  /// `Must be less than {maxLength} characters long`
  String maxLength(Object maxLength) {
    return Intl.message(
      'Must be less than $maxLength characters long',
      name: 'maxLength',
      desc: '',
      args: [maxLength],
    );
  }

  /// `Must be a valid number`
  String get validNumber {
    return Intl.message(
      'Must be a valid number',
      name: 'validNumber',
      desc: '',
      args: [],
    );
  }

  /// `Must be alphanumeric`
  String get alphanumeric {
    return Intl.message(
      'Must be alphanumeric',
      name: 'alphanumeric',
      desc: '',
      args: [],
    );
  }

  /// `Invalid format`
  String get invalidFormat {
    return Intl.message(
      'Invalid format',
      name: 'invalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `Password must be 8+ characters, with uppercase, lowercase, number, and symbol.`
  String get strongPassword {
    return Intl.message(
      'Password must be 8+ characters, with uppercase, lowercase, number, and symbol.',
      name: 'strongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a phone number`
  String get enterPhone {
    return Intl.message(
      'Please enter a phone number',
      name: 'enterPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get invalidPhone {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Values do not match`
  String get valuesDoNotMatch {
    return Intl.message(
      'Values do not match',
      name: 'valuesDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid URL`
  String get invalidURL {
    return Intl.message(
      'Please enter a valid URL',
      name: 'invalidURL',
      desc: '',
      args: [],
    );
  }

  /// `Wizard`
  String get wizard {
    return Intl.message('Wizard', name: 'wizard', desc: '', args: []);
  }

  /// `Charts`
  String get chart {
    return Intl.message('Charts', name: 'chart', desc: '', args: []);
  }

  /// `Line Chart`
  String get line {
    return Intl.message('Line Chart', name: 'line', desc: '', args: []);
  }

  /// `Column Chart`
  String get columnChart {
    return Intl.message(
      'Column Chart',
      name: 'columnChart',
      desc: '',
      args: [],
    );
  }

  /// `Spline Chart`
  String get splineChart {
    return Intl.message(
      'Spline Chart',
      name: 'splineChart',
      desc: '',
      args: [],
    );
  }

  /// `Area Chart`
  String get areaChart {
    return Intl.message('Area Chart', name: 'areaChart', desc: '', args: []);
  }

  /// `Bar Chart`
  String get barChart {
    return Intl.message('Bar Chart', name: 'barChart', desc: '', args: []);
  }

  /// `Bubble Chart`
  String get bubbleChart {
    return Intl.message(
      'Bubble Chart',
      name: 'bubbleChart',
      desc: '',
      args: [],
    );
  }

  /// `Scatter Chart`
  String get scatterChart {
    return Intl.message(
      'Scatter Chart',
      name: 'scatterChart',
      desc: '',
      args: [],
    );
  }

  /// `Error Bar Chart`
  String get errorChart {
    return Intl.message(
      'Error Bar Chart',
      name: 'errorChart',
      desc: '',
      args: [],
    );
  }

  /// `Step Line Chart`
  String get stepLineChart {
    return Intl.message(
      'Step Line Chart',
      name: 'stepLineChart',
      desc: '',
      args: [],
    );
  }

  /// `Range Column Chart`
  String get rangeColumnChart {
    return Intl.message(
      'Range Column Chart',
      name: 'rangeColumnChart',
      desc: '',
      args: [],
    );
  }

  /// `Financial Chart`
  String get financialChart {
    return Intl.message(
      'Financial Chart',
      name: 'financialChart',
      desc: '',
      args: [],
    );
  }

  /// `Histogram Chart`
  String get histogramChart {
    return Intl.message(
      'Histogram Chart',
      name: 'histogramChart',
      desc: '',
      args: [],
    );
  }

  /// `Basic Table`
  String get basicTable {
    return Intl.message('Basic Table', name: 'basicTable', desc: '', args: []);
  }

  /// `Drag Drop Table`
  String get dragColumnTable {
    return Intl.message(
      'Drag Drop Table',
      name: 'dragColumnTable',
      desc: '',
      args: [],
    );
  }

  /// `Stacked Header Table`
  String get stackedHeaderTable {
    return Intl.message(
      'Stacked Header Table',
      name: 'stackedHeaderTable',
      desc: '',
      args: [],
    );
  }

  /// `Checkbox Table`
  String get checkboxColumbTable {
    return Intl.message(
      'Checkbox Table',
      name: 'checkboxColumbTable',
      desc: '',
      args: [],
    );
  }

  /// `Editable Table`
  String get editableTable {
    return Intl.message(
      'Editable Table',
      name: 'editableTable',
      desc: '',
      args: [],
    );
  }

  /// `Filtering Table`
  String get filteringTable {
    return Intl.message(
      'Filtering Table',
      name: 'filteringTable',
      desc: '',
      args: [],
    );
  }

  /// `Summaries Table`
  String get summariesTable {
    return Intl.message(
      'Summaries Table',
      name: 'summariesTable',
      desc: '',
      args: [],
    );
  }

  /// `Resizing Tabel`
  String get resizingTable {
    return Intl.message(
      'Resizing Tabel',
      name: 'resizingTable',
      desc: '',
      args: [],
    );
  }

  /// `Styling Tabel`
  String get stylingTable {
    return Intl.message(
      'Styling Tabel',
      name: 'stylingTable',
      desc: '',
      args: [],
    );
  }

  /// `Authentication`
  String get authentication {
    return Intl.message(
      'Authentication',
      name: 'authentication',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signin {
    return Intl.message('Sign In', name: 'signin', desc: '', args: []);
  }

  /// `Basic`
  String get basic {
    return Intl.message('Basic', name: 'basic', desc: '', args: []);
  }

  /// `Sign Up`
  String get signup {
    return Intl.message('Sign Up', name: 'signup', desc: '', args: []);
  }

  /// `Password Reset`
  String get passwordReset {
    return Intl.message(
      'Password Reset',
      name: 'passwordReset',
      desc: '',
      args: [],
    );
  }

  /// `Password Create`
  String get passwordCreate {
    return Intl.message(
      'Password Create',
      name: 'passwordCreate',
      desc: '',
      args: [],
    );
  }

  /// `Screen Lock`
  String get screenLock {
    return Intl.message('Screen Lock', name: 'screenLock', desc: '', args: []);
  }

  /// `2-Steps Verification`
  String get twoStepsVerification {
    return Intl.message(
      '2-Steps Verification',
      name: 'twoStepsVerification',
      desc: '',
      args: [],
    );
  }

  /// `Team`
  String get team {
    return Intl.message('Team', name: 'team', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Timeline`
  String get timeline {
    return Intl.message('Timeline', name: 'timeline', desc: '', args: []);
  }

  /// `FAQs`
  String get faqs {
    return Intl.message('FAQs', name: 'faqs', desc: '', args: []);
  }

  /// `Pricing`
  String get pricing {
    return Intl.message('Pricing', name: 'pricing', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Maintenance`
  String get maintenance {
    return Intl.message('Maintenance', name: 'maintenance', desc: '', args: []);
  }

  /// `Coming Soon`
  String get comingSoon {
    return Intl.message('Coming Soon', name: 'comingSoon', desc: '', args: []);
  }

  /// `Search Result`
  String get searchResult {
    return Intl.message(
      'Search Result',
      name: 'searchResult',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termConditions',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message('Calendar', name: 'calendar', desc: '', args: []);
  }

  /// `{count, plural, one{App} other{Apps}}`
  String apps(num count) {
    return Intl.plural(
      count,
      one: 'App',
      other: 'Apps',
      name: 'apps',
      desc: '',
      args: [count],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message('Chat', name: 'chat', desc: '', args: []);
  }

  /// `Project List`
  String get projectList {
    return Intl.message(
      'Project List',
      name: 'projectList',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get detail {
    return Intl.message('Details', name: 'detail', desc: '', args: []);
  }

  /// `Kanban Board`
  String get kanbanBoard {
    return Intl.message(
      'Kanban Board',
      name: 'kanbanBoard',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task {
    return Intl.message('Task', name: 'task', desc: '', args: []);
  }

  /// `List View`
  String get listView {
    return Intl.message('List View', name: 'listView', desc: '', args: []);
  }

  /// `Task List`
  String get taskList {
    return Intl.message('Task List', name: 'taskList', desc: '', args: []);
  }

  /// `Crypto`
  String get crypto {
    return Intl.message('Crypto', name: 'crypto', desc: '', args: []);
  }

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: '',
      args: [],
    );
  }

  /// `Buy Sell`
  String get buySell {
    return Intl.message('Buy Sell', name: 'buySell', desc: '', args: []);
  }

  /// `My Wallet`
  String get myWallet {
    return Intl.message('My Wallet', name: 'myWallet', desc: '', args: []);
  }

  /// `{count, plural, one{Invoice} other{Invoices}}`
  String invoices(num count) {
    return Intl.plural(
      count,
      one: 'Invoice',
      other: 'Invoices',
      name: 'invoices',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{Support} other{Supports}}`
  String support(num count) {
    return Intl.plural(
      count,
      one: 'Support',
      other: 'Supports',
      name: 'support',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{Ticket} other{Tickets}}`
  String ticket(num count) {
    return Intl.plural(
      count,
      one: 'Ticket',
      other: 'Tickets',
      name: 'ticket',
      desc: '',
      args: [count],
    );
  }

  /// `Analytics`
  String get analytics {
    return Intl.message('Analytics', name: 'analytics', desc: '', args: []);
  }

  /// `CRM`
  String get crm {
    return Intl.message('CRM', name: 'crm', desc: '', args: []);
  }

  /// `Ecommerce`
  String get ecommerce {
    return Intl.message('Ecommerce', name: 'ecommerce', desc: '', args: []);
  }

  /// `NFT`
  String get nft {
    return Intl.message('NFT', name: 'nft', desc: '', args: []);
  }

  /// `Dropdown Form`
  String get formDropdown {
    return Intl.message(
      'Dropdown Form',
      name: 'formDropdown',
      desc: '',
      args: [],
    );
  }

  /// `Drop files here or click to upload`
  String get dropFiles {
    return Intl.message(
      'Drop files here or click to upload',
      name: 'dropFiles',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{Choose File} other{Choose Files}}`
  String chooseFile(num count) {
    return Intl.plural(
      count,
      one: 'Choose File',
      other: 'Choose Files',
      name: 'chooseFile',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{file selected} other{files selected}}`
  String filesSelected(num count) {
    return Intl.plural(
      count,
      one: 'file selected',
      other: 'files selected',
      name: 'filesSelected',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{No file selected} other{No files selected}}`
  String noFilesSelected(num count) {
    return Intl.plural(
      count,
      one: 'No file selected',
      other: 'No files selected',
      name: 'noFilesSelected',
      desc: '',
      args: [count],
    );
  }

  /// `Looks good!`
  String get successValidationMessage {
    return Intl.message(
      'Looks good!',
      name: 'successValidationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Finish`
  String get finish {
    return Intl.message('Finish', name: 'finish', desc: '', args: []);
  }

  /// `Layout`
  String get layout {
    return Intl.message('Layout', name: 'layout', desc: '', args: []);
  }

  /// `Create Project`
  String get createProject {
    return Intl.message(
      'Create Project',
      name: 'createProject',
      desc: '',
      args: [],
    );
  }

  /// `Chip`
  String get chip {
    return Intl.message('Chip', name: 'chip', desc: '', args: []);
  }

  /// `Designed & Developed by`
  String get designedBy {
    return Intl.message(
      'Designed & Developed by',
      name: 'designedBy',
      desc: '',
      args: [],
    );
  }

  /// `Labs Page`
  String get labs {
    return Intl.message('Labs Page', name: 'labs', desc: '', args: []);
  }

  /// `Form Control`
  String get formControl {
    return Intl.message(
      'Form Control',
      name: 'formControl',
      desc: '',
      args: [],
    );
  }

  /// `File Manager`
  String get fileManager {
    return Intl.message(
      'File Manager',
      name: 'fileManager',
      desc: '',
      args: [],
    );
  }

  /// `Integration`
  String get integration {
    return Intl.message('Integration', name: 'integration', desc: '', args: []);
  }

  /// `AI Assistant`
  String get aiAssistant {
    return Intl.message(
      'AI Assistant',
      name: 'aiAssistant',
      desc: '',
      args: [],
    );
  }

  /// `SaaS`
  String get saas {
    return Intl.message('SaaS', name: 'saas', desc: '', args: []);
  }

  /// `User Management`
  String get userManagement {
    return Intl.message(
      'User Management',
      name: 'userManagement',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Management`
  String get subscriptionManagement {
    return Intl.message(
      'Subscription Management',
      name: 'subscriptionManagement',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message('System', name: 'system', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Local Notifications`
  String get localNotifications {
    return Intl.message(
      'Local Notifications',
      name: 'localNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Billing`
  String get billing {
    return Intl.message('Billing', name: 'billing', desc: '', args: []);
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `AI Reference`
  String get aiReference {
    return Intl.message(
      'AI Reference',
      name: 'aiReference',
      desc: '',
      args: [],
    );
  }

  /// `Documentation`
  String get documentation {
    return Intl.message(
      'Documentation',
      name: 'documentation',
      desc: '',
      args: [],
    );
  }

  /// `Management`
  String get management {
    return Intl.message('Management', name: 'management', desc: '', args: []);
  }

  /// `Grid View`
  String get gridView {
    return Intl.message('Grid View', name: 'gridView', desc: '', args: []);
  }

  /// `Gantt Chart`
  String get ganttChart {
    return Intl.message('Gantt Chart', name: 'ganttChart', desc: '', args: []);
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Lang> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'id'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Lang> load(Locale locale) => Lang.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
