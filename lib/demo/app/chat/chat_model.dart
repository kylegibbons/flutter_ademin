import 'package:flutter/material.dart';

enum MessageStatus { sent, delivered, read, unread }

class User {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;

  User({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isOnline = false,
  });
}

class ChatMessage {
  final String content;
  final DateTime time;
  final User sender;
  final MessageStatus status;

  ChatMessage({
    required this.content,
    required this.time,
    required this.sender,
    required this.status,
  });

  ChatMessage copyWith({
    String? content,
    DateTime? time,
    User? sender,
    MessageStatus? status,
  }) {
    return ChatMessage(
      content: content ?? this.content,
      time: time ?? this.time,
      sender: sender ?? this.sender,
      status: status ?? this.status,
    );
  }
}

// Personal Chat Model
class Chat {
  final User user;
  final List<ChatMessage> messages;

  Chat({required this.user, required this.messages});
}

//  uGroup/Channel Model
class Channel {
  final String channelName;
  final List<User> members;
  final IconData icon;
  final List<ChatMessage> messages;

  Channel({
    required this.channelName,
    required this.members,
    required this.icon,
    required this.messages,
  });
}

// Wrapper to ease selection in UI (Simple Polymorphism)
class ChatSelection {
  final Chat? personalChat;
  final Channel? channel;
  final bool isPersonal;

  ChatSelection.personal(this.personalChat) : channel = null, isPersonal = true;

  ChatSelection.channel(this.channel) : personalChat = null, isPersonal = false;

  String get id => isPersonal ? personalChat!.user.id : channel!.channelName;
}
