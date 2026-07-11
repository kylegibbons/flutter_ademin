import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(kText: 'About', showDivider: false),

          // about
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi! I’m Umar Hamzah, a software engineer who believes that every pixel has a purpose and every function deserves clarity. With a passion for both design and code, I strive to create seamless digital experiences that are both beautiful and robust. I specialize in building scalable web and mobile apps using modern tech stacks.\n\nWhether I’m leading a team or diving into solo projects, I’m always fueled by clean design systems, thoughtful UI, and maintainable code. Let’s build something amazing together!.\n\nMy approach to software engineering is deeply rooted in collaboration and continuous improvement. I believe in fostering an environment where every team member's voice is heard, and where we're always pushing the boundaries of what's possible. I'm committed to staying at the forefront of technology, embracing new tools and methodologies to deliver cutting-edge solutions.\n\nWhen I'm not immersed in code, you can find me exploring the latest advancements in UX/UI, contributing to open-source projects, or mentoring aspiring developers. I'm a firm believer in giving back to the community and empowering others to pursue their passion for technology.",
                  style: TextStyle(color: themeData.colorScheme.onSurface),
                ),

                SizedBox(height: kDefaultPadding),

                Wrap(
                  spacing: kDefaultPadding * 4,
                  runSpacing: kDefaultPadding,
                  children: [
                    // Designation
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: themeData.colorScheme.primary
                              .withValues(alpha: 0.1),
                          child: Icon(
                            Icons.badge,
                            color: themeData.colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: kDefaultPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Designation :',
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              'Senior Software Engineer',
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Website
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: themeData.colorScheme.primary
                              .withValues(alpha: 0.1),
                          child: Icon(
                            Icons.language,
                            color: themeData.colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: kDefaultPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Website :',
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                'www.umarhamzah.dev',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: themeData.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
