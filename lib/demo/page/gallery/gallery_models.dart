// gallery item model

class GalleryItem {
  final String imageUrl;
  final String author;
  final int likes;
  final int comments;
  final String category;

  GalleryItem({
    required this.imageUrl,
    required this.author,
    required this.likes,
    required this.comments,
    required this.category,
  });
}
