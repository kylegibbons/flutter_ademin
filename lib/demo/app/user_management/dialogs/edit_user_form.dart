import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/user_management/user_management_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/toast.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:flutkit_ademin/widgets/form/form_file_upload.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditUserForm extends StatefulWidget {
  final UserModel user;
  final void Function(UserModel updateUser)? onSubmit;
  const EditUserForm({super.key, required this.user, this.onSubmit});

  @override
  State<EditUserForm> createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;

  late String _status;
  late String _plan;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.user.fullName);
    _emailController = TextEditingController(text: widget.user.email);
    _usernameController = TextEditingController(text: widget.user.username);

    _status = widget.user.status;
    _plan = widget.user.plan;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

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
              // avatar upload
              Center(
                child: AvatarUpload(
                  maxSizeBytes: 2 * 1024 * 1024, // 2 MB
                  allowedExtensions: ['jpg', 'jpeg', 'png'],
                  radius: 60,
                  enabled: true,
                  initialUrl: AssetImage(widget.user.avatarUrl),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                labelText: 'Enter Full Name',
                hintText: 'Jhon Doe',
                suffixIcon: Icons.person,
                validator: FormBuilderValidators.required(),
                originalValue:
                    widget.user.fullName, // helper for success message
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),

              // email
              FormLabel(text: "Email", showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                labelText: 'Enter Email',
                hintText: 'jhon_doe@mail.com',
                suffixIcon: Icons.email_outlined,
                validator: FormBuilderValidators.email(),
                originalValue: widget.user.email,
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),

              // email
              FormLabel(text: "Username", showRequired: false),
              SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: _usernameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                labelText: 'Enter Username',
                hintText: 'jhondoe',
                suffixIcon: Icons.person_outline,
                validator: FormBuilderValidators.username(),
                originalValue: widget.user.username,
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),

              // Select User Status
              FormLabel(text: "User Status", showRequired: false),
              SizedBox(height: kDefaultPadding / 2),

              CustomDropdownFormField<String>(
                hint: 'Select user status',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                items: [
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'banned', child: Text('Banned')),
                  DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
                  DropdownMenuItem(
                    value: 'suspended',
                    child: Text('Suspended'),
                  ),
                ],
                initialValue: _status,
                onChanged: (statusValue) {
                  setState(() {
                    _status = statusValue!;
                  });
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                items: [
                  DropdownMenuItem(value: 'free', child: Text('Free')),
                  DropdownMenuItem(value: 'starter', child: Text('Starter')),
                  DropdownMenuItem(value: 'pro', child: Text('Pro')),
                  DropdownMenuItem(
                    value: 'enterprise',
                    child: Text('Enterprise'),
                  ),
                ],
                initialValue: _plan,
                onChanged: (planValue) {
                  setState(() {
                    _plan = planValue!;
                  });
                },
                validator: FormBuilderValidators.required(),
                successMessage: 'Looks Good!',
              ),

              const SizedBox(height: kDefaultPadding * 2),

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
                      bgColor: kSecondaryColor,
                      kTextColor: Colors.white,

                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // success toast
                          Toast.showToast(
                            context: context,
                            icon: Icons.check_circle_outline,
                            message: 'Edit Success!',
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
