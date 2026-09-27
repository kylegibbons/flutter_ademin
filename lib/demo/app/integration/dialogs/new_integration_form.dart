import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/integration/integration_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/toast.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// New Integration Form

class NewIntegrationForm extends StatefulWidget {
  final List<Integration> apps;
  const NewIntegrationForm({super.key, required this.apps});

  @override
  State<NewIntegrationForm> createState() => _NewIntegrationFormState();
}

class _NewIntegrationFormState extends State<NewIntegrationForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedAppId;
  final TextEditingController clientIdController = TextEditingController();
  final TextEditingController clientSecretController = TextEditingController();
  final TextEditingController uriController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
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
                "Set up an integration and add a brief explanation for the team.",
              ),
              const SizedBox(height: kDefaultPadding),

              // Select App Dropdown
              FormLabel(text: "Select App", showRequired: false),
              SizedBox(height: kDefaultPadding / 2),

              CustomDropdownFormField<String>(
                hint: 'Select Option',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                items: widget.apps.map((app) {
                  return DropdownMenuItem(value: app.id, child: Text(app.name));
                }).toList(),
                onChanged: (val) => setState(() => selectedAppId = val),
                validator: FormBuilderValidators.required(),
                successMessage: 'Looks Good!',
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
                successMessage: 'Looks Good!', // show success message
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
                successMessage: 'Looks Good!', // show success message
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
                successMessage: 'Looks Good!', // show success message
              ),
              const SizedBox(height: kDefaultPadding / 2),
              const Text(
                "Paste the full URI, and we'll automatically pull out and show only the subdomain for quick reference.",
              ),
              const SizedBox(height: kDefaultPadding * 2),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      kText: 'Close',
                      outlineColor: themeData.colorScheme.primary,

                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding),
                  Expanded(
                    child: FlatButton(
                      kText: 'Add Integration',
                      bgColor: kSecondaryColor,
                      kTextColor: Colors.white,

                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // success toast
                          Toast.showToast(
                            context: context,
                            icon: Icons.check_circle_outline,
                            message: 'Form submitted!',
                            color: kSuccessColor,
                            alignment: Alignment.topRight,
                            showProgress: true,
                            showCloseButton: true,
                          );

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
