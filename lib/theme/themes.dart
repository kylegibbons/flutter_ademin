import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/theme_extensions/app_sidebar_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemePalette {
  ThemePalette._();

  static final ThemePalette instance = ThemePalette._();

  // default palette
  Color primary = const Color(0xFF313F6C);
  Color primaryDark = const Color(0xFF212529);
  Color secondary = const Color(0xFF2C71F2);
  Color error = const Color(0xFFE95F43);
  Color success = const Color(0xFF0DC6AD);
  Color info = const Color(0xFF0A92DB);
  Color warning = const Color(0xFFFAB237);
  Color text = const Color(0xff878a99);

  /// switch palette by index (0 = default, 1 = alt1, 2 = alt2)
  void setPalette(int index) {
    switch (index) {
      case 1:
        primary = const Color(0xFF303e8a);
        primaryDark = const Color(0xFF212529);
        secondary = const Color(0xFF4b6daf);
        error = const Color(0xFFed1f0b);
        success = const Color(0xFF189e5d);
        info = const Color(0xFF6a96f5);
        warning = const Color(0xFFe0ca19);
        text = const Color(0xff878a99);
        break;
      case 2:
        primary = const Color(0xFF463171);
        primaryDark = const Color(0xFF1a0835);
        secondary = const Color(0xFF663171);
        error = const Color(0xFFea301c);
        success = const Color(0xFF34a36a);
        info = const Color(0xFF313C71);
        warning = const Color(0xFFdfcc34);
        text = const Color(0xff878a99);
        break;
      case 3:
        primary = const Color(0xFF520DC2);
        primaryDark = const Color(0xFF140330);
        secondary = const Color(0xFF0D22C2);
        error = const Color(0xFFdc3545);
        success = const Color(0xFF20c997);
        info = const Color(0xFF0dcaf0);
        warning = const Color(0xFFffc107);
        text = const Color(0xff878a99);
        break;
      case 4:
        primary = const Color(0xFF087990);
        primaryDark = const Color(0xFF032830);
        secondary = const Color(0xFFD63384);
        error = const Color(0xFFDC3545);
        success = const Color(0xFF20C997);
        info = const Color(0xFF0DCAF0);
        warning = const Color(0xFFFFCD39);
        text = const Color(0xff495057);
        break;
      case 0:
      default:
        primary = const Color(0xFF313F6C);
        primaryDark = const Color(0xFF212529);
        secondary = const Color(0xFF2C71F2);
        error = const Color(0xFFE95F43);
        success = const Color(0xFF0DC6AD);
        info = const Color(0xFF0A92DB);
        warning = const Color(0xFFFAB237);
        text = const Color(0xff878a99);
    }
  }
}

// keep top-level names so existing code still refers to same identifiers
Color get kPrimaryColor => ThemePalette.instance.primary;
Color get kPrimaryColorDark => ThemePalette.instance.primaryDark;
Color get kSecondaryColor => ThemePalette.instance.secondary;
Color get kErrorColor => ThemePalette.instance.error;
Color get kSuccessColor => ThemePalette.instance.success;
Color get kInfoColor => ThemePalette.instance.info;
Color get kWarningColor => ThemePalette.instance.warning;
Color get kTextColor => ThemePalette.instance.text;

//static color

const Color kSurfaceLight = Colors.white;
final Color kSurfaceDark = Color(0xFF212529);
const Color kSurfaceContainerHighLight = Colors.white;
const Color kSurfaceContainerHighDark = Color(0xFF1A1D20);
const Color kSurfaceContainerHighestLight = Colors.white;
const Color kSurfaceContainerHighestDark = Color(0xff262a2f);
const Color kOnSurfaceLight = Color(0xff495057);
const Color kOnSurfaceDark = Color(0xffd9dce7);
const Color inlineCode = Color(0xfff672a7);

const Color kSurfaceBrightLight = Colors.white;
// const Color kSurfaceBrightDark = Color(0xFF292E32);
const Color kSurfaceBrightDark = Color(0xFF25292D);

const Color kScreenBackgroundColorLight = Color(0xFFF3F3F9);
const Color kScreenBackgroundColorDark = Color(0xFF1A1D21);

//outline color
Color kOutlineColorLight = Colors.grey.withValues(alpha: 0.3);
const Color kOutlineColorDark = Color(0xff32383e);

// table color

// const Color kTableHeaderColor = Color(0x12546276);
Color get kTableHeaderColor => kPrimaryColor.withValues(alpha: 0.05);

class AppThemeData {
  AppThemeData._();

