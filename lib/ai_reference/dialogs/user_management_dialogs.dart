import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/ai_reference/ai_reference_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/toast.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/form/form_dropdown.dart';
import 'package:flutter_ademin/widgets/form/form_file_upload.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lottie/lottie.dart';

class DeleteWarningDialog extends StatelessWidget {
  const DeleteWarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      width: 520,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4 * kDefaultPadding),
          SizedBox(
            width: 120,
            height: 120,
            child: DotLottieLoader.fromAsset(
              'assets/animations/alert.lottie',
              frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                }
                return Container();
              },
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          Text(
            'Important Warning!',
            style: TextStyle(
              color: themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: kHeadlineSmall,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          const Text(
            'This action is irreversible. Are you sure you want to proceed?',
            style: TextStyle(fontSize: kBodyLarge),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2 * kDefaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SoftButton(
                kText: 'Cancel',
                bgColor: kSuccessColor,
                kLeadingIcon: Icons.cancel_outlined,
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: kDefaultPadding),
              CustomOutlinedButton(
                kText: 'Delete',
                outlineColor: kErrorColor,
                kLeadingIcon: Icons.arrow_circle_right_outlined,
                onPressed: () {
                  Navigator.of(context).pop();
                  Toast.showToast(
                    context: context,
                    icon: Icons.check_circle_outline,
                    message: 'User Deleted!',
                    color: kSuccessColor,
                    alignment: Alignment.topRight,
                    showProgress: true,
                    showCloseButton: true,
                    bottomBorder: true,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4 * kDefaultPadding),
        ],
      ),
    );
  }
}

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
  String? _status = 'active';
  String? _plan = 'free';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

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
              Center(
                child: AvatarUpload(
                  maxSizeBytes: 2 * 1024 * 1024,
                  allowedExtensions: const ['jpg', 'jpeg', 'png'],
                  radius: 60,
                  enabled: true,
                  onChanged: (file) {},
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              const FormLabel(text: 'Full Name', showRequired: false),
              const SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: _fullNameController,
                labelText: 'Enter Full Name',
                hintText: 'Jhon Doe',
                suffixIcon: Icons.person,
                validator: FormBuilderValidators.required(),
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),
              const FormLabel(text: 'Email', showRequired: false),
              const SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: _emailController,
                labelText: 'Enter Email',
                hintText: 'jhon_doe@mail.com',
                suffixIcon: Icons.email_outlined,
                validator: FormBuilderValidators.email(),
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),
              const FormLabel(text: 'Username', showRequired: false),
              const SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: _usernameController,
                labelText: 'Enter Username',
                hintText: 'jhondoe',
                suffixIcon: Icons.person_outline,
                validator: FormBuilderValidators.username(),
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),
              const FormLabel(text: 'User Status', showRequired: false),
              const SizedBox(height: kDefaultPadding / 2),
              CustomDropdownFormField<String>(
                hint: 'Select user status',
                items: const [
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'banned', child: Text('Banned')),
                  DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
                  DropdownMenuItem(
                    value: 'suspended',
                    child: Text('Suspended'),
                  ),
                ],
                initialValue: _status,
                onChanged: (val) => setState(() => _status = val),
                validator: FormBuilderValidators.required(),
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),
              const FormLabel(text: 'User Plan', showRequired: false),
              const SizedBox(height: kDefaultPadding / 2),
              CustomDropdownFormField<String>(
                hint: 'Select user plan',
                items: const [
                  DropdownMenuItem(value: 'free', child: Text('Free')),
                  DropdownMenuItem(value: 'starter', child: Text('Starter')),
                  DropdownMenuItem(value: 'pro', child: Text('Pro')),
                  DropdownMenuItem(
                    value: 'enterprise',
                    child: Text('Enterprise'),
                  ),
                ],
                initialValue: _plan,
                onChanged: (val) => setState(() => _plan = val),
                validator: FormBuilderValidators.required(),
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),
              const Text(
                "A setup password link will be sent to the user's email address.",
              ),
              const SizedBox(height: kDefaultPadding * 2),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      kText: 'Cancel',
                      outlineColor: themeData.colorScheme.primary,
                      onPressed: () => Navigator.of(context).pop(),
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
              Center(
                child: AvatarUpload(
                  maxSizeBytes: 2 * 1024 * 1024,
                  allowedExtensions: const ['jpg', 'jpeg', 'png'],
                  radius: 60,
                  enabled: true,
                  initialUrl: AssetImage(widget.user.avatarUrl),
                  onChanged: (file) {},
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              const FormLabel(text: 'Full Name', showRequired: false),
              const SizedBox(height: kDefaultPadding / 2),
              CustomTextFormField(
                controller: _fullNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                labelText: 'Enter Full Name',
                hintText: 'Jhon Doe',
                suffixIcon: Icons.person,
                validator: FormBuilderValidators.required(),
                originalValue: widget.user.fullName,
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),
              const FormLabel(text: 'Email', showRequired: false),
              const SizedBox(height: kDefaultPadding / 2),
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
              const FormLabel(text: 'Username', showRequired: false),
              const SizedBox(height: kDefaultPadding / 2),
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
              const FormLabel(text: 'User Status', showRequired: false),
              const SizedBox(height: kDefaultPadding / 2),
              CustomDropdownFormField<String>(
                hint: 'Select user status',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                items: const [
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'banned', child: Text('Banned')),
                  DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
                  DropdownMenuItem(
                    value: 'suspended',
                    child: Text('Suspended'),
                  ),
                ],
                initialValue: _status,
                onChanged: (value) => setState(() => _status = value!),
                validator: FormBuilderValidators.required(),
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding),
              const FormLabel(text: 'User Plan', showRequired: false),
              const SizedBox(height: kDefaultPadding / 2),
              CustomDropdownFormField<String>(
                hint: 'Select user plan',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                items: const [
                  DropdownMenuItem(value: 'free', child: Text('Free')),
                  DropdownMenuItem(value: 'starter', child: Text('Starter')),
                  DropdownMenuItem(value: 'pro', child: Text('Pro')),
                  DropdownMenuItem(
                    value: 'enterprise',
                    child: Text('Enterprise'),
                  ),
                ],
                initialValue: _plan,
                onChanged: (value) => setState(() => _plan = value!),
                validator: FormBuilderValidators.required(),
                successMessage: 'Looks Good!',
              ),
              const SizedBox(height: kDefaultPadding * 2),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      kText: 'Cancel',
                      outlineColor: kPrimaryColor,
                      onPressed: () => Navigator.of(context).pop(),
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
