import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';

class AiOperatorButton extends StatelessWidget {
  const AiOperatorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      kText: 'AI Operator',
      bgColor: [Colors.deepPurple, Colors.purple],
      kTextColor: Colors.white,
      isRounded: true,
      onPressed: () {},
    );
  }
}
