import 'package:flutter/material.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/public_master_layout/public_footer.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/pattern.png"),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kPrimaryColor.withValues(alpha: 0.9),
              kSuccessColor.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: double.infinity,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(flex: 2),
                      SizedBox(height: kDefaultPadding),
                      Image.asset(AppSettings.logoPath, height: 28.0),
                      Spacer(flex: 2),
                      SizedBox(height: kDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: const Text(
                          'Our site is currently down for maintenance',
                          style: TextStyle(
                            fontSize: kHeadlineMedium,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: kDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: const Text(
                          'We apologize for any inconveniences caused and we will be online as soon as possible. Please check again in a little while.',
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: const Text(
                          'Thank you!',
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(flex: 1),
                      SizedBox(height: kDefaultPadding),

                      // icon
                      const Icon(
                        Icons.cloud_off_outlined,
                        size: 210,
                        color: Colors.white,
                      ),

                      Spacer(flex: 1),
                      SizedBox(height: kDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: const PublicFooter(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
