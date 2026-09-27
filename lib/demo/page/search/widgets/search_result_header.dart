import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';

class SearchResultHeader extends StatelessWidget {
  const SearchResultHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultRadius),
          topRight: Radius.circular(defaultRadius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 4 * kDefaultPadding,
          bottom: kDefaultPadding * 2,
        ),
        child: Center(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: SearchBarWithActions(
                    onMicTap: () {
                      // Voice input logic
                    },
                    onVisionTap: () {
                      // Visual search logic
                    },
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Showing results for ',
                    style: TextStyle(
                      fontSize: kBodyLarge,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '"Flutter Funny Things"',
                    style: TextStyle(
                      fontSize: kBodyLarge,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
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
