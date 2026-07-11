import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/toast.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/form/form_dropdown.dart';
import 'package:flutter_ademin/widgets/form/form_file_upload.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();

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
              // avatar upload
              Center(
                child: AvatarUpload(
                  maxSizeBytes: 2 * 1024 * 1024, // 2 MB
                  allowedExtensions: ['jpg', 'jpeg', 'png'],
                  radius: 60,
                  enabled: true,
                  onChanged: (file) {
                    // do something with your files
                  },
                ),
              ),

              const SizedBox(height: kDefaultPadding),

              // full name
              FormLabel(text: "Full Name", showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: _fullNameController,
                labelText: 'Enter Full Name',
                hintText: 'Jhon Doe',
                suffixIcon: Icons.person,
                validator: FormBuilderValidators.required(),
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),

              // email
              FormLabel(text: "Email", showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: _emailController,
                labelText: 'Enter Email',
                hintText: 'jhon_doe@mail.com',
                suffixIcon: Icons.email_outlined,
                validator: FormBuilderValidators.email(),
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),

              // email
              FormLabel(text: "Username", showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: _usernameController,
                labelText: 'Enter Username',
                hintText: 'jhondoe',
                suffixIcon: Icons.person_outline,
                validator: FormBuilderValidators.username(),
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),

              // Select User Status
              FormLabel(text: "User Status", showRequired: false),
              SizedBox(height: kDefaultPadding / 2),

              CustomDropdownFormField<String>(
                hint: 'Select user status',
                items: [
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'banned', child: Text('Banned')),
                  DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
                  DropdownMenuItem(
                    value: 'suspended',
                    child: Text('Suspended'),
                  ),
                ],
                // initialValue: _status,
                onChanged: (val) {
                  setState(() {});
                },
                validator: FormBuilderValidators.required(),
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),

              // Select User Plan
              FormLabel(text: "User Plan", showRequired: false),
              SizedBox(height: kDefaultPadding / 2),

              CustomDropdownFormField<String>(
                hint: 'Select user plan',
                items: [
                  DropdownMenuItem(value: 'free', child: Text('Free')),
                  DropdownMenuItem(value: 'starter', child: Text('Starter')),
                  DropdownMenuItem(value: 'pro', child: Text('Pro')),
                  DropdownMenuItem(
                    value: 'enterprise',
                    child: Text('Enterprise'),
                  ),
                ],
                // initialValue: _plan,
                onChanged: (val) {
                  setState(() {});
                },
                validator: FormBuilderValidators.required(),
                successMessage: 'Looks Good!',
              ),

              SizedBox(height: kDefaultPadding),
              Text(
                'A setup password link will be sent to the user’s email address.',
              ),

              const SizedBox(height: kDefaultPadding * 2),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      kText: 'Cancel',
                      outlineColor: themeData.colorScheme.primary,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding),
                  Expanded(
                    child: FlatButton(
                      kText: 'Add User',
                      bgColor: kSecondaryColor,
                      kTextColor: Colors.white,

                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // success toast
                          Toast.showToast(
                            context: context,
                            icon: Icons.check_circle_outline,
                            message: 'User Added!',
                            color: kSuccessColor,
                            alignment: Alignment.topRight,
                            showProgress: true,
                            showCloseButton: true,
                            bottomBorder: true,
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
