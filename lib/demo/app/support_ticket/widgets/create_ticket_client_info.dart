import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';

class CreateTicketClient extends StatefulWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController companyController;

  const CreateTicketClient({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.companyController,
  });

  @override
  State<CreateTicketClient> createState() => _CreateTicketClientState();
}

class _CreateTicketClientState extends State<CreateTicketClient> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Client Contact Information Card
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(kText: 'Client Contact Information'),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full Name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabel(text: 'Full Name', showRequired: true),
                        const SizedBox(height: 0.5 * kDefaultPadding),
                        CustomTextFormField(
                          controller: widget.fullNameController,
                          hintText: 'Enter client name',
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Full name is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding),

                    // Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabel(text: 'Email Address', showRequired: true),
                        const SizedBox(height: 0.5 * kDefaultPadding),
                        CustomTextFormField(
                          controller: widget.emailController,
                          hintText: 'email@example.com',
                          prefixIcon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding),

                    // Phone
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabel(text: 'Phone Number', showRequired: true),
                        const SizedBox(height: 0.5 * kDefaultPadding),
                        CustomTextFormField(
                          controller: widget.phoneController,
                          hintText: '+1 (555) 123-4567',
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding),

                    // Company (optional)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormLabel(text: 'Company', showRequired: false),
                        const SizedBox(height: 0.5 * kDefaultPadding),
                        CustomTextFormField(
                          controller: widget.companyController,
                          hintText: 'Company name (optional)',
                          prefixIcon: Icons.business_outlined,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: kDefaultPadding),
      ],
    );
  }
}
