// warning dialog

import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:lottie/lottie.dart';

class DeleteWarningDialog extends StatelessWidget {
  const DeleteWarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: DotLottieLoader.fromAsset(
                  "assets/animations/alert.lottie",
                  frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                    if (dotlottie != null) {
                      return Lottie.memory(dotlottie.animations.values.single);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              Text(
                "Important Warning!",
                style: TextStyle(
                  color: themeData.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: kHeadlineSmall,
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              const Center(
                child: Text(
                  "Deleting project is irreversible. Are you sure you want to proceed?",
                  style: TextStyle(fontSize: kBodyLarge),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 2 * kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SoftButton(
                    kText: 'Cancel',
                    bgColor: kSuccessColor,
                    kLeadingIcon: Icons.cancel_outlined,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: kDefaultPadding),
                  CustomOutlinedButton(
                    kText: 'Delete',
                    outlineColor: kErrorColor,
                    kLeadingIcon: Icons.arrow_circle_right_outlined,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
