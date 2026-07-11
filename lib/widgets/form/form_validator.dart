import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/generated/l10n.dart';

typedef ValidatorFunction = String? Function(String? value);
typedef FileValidatorFunction = String? Function(List<PlatformFile>? files);

enum FileSizeUnit { kb, mb, gb }

class Validators {
  // Combines multiple validators.
  static ValidatorFunction combineValidators(
    List<ValidatorFunction> validators,
  ) {
    return (value) {
      for (var validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result; // Return the first error message
        }
      }
      return null; // All validators passed
    };
  }

  // Combines multiple file validators.
  static FileValidatorFunction combineFileValidators(
    List<FileValidatorFunction> validators,
  ) {
    return (files) {
      for (var validator in validators) {
        final result = validator(files);
        if (result != null) {
          return result; // Return the first error message
        }
      }
      return null; // All validators passed
    };
  }

  static String? requiredField(
    String? value,
    BuildContext context, {
    String? customMessage,
  }) {
    return (value == null || value.trim().isEmpty)
        ? (customMessage ?? Lang.of(context).requiredField)
        : null;
  }

  static String? email(
    String? value,
    BuildContext context, {
    String? customMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final emailRegex = RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value)
        ? null
        : (customMessage ?? Lang.of(context).invalidEmail);
  }

  static String? minLength(
    String? value,
    int minLength,
    BuildContext context, {
    String? customMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    String message = customMessage ?? Lang.of(context).minLength(minLength);
    return (value).length >= minLength ? null : message;
  }

  static String? maxLength(
    String? value,
    int maxLength,
    BuildContext context, {
    String? customMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    String message = customMessage ?? Lang.of(context).maxLength(maxLength);
    return (value).length <= maxLength ? null : message;
  }

  static String? numeric(
    String? value,
    BuildContext context, {
    String? customMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final message = customMessage ?? Lang.of(context).validNumber;
    return double.tryParse(value) != null ? null : message;
  }

  static String? alphanumeric(
    String? value,
    BuildContext context, {
    String? customMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final message = customMessage ?? Lang.of(context).alphanumeric;
    final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return alphanumericRegex.hasMatch(value) ? null : message;
  }

  static String? regex(
    String? value,
    RegExp pattern,
    BuildContext context, {
    String? customMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final message = customMessage ?? Lang.of(context).invalidFormat;
    return pattern.hasMatch(value) ? null : message;
  }

  static String? strongPassword(
    String? value,
    BuildContext context, {
    String? customMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final message = customMessage ?? Lang.of(context).strongPassword;
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegex.hasMatch(value) ? null : message;
  }

  static String? phone(
    String? value,
    BuildContext context, {
    String? customMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    return phoneRegex.hasMatch(value)
        ? null
        : (customMessage ?? Lang.of(context).invalidPhone);
  }

  static String? match(
    String? value,
    String? otherValue,
    BuildContext context, {
    String? customMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final message = customMessage ?? Lang.of(context).valuesDoNotMatch;
    return value == otherValue ? null : message;
  }

  static String? url(
    String? value,
    BuildContext context, {
    String? customMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final message = customMessage ?? Lang.of(context).invalidURL;
    final urlRegex = RegExp(r'^(https?:\/\/)?([\w-]+\.)+[\w-]+(\/[\w-]*)*\/?$');
    return urlRegex.hasMatch(value) ? null : message;
  }

  // File validators
  static String? fileRequired(
    List<PlatformFile>? files,
    BuildContext context, {
    String? customMessage,
  }) {
    return (files == null || files.isEmpty)
        ? (customMessage ?? Lang.of(context).requiredField)
        : null;
  }

  static String? fileExtension(
    List<PlatformFile>? files,
    List<String> allowedExtensions,
    BuildContext context, {
    String? customMessage,
  }) {
    if (files == null || files.isEmpty) return null;
    for (var file in files) {
      final ext = file.extension?.toLowerCase() ?? '';
      if (!allowedExtensions.contains(ext)) {
        return customMessage ?? 'Invalid file type for ${file.name}';
      }
    }
    return null;
  }

  static String? fileSize(
    List<PlatformFile>? files,
    int maxSize,
    FileSizeUnit unit,
    BuildContext context, {
    String? customMessage,
  }) {
    if (files == null || files.isEmpty) return null;
    int maxSizeBytes =
        maxSize *
        (unit == FileSizeUnit.kb
            ? 1024
            : unit == FileSizeUnit.mb
            ? 1024 * 1024
            : 1024 * 1024 * 1024);
    for (var file in files) {
      if (file.size > maxSizeBytes) {
        return customMessage ??
            'File ${file.name} too large. Max $maxSize ${unit.name.toUpperCase()}';
      }
    }
    return null;
  }
}
