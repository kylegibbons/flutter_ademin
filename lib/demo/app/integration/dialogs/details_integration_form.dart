import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/integration/integration_models.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// Details Integration Form

class DetailsIntegrationForm extends StatefulWidget {
  final List<Integration> apps;
  const DetailsIntegrationForm({super.key, required this.apps});

  @override
  State<DetailsIntegrationForm> createState() => _DetailsIntegrationFormState();
}

class _DetailsIntegrationFormState extends State<DetailsIntegrationForm> {
  String? selectedAppId = '2'; // gmail id
  final TextEditingController appController = TextEditingController(
    text: 'Gmail',
  );
  final TextEditingController clientIdController = TextEditingController(
    text: '1234567890-a1b2c3d4e5f6.apps.googleusercontent.com',
  );
  final TextEditingController clientSecretController = TextEditingController(
    text: '4f6e2a8b1c3d5e7f9a0b2c4d6e8f0a2b1c3d5e7f',
  );
  final TextEditingController uriController = TextEditingController(
    text: 'https://api.namaservice.com/oauth2/authorize',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 520),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Check the credentials and settings for your connected app.",
            ),
            const SizedBox(height: kDefaultPadding),

            // Select App Dropdown
            FormLabel(text: "App Name", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            CustomTextFormField(
              controller: appController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Select Option',
              hintText: 'Select Option',
              suffixIcon: Icons.grid_view_outlined,
              validator: FormBuilderValidators.required(),
              enabled: false,
            ),
            const SizedBox(height: kDefaultPadding),

            // Client ID
            FormLabel(text: "Client ID", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            CustomTextFormField(
              controller: clientIdController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Enter client ID here',
              hintText:
                  'Ex: 1234567890-a1b2c3d4e5f6.apps.googleusercontent.com',
              suffixIcon: Icons.key,
              validator: FormBuilderValidators.required(),
              enabled: false,
            ),
            const SizedBox(height: kDefaultPadding),

            // Client Secret
            FormLabel(text: "Client Secret", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            CustomTextFormField(
              controller: clientSecretController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Client Secret',
              hintText: 'Ex: 4f6e2a8b1c3d5e7f9a0b2c4d6e8f0a2b1c3d5e7f',
              suffixIcon: Icons.lock_outline,
              validator: FormBuilderValidators.required(),
              enabled: false,
            ),
            const SizedBox(height: kDefaultPadding),

            // Auth URI
            FormLabel(text: "Authentication base URI", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            CustomTextFormField(
              controller: uriController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Paste URL here',
              hintText: 'Ex: https://api.namaservice.com/oauth2/authorize',
              suffixIcon: Icons.link,
              validator: FormBuilderValidators.required(),
              enabled: false,
            ),
            SizedBox(height: kDefaultPadding / 2),
          ],
        ),
      ),
    );
  }
}
