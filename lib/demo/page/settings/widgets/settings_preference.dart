// Preferences Settings

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/form/form_checkbox_radio.dart';

class PreferenceItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const PreferenceItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: themeData.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                    // fontSize: kBodyLarge,
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 4),
                Text(subtitle),
              ],
            ),
          ),

          const SizedBox(width: kDefaultPadding),

          // Switch
          CustomSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: kSecondaryColor,
          ),
        ],
      ),
    );
  }
}

class PreferencesSettings extends StatefulWidget {
  const PreferencesSettings({super.key});

  @override
  State<PreferencesSettings> createState() => _PreferencesSettingsState();
}

class _PreferencesSettingsState extends State<PreferencesSettings> {
  bool orderNotifications = true;
  bool marketingEmails = false;
  bool securityAlerts = true;
  bool pushNotifications = true;
  bool smsNotifications = true;
  bool mentionsNotifications = true;
  bool weeklyDigest = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notification Preferences'.toUpperCase(),
            style: TextStyle(
              fontSize: kBodyMedium,
              color: themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),

          Text(
            'Manage your notification and communication preferences',
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),

          const SizedBox(height: kDefaultPadding),
          PreferenceItem(
            title: 'Order notifications',
            subtitle: 'Receive emails for new orders and status changes',
            value: orderNotifications,
            onChanged: (val) => setState(() => orderNotifications = val),
          ),

          PreferenceItem(
            title: 'Marketing emails',
            subtitle: 'Receive product updates and promotional content',
            value: marketingEmails,
            onChanged: (val) => setState(() => marketingEmails = val),
          ),

          PreferenceItem(
            title: 'Security alerts',
            subtitle: 'Get notified about suspicious account activity',
            value: securityAlerts,
            onChanged: (val) => setState(() => securityAlerts = val),
          ),

          PreferenceItem(
            title: 'Push notifications',
            subtitle: 'Receive push notifications for real-time order updates',
            value: pushNotifications,
            onChanged: (val) => setState(() => pushNotifications = val),
          ),

          PreferenceItem(
            title: 'SMS Notifications',
            subtitle: 'Receive SMS for critical updates',
            value: smsNotifications,
            onChanged: (val) => setState(() => smsNotifications = val),
          ),

          PreferenceItem(
            title: 'Mentions & Comments',
            subtitle: 'Get notified when someone mentions you',
            value: mentionsNotifications,
            onChanged: (val) => setState(() => mentionsNotifications = val),
          ),

          PreferenceItem(
            title: 'Weekly digest',
            subtitle: 'Get a summary of your weekly performance',
            value: weeklyDigest,
            onChanged: (val) => setState(() => weeklyDigest = val),
          ),
        ],
      ),
    );
  }
}
