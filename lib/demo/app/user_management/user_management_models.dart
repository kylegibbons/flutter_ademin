// User metrics

class UserMetrics {
  final int totalUsers;
  final int activeUsers;
  final int paidUsers;
  final int restrictedUsers;

  UserMetrics({
    required this.totalUsers,
    required this.activeUsers,
    required this.paidUsers,
    required this.restrictedUsers,
  });

  factory UserMetrics.fromUsers(List<UserModel> users) {
    return UserMetrics(
      totalUsers: users.length,
      activeUsers: users.where((u) => u.status == 'active').length,
      paidUsers: users.where((u) => u.plan != 'free').length,
      restrictedUsers: users
          .where((u) => u.status == 'suspended' || u.status == 'banned')
          .length,
    );
  }
}

// user data model

class UserModel {
  final String avatarUrl;
  final String fullName;
  final String email;
  final String username;
  final String status;
  final String role;
  final DateTime joinedDate;
  final DateTime lastActive;
  final String plan;

  const UserModel({
    required this.avatarUrl,
    required this.fullName,
    required this.email,
    required this.username,
    required this.status,
    required this.role,
    required this.joinedDate,
    required this.lastActive,
    required this.plan,
  });
}
