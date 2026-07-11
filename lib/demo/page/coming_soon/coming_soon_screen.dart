import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/public_master_layout/public_footer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({super.key});

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  final _emailController = TextEditingController();

  late final DateTime launchDate;

  // for demo purpose, we had set a launch date to 4 days from now, replace with your actual launch date.
  @override
  void initState() {
    super.initState();
    launchDate = DateTime.now()
        .add(const Duration(days: 4))
        .copyWith(
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
    _startCountdown();
  }

  void _startCountdown() {
    _remaining = launchDate.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final newRemaining = launchDate.difference(DateTime.now());
      if (newRemaining.isNegative) {
        _timer.cancel();
      }
      setState(() {
        _remaining = newRemaining;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _emailController.dispose();
    super.dispose();
  }

  String _formatTime(int value) => value.toString().padLeft(2, '0');
  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

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
              kPrimaryColor.withValues(alpha: 1.0),
              kSuccessColor.withValues(alpha: 0.7),
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
                      Spacer(flex: 3),
                      SizedBox(height: kDefaultPadding),
                      Image.asset(AppSettings.logoPath, height: 28.0),
                      Spacer(flex: 2),
                      SizedBox(height: kDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: const Text(
                          'Something Exciting is Coming!',
                          style: TextStyle(
                            fontSize: kHeadlineLarge,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(flex: 2),
                      SizedBox(height: kDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: const Text(
                          'We are working hard to launch our new product.\nStay tuned!',
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: kDefaultPadding),

                      // countdown timer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTimeBox(label: 'Days', value: days),
                          _buildTimeBox(label: 'Hours', value: hours),
                          _buildTimeBox(label: 'Minutes', value: minutes),
                          _buildTimeBox(label: 'Seconds', value: seconds),
                        ],
                      ),
                      Spacer(),
                      SizedBox(height: kDefaultPadding),

                      // social medias
                      Wrap(
                        spacing: 2 * kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          SocialMediaButton(
                            icon: FontAwesomeIcons.facebookF,
                            onTap: () {},
                          ),
                          SocialMediaButton(
                            icon: FontAwesomeIcons.youtube,
                            onTap: () {},
                          ),
                          SocialMediaButton(
                            icon: FontAwesomeIcons.x,
                            onTap: () {},
                          ),
                          SocialMediaButton(
                            icon: FontAwesomeIcons.instagram,
                            onTap: () {},
                          ),
                        ],
                      ),

                      Spacer(),
                      SizedBox(height: kDefaultPadding),

                      // email subscription form
                      SizedBox(
                        width: 400,
                        child: ActionInputField(
                          hintText: "Enter your email address",
                          buttonText: "Send",
                          buttonColor: kErrorColor,
                          radius: 50,
                        ),
                      ),

                      Spacer(),

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

  Widget _buildTimeBox({required String label, required int value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _formatTime(value),
              style: const TextStyle(
                fontSize: 3 * kBodyLarge,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.color,
  });

  final VoidCallback onTap;
  final FaIconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: FaIcon(icon, color: color ?? Colors.white, size: 36),
    );
  }
}
