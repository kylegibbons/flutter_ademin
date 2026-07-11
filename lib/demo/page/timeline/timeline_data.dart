import 'package:flutter/material.dart';
import 'package:flutter_ademin/demo/page/timeline/timeline_models.dart';
import 'package:flutter_ademin/theme/themes.dart';

// centered timeline data mockup

final List<TimelineEvent> timelineEvents = [
  TimelineEvent(
    imageUrl: 'assets/images/avatar_1.jpg',
    username: '@Deasy232',
    timeAgo: '10 min Ago',
    description:
        'Wish someone a sincere ‘good luck in your new job’ with these thoughtful words. A kind message can go a long way in making someone feel appreciated, especially when they’re starting a new chapter. Don’t forget to include a personal touch or memory to make your wishes stand out even more.',
  ),
  TimelineEvent(
    imageUrl: 'assets/images/avatar_3.jpg',
    username: '@JakeWork',
    timeAgo: '25 min Ago',
    description:
        'Don’t forget to send your best wishes for big changes! Whether it’s a new job, new city, or a fresh start, a heartfelt note can make someone’s day. Celebrate their journey with words that reflect their strength and your admiration for their accomplishments and courage to start something new.',
  ),
  TimelineEvent(
    imageUrl: 'assets/images/avatar_4.jpg',
    username: '@FlutterDev',
    timeAgo: '1 hour Ago',
    description:
        'We just released a new update for the timeline layout! It brings smoother animations, better alignment, and a much more visually appealing design. If you’re building social feeds, activity logs, or progress trackers, this is going to be a game-changer. Dive into the docs to explore what’s new and optimized.',
  ),
  TimelineEvent(
    imageUrl: 'assets/images/avatar_5.jpg',
    username: '@EmilyTalks',
    timeAgo: '2 hours Ago',
    description:
        'Just wrapped up a fantastic webinar on personal branding! It’s amazing how much clarity a strong personal narrative can bring to your career. From social presence to portfolio design, there are so many tools out there. Stay tuned for the full recap and downloadable resources—coming to your inbox soon!',
  ),
  TimelineEvent(
    imageUrl: 'assets/images/avatar_6.jpg',
    username: '@CodeCraft',
    timeAgo: '5 hours Ago',
    description:
        'Today we discussed the importance of clean architecture in app development. Separating concerns, managing state effectively, and scaling with confidence are all easier when your architecture supports it. Stay tuned for the full recording of the session and the GitHub repo with all the examples we covered live.',
  ),
  TimelineEvent(
    imageUrl: 'assets/images/avatar_7.jpg',
    username: '@NiaDesigns',
    timeAgo: '7 hours Ago',
    description:
        'Working on a new design system today! Starting with buttons, colors, and typography. Creating consistency across your UI helps reduce cognitive load and improves user experience. Can’t wait to share the Figma components and a breakdown of how I handle spacing, elevation, and states in complex UI projects.',
  ),
];

// leading timeline data model

final List<LeadingTimelineStep> projectSteps = [
  LeadingTimelineStep(
    title: "Planning",
    description:
        "Define project goals, stakeholders, requirements, and timelines to build a clear roadmap.",
    date: "2025-04-01",
    dueDate: "2025-04-01",
    status: "completed",
    icon: Icons.edit_calendar,
    isCompleted: true,
    color: kPrimaryColor,
  ),
  LeadingTimelineStep(
    title: "Design",
    description:
        "UI/UX wireframes and high-fidelity mockups prepared and approved by the design team.",
    date: "2025-04-05",
    dueDate: "2025-04-07",
    status: "completed",
    icon: Icons.design_services,
    isCompleted: true,
    color: kSecondaryColor,
  ),
  LeadingTimelineStep(
    title: "Development",
    description:
        "Frontend and backend developers collaborate to implement features as per the specs.",
    date: "2025-04-10",
    dueDate: "2025-04-20",
    status: "in progress",
    icon: Icons.code,
    isCompleted: true,
    color: kInfoColor,
  ),
  LeadingTimelineStep(
    title: "Testing",
    description:
        "QA team performs functionality, usability, and performance tests before launch.",
    date: "2025-04-18",
    dueDate: "2025-04-23",
    status: "upcoming",
    icon: Icons.bug_report,
    isCompleted: false,
    color: kWarningColor,
  ),
  LeadingTimelineStep(
    title: "Launch",
    description:
        "The project is deployed to production, followed by a soft release for early feedback.",
    date: "2025-04-25",
    dueDate: "2025-04-25",
    status: "upcoming",
    icon: Icons.rocket_launch,
    isCompleted: false,
    color: kErrorColor,
  ),
  LeadingTimelineStep(
    title: "Review",
    description:
        "Post-launch review meeting to gather lessons learned and define next iteration goals.",
    date: "2025-04-30",
    dueDate: "2025-04-30",
    status: "upcoming",
    icon: Icons.rate_review,
    isCompleted: false,
    color: Colors.black,
  ),
];
