import 'package:flutter/material.dart';
import 'package:flutkit_ademin/demo/app/chat/chat_model.dart';

class MockData {
  // --- Define Users ---
  static final User currentUser = User(
    id: 'u1',
    name: 'Me',
    avatarUrl: 'assets/images/avatar_2.jpg',
    isOnline: true,
  );

  static final User alice = User(
    id: 'u2',
    name: 'Alice Land',
    avatarUrl: 'assets/images/avatar_1.jpg',
    isOnline: true,
  );
  static final User bob = User(
    id: 'u3',
    name: 'Bob Marley',
    avatarUrl: 'assets/images/avatar_5.jpg',
    isOnline: false,
  );
  static final User charlie = User(
    id: 'u4',
    name: 'Charlie Stone',
    avatarUrl: 'assets/images/avatar_11.jpg',
    isOnline: true,
  );
  static final User diana = User(
    id: 'u5',
    name: 'Diana Prince',
    avatarUrl: 'assets/images/avatar_4.jpg',
    isOnline: false,
  );
  static final User ethan = User(
    id: 'u6',
    name: 'Ethan Hunt',
    avatarUrl: 'assets/images/avatar_3.jpg',
    isOnline: true,
  );
  static final User fiona = User(
    id: 'u7',
    name: 'Fiona Gall',
    avatarUrl: 'assets/images/avatar_6.jpg',
    isOnline: false,
  );
  static final User george = User(
    id: 'u8',
    name: 'George Time',
    avatarUrl: 'assets/images/avatar_8.jpg',
    isOnline: true,
  );
  static final User hannah = User(
    id: 'u9',
    name: 'Hannah Montana',
    avatarUrl: 'assets/images/avatar_10.jpg',
    isOnline: true,
  );
  static final User isaac = User(
    id: 'u10',
    name: 'Isaac Newton',
    avatarUrl: 'assets/images/avatar_9.jpg',
    isOnline: false,
  );

  // Add this so the dialog can call up a complete list
  static List<User> get allUsers => [
    alice,
    bob,
    charlie,
    diana,
    ethan,
    fiona,
    george,
    hannah,
    isaac,
  ];

