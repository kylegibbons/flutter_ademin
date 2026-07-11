import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/settings/settings_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/form/form_file_upload.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ProfileSettings extends StatefulWidget {
  final UserProfile initialData;
  final void Function(UserProfile value) onSubmit;
  const ProfileSettings({
    super.key,
    required this.initialData,
    required this.onSubmit,
  });

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _usernameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _bioCtrl;

  @override
  void initState() {
    super.initState();

    // Prefill dari initialData
    _nameCtrl = TextEditingController(text: widget.initialData.name);
    _emailCtrl = TextEditingController(text: widget.initialData.email);
    _usernameCtrl = TextEditingController(text: widget.initialData.username);
    _phoneCtrl = TextEditingController(text: widget.initialData.phone);
    _bioCtrl = TextEditingController(text: widget.initialData.bio);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _usernameCtrl.dispose();
    _phoneCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final updated = UserProfile(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      username: _usernameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      bio: _bioCtrl.text.trim(),
    );

    widget.onSubmit(updated);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information'.toUpperCase(),
              style: TextStyle(
                fontSize: kBodyMedium,
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: kDefaultPadding / 2),

            Text(
              'Update your personal details and profile information',
              style: TextStyle(color: themeData.colorScheme.onSurface),
            ),

            const SizedBox(height: 2 * kDefaultPadding),

            // avatar upload
            AvatarUpload(
              maxSizeBytes: 2 * 1024 * 1024, // 2 MB
              allowedExtensions: ['jpg', 'jpeg', 'png'],
              radius: 60,
              enabled: true,
              initialUrl: AssetImage('assets/images/avatar_2.jpg'),
              onChanged: (file) {
                // do something with your files
              },
            ),

            const SizedBox(height: kDefaultPadding),

            // full name
            FormLabel(text: "Full Name", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),
            CustomTextFormField(
              controller: _nameCtrl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter Full Name',
              hintText: 'Jhon Doe',
              suffixIcon: Icons.person_outline,
              validator: FormBuilderValidators.required(),
              originalValue:
                  widget.initialData.name, // helper for success message
              successMessage: 'Looks Good!',
            ),
            const SizedBox(height: kDefaultPadding),

            // email
            FormLabel(text: "Email", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),
            CustomTextFormField(
              controller: _emailCtrl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter Email',
              hintText: 'jhon_doe@mail.com',
              suffixIcon: Icons.email_outlined,
              validator: FormBuilderValidators.email(),
              originalValue: widget.initialData.email,
              successMessage: 'Looks Good!',
            ),
            const SizedBox(height: kDefaultPadding),

            // email
            FormLabel(text: "Username", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),
            CustomTextFormField(
              controller: _usernameCtrl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter Username',
              hintText: 'jhondoe',
              suffixIcon: Icons.person_outline,
              validator: FormBuilderValidators.username(),
              originalValue: widget.initialData.username,
              successMessage: 'Looks Good!',
            ),
            const SizedBox(height: kDefaultPadding),

            // phone
            FormLabel(text: "Phone", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),
            CustomTextFormField(
              controller: _phoneCtrl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter Phone',
              hintText: '+624576513231',
              suffixIcon: Icons.person_outline,
              validator: FormBuilderValidators.phoneNumber(),
              originalValue: widget.initialData.phone,
              successMessage: 'Looks Good!',
            ),

            const SizedBox(height: kDefaultPadding),

            // bio
            FormLabel(text: "Biography", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),
            CustomTextFormField(
              controller: _bioCtrl,
              minLines: 6,
              maxLines: 6,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter Biography',
              hintText: 'Your biography...',
              originalValue: widget.initialData.bio,
              successMessage: 'Looks Good!',
            ),

            const SizedBox(height: kDefaultPadding * 2),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomOutlinedButton(
                  kText: 'Cancel',
                  outlineColor: kPrimaryColor,

                  onPressed: () {},
                ),
                const SizedBox(width: kDefaultPadding),
                FlatButton(
                  kText: 'Save Changes',
                  bgColor: kSecondaryColor,
                  kTextColor: Colors.white,

                  onPressed: () {
                    _submit();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
