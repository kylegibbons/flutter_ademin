import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/toast.dart';
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
          SizedBox(height: 4 * kDefaultPadding),
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
              "This action is irreversible. Are you sure you want to proceed?",
              style: TextStyle(fontSize: kBodyLarge),
              textAlign: TextAlign.center,
            ),
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
                  // delete logic

                  // success toast
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
          SizedBox(height: 4 * kDefaultPadding),
        ],
      ),
    );
  }
}
