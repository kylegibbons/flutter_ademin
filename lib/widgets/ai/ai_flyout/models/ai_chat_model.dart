import 'package:flutter/material.dart';

class AIHome {
  const AIHome({
    required this.greeting,
    required this.subtitle,
    required this.quickActions,
  });

  final String greeting;

  final String subtitle;

  final List<AIQuickAction> quickActions;
}

class AIConversation {
  const AIConversation({
    required this.id,
    required this.title,
    required this.preview,
    required this.updatedAt,
    required this.chat,

    this.pinned = false,
    this.favorite = false,
    this.unreadCount = 0,
  });

  final String id;

  final String title;

  final String preview;

  final DateTime updatedAt;

  final bool pinned;

  final bool favorite;

  final int unreadCount;

  final List<AIChatMessage> chat;
}

class AIChatMessage {
  const AIChatMessage({
    required this.id,
    required this.role,
    required this.type,

    this.text,

    this.suggestions = const [],

    this.actions = const [],
  });

  final String id;

  final ChatRole role;

  final ChatMessageType type;

  final String? text;

  final List<AIQuickAction> suggestions;

  final List<AIQuickAction> actions;
}

class AIQuickAction {
  const AIQuickAction({
    required this.id,
    required this.title,

    this.icon,

    this.prompt,
  });

  final String id;

  final IconData? icon;

  final String title;

  final String? prompt;
}

enum ChatRole { assistant, user }

enum ChatMessageType { text, suggestions, actions }
