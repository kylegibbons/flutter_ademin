class UserProfile {
  final String name;
  final String role;
  final String avatarUrl;
  final String backgroundUrl;
  final int projects;
  final int tasks;
  bool isFavorite; // <-- Add this line

  UserProfile({
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.backgroundUrl,
    required this.projects,
    required this.tasks,
    this.isFavorite = false, // <-- Default to false
  });
}