  // --- Personal Chats Data ---
  static List<Chat> personalChats = [
    Chat(
      user: alice,
      messages: [
        ChatMessage(
          content: 'Hey, did you get a chance to review the design proposal?',
          time: DateTime.now().subtract(const Duration(minutes: 45)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content:
              'Yes, I did. Looks good overall. I’ve just added a few comments.',
          time: DateTime.now().subtract(const Duration(minutes: 43)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Awesome! I’ll go through them now and make the updates.',
          time: DateTime.now().subtract(const Duration(minutes: 42)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Let me know once it’s ready for the client presentation.',
          time: DateTime.now().subtract(const Duration(minutes: 40)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Will do. Thanks!',
          time: DateTime.now().subtract(const Duration(minutes: 39)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content:
              'Also, have you seen the latest client feedback? Lorem ipsum dolor sit amet...',
          time: DateTime.now().subtract(const Duration(minutes: 38)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Not yet. Where is it posted?',
          time: DateTime.now().subtract(const Duration(minutes: 36)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Check the feedback channel in Slack.',
          time: DateTime.now().subtract(const Duration(minutes: 35)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Got it. Thanks!',
          time: DateTime.now().subtract(const Duration(minutes: 34)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'We need to adjust the mobile layout as per the comments.',
          time: DateTime.now().subtract(const Duration(minutes: 33)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Noted. I’ll work on that after lunch.',
          time: DateTime.now().subtract(const Duration(minutes: 32)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Cool. I’ll handle the typography tweaks.',
          time: DateTime.now().subtract(const Duration(minutes: 30)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Perfect. Let’s aim to wrap this by EOD.',
          time: DateTime.now().subtract(const Duration(minutes: 29)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Agreed!',
          time: DateTime.now().subtract(const Duration(minutes: 28)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Sent you the updated Figma file.',
          time: DateTime.now().subtract(const Duration(minutes: 26)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Reviewing now.',
          time: DateTime.now().subtract(const Duration(minutes: 25)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Looks great! Just one minor fix on the header spacing.',
          time: DateTime.now().subtract(const Duration(minutes: 23)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Fixed and re-uploaded!',
          time: DateTime.now().subtract(const Duration(minutes: 21)),
          sender: alice,
          status: MessageStatus.unread,
        ),
      ],
    ),
    Chat(
      user: bob,
      messages: [
        ChatMessage(
          content: 'Can you check the updated report?',
          time: DateTime.now().subtract(const Duration(minutes: 35)),
          sender: bob,
          status: MessageStatus.sent,
        ),
        ChatMessage(
          content: 'Sure, I’ll review it in a bit.',
          time: DateTime.now().subtract(const Duration(minutes: 34)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Just a quick reminder about the key findings.',
          time: DateTime.now().subtract(const Duration(minutes: 5)),
          sender: bob,
          status: MessageStatus.unread,
        ),
        ChatMessage(
          content: 'Let me know if you have any initial thoughts.',
          time: DateTime.now().subtract(const Duration(minutes: 4)),
          sender: bob,
          status: MessageStatus.unread,
        ),
        ChatMessage(
          content: 'Did you see the section on budget allocation?',
          time: DateTime.now().subtract(const Duration(minutes: 3)),
          sender: bob,
          status: MessageStatus.unread,
        ),
        ChatMessage(
          content: 'It’s quite important for our next steps.',
          time: DateTime.now().subtract(const Duration(minutes: 2)),
          sender: bob,
          status: MessageStatus.unread,
        ),
        ChatMessage(
          content: 'Hoping to hear from you soon!',
          time: DateTime.now().subtract(const Duration(minutes: 1)),
          sender: bob,
          status: MessageStatus.unread,
        ),
      ],
    ),
    Chat(
      user: charlie,
      messages: [
        ChatMessage(
          content: 'Hey, are we still on for the 2 PM meeting?',
          time: DateTime.now().subtract(const Duration(hours: 1, minutes: 7)),
          sender: charlie,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Yes, I’ve blocked out the time.',
          time: DateTime.now().subtract(const Duration(hours: 1, minutes: 8)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Just wanted to share the agenda beforehand.',
          time: DateTime.now().subtract(const Duration(minutes: 5)),
          sender: charlie,
          status: MessageStatus.unread,
        ),
        ChatMessage(
          content: 'Could you quickly review the key discussion points?',
          time: DateTime.now().subtract(const Duration(minutes: 3)),
          sender: charlie,
          status: MessageStatus.unread,
        ),
        ChatMessage(
          content: 'It would be great to get your initial feedback.',
          time: DateTime.now().subtract(const Duration(minutes: 2)),
          sender: charlie,
          status: MessageStatus.unread,
        ),
        ChatMessage(
          content: 'See you at 2!',
          time: DateTime.now().subtract(const Duration(minutes: 1)),
          sender: charlie,
          status: MessageStatus.unread,
        ),
        ChatMessage(
          content: 'Let me know if anything comes up.',
          time: DateTime.now(),
          sender: charlie,
          status: MessageStatus.unread,
        ),
      ],
    ),
    Chat(
      user: diana,
      messages: [
        ChatMessage(
          content: 'I’ve pushed the latest commit to Git.',
          time: DateTime.now().subtract(const Duration(minutes: 45)),
          sender: diana,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Thanks, I’ll pull and test it now.',
          time: DateTime.now().subtract(const Duration(minutes: 44)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
      ],
    ),
    Chat(
      user: ethan,
      messages: [
        ChatMessage(
          content: 'Did the client approve the mockups?',
          time: DateTime.now().subtract(const Duration(minutes: 90)),
          sender: ethan,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Yes, we got the green light this morning.',
          time: DateTime.now().subtract(const Duration(minutes: 88)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
      ],
    ),
    Chat(
      user: fiona,
      messages: [
        ChatMessage(
          content: 'Great job on the pitch deck!',
          time: DateTime.now().subtract(const Duration(hours: 2)),
          sender: fiona,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Thanks! Appreciate your feedback.',
          time: DateTime.now().subtract(const Duration(hours: 2, minutes: 1)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
      ],
    ),
    Chat(
      user: george,
      messages: [
        ChatMessage(
          content: 'I’ve shared the presentation slides.',
          time: DateTime.now().subtract(const Duration(hours: 3)),
          sender: george,
          status: MessageStatus.sent,
        ),
        ChatMessage(
          content: 'Got them. Will review before the meeting.',
          time: DateTime.now().subtract(const Duration(hours: 2, minutes: 55)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
      ],
    ),
  ];

  // --- Group Chats Data ---
  static List<Channel> groupChats = [
    Channel(
      channelName: 'Flutter Devs',
      members: [currentUser, alice, bob, george, ethan],
      icon: Icons.code,
      messages: [
        ChatMessage(
          content: 'Hello team!',
          time: DateTime.now().subtract(const Duration(minutes: 30)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Hey Alice!',
          time: DateTime.now().subtract(const Duration(minutes: 29)),
          sender: bob,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Morning all, ready for the sprint planning?',
          time: DateTime.now().subtract(const Duration(minutes: 28)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Yes! I’ve updated the backlog with the new tickets.',
          time: DateTime.now().subtract(const Duration(minutes: 27)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Great. I’ll handle the auth module updates this sprint.',
          time: DateTime.now().subtract(const Duration(minutes: 26)),
          sender: bob,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Sounds good. I’ll take on the settings page refactor.',
          time: DateTime.now().subtract(const Duration(minutes: 25)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'I can also help with the new theme integration if needed.',
          time: DateTime.now().subtract(const Duration(minutes: 24)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Thanks, Alice! That would be super helpful.',
          time: DateTime.now().subtract(const Duration(minutes: 23)),
          sender: bob,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content:
              'Also, we should test on both light and dark modes this time.',
          time: DateTime.now().subtract(const Duration(minutes: 22)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Agree. I’ll add that to the checklist.',
          time: DateTime.now().subtract(const Duration(minutes: 21)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Anyone heard from QA about last sprint’s bugs?',
          time: DateTime.now().subtract(const Duration(minutes: 20)),
          sender: bob,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Yes, I got their feedback. Only two minor issues left.',
          time: DateTime.now().subtract(const Duration(minutes: 19)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Awesome. Let’s aim to close those today.',
          time: DateTime.now().subtract(const Duration(minutes: 18)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'I’ll take the crash report one.',
          time: DateTime.now().subtract(const Duration(minutes: 17)),
          sender: bob,
          status: MessageStatus.unread,
        ),
        ChatMessage(
          content: 'Perfect. Let’s sync again post-lunch.',
          time: DateTime.now().subtract(const Duration(minutes: 16)),
          sender: alice,
          status: MessageStatus.unread,
        ),
      ],
    ),
    Channel(
      channelName: 'Design Team',
      members: [currentUser, diana, fiona, george],
      icon: Icons.palette_outlined,
      messages: [
        ChatMessage(
          content: 'New homepage mockups are up on Figma.',
          time: DateTime.now().subtract(const Duration(minutes: 60)),
          sender: diana,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Nice work, Diana! Looks clean.',
          time: DateTime.now().subtract(const Duration(minutes: 59)),
          sender: fiona,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Agreed. Let’s get feedback from product before finalizing.',
          time: DateTime.now().subtract(const Duration(minutes: 58)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Will do. I’ll send it to them today.',
          time: DateTime.now().subtract(const Duration(minutes: 56)),
          sender: diana,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Any updates on the dark mode UI?',
          time: DateTime.now().subtract(const Duration(minutes: 54)),
          sender: fiona,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'I’ve started on it—will share a draft by EOD.',
          time: DateTime.now().subtract(const Duration(minutes: 52)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Awesome. I’ll prep icons in both variants.',
          time: DateTime.now().subtract(const Duration(minutes: 51)),
          sender: fiona,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Make sure to follow the new spacing guidelines.',
          time: DateTime.now().subtract(const Duration(minutes: 50)),
          sender: diana,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Got it!',
          time: DateTime.now().subtract(const Duration(minutes: 49)),
          sender: fiona,
          status: MessageStatus.unread,
        ),
        ChatMessage(
          content: 'Let’s aim to wrap the design pass by tomorrow.',
          time: DateTime.now().subtract(const Duration(minutes: 48)),
          sender: diana,
          status: MessageStatus.unread,
        ),
      ],
    ),
    Channel(
      channelName: 'QA & Testing',
      members: [currentUser, george, hannah, isaac, fiona],
      icon: Icons.bug_report_outlined,
      messages: [
        ChatMessage(
          content: 'Found 3 new issues on the latest Android build.',
          time: DateTime.now().subtract(const Duration(minutes: 90)),
          sender: hannah,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Thanks. Are they blockers?',
          time: DateTime.now().subtract(const Duration(minutes: 89)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'One is related to login crash. Others are minor.',
          time: DateTime.now().subtract(const Duration(minutes: 88)),
          sender: hannah,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'I’ll fix the crash right away.',
          time: DateTime.now().subtract(const Duration(minutes: 87)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Also, push notifications failed on iOS.',
          time: DateTime.now().subtract(const Duration(minutes: 85)),
          sender: george,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Hmm, let me test that on a simulator.',
          time: DateTime.now().subtract(const Duration(minutes: 83)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Make sure the provisioning profile is updated.',
          time: DateTime.now().subtract(const Duration(minutes: 82)),
          sender: george,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Got it. On it now.',
          time: DateTime.now().subtract(const Duration(minutes: 81)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Can you flag any flaky tests as well?',
          time: DateTime.now().subtract(const Duration(minutes: 80)),
          sender: hannah,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Sure. I’ll mark them on TestRail.',
          time: DateTime.now().subtract(const Duration(minutes: 79)),
          sender: george,
          status: MessageStatus.unread,
        ),
      ],
    ),
    Channel(
      channelName: 'Marketing',
      members: [currentUser, fiona, isaac],
      icon: Icons.storefront_outlined,
      messages: [
        ChatMessage(
          content: 'Newsletter copy is ready for review.',
          time: DateTime.now().subtract(const Duration(minutes: 70)),
          sender: fiona,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Looks solid. I’ve added a few tweaks.',
          time: DateTime.now().subtract(const Duration(minutes: 69)),
          sender: isaac,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Nice! When are we scheduling it?',
          time: DateTime.now().subtract(const Duration(minutes: 68)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Tomorrow at 10 AM PST.',
          time: DateTime.now().subtract(const Duration(minutes: 67)),
          sender: fiona,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Don’t forget to include the referral link.',
          time: DateTime.now().subtract(const Duration(minutes: 66)),
          sender: isaac,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Good point. Updating now.',
          time: DateTime.now().subtract(const Duration(minutes: 65)),
          sender: fiona,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'How’s the social campaign going?',
          time: DateTime.now().subtract(const Duration(minutes: 64)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'CTR is up by 18% since last week!',
          time: DateTime.now().subtract(const Duration(minutes: 63)),
          sender: isaac,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Awesome, let’s keep that momentum.',
          time: DateTime.now().subtract(const Duration(minutes: 62)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Posting next teaser this afternoon.',
          time: DateTime.now().subtract(const Duration(minutes: 61)),
          sender: fiona,
          status: MessageStatus.read,
        ),
      ],
    ),
    Channel(
      channelName: 'Product Planning',
      members: [currentUser, alice],
      icon: Icons.shopping_bag_outlined,
      messages: [
        ChatMessage(
          content: 'Kickoff meeting is scheduled for 11 AM tomorrow.',
          time: DateTime.now().subtract(const Duration(hours: 4)),
          sender: charlie,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Got it. I’ll prepare the agenda.',
          time: DateTime.now().subtract(const Duration(hours: 4, minutes: 1)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Let’s include Q2 goals in the deck.',
          time: DateTime.now().subtract(const Duration(hours: 4, minutes: 2)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'I’ll draft that section.',
          time: DateTime.now().subtract(const Duration(hours: 4, minutes: 3)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Are we aligned on the MVP scope?',
          time: DateTime.now().subtract(const Duration(hours: 4, minutes: 5)),
          sender: charlie,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Mostly, just need confirmation from devs.',
          time: DateTime.now().subtract(const Duration(hours: 4, minutes: 6)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'I’ll send a follow-up after stand-up.',
          time: DateTime.now().subtract(const Duration(hours: 4, minutes: 7)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Thanks! Also add the OKR slides.',
          time: DateTime.now().subtract(const Duration(hours: 4, minutes: 8)),
          sender: charlie,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Already on it 👍',
          time: DateTime.now().subtract(const Duration(hours: 4, minutes: 9)),
          sender: alice,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Let’s sync briefly at 4 PM.',
          time: DateTime.now().subtract(const Duration(hours: 4, minutes: 10)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
      ],
    ),
    Channel(
      channelName: 'DevOps & Releases',
      members: [currentUser, ethan, george, isaac],
      icon: Icons.terminal_outlined,
      messages: [
        ChatMessage(
          content: 'Next release is scheduled for Friday.',
          time: DateTime.now().subtract(const Duration(minutes: 120)),
          sender: ethan,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'CI pipeline is green on all branches.',
          time: DateTime.now().subtract(const Duration(minutes: 119)),
          sender: george,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Do we need to patch that logging bug?',
          time: DateTime.now().subtract(const Duration(minutes: 118)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Yes, just pushed a fix.',
          time: DateTime.now().subtract(const Duration(minutes: 117)),
          sender: ethan,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'I’ll tag the build after your merge.',
          time: DateTime.now().subtract(const Duration(minutes: 116)),
          sender: george,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Remember to bump the version code.',
          time: DateTime.now().subtract(const Duration(minutes: 115)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Done. Also updated the changelog.',
          time: DateTime.now().subtract(const Duration(minutes: 114)),
          sender: ethan,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Nice. Uploading to TestFlight now.',
          time: DateTime.now().subtract(const Duration(minutes: 113)),
          sender: george,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'Let’s notify QA once it’s live.',
          time: DateTime.now().subtract(const Duration(minutes: 112)),
          sender: currentUser,
          status: MessageStatus.read,
        ),
        ChatMessage(
          content: 'On it. Should be live in 10 mins.',
          time: DateTime.now().subtract(const Duration(minutes: 111)),
          sender: george,
          status: MessageStatus.read,
        ),
      ],
    ),
  ];
}
