import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/integration/integration_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// Edit Integration Form

class EditIntegrationForm extends StatefulWidget {
  final List<Integration> apps;
  const EditIntegrationForm({super.key, required this.apps});

  @override
  State<EditIntegrationForm> createState() => _EditIntegrationFormState();
}

class _EditIntegrationFormState extends State<EditIntegrationForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedAppId = '2'; // gmail id
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Manage and configure your connected apps and services.",
              ),
              const SizedBox(height: kDefaultPadding),

              // Select App Dropdown
              FormLabel(text: "Select App", showRequired: false),
              SizedBox(height: kDefaultPadding / 2),

              CustomDropdownFormField<String>(
                hint: 'Select Option',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                items: widget.apps.where((app) => app.id == selectedAppId).map((
                  app,
                ) {
                  return DropdownMenuItem(value: app.id, child: Text(app.name));
                }).toList(),
                onChanged: null,
                validator: FormBuilderValidators.required(),
                initialValue: selectedAppId,
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
              ),

              const SizedBox(height: kDefaultPadding * 1.5),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      kText: 'Cancel',
                      outlineColor: kPrimaryColor,

                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding),
                  Expanded(
                    child: FlatButton(
                      kText: 'Save',
                      bgColor: kSuccessColor,
                      kTextColor: Colors.white,

                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