  static final AppThemeData _instance = AppThemeData._();

  static AppThemeData get instance => _instance;

  ThemeData light() {
    final themeData = ThemeData(
      useMaterial3: false,
      visualDensity: VisualDensity.compact,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: kTextColor),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0.1,
      ),
      scaffoldBackgroundColor: kScreenBackgroundColorLight,
      drawerTheme: DrawerThemeData(backgroundColor: kPrimaryColor),
      canvasColor: kSurfaceContainerHighLight,
      hoverColor: kTableHeaderColor,
      focusColor: Color(0x35A2ADBC),
      disabledColor: Colors.blueGrey.withValues(alpha: 0.5),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: kPrimaryColor,
        primaryContainer: kPrimaryColor,
        onPrimary: Colors.white,
        secondary: kSecondaryColor,
        onSecondary: Colors.white,
        error: kErrorColor,
        onError: Colors.white,
        surface: kSurfaceLight,
        surfaceContainerHigh: kSurfaceContainerHighLight,
        surfaceContainerHighest: kSurfaceContainerHighestLight,
        onSurface: kOnSurfaceLight,
        surfaceBright: kSurfaceBrightLight,
        outline: kOutlineColorLight,
        inverseSurface: kSurfaceDark,
        onInverseSurface: kOnSurfaceDark,
        surfaceContainerLow: kPrimaryColor.withValues(alpha: 0.05),
      ),
      cardTheme: const CardThemeData(
        margin: EdgeInsets.zero,
        color: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
          fontSize: kDisplayLarge,
          fontWeight: FontWeight.w300,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: kDisplayMedium,
          fontWeight: FontWeight.w300,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: kDisplaySmall,
          fontWeight: FontWeight.w300,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontSize: kHeadlineLarge,
          fontWeight: FontWeight.w300,
        ),
        headlineMedium: GoogleFonts.poppins(fontSize: kHeadlineMedium),
        headlineSmall: GoogleFonts.poppins(fontSize: kHeadlineSmall),
        titleLarge: GoogleFonts.poppins(fontSize: kTitleLarge),
        titleMedium: GoogleFonts.poppins(fontSize: kBodyMedium),
        titleSmall: GoogleFonts.poppins(fontSize: kTitleSmall),
        labelLarge: GoogleFonts.poppins(fontSize: kLabelLarge),
        labelMedium: GoogleFonts.poppins(fontSize: kLabelMedium),
        labelSmall: GoogleFonts.poppins(fontSize: kLabelSmall),
        bodyLarge: GoogleFonts.poppins(fontSize: kBodyLarge),
        bodySmall: GoogleFonts.poppins(fontSize: kBodySmall),
        bodyMedium: GoogleFonts.poppins(fontSize: kBodyMedium),
      ),

      iconTheme: IconThemeData(size: 20, color: kTextColor),
      popupMenuTheme: PopupMenuThemeData(
        color: kSurfaceLight,
        textStyle: GoogleFonts.poppins(
          color: kOnSurfaceLight,
          fontSize: kBodyMedium,
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: kPrimaryColorDark,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: kSurfaceContainerHighestLight,
        filled: true,
        isDense: true,
        floatingLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        hoverColor: kPrimaryColor.withValues(alpha: 0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(width: outlineWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(
            width: outlineWidth,
            color: kOutlineColorLight,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(color: kErrorColor, width: outlineWidth),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(
            color: Colors.blueGrey.withValues(alpha: 0.3),
            width: outlineWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(color: kPrimaryColor, width: outlineWidth),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(color: kErrorColor, width: outlineWidth),
        ),
        labelStyle: TextStyle(color: kTextColor),
        hintStyle: TextStyle(color: kTextColor),
        contentPadding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kVerticalPadding,
        ),
        prefixIconConstraints: const BoxConstraints.tightFor(
          width: mediumHeight,
        ),
        suffixIconConstraints: const BoxConstraints.tightFor(
          width: mediumHeight,
        ),
      ),
      sliderTheme: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
        valueIndicatorColor: Colors.white,
        valueIndicatorTextStyle: const TextStyle(
          color: kOnSurfaceLight,
          fontSize: kBodyMedium,
        ),
        valueIndicatorStrokeColor: kOutlineColorLight,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: kDefaultPadding / 2,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius), // Border radius
        ),
        side: BorderSide(
          width: outlineWidth, // Border width
          color: kOutlineColorLight, // Border color
        ),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return kPrimaryColor; // Checked color
          }
          return kSurfaceContainerHighestLight; // Default color
        }),
        checkColor: WidgetStateProperty.all(Colors.white), // Checkmark color
      ),
      dialogTheme: const DialogThemeData(backgroundColor: kSurfaceLight),
      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey.shade300; // background disabled
            }
            return null; // default / override
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey.shade600; // text disabled
            }
            return null;
          }),
        ),
      ),

      // TextButton
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return kTableHeaderColor; // background disabled
            }
            return null; // transparan default
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return kTextColor; // text disabled
            }
            return null;
          }),
        ),
      ),

      // OutlinedButton
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey.shade500; // text disabled
            }
            return null;
          }),
          side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: Colors.grey.shade400); // border disabled
            }
            return null;
          }),
        ),
      ),
    );

    final appSidebarTheme = AppSidebarTheme(
      backgroundColor: themeData.drawerTheme.backgroundColor!,
      foregroundColor: const Color(0xFFabb9e8),
      sidebarWidth: kSidebarWidth,
      sidebarLeftPadding: kDefaultPadding,
      sidebarTopPadding: kDefaultPadding,
      sidebarRightPadding: kDefaultPadding,
      sidebarBottomPadding: kDefaultPadding,
      headerUserProfileRadius: 20.0,
      headerUsernameFontSize: 14.0,
      headerTextButtonFontSize: 14.0,
      menuFontSize: kBodyMedium,
      menuBorderRadius: 5.0,
      menuLeftPadding: 0.0,
      menuTopPadding: 2.0,
      menuRightPadding: 0.0,
      menuBottomPadding: 2.0,
      menuHoverColor: Colors.white.withValues(alpha: 0.5),
      menuSelectedFontColor: Colors.white,
      menuSelectedBackgroundColor: kPrimaryColor,
      menuExpandedBackgroundColor: Colors.white.withValues(alpha: 0.02),
      menuExpandedHoverColor: Colors.white.withValues(alpha: 0.02),
      menuExpandedChildLeftPadding: 4.0,
      menuExpandedChildTopPadding: 2.0,
      menuExpandedChildRightPadding: 4.0,
      menuExpandedChildBottomPadding: 2.0,
    );

    return themeData.copyWith(
      textTheme: themeData.textTheme.apply(
        bodyColor: kTextColor,
        displayColor: kTextColor,
      ),
      extensions: [appSidebarTheme],
    );
  }

  ThemeData dark() {
    final themeData = ThemeData.dark(useMaterial3: false).copyWith(
      drawerTheme: DrawerThemeData(backgroundColor: kPrimaryColorDark),
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColorDark,
        foregroundColor: Colors.white,
      ),
      visualDensity: VisualDensity.compact,
      scaffoldBackgroundColor: kScreenBackgroundColorDark,
      cardTheme: CardThemeData(margin: EdgeInsets.zero, color: kSurfaceDark),
      canvasColor: kSurfaceContainerHighDark,
      hoverColor: Colors.black12,
      focusColor: Colors.black26,
      disabledColor: Colors.blueGrey.withValues(alpha: 0.5),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.white,
        primaryContainer: kSurfaceDark,
        onPrimary: Colors.white,
        secondary: kSecondaryColor,
        onSecondary: Colors.white,
        error: kErrorColor,
        onError: Colors.white,
        surface: kSurfaceDark,
        surfaceContainerHigh: kSurfaceContainerHighDark,
        surfaceContainerHighest: kSurfaceContainerHighestDark,
        onSurface: kOnSurfaceDark,
        surfaceBright: kSurfaceBrightDark,
        outline: kOutlineColorDark,
        inverseSurface: kSurfaceLight,
        onInverseSurface: kOnSurfaceLight,
        surfaceContainerLow: Colors.blueGrey.withValues(alpha: 0.1),
      ),
      iconTheme: IconThemeData(size: 20, color: kTextColor),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
          fontSize: kDisplayLarge,
          fontWeight: FontWeight.w300,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: kDisplayMedium,
          fontWeight: FontWeight.w300,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: kDisplaySmall,
          fontWeight: FontWeight.w300,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontSize: kHeadlineLarge,
          fontWeight: FontWeight.w300,
        ),
        headlineMedium: GoogleFonts.poppins(fontSize: kHeadlineMedium),
        headlineSmall: GoogleFonts.poppins(fontSize: kHeadlineSmall),
        titleLarge: GoogleFonts.poppins(fontSize: kTitleLarge),
        titleMedium: GoogleFonts.poppins(fontSize: kBodyMedium),
        titleSmall: GoogleFonts.poppins(fontSize: kTitleSmall),
        labelLarge: GoogleFonts.poppins(fontSize: kLabelLarge),
        labelMedium: GoogleFonts.poppins(fontSize: kLabelMedium),
        labelSmall: GoogleFonts.poppins(fontSize: kLabelSmall),
        bodyLarge: GoogleFonts.poppins(fontSize: kBodyLarge),
        bodySmall: GoogleFonts.poppins(fontSize: kBodySmall),
        bodyMedium: GoogleFonts.poppins(fontSize: kBodyMedium),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: kPrimaryColorDark,
        textStyle: GoogleFonts.poppins(
          color: kOnSurfaceDark,
          fontSize: kBodyMedium,
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: kSurfaceContainerHighestDark,
        filled: true,
        isDense: true,
        floatingLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        hoverColor: Colors.white.withValues(alpha: 0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(width: outlineWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(width: outlineWidth, color: kOutlineColorDark),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(color: kErrorColor, width: outlineWidth),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(
            color: Colors.blueGrey.withValues(alpha: 0.3),
            width: outlineWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(color: kPrimaryColor, width: outlineWidth),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(color: kErrorColor, width: outlineWidth),
        ),
        labelStyle: TextStyle(color: kTextColor),
        hintStyle: TextStyle(color: kTextColor),
        contentPadding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kVerticalPadding,
        ),
        prefixIconConstraints: const BoxConstraints.tightFor(
          width: mediumHeight,
        ),
        suffixIconConstraints: const BoxConstraints.tightFor(
          width: mediumHeight,
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        headerBackgroundColor: kPrimaryColorDark, // Header background
        backgroundColor: kPrimaryColorDark, // Background color of date picker
        // dayBackgroundColor: WidgetStateProperty.all(Colors.white),
        yearBackgroundColor: WidgetStateProperty.all(Colors.white),
        todayBackgroundColor: WidgetStateProperty.all(
          kPrimaryColorDark,
        ), // Background color of today’s date
        dayForegroundColor: WidgetStateProperty.all(Colors.grey),
        yearForegroundColor: WidgetStateProperty.all(Colors.black),
      ),
      sliderTheme: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
        valueIndicatorColor: kSurfaceContainerHighDark,
        valueIndicatorTextStyle: const TextStyle(
          color: kOnSurfaceDark,
          fontSize: kBodyMedium,
        ),
        valueIndicatorStrokeColor: kOutlineColorDark,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius), // Border radius
        ),
        side: const BorderSide(
          width: outlineWidth, // Border width
          color: kOutlineColorDark, // Border color
        ),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return kPrimaryColor; // Checked color
          }
          return kSurfaceContainerHighestDark; // Default color
        }),
        checkColor: WidgetStateProperty.all(Colors.white), // Checkmark color
      ),
      dialogTheme: DialogThemeData(backgroundColor: kSurfaceDark),
    );

    final appSidebarTheme = AppSidebarTheme(
      backgroundColor: themeData.drawerTheme.backgroundColor!,
      foregroundColor: const Color(0xFF7c7f90),
      sidebarWidth: kSidebarWidth,
      sidebarLeftPadding: kDefaultPadding,
      sidebarTopPadding: kDefaultPadding,
      sidebarRightPadding: kDefaultPadding,
      sidebarBottomPadding: kDefaultPadding,
      headerUserProfileRadius: 20.0,
      headerUsernameFontSize: 14.0,
      headerTextButtonFontSize: 14.0,
      menuFontSize: kBodyMedium,
      menuBorderRadius: 5.0,
      menuLeftPadding: 0.0,
      menuTopPadding: 2.0,
      menuRightPadding: 0.0,
      menuBottomPadding: 2.0,
      menuHoverColor: Colors.blueGrey.withValues(alpha: 0.03),
      menuSelectedFontColor: Colors.white,
      menuSelectedBackgroundColor: kPrimaryColorDark,
      menuExpandedBackgroundColor: Colors.blueGrey.withValues(alpha: 0.03),
      menuExpandedHoverColor: Colors.blueGrey.withValues(alpha: 0.03),
      menuExpandedChildLeftPadding: 4.0,
      menuExpandedChildTopPadding: 2.0,
      menuExpandedChildRightPadding: 4.0,
      menuExpandedChildBottomPadding: 2.0,
    );

    return themeData.copyWith(
      textTheme: themeData.textTheme.apply(
        bodyColor: kTextColor,
        displayColor: kTextColor,
      ),
      extensions: [appSidebarTheme],
    );
  }
}
