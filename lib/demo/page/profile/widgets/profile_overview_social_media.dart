import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            CardHeader(kText: 'Social Media', showDivider: false),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Wrap(
                spacing: kDefaultPadding,
                runSpacing: kDefaultPadding,

                children: [
                  // github button
                  CustomIconButton(
                    useFontAwesome: true,
                    icon: FontAwesomeIcons.github,
                    buttonColor: Color(0xff181717),
                    iconColor: Colors.white,
                    shape: ButtonShape.circle,
                    size: ButtonSize.large,
                    onTap: () {},
                  ),

                  // google button
                  CustomIconButton(
                    useFontAwesome: true,
                    icon: FontAwesomeIcons.google,
                    buttonColor: Color(0xffDB4437),
                    iconColor: Colors.white,
                    shape: ButtonShape.circle,
                    size: ButtonSize.large,
                    onTap: () {},
                  ),

                  // facebook button
                  CustomIconButton(
                    useFontAwesome: true,
                    icon: FontAwesomeIcons.facebook,
                    buttonColor: Color(0xff1877F2),
                    iconColor: Colors.white,
                    shape: ButtonShape.circle,
                    size: ButtonSize.large,
                    onTap: () {},
                  ),

                  // apple button
                  CustomIconButton(
                    useFontAwesome: true,
                    icon: FontAwesomeIcons.apple,
                    buttonColor: Color(0xff1877F2),
                    iconColor: Colors.white,
                    shape: ButtonShape.circle,
                    size: ButtonSize.large,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
