import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// social login section
class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // github button
        CustomIconButton(
          useFontAwesome: true,
          icon: FontAwesomeIcons.github,
          buttonColor: const Color(0xff181717),
          iconColor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(width: kDefaultPadding / 2),
        // google button
        CustomIconButton(
          useFontAwesome: true,
          icon: FontAwesomeIcons.google,
          buttonColor: const Color(0xffDB4437),
          iconColor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(width: kDefaultPadding / 2),
        // facebook button
        CustomIconButton(
          useFontAwesome: true,
          icon: FontAwesomeIcons.facebook,
          buttonColor: const Color(0xff1877F2),
          iconColor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(width: kDefaultPadding / 2),
        // apple button
        CustomIconButton(
          useFontAwesome: true,
          icon: FontAwesomeIcons.apple,
          buttonColor: Colors.black,
          iconColor: Colors.white,
          onTap: () {},
        ),
      ],
    );
  }
}
