// Profile Settings

class UserProfile {
  final String name;
  final String email;
  final String username;
  final String phone;
  final String bio;

  const UserProfile({
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.bio,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? username,
    String? phone,
    String? bio,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
    );
  }
}
