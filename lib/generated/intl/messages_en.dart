// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "${Intl.plural(count, one: 'App', other: 'Apps')}";

  static String m1(count) =>
      "${Intl.plural(count, one: 'Button', other: 'Buttons')}";

  static String m2(count) =>
      "${Intl.plural(count, one: 'Choose File', other: 'Choose Files')}";

  static String m3(count) =>
      "${Intl.plural(count, one: 'Color', other: 'Colors')}";

  static String m4(count) =>
      "${Intl.plural(count, one: 'Dialog', other: 'Dialogs')}";

  static String m5(value) => "This field value must be equal to ${value}.";

  static String m6(count) =>
      "${Intl.plural(count, one: 'Extension', other: 'Extensions')}";

  static String m7(count) =>
      "${Intl.plural(count, one: 'file selected', other: 'files selected')}";

  static String m8(count) =>
      "${Intl.plural(count, one: 'Form', other: 'Forms')}";

  static String m9(count) =>
      "${Intl.plural(count, one: 'Invoice', other: 'Invoices')}";

  static String m10(max) => "Value must be less than or equal to ${max}";

  static String m11(maxLength) =>
      "Must be less than ${maxLength} characters long";

  static String m12(maxLength) =>
      "Value must have a length less than or equal to ${maxLength}";

  static String m13(min) => "Value must be greater than or equal to ${min}.";

  static String m14(minLength) =>
      "Must be at least ${minLength} characters long";

  static String m15(minLength) =>
      "Value must have a length greater than or equal to ${minLength}";

  static String m16(count) =>
      "${Intl.plural(count, one: 'New Order', other: 'New Orders')}";

  static String m17(count) =>
      "${Intl.plural(count, one: 'New User', other: 'New Users')}";

  static String m18(count) =>
      "${Intl.plural(count, one: 'No file selected', other: 'No files selected')}";

  static String m19(value) => "This field value must not be equal to ${value}.";

  static String m20(count) =>
      "${Intl.plural(count, one: 'Page', other: 'Pages')}";

  static String m21(count) =>
      "${Intl.plural(count, one: 'Pending Issue', other: 'Pending Issues')}";

  static String m22(count) =>
      "${Intl.plural(count, one: 'Project', other: 'Projects')}";

  static String m23(count) =>
      "${Intl.plural(count, one: 'Recent Order', other: 'Recent Orders')}";

  static String m24(count) =>
      "${Intl.plural(count, one: 'Support', other: 'Supports')}";

  static String m25(count) =>
      "${Intl.plural(count, one: 'Ticket', other: 'Tickets')}";

  static String m26(count) =>
      "${Intl.plural(count, one: 'UI Element', other: 'UI Elements')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accordion": MessageLookupByLibrary.simpleMessage("Accordions"),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "adminPortalLogin": MessageLookupByLibrary.simpleMessage(
      "Admin Portal Login",
    ),
    "aiAssistant": MessageLookupByLibrary.simpleMessage("AI Assistant"),
    "aiReference": MessageLookupByLibrary.simpleMessage("AI Reference"),
    "alerts": MessageLookupByLibrary.simpleMessage("Alerts"),
    "alphanumeric": MessageLookupByLibrary.simpleMessage(
      "Must be alphanumeric",
    ),
    "analytics": MessageLookupByLibrary.simpleMessage("Analytics"),
    "apps": m0,
    "areaChart": MessageLookupByLibrary.simpleMessage("Area Chart"),
    "authentication": MessageLookupByLibrary.simpleMessage("Authentication"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "backToLogin": MessageLookupByLibrary.simpleMessage("Back to Login"),
    "badge": MessageLookupByLibrary.simpleMessage("Badges"),
    "barChart": MessageLookupByLibrary.simpleMessage("Bar Chart"),
    "baseUI": MessageLookupByLibrary.simpleMessage("Base UI"),
    "basic": MessageLookupByLibrary.simpleMessage("Basic"),
    "basicElement": MessageLookupByLibrary.simpleMessage("Basic Form"),
    "basicTable": MessageLookupByLibrary.simpleMessage("Basic Table"),
    "billing": MessageLookupByLibrary.simpleMessage("Billing"),
    "bubbleChart": MessageLookupByLibrary.simpleMessage("Bubble Chart"),
    "buttonEmphasis": MessageLookupByLibrary.simpleMessage("Button Emphasis"),
    "buttons": m1,
    "buySell": MessageLookupByLibrary.simpleMessage("Buy Sell"),
    "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cards": MessageLookupByLibrary.simpleMessage("Cards"),
    "carousels": MessageLookupByLibrary.simpleMessage("Carousels"),
    "chart": MessageLookupByLibrary.simpleMessage("Charts"),
    "chat": MessageLookupByLibrary.simpleMessage("Chat"),
    "checkboxColumbTable": MessageLookupByLibrary.simpleMessage(
      "Checkbox Table",
    ),
    "checkboxRadio": MessageLookupByLibrary.simpleMessage(
      "Checkboxes & Radios",
    ),
    "chip": MessageLookupByLibrary.simpleMessage("Chip"),
    "chooseFile": m2,
    "closeNavigationMenu": MessageLookupByLibrary.simpleMessage(
      "Close Navigation Menu",
    ),
    "colorPalette": MessageLookupByLibrary.simpleMessage("Color Palette"),
    "colorScheme": MessageLookupByLibrary.simpleMessage("Color Scheme"),
    "colors": m3,
    "columnChart": MessageLookupByLibrary.simpleMessage("Column Chart"),
    "comingSoon": MessageLookupByLibrary.simpleMessage("Coming Soon"),
    "confirmDeleteRecord": MessageLookupByLibrary.simpleMessage(
      "Confirm delete this record?",
    ),
    "confirmSubmitRecord": MessageLookupByLibrary.simpleMessage(
      "Confirm submit this record?",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Copy"),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "createProject": MessageLookupByLibrary.simpleMessage("Create Project"),
    "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
      "This field requires a valid credit card number.",
    ),
    "crm": MessageLookupByLibrary.simpleMessage("CRM"),
    "crudBack": MessageLookupByLibrary.simpleMessage("Back"),
    "crudDelete": MessageLookupByLibrary.simpleMessage("Delete"),
    "crudDetail": MessageLookupByLibrary.simpleMessage("Detail"),
    "crudNew": MessageLookupByLibrary.simpleMessage("New"),
    "crypto": MessageLookupByLibrary.simpleMessage("Crypto"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
      "This field requires a valid date string.",
    ),
    "designedBy": MessageLookupByLibrary.simpleMessage(
      "Designed & Developed by",
    ),
    "detail": MessageLookupByLibrary.simpleMessage("Details"),
    "dialog": MessageLookupByLibrary.simpleMessage("Dialogs"),
    "dialogs": m4,
    "documentation": MessageLookupByLibrary.simpleMessage("Documentation"),
    "dontHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "dragColumnTable": MessageLookupByLibrary.simpleMessage("Drag Drop Table"),
    "dropFiles": MessageLookupByLibrary.simpleMessage(
      "Drop files here or click to upload",
    ),
    "dropdown": MessageLookupByLibrary.simpleMessage("Dropdowns"),
    "ecommerce": MessageLookupByLibrary.simpleMessage("Ecommerce"),
    "editableTable": MessageLookupByLibrary.simpleMessage("Editable Table"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailErrorText": MessageLookupByLibrary.simpleMessage(
      "This field requires a valid email address.",
    ),
    "embed": MessageLookupByLibrary.simpleMessage("Embed"),
    "enterEmail": MessageLookupByLibrary.simpleMessage("Please enter an email"),
    "enterPhone": MessageLookupByLibrary.simpleMessage(
      "Please enter a phone number",
    ),
    "equalErrorText": m5,
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "error404": MessageLookupByLibrary.simpleMessage("Error 404"),
    "error404Message": MessageLookupByLibrary.simpleMessage(
      "Sorry, the page you are looking for has been removed or not exists.",
    ),
    "error404Title": MessageLookupByLibrary.simpleMessage("Page not found"),
    "error500": MessageLookupByLibrary.simpleMessage("Error 500"),
    "error503": MessageLookupByLibrary.simpleMessage("Error 503"),
    "errorChart": MessageLookupByLibrary.simpleMessage("Error Bar Chart"),
    "example": MessageLookupByLibrary.simpleMessage("Example"),
    "extensions": m6,
    "faqs": MessageLookupByLibrary.simpleMessage("FAQs"),
    "fileManager": MessageLookupByLibrary.simpleMessage("File Manager"),
    "fileUpload": MessageLookupByLibrary.simpleMessage("File Upload"),
    "filesSelected": m7,
    "filteringTable": MessageLookupByLibrary.simpleMessage("Filtering Table"),
    "financialChart": MessageLookupByLibrary.simpleMessage("Financial Chart"),
    "finish": MessageLookupByLibrary.simpleMessage("Finish"),
    "formControl": MessageLookupByLibrary.simpleMessage("Form Control"),
    "formDropdown": MessageLookupByLibrary.simpleMessage("Dropdown Form"),
    "formEditor": MessageLookupByLibrary.simpleMessage("Editors"),
    "formLayout": MessageLookupByLibrary.simpleMessage("Form Layout"),
    "formSelect": MessageLookupByLibrary.simpleMessage("Form Select"),
    "formValidation": MessageLookupByLibrary.simpleMessage("Form Validations"),
    "forms": m8,
    "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
    "ganttChart": MessageLookupByLibrary.simpleMessage("Gantt Chart"),
    "generalUi": MessageLookupByLibrary.simpleMessage("General UI"),
    "gridView": MessageLookupByLibrary.simpleMessage("Grid View"),
    "hi": MessageLookupByLibrary.simpleMessage("Hi"),
    "histogramChart": MessageLookupByLibrary.simpleMessage("Histogram Chart"),
    "homePage": MessageLookupByLibrary.simpleMessage("Home"),
    "iframeDemo": MessageLookupByLibrary.simpleMessage("IFrame Demo"),
    "image": MessageLookupByLibrary.simpleMessage("Images"),
    "inputMask": MessageLookupByLibrary.simpleMessage("Input Masks"),
    "integerErrorText": MessageLookupByLibrary.simpleMessage(
      "This field requires a valid integer.",
    ),
    "integration": MessageLookupByLibrary.simpleMessage("Integration"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email address",
    ),
    "invalidFormat": MessageLookupByLibrary.simpleMessage("Invalid format"),
    "invalidPhone": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid phone number",
    ),
    "invalidURL": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid URL",
    ),
    "invoices": m9,
    "ipErrorText": MessageLookupByLibrary.simpleMessage(
      "This field requires a valid IP.",
    ),
    "kanbanBoard": MessageLookupByLibrary.simpleMessage("Kanban Board"),
    "labs": MessageLookupByLibrary.simpleMessage("Labs Page"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "layout": MessageLookupByLibrary.simpleMessage("Layout"),
    "lightTheme": MessageLookupByLibrary.simpleMessage("Light Theme"),
    "line": MessageLookupByLibrary.simpleMessage("Line Chart"),
    "list": MessageLookupByLibrary.simpleMessage("List"),
    "listView": MessageLookupByLibrary.simpleMessage("List View"),
    "localNotifications": MessageLookupByLibrary.simpleMessage(
      "Local Notifications",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginNow": MessageLookupByLibrary.simpleMessage("Login now!"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "loremIpsum": MessageLookupByLibrary.simpleMessage(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    ),
    "maintenance": MessageLookupByLibrary.simpleMessage("Maintenance"),
    "management": MessageLookupByLibrary.simpleMessage("Management"),
    "matchErrorText": MessageLookupByLibrary.simpleMessage(
      "Value does not match pattern.",
    ),
    "maxErrorText": m10,
    "maxLength": m11,
    "maxLengthErrorText": m12,
    "minErrorText": m13,
    "minLength": m14,
    "minLengthErrorText": m15,
    "myProfile": MessageLookupByLibrary.simpleMessage("My Profile"),
    "myWallet": MessageLookupByLibrary.simpleMessage("My Wallet"),
    "newOrders": m16,
    "newUsers": m17,
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "nft": MessageLookupByLibrary.simpleMessage("NFT"),
    "noFilesSelected": m18,
    "notEqualErrorText": m19,
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "numericErrorText": MessageLookupByLibrary.simpleMessage(
      "Value must be numeric.",
    ),
    "openInNewTab": MessageLookupByLibrary.simpleMessage("Open in new tab"),
    "pages": m20,
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordCreate": MessageLookupByLibrary.simpleMessage("Password Create"),
    "passwordHelperText": MessageLookupByLibrary.simpleMessage(
      "* 6 - 18 characters",
    ),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "Password not match.",
    ),
    "passwordReset": MessageLookupByLibrary.simpleMessage("Password Reset"),
    "pendingIssues": m21,
    "picker": MessageLookupByLibrary.simpleMessage("Pickers"),
    "pricing": MessageLookupByLibrary.simpleMessage("Pricing"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "progress": MessageLookupByLibrary.simpleMessage("Progress"),
    "project": m22,
    "projectList": MessageLookupByLibrary.simpleMessage("Project List"),
    "rangeColumnChart": MessageLookupByLibrary.simpleMessage(
      "Range Column Chart",
    ),
    "recentOrders": m23,
    "recordDeletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Record deleted successfully.",
    ),
    "recordSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Record saved successfully.",
    ),
    "recordSubmittedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Record submitted successfully.",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "registerANewAccount": MessageLookupByLibrary.simpleMessage(
      "Register a new account",
    ),
    "registerNow": MessageLookupByLibrary.simpleMessage("Register now!"),
    "requiredErrorText": MessageLookupByLibrary.simpleMessage(
      "This field cannot be empty.",
    ),
    "requiredField": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "resizingTable": MessageLookupByLibrary.simpleMessage("Resizing Tabel"),
    "retypePassword": MessageLookupByLibrary.simpleMessage("Retype Password"),
    "ribbon": MessageLookupByLibrary.simpleMessage("Ribbons"),
    "saas": MessageLookupByLibrary.simpleMessage("SaaS"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "scatterChart": MessageLookupByLibrary.simpleMessage("Scatter Chart"),
    "screenLock": MessageLookupByLibrary.simpleMessage("Screen Lock"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchResult": MessageLookupByLibrary.simpleMessage("Search Result"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "signin": MessageLookupByLibrary.simpleMessage("Sign In"),
    "signup": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "slider": MessageLookupByLibrary.simpleMessage("Slider"),
    "sliding": MessageLookupByLibrary.simpleMessage("Slidings"),
    "splineChart": MessageLookupByLibrary.simpleMessage("Spline Chart"),
    "stackedHeaderTable": MessageLookupByLibrary.simpleMessage(
      "Stacked Header Table",
    ),
    "starterPage": MessageLookupByLibrary.simpleMessage("Starter Page"),
    "stepLineChart": MessageLookupByLibrary.simpleMessage("Step Line Chart"),
    "strongPassword": MessageLookupByLibrary.simpleMessage(
      "Password must be 8+ characters, with uppercase, lowercase, number, and symbol.",
    ),
    "stylingTable": MessageLookupByLibrary.simpleMessage("Styling Tabel"),
    "submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "subscription": MessageLookupByLibrary.simpleMessage("Subscription"),
    "subscriptionManagement": MessageLookupByLibrary.simpleMessage(
      "Subscription Management",
    ),
    "successValidationMessage": MessageLookupByLibrary.simpleMessage(
      "Looks good!",
    ),
    "summariesTable": MessageLookupByLibrary.simpleMessage("Summaries Table"),
    "support": m24,
    "system": MessageLookupByLibrary.simpleMessage("System"),
    "tab": MessageLookupByLibrary.simpleMessage("Tabs"),
    "tables": MessageLookupByLibrary.simpleMessage("Tables"),
    "task": MessageLookupByLibrary.simpleMessage("Task"),
    "taskList": MessageLookupByLibrary.simpleMessage("Task List"),
    "team": MessageLookupByLibrary.simpleMessage("Team"),
    "termConditions": MessageLookupByLibrary.simpleMessage(
      "Terms & Conditions",
    ),
    "text": MessageLookupByLibrary.simpleMessage("Text"),
    "textEmphasis": MessageLookupByLibrary.simpleMessage("Text Emphasis"),
    "textTheme": MessageLookupByLibrary.simpleMessage("Text Theme"),
    "ticket": m25,
    "timeline": MessageLookupByLibrary.simpleMessage("Timeline"),
    "toast": MessageLookupByLibrary.simpleMessage("Toasts"),
    "todaySales": MessageLookupByLibrary.simpleMessage("Today Sales"),
    "transactions": MessageLookupByLibrary.simpleMessage("Transactions"),
    "twoStepsVerification": MessageLookupByLibrary.simpleMessage(
      "2-Steps Verification",
    ),
    "typography": MessageLookupByLibrary.simpleMessage("Typography"),
    "uiElements": m26,
    "urlErrorText": MessageLookupByLibrary.simpleMessage(
      "This field requires a valid URL address.",
    ),
    "userManagement": MessageLookupByLibrary.simpleMessage("User Management"),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "validNumber": MessageLookupByLibrary.simpleMessage(
      "Must be a valid number",
    ),
    "validation": MessageLookupByLibrary.simpleMessage("Validations"),
    "valuesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Values do not match",
    ),
    "wizard": MessageLookupByLibrary.simpleMessage("Wizard"),
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
  };
}
